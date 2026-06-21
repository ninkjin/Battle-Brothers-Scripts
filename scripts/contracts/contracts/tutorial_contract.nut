this.tutorial_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Location = null,
		BigCity = null
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.tutorial";
		this.m.Name = "%companyname%战团";
		this.m.TimeOut = this.Time.getVirtualTimeF() + 9000.0;
	}

	function start()
	{
		local settlements = this.World.EntityManager.getSettlements();
		local best_dist = 9000;
		local best_start;
		local best_big;

		foreach( s in settlements )
		{
			if (s.isMilitary() || s.getSize() > 1 || s.isIsolatedFromRoads())
			{
				continue;
			}

			local bestDist = 9000;
			local best;

			foreach( b in settlements )
			{
				if (s.getID() == b.getID())
				{
					continue;
				}

				if (b.getSize() <= 1 || b.isIsolatedFromRoads())
				{
					continue;
				}

				local d = s.getTile().getDistanceTo(b.getTile());

				if (d < bestDist)
				{
					bestDist = d;
					best = b;
				}
			}

			if (best != null && bestDist < best_dist)
			{
				best_dist = bestDist;
				best_start = s;
				best_big = best;
			}
		}

		this.setHome(best_start);
		this.setOrigin(best_start);
		this.m.Home.setVisited(true);
		this.m.Home.setDiscovered(true);
		this.World.uncoverFogOfWar(this.m.Home.getTile().Pos, 500.0);
		this.m.Faction = best_start.getFactions()[0];
		this.m.EmployerID = this.World.FactionManager.getFaction(this.m.Faction).getRandomCharacter().getID();
		this.m.BigCity = this.WeakTableRef(best_big);
		local tile = this.getTileToSpawnLocation(this.m.Home.getTile(), 5, 8, [
			this.Const.World.TerrainType.Swamp,
			this.Const.World.TerrainType.Forest,
			this.Const.World.TerrainType.LeaveForest,
			this.Const.World.TerrainType.SnowyForest,
			this.Const.World.TerrainType.Shore,
			this.Const.World.TerrainType.Ocean,
			this.Const.World.TerrainType.Mountains
		]);
		this.World.State.getPlayer().setPos(tile.Pos);
		this.World.getCamera().jumpTo(this.World.State.getPlayer());
		this.m.Flags.set("BossName", "黄鼠狼霍加特");
		this.m.Flags.set("LocationName", "霍加特避难所");
		this.setState("StartingBattle");
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "StartingBattle",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"击杀%boss%。"
				];
				this.World.State.m.IsAutosaving = false;
			}

			function update()
			{
				if (!this.Flags.get("IsTutorialBattleDone"))
				{
					if (!this.Flags.get("IsIntroShown"))
					{
						this.Flags.set("IsIntroShown", true);
						this.Sound.play("sounds/intro_battle.wav");
						this.Contract.setScreen("Intro");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local tile = this.World.State.getPlayer().getTile();
						local p = this.Const.Tactical.CombatInfo.getClone();
						p.Music = this.Const.Music.CivilianTracks;
						p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
						p.Tile = tile;
						p.CombatID = "Tutorial1";
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Custom;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Custom;
						p.PlayerDeploymentCallback = this.onPlayerDeployment.bindenv(this);
						p.EnemyDeploymentCallback = this.onAIDeployment.bindenv(this);
						p.IsFleeingProhibited = true;
						p.IsAutoAssigningBases = false;
						this.World.Contracts.startScriptedCombat(p, false, false, false);
					}
				}
				else
				{
					this.Contract.setScreen("IntroAftermath");
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "Tutorial1")
				{
					this.Flags.set("IsTutorialBattleDone", true);
					local brothers = this.World.getPlayerRoster().getAll();
					brothers[0].setIsAbleToDie(true);
					brothers[1].setIsAbleToDie(true);
					brothers[2].setIsAbleToDie(true);
					this.World.State.m.IsAutosaving = true;
				}
			}

			function onPlayerDeployment()
			{
				for( local x = 0; x != 32; x = ++x )
				{
					for( local y = 0; y != 32; y = ++y )
					{
						local tile = this.Tactical.getTileSquare(x, y);
						tile.Level = 0;

						if (x > 11 && x < 22 && y > 12 && y < 21)
						{
							tile.removeObject();

							if (tile.IsHidingEntity)
							{
								tile.clear();
								tile.IsHidingEntity = false;
							}
						}
					}
				}

				this.Tactical.fillVisibility(this.Const.Faction.Player, true);
				local brothers = this.World.getPlayerRoster().getAll();
				this.Tactical.addEntityToMap(brothers[0], 13, 15 - 13 / 2);
				brothers[0].setIsAbleToDie(false);
				this.Tactical.addEntityToMap(brothers[1], 13, 16 - 13 / 2);
				brothers[1].setIsAbleToDie(false);
				this.Tactical.addEntityToMap(brothers[2], 12, 18 - 12 / 2);
				brothers[2].setIsAbleToDie(false);
				this.Tactical.CameraDirector.addJumpToTileEvent(0, this.Tactical.getTile(6, 17 - 6 / 2), 0, null, null, 0, 0);
				this.Tactical.CameraDirector.addMoveSlowlyToTileEvent(0, this.Tactical.getTile(18, 17 - 18 / 2), 0, null, null, 0, 1000);
				this.Contract.spawnBlood(11, 12);
				this.Contract.spawnBlood(13, 15);
				this.Contract.spawnBlood(14, 17);
				this.Contract.spawnBlood(15, 16);
				this.Contract.spawnBlood(17, 14);
				this.Contract.spawnBlood(15, 15);
				this.Contract.spawnBlood(18, 16);
				this.Contract.spawnBlood(12, 14);
				this.Contract.spawnBlood(13, 16);
				this.Contract.spawnBlood(12, 15);
				this.Contract.spawnBlood(16, 18);
				this.Contract.spawnBlood(15, 17);
				this.Contract.spawnArrow(13, 13);
				this.Contract.spawnArrow(14, 17);
				this.Contract.spawnArrow(17, 15);
				this.Contract.spawnCorpse(12, 13);
				this.Contract.spawnCorpse(16, 14);
				this.Contract.spawnCorpse(17, 16);
				this.Contract.spawnCorpse(15, 14);
				this.Contract.spawnCorpse(14, 18);
			}

			function onAIDeployment()
			{
				local e;
				this.Const.Movement.AnnounceDiscoveredEntities = false;
				e = this.Tactical.spawnEntity("scripts/entity/tactical/humans/bounty_hunter", 16, 16 - 16 / 2);
				e.setFaction(this.Const.Faction.PlayerAnimals);
				e.setName("一只眼");
				e.getSprite("socket").setBrush("bust_base_player");
				e.assignRandomEquipment();
				e.getSkills().removeByID("perk.overwhelm");
				e.getSkills().removeByID("perk.nimble");
				e.getItems().getItemAtSlot(this.Const.ItemSlot.Body).setArmor(0);

				if (e.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
				{
					e.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
				}

				if (e.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
				{
					e.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
				}

				e.getBaseProperties().Hitpoints = 5;
				e.getBaseProperties().MeleeSkill = -200;
				e.getBaseProperties().RangedSkill = 0;
				e.getBaseProperties().MeleeDefense = -200;
				e.getBaseProperties().Initiative = 200;
				e.getSkills().update();
				e.setHitpoints(5);
				e = this.Tactical.spawnEntity("scripts/entity/tactical/humans/bounty_hunter", 15, 18 - 15 / 2);
				e.setFaction(this.Const.Faction.PlayerAnimals);
				e.setName("团长伯恩哈德");
				e.getSprite("socket").setBrush("bust_base_player");
				e.getSkills().removeByID("perk.overwhelm");
				e.getSkills().removeByID("perk.nimble");
				local armor = this.new("scripts/items/armor/mail_hauberk");
				armor.setVariant(32);
				armor.setArmor(0);
				e.getItems().equip(armor);
				e.getItems().equip(this.new("scripts/items/weapons/arming_sword"));
				e.getBaseProperties().Hitpoints = 9;
				e.getBaseProperties().MeleeSkill = -200;
				e.getBaseProperties().RangedSkill = 0;
				e.getBaseProperties().MeleeDefense = -200;
				e.getBaseProperties().DamageTotalMult = 0.1;
				e.getBaseProperties().Initiative = 250;
				e.getSkills().update();
				e.setHitpoints(5);
				e = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", 18, 17 - 18 / 2);
				e.setFaction(this.Const.Faction.Enemy);
				e.getAIAgent().getProperties().OverallDefensivenessMult = 0.0;
				e.getAIAgent().getProperties().BehaviorMult[this.Const.AI.Behavior.ID.Retreat] = 0.0;
				e.assignRandomEquipment();
				e.getBaseProperties().Initiative = 300;
				e.getSkills().update();
				e = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", 17, 18 - 17 / 2);
				e.setFaction(this.Const.Faction.Enemy);
				e.getAIAgent().getProperties().OverallDefensivenessMult = 0.0;
				e.getAIAgent().getProperties().BehaviorMult[this.Const.AI.Behavior.ID.Retreat] = 0.0;
				e.assignRandomEquipment();
				e.getBaseProperties().Initiative = 200;
				e.getSkills().update();
				e = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_raider_low", 19, 17 - 19 / 2);
				e.setFaction(this.Const.Faction.Enemy);
				e.setName(this.Flags.get("BossName"));
				e.getAIAgent().getProperties().OverallDefensivenessMult = 0.0;
				e.getAIAgent().addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat_always"));
				local items = e.getItems();
				items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
				items.equip(this.new("scripts/items/weapons/hunting_bow"));
				this.Flags.set("BossHead", e.getSprite("head").getBrush().Name);
				this.Flags.set("BossBeard", e.getSprite("beard").HasBrush ? e.getSprite("beard").getBrush().Name : "");
				this.Flags.set("BossBeardTop", e.getSprite("beard_top").HasBrush ? e.getSprite("beard_top").getBrush().Name : "");
				this.Flags.set("BossHair", e.getSprite("hair").HasBrush ? e.getSprite("hair").getBrush().Name : "");
				e.getBaseProperties().Hitpoints = 300;
				e.getSkills().update();
				e.setHitpoints(180);
				e.setMoraleState(this.Const.MoraleState.Wavering);
				this.Const.Movement.AnnounceDiscoveredEntities = true;
			}

		});
		this.m.States.push({
			ID = "ReturnAfterIntro",
			function start()
			{
				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.Contract.m.BulletpointsObjectives = [
					"返回" + this.Contract.m.Home.getName() + "获得报酬"
				];
				this.World.State.getPlayer().setAttackable(false);
				this.World.State.m.IsAutosaving = true;
			}

			function update()
			{
				if (this.World.getTime().Days > 2)
				{
					this.World.State.getPlayer().setAttackable(true);
				}

				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("PaymentAfterIntro1", false);
					this.World.Contracts.showActiveContract();
				}
			}

		});
		this.m.States.push({
			ID = "Recruit",
			function start()
			{
				this.Contract.m.Home.getSprite("selection").Visible = false;
				this.Contract.m.BigCity.getSprite("selection").Visible = true;
				this.Contract.m.BulletpointsObjectives = [
					"拜访%townname%%citydirection%的%bigcity%"
				];

				if (this.World.getPlayerRoster().getSize() < 6)
				{
					if (this.Math.max(1, 6 - this.World.getPlayerRoster().getSize()) > 1)
					{
						this.Contract.m.BulletpointsObjectives.push("再招募至少" + this.Math.max(1, 6 - this.World.getPlayerRoster().getSize()) + "个人");
					}
					else
					{
						this.Contract.m.BulletpointsObjectives.push("再招募一个人");
					}
				}

				this.Contract.m.BulletpointsObjectives.push("给你的手下买武器和盔甲");
				this.World.State.getPlayer().setAttackable(false);
				this.Contract.m.BigCity.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.BigCity.getTile().Pos, 500.0);
			}

			function update()
			{
				if (this.World.getTime().Days > 4)
				{
					this.World.State.getPlayer().setAttackable(true);
				}

				if (this.World.getPlayerRoster().getSize() >= 6 && this.Flags.get("IsMarketplaceTipShown"))
				{
					this.Contract.setState("ReturnAfterRecruiting");
				}
				else if (this.World.getPlayerRoster().getSize() >= 6 && this.Contract.m.BulletpointsObjectives.len() == 3)
				{
					this.start();
					this.World.Contracts.updateActiveContract();
				}
				else if (!this.Flags.get("IsMarketplaceTipShown") && this.World.State.getPlayer().getDistanceTo(this.Contract.m.BigCity.get()) <= 600)
				{
					this.Flags.set("IsMarketplaceTipShown", true);
					this.Contract.setScreen("MarketplaceTip");
					this.World.Contracts.showActiveContract();
				}
			}

		});
		this.m.States.push({
			ID = "ReturnAfterRecruiting",
			function start()
			{
				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.Contract.m.BigCity.getSprite("selection").Visible = false;
				this.Contract.m.BulletpointsObjectives = [
					"回到%townname%的%employer%处"
				];
				this.World.State.getPlayer().setAttackable(false);
			}

			function update()
			{
				if (this.World.getTime().Days > 6)
				{
					this.World.State.getPlayer().setAttackable(true);
				}

				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					local tile = this.Contract.getTileToSpawnLocation(this.World.State.getPlayer().getTile(), 6, 10, [
						this.Const.World.TerrainType.Swamp,
						this.Const.World.TerrainType.Forest,
						this.Const.World.TerrainType.LeaveForest,
						this.Const.World.TerrainType.SnowyForest,
						this.Const.World.TerrainType.Shore,
						this.Const.World.TerrainType.Ocean,
						this.Const.World.TerrainType.Mountains
					], false);
					tile.clear();
					this.Contract.m.Location = this.WeakTableRef(this.World.spawnLocation("scripts/entity/world/locations/bandit_hideout_location", tile.Coords));
					this.Contract.m.Location.setResources(0);
					this.Contract.m.Location.setBanner("banner_deserters");
					this.Contract.m.Location.getSprite("location_banner").Visible = false;
					this.Contract.m.Location.setName(this.Flags.get("LocationName"));
					this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).addSettlement(this.Contract.m.Location.get(), false);
					this.Contract.m.Location.setDiscovered(true);
					this.World.uncoverFogOfWar(this.Contract.m.Location.getTile().Pos, 400.0);
					this.Contract.m.Location.clearTroops();
					this.Const.World.Common.addTroop(this.Contract.m.Location, {
						Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW
					}, false);
					this.Const.World.Common.addTroop(this.Contract.m.Location, {
						Type = this.Const.World.Spawn.Troops.BanditThug
					}, false);
					this.Const.World.Common.addTroop(this.Contract.m.Location, {
						Type = this.Const.World.Spawn.Troops.BanditThug
					}, false);

					if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Normal)
					{
						this.Const.World.Common.addTroop(this.Contract.m.Location, {
							Type = this.Const.World.Spawn.Troops.BanditThug
						}, false);
					}

					if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Hard)
					{
						this.Const.World.Common.addTroop(this.Contract.m.Location, {
							Type = this.Const.World.Spawn.Troops.BanditThug
						}, false);
					}

					this.Contract.m.Location.updateStrength();
					this.Contract.setScreen("Briefing");
					this.World.Contracts.showActiveContract();
				}
			}

		});
		this.m.States.push({
			ID = "Finale",
			function start()
			{
				this.Contract.m.Home.getSprite("selection").Visible = false;

				if (this.Contract.m.Location != null && !this.Contract.m.Location.isNull())
				{
					this.Contract.m.Location.getSprite("selection").Visible = true;
				}

				if (this.Contract.m.BigCity != null && !this.Contract.m.BigCity.isNull())
				{
					this.Contract.m.BigCity.getSprite("selection").Visible = false;
				}

				if (this.Contract.m.Location != null && !this.Contract.m.Location.isNull())
				{
					this.Contract.m.Location.setOnCombatWithPlayerCallback(this.onLocationAttacked.bindenv(this));
				}

				this.Contract.m.BulletpointsObjectives = [
					"前往%townname%%direction%的%location%",
					"击杀%boss%。"
				];
				this.Contract.m.BulletpointsPayment = [
					"完成时获得400克朗"
				];
				this.World.State.getPlayer().setAttackable(false);
			}

			function update()
			{
				if (this.World.getTime().Days > 8)
				{
					this.World.State.getPlayer().setAttackable(true);
				}

				if (this.Flags.has("IsHoggartDead") || this.Contract.m.Location == null || this.Contract.m.Location.isNull() || !this.Contract.m.Location.isAlive())
				{
					if (this.Contract.m.Location != null && !this.Contract.m.Location.isNull())
					{
						this.Contract.m.Location.die();
						this.Contract.m.Location = null;
					}

					this.Contract.setScreen("AfterFinale");
					this.World.Contracts.showActiveContract();
				}
			}

			function onLocationAttacked( _dest, _isPlayerAttacking = true )
			{
				local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
				properties.Music = this.Const.Music.BanditTracks;
				properties.BeforeDeploymentCallback = this.onDeployment.bindenv(this);
				this.World.Contracts.startScriptedCombat(properties, true, true, true);
			}

			function onDeployment()
			{
				this.Tactical.getTileSquare(21, 17).removeObject();
				local e = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_raider_low", 21, 17 - 21 / 2);
				e.setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
				e.setName(this.Flags.get("BossName"));
				e.m.IsGeneratingKillName = false;
				e.getAIAgent().getProperties().BehaviorMult[this.Const.AI.Behavior.ID.Retreat] = 0.0;
				e.getFlags().add("IsFinalBoss", true);
				local items = e.getItems();
				items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
				items.equip(this.new("scripts/items/weapons/falchion"));
				local shield = this.new("scripts/items/shields/wooden_shield");
				shield.setVariant(4);
				items.equip(shield);
				e.getSprite("head").setBrush(this.Flags.get("BossHead"));
				e.getSprite("beard").setBrush(this.Flags.get("BossBeard"));
				e.getSprite("beard_top").setBrush(this.Flags.get("BossBeardTop"));
				e.getSprite("hair").setBrush(this.Flags.get("BossHair"));
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_actor.getFlags().get("IsFinalBoss") == true)
				{
					this.Flags.set("IsHoggartDead", true);
					this.updateAchievement("TrialByFire", 1, 1);
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.Contract.m.BigCity.getSprite("selection").Visible = false;
				this.Contract.m.BulletpointsObjectives = [
					"返回%townname%的%employer%处得到报酬"
				];
				this.World.State.getPlayer().setAttackable(false);
			}

			function update()
			{
				if (this.World.getTime().Days > 10)
				{
					this.World.State.getPlayer().setAttackable(true);
				}

				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("Success");
					this.World.Contracts.showActiveContract();
				}
				else if (!this.Flags.get("IsCampingTipShown") && this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() >= 10.0)
				{
					this.Flags.set("IsCampingTipShown", true);
					this.Contract.setScreen("CampingTip");
					this.World.Contracts.showActiveContract();
				}
			}

		});
	}

	function createScreens()
	{
		this.m.Screens.push({
			ID = "Intro",
			Title = "最后一战",
			Text = "[img]gfx/ui/events/event_21.png[/img]一切都搞砸了。两天前，战团被雇来追猎%boss%和他的掠夺者团队，但他们先找到了你们。一场埋伏。有关马的笑话被穿透喉咙的箭矢打断。到处都有箭射来。人们在死前大声的呼喊尖叫。\n\n当箭雨平息时，你和残存的人拔出了武器，却只能跪倒在地上。一支箭刺穿了你的体侧。你疼痛的大叫出声。匆匆一瞥，只见人们不等你就英勇冲上去做最后一搏，钢铁和钢铁近距离的做出碰撞。\n\n你和团长对视了一眼，他在喉咙被切断前最后向你点了下头。现在就由你来指挥仅剩的人。你在痛苦中颤抖着倚靠在你的剑上，用你所能鼓起的所有意志慢慢地重新站起来…",
			Image = "",
			List = [],
			Options = [
				{
					Text = "坚持到底！",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "IntroAftermath",
			Title = "结果",
			Text = "[img]gfx/ui/events/event_22.png[/img]你还活着。你们赢了。\n\n肾上腺素逐渐褪去，你不由自主的重新倒在地上。咬紧牙关后，你折断了箭杆。你的胸膛起伏着，呼吸带痛，一切都变得模糊起来。\n\n战团几近被摧毁，只剩下了几个人。霍加特那个混蛋名副其实，就像黄鼠狼一样逃走了。%SPEECH_ON%现在怎么办，团长？%SPEECH_OFF%一个声音在后面说道。是坐在你边上的%bro2%，正在把他沾血的斧子放在他的腿上。你转身去回答，但在你张口之前他就继续说道。%SPEECH_ON%伯恩哈德死了。他们割断了他的喉咙。他是个好人，也是一个非常优秀的领袖，但一个错误就全没了。这让你成为了现在管事的那个，不是吗？%SPEECH_OFF%%bro3%来到你们身边，仍然剧烈的呼吸着。然后是%bro1%。%SPEECH_ON%把仪式和涂油礼留到其他时候吧。让我们先好好安葬这些人，然后回到%townname%收取我们的报酬。不管怎么说，黄鼠狼的手下都给杀了。除此之外，团长，我们应该在失去你前好好检查下那个伤口。你也不想留下%bro3%来管事，对吧？%SPEECH_OFF%",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "就这样吧。",
					function getResult()
					{
						this.Contract.setState("ReturnAfterIntro");
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.World.getPlayerRoster().getAll()[1].getImagePath());
				this.Characters.push(this.World.getPlayerRoster().getAll()[0].getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "PaymentAfterIntro1",
			Title = "回到%townname%",
			Text = "[img]gfx/ui/events/event_79.png[/img]你们抵达%townname%的场景对旁观者来说看起来多么悲伤。四个浑身是血挂着彩的雇佣兵走了霉运。几天前雇佣了战团的那个人，%employer%，无疑希望你们能用更加荣耀的方式返回。\n\n即便如此，他依旧将你们迎入他的房子，同时让一个仆人去请了医师。在一位老人用颤抖的双手处理你的伤口时，除开几声咕哝和喘息外，几乎没有交谈。一枚针刺入了你的皮肤，这是即将到来的很多针中的第一针。你咬紧牙关，直到你认为自己听到了线断的声音。%employer%坐在你的身旁，问你是否处理掉了霍加特。你摇了摇头。%SPEECH_ON%我们杀掉了他的手下，但黄鼠狼最终躲过了我们的剑刃。%SPEECH_OFF%医师挥动一个发光的火棍，表示他想要把它推进你的伤口里。你点头后他就照做了。片刻间，就是这么简单。你不再是一个人，而是一团火，血肉之火，一具痛苦的傀儡。%employer%递给你一杯酒。%SPEECH_ON%你做的很好，佣兵。强盗被消灭了，虽然霍加特还活着令人遗憾。%SPEECH_OFF%",
			Characters = [],
			ShowEmployer = true,
			List = [],
			Options = [
				{
					Text = "我们希望为此得到报酬。",
					function getResult()
					{
						return "PaymentAfterIntro2";
					}

				}
			],
			function start()
			{
				this.World.Assets.addMoney(400);
				this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "杀了霍加特的手下");
			}

		});
		this.m.Screens.push({
			ID = "PaymentAfterIntro2",
			Title = "回到%townname%",
			Text = "[img]gfx/ui/events/event_79.png[/img]%employer%叹了口气。%SPEECH_ON%好吧，当然！400克朗，正如约定。%SPEECH_OFF%他冲着一个仆人做了个手势，随后仆人拿着报酬快速来到你的身边。%SPEECH_ON%我想…我可以再次使用你们的服务吗？我很想彻底了结霍加特这块心病。当然，我会再次付钱给你们。额外的400克朗，如何？%SPEECH_OFF%%bro2%嗤之以鼻，转身去喝更多的酒，但是%bro1%站起来说道。%SPEECH_ON%是的，战团被毁了，但我们会重建它！没有了%companyname%，%bro2%会把钱全花在酒上最后落得街头乞讨，还有%bro3%，诸神在上，我们都知道他会去追女人直到其中某个把他的朽木脑袋砸扁。我们需要%companyname%，这是我们所拥有的一些！你怎么说，团长？%SPEECH_OFF%%bro2%打了个嗝然后向你举起了他的杯子。%bro3%调皮地扣了下鼻子然后点了点头。%SPEECH_ON%杀不杀那个混球霍加特由你来决定，团长。%SPEECH_OFF%",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "是的，我们和霍加特的事还没完。",
					function getResult()
					{
						return "PaymentAfterIntro3";
					}

				},
				{
					Text = "不，我们会到别的地方试试我们的运气。",
					function getResult()
					{
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Tactical.getEntityByID(this.Contract.m.EmployerID).getImagePath());
				this.Characters.push(this.World.getPlayerRoster().getAll()[0].getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "PaymentAfterIntro3",
			Title = "回到%townname%",
			Text = "[img]gfx/ui/events/event_79.png[/img]%employer%满意地拍了拍手。%SPEECH_ON%好极了！我的探子需要一些时间来找到霍加特的藏身处。与此同时，我建议你们储存一些补给，这样当时机来临时你们就可以做好准备了结这件事。我最迟过几天后见你们！%SPEECH_OFF%当你们离开%employer%的住宅并站在%townname%郊外后，%bro1%找你谈话。%SPEECH_ON%我们需要更多的人手，团长。我知道我在那高谈阔论了一番，但虚张声势没有什么用。我们需要队伍里有更多人。我想我们可以找三个不错的人，给他们买一些像样的武器，给他们穿上我们买得起的最好的护甲。%SPEECH_OFF%这个人暂停了下，环视四周。%SPEECH_ON%我打赌这镇上会有那么几个渴望新生活的平民。或者我们可以前往%citydirection%的%bigcity%，那的市民可能并不像这的土包子一样耐劳，但我们也更可能找到有战斗经验恰巧在那休息的人。%SPEECH_OFF%",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那就是我们将要做的。",
					function getResult()
					{
						this.Contract.setState("Recruit");
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Tactical.getEntityByID(this.Contract.m.EmployerID).getImagePath());
				this.Characters.push(this.World.getPlayerRoster().getAll()[0].getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "MarketplaceTip",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_77.png[/img]当%bigcity%的轮廓出现在地平线上时，%bro3%找你谈话。%SPEECH_ON%我之前从没去过%bigcity%，但去过很多类似的城市。这样的城市很适合卖货，这些大惊小怪的，傲慢自大的混蛋喜欢让他们的货物流通。有这么多商人，你几乎可以找到所有你需要的东西。小心讨价还价，并且不要被奸商骗了。%SPEECH_OFF%%bro2%认为有必要对你应该做的事提出自己的意见。%SPEECH_ON%如果那有一家好的酒馆，我要说那就是我们应该最先去的地方。没有啥比酒更能帮助倒霉的人了。诸神知道这是我们应得的！%SPEECH_OFF%%bro3%摇了摇他的头。%SPEECH_ON%每次我们到城镇你都这么说！甚至你已经喝多了时也一样！%SPEECH_OFF%",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我会记住的。",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				if (this.World.getPlayerRoster().getSize() >= 3)
				{
					this.Characters.push(this.World.getPlayerRoster().getAll()[2].getImagePath());
					this.Characters.push(this.World.getPlayerRoster().getAll()[1].getImagePath());
				}
			}

		});
		this.m.Screens.push({
			ID = "Briefing",
			Title = "未完成的工作",
			Text = "[img]gfx/ui/events/event_79.png[/img]你找到%employer%时他正来回踱步。那个差点用火棍杀了你的医师就站在旁边。他正在从指甲里剔除血块。%employer%拍起了手。%SPEECH_ON%终于，你来了。我有好消息！我们活捉了一个霍加特的前手下！我的这位好朋友和那人进行了一次友好的谈话，现在我知道霍加特在哪里舔舐他的伤口了。%SPEECH_OFF%医师清了清嗓子，张开手指就像有一个少女想要画它们似的。他讲话的口气像是在检查他将要处理的恶疾一样。%SPEECH_ON%那个名为霍加特的强盗藏在这里%direction%%terrain%的一个小营地里。依照我跟他一个手下最文明的交谈，霍加特知道%companyname%还紧紧咬着他的屁股，并且自你们上次遇到他后也召集了更多人手。%SPEECH_OFF%%employer%点着头挥手示意你离开。%SPEECH_ON%祝你好运，佣兵。%SPEECH_OFF%",
			ShowEmployer = true,
			List = [],
			Options = [
				{
					Text = "我们会带着他的头回来！",
					function getResult()
					{
						this.Contract.setState("Finale");
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "AfterFinale",
			Title = "战斗之后",
			Text = "[img]gfx/ui/events/event_87.png[/img]霍加特死在了他自己的血泊中，僵在了一个丑陋且可怕的姿势。这次他没能跟黄鼠狼一样逃掉。你一只脚踩在他的尸体上看向你的手下。%SPEECH_ON%为了战团。为了所有死去的同伴。%SPEECH_OFF%%bro3%朝这个死人脸上吐了口水。%SPEECH_ON%让我们取下这个混球的首级然后返回%townname%%SPEECH_OFF%",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "是时候拿报酬了。",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				if (this.World.getPlayerRoster().getSize() >= 3)
				{
					this.Characters.push(this.World.getPlayerRoster().getAll()[2].getImagePath());
				}
			}

		});
		this.m.Screens.push({
			ID = "CampingTip",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_75.png[/img]%bro3%来到你的身边。%SPEECH_ON%有空吗，团长？%SPEECH_OFF%你点头示意他说出自己的想法。%SPEECH_ON%战斗让一些装备遭到磨损，有些人也受伤了。我们可以在行军时疗伤和修理装备，但扎营下来做这些事情的速度会快很多。当然，如果我们扎营我们应该警惕埋伏。在这附近点起营火各个方向都能看到。%SPEECH_OFF%",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我会记住的。",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				if (this.World.getPlayerRoster().getSize() >= 3)
				{
					this.Characters.push(this.World.getPlayerRoster().getAll()[2].getImagePath());
				}
			}

		});
		this.m.Screens.push({
			ID = "Success",
			Title = "回到%townname%",
			Text = "[img]gfx/ui/events/event_24.png[/img]战团作为胜利者回到了%townname%，这次他们的头抬得高多了。%companyname%不再是之前的规模了，但正如霍加特在最后一刻所学到的那样，他们仍是一支不可小觑的力量。\n\n你把他的头从麻袋里倒在%employer%的脚前。他往后一跳，但医师飞快地捡起头颅盯着看，然后点头。%employer%靠近这名强盗沾血的脸庞并仔细查看。%SPEECH_ON%是的，是的…就是他那张丑脸。仆人！付钱给这位先生！%SPEECH_OFF%手里拿着钱，你高声对手下们说。%SPEECH_ON%只要我们的血管里还流动着血液，只要我们还能拿起剑和盾牌，我们的战团就屹立不倒。整个世界都会知道%companyname%的名字！%SPEECH_OFF%手下们欢呼起来。%bro1%把一只手放在你的肩上。%SPEECH_ON%你做的很棒，团长。不管你带领我们去哪，伙伴们都会跟随你，作为战场上的兄弟。%SPEECH_OFF%",
			ShowEmployer = true,
			Image = "",
			List = [],
			Options = [
				{
					Text = "像兄弟一样！",
					function getResult()
					{
						this.World.Flags.set("IsHoggartDead", true);
						this.Music.setTrackList(this.Const.Music.WorldmapTracks, this.Const.Music.CrossFadeTime, true);
						this.World.Assets.addMoney(400);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "彻底杀了霍加特");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.Music.setTrackList(this.Const.Music.VictoryTracks, this.Const.Music.CrossFadeTime);
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.companion")
					{
						bro.improveMood(1.0, "为战团报了仇");
					}
					else
					{
						bro.improveMood(0.25, "对你的领导有信心");
					}
				}

				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了[color=" + this.Const.UI.Color.PositiveEventValue + "]400[/color]克朗"
				});
			}

		});
	}

	function spawnCorpse( _x, _y )
	{
		local tile = this.Tactical.getTileSquare(_x, _y);
		local armors = [
			"bust_body_10_dead",
			"bust_body_13_dead",
			"bust_body_14_dead",
			"bust_body_15_dead",
			"bust_body_19_dead",
			"bust_body_20_dead",
			"bust_body_22_dead",
			"bust_body_23_dead",
			"bust_body_24_dead",
			"bust_body_26_dead"
		];
		local armorSprite = armors[this.Math.rand(0, armors.len() - 1)];
		local flip = this.Math.rand(0, 1) == 1;
		local decal = tile.spawnDetail(armorSprite, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
		decal.Scale = 0.9;
		decal.setBrightness(0.9);
		decal = tile.spawnDetail("bust_naked_body_01_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
		decal.Scale = 0.9;
		decal.setBrightness(0.9);

		if (this.Math.rand(1, 100) <= 25)
		{
			decal = tile.spawnDetail("bust_body_guts_0" + this.Math.rand(1, 3), this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
			decal.Scale = 0.9;
		}
		else if (this.Math.rand(1, 100) <= 25)
		{
			decal = tile.spawnDetail("bust_head_smashed_01", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
			decal.Scale = 0.9;
		}
		else
		{
			decal = tile.spawnDetail(armorSprite + "_arrows", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
			decal.Scale = 0.9;
		}

		local color = this.Const.HairColors.All[this.Math.rand(0, this.Const.HairColors.All.len() - 1)];
		local hairSprite = "hair_" + color + "_" + this.Const.Hair.AllMale[this.Math.rand(0, this.Const.Hair.AllMale.len() - 1)];
		local beardSprite = "beard_" + color + "_" + this.Const.Beards.All[this.Math.rand(0, this.Const.Beards.All.len() - 1)];
		local headSprite = this.Const.Faces.AllMale[this.Math.rand(0, this.Const.Faces.AllMale.len() - 1)];
		local decal = tile.spawnDetail(headSprite + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
		decal.Scale = 0.9;
		decal.setBrightness(0.9);

		if (this.Math.rand(1, 100) <= 50)
		{
			local decal = tile.spawnDetail(beardSprite + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
		}

		if (this.Math.rand(1, 100) <= 90)
		{
			local decal = tile.spawnDetail(hairSprite + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
		}

		local pools = this.Math.rand(this.Const.Combat.BloodPoolsAtDeathMin, this.Const.Combat.BloodPoolsAtDeathMax);

		for( local i = 0; i < pools; i = ++i )
		{
			this.Tactical.spawnPoolEffect(this.Const.BloodPoolDecals[this.Const.BloodType.Red][this.Math.rand(0, this.Const.BloodPoolDecals[this.Const.BloodType.Red].len() - 1)], tile, this.Const.BloodPoolTerrainAlpha[tile.Type], 1.0, this.Const.Tactical.DetailFlag.Corpse);
		}

		local corpse = clone this.Const.Corpse;
		corpse.CorpseName = "某人";
		tile.Properties.set("Corpse", corpse);
	}

	function spawnBlood( _x, _y )
	{
		local tile = this.Tactical.getTileSquare(_x, _y);
		tile.spawnDetail(this.Const.BloodDecals[this.Const.BloodType.Red][this.Math.rand(0, this.Const.BloodDecals[this.Const.BloodType.Red].len() - 1)]);
	}

	function spawnArrow( _x, _y )
	{
		local tile = this.Tactical.getTileSquare(_x, _y);
		tile.spawnDetail(this.Const.ProjectileDecals[this.Const.ProjectileType.Arrow][this.Math.rand(0, this.Const.ProjectileDecals[this.Const.ProjectileType.Arrow].len() - 1)], 0, true);
	}

	function onPrepareVariables( _vars )
	{
		local bros = this.World.getPlayerRoster().getAll();
		_vars.push([
			"location",
			this.m.Flags.get("LocationName")
		]);
		_vars.push([
			"bigcity",
			this.m.BigCity.getName()
		]);
		_vars.push([
			"boss",
			this.m.Flags.get("BossName")
		]);
		_vars.push([
			"direction",
			this.m.Location != null && !this.m.Location.isNull() ? this.Const.Strings.Direction8[this.m.Home.getTile().getDirection8To(this.m.Location.getTile())] : ""
		]);
		_vars.push([
			"citydirection",
			this.m.BigCity != null && !this.m.BigCity.isNull() ? this.Const.Strings.Direction8[this.m.Home.getTile().getDirection8To(this.m.BigCity.getTile())] : ""
		]);
		_vars.push([
			"terrain",
			this.m.Location != null && !this.m.Location.isNull() ? this.Const.Strings.Terrain[this.m.Location.getTile().Type] : ""
		]);
		_vars.push([
			"bro1",
			bros[0].getName()
		]);
		_vars.push([
			"bro2",
			bros.len() >= 2 ? bros[1].getName() : bros[0].getName()
		]);
		_vars.push([
			"bro3",
			bros.len() >= 3 ? bros[2].getName() : bros[0].getName()
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Location != null && !this.m.Location.isNull())
			{
				this.m.Location.getSprite("selection").Visible = false;
			}

			if (this.m.BigCity != null && !this.m.BigCity.isNull())
			{
				this.m.BigCity.getSprite("selection").Visible = false;
			}

			this.m.Home.getSprite("selection").Visible = false;
			this.World.Ambitions.setDelay(12);
		}

		this.World.State.getPlayer().setAttackable(true);
		this.World.State.m.IsAutosaving = true;
	}

	function onIsValid()
	{
		return true;
	}

	function onSerialize( _out )
	{
		if (this.m.Location != null && !this.m.Location.isNull())
		{
			_out.writeU32(this.m.Location.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		if (this.m.BigCity != null && !this.m.BigCity.isNull())
		{
			_out.writeU32(this.m.BigCity.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local location = _in.readU32();

		if (location != 0)
		{
			this.m.Location = this.WeakTableRef(this.World.getEntityByID(location));
		}

		local bigCity = _in.readU32();

		if (bigCity != 0)
		{
			this.m.BigCity = this.WeakTableRef(this.World.getEntityByID(bigCity));
		}

		this.contract.onDeserialize(_in);
	}

});

