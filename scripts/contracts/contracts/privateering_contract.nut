this.privateering_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Item = null,
		CurrentObjective = null,
		Objectives = [],
		LastOrderUpdateTime = 0.0
	},
	function create()
	{
		this.contract.create();
		local r = this.Math.rand(1, 100);

		if (r <= 70)
		{
			this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
		}

		this.m.Type = "contract.privateering";
		this.m.Name = "私掠";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.MakeAllSpawnsAttackableByAIOnceDiscovered = true;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		local nobleHouses = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);

		foreach( i, h in nobleHouses )
		{
			if (h.getID() == this.getFaction())
			{
				nobleHouses.remove(i);
				break;
			}
		}

		nobleHouses.sort(this.onSortBySettlements);
		this.m.Flags.set("FeudingHouseID", nobleHouses[0].getID());
		this.m.Flags.set("FeudingHouseName", nobleHouses[0].getName());
		this.m.Flags.set("RivalHouseID", nobleHouses[1].getID());
		this.m.Flags.set("RivalHouseName", nobleHouses[1].getName());
		this.m.Payment.Pool = 1300 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else if (r == 2)
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("Score", 0);
		this.m.Flags.set("StartDay", 0);
		this.m.Flags.set("LastUpdateDay", 0);
		this.m.Flags.set("SearchPartyLastNotificationTime", 0);
		this.contract.start();
	}

	function onSortBySettlements( _a, _b )
	{
		if (_a.getSettlements().len() > _b.getSettlements().len())
		{
			return -1;
		}
		else if (_a.getSettlements().len() < _b.getSettlements().len())
		{
			return 1;
		}

		return 0;
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Flags.set("StartDay", this.World.getTime().Days);
				this.Contract.m.BulletpointsObjectives = [
					"前往%feudfamily%的领土",
					"掠夺和焚毁地点",
					"摧毁商队或巡逻队",
					"5天之后返回"
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
				{
					this.Contract.setScreen("Intro");
				}
				else
				{
					this.Contract.setScreen("Task");
				}
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local f = this.World.FactionManager.getFaction(this.Flags.get("FeudingHouseID"));
				f.addPlayerRelation(-99.0, "在战争选择了阵营");
				this.Flags.set("StartDay", this.World.getTime().Days);
				local nonIsolatedSettlements = [];

				foreach( s in f.getSettlements() )
				{
					if (s.isIsolated() || !s.isDiscovered())
					{
						continue;
					}

					nonIsolatedSettlements.push(s);
					local a = s.getActiveAttachedLocations();

					if (a.len() == 0)
					{
						continue;
					}

					local obj = a[this.Math.rand(0, a.len() - 1)];
					this.Contract.m.Objectives.push(this.WeakTableRef(obj));
					obj.clearTroops();

					if (s.isMilitary())
					{
						if (obj.isMilitary())
						{
							this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Noble, this.Math.rand(90, 120) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						}
						else
						{
							local r = this.Math.rand(1, 100);

							if (r <= 10)
							{
								this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Mercenaries, this.Math.rand(90, 110) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
							}
							else
							{
								this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Noble, this.Math.rand(70, 100) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
							}
						}
					}
					else if (obj.isMilitary())
					{
						this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Militia, this.Math.rand(80, 110) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
					else
					{
						local r = this.Math.rand(1, 100);

						if (r <= 15)
						{
							this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Mercenaries, this.Math.rand(80, 110) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						}
						else if (r <= 30)
						{
							obj.getFlags().set("HasNobleProtection", true);
							this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Noble, this.Math.rand(80, 100) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						}
						else if (r <= 70)
						{
							this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Militia, this.Math.rand(70, 110) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						}
						else
						{
							this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Peasants, this.Math.rand(70, 100));
						}
					}

					if (this.Contract.m.Objectives.len() >= 3)
					{
						break;
					}
				}

				local origin = nonIsolatedSettlements[this.Math.rand(0, nonIsolatedSettlements.len() - 1)];
				local party = f.spawnEntity(origin.getTile(), origin.getName() + " Company", true, this.Const.World.Spawn.Noble, 190 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
				party.setDescription("为地方领主服务的专业士兵。");
				this.Contract.m.UnitsSpawned.push(party.getID());
				party.getLoot().Money = this.Math.rand(50, 200);
				party.getLoot().ArmorParts = this.Math.rand(0, 25);
				party.getLoot().Medicine = this.Math.rand(0, 3);
				party.getLoot().Ammo = this.Math.rand(0, 30);
				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					party.addToInventory("supplies/bread_item");
				}
				else if (r == 2)
				{
					party.addToInventory("supplies/roots_and_berries_item");
				}
				else if (r == 3)
				{
					party.addToInventory("supplies/dried_fruits_item");
				}
				else if (r == 4)
				{
					party.addToInventory("supplies/ground_grains_item");
				}

				local c = party.getController();
				local wait = this.new("scripts/ai/world/orders/wait_order");
				wait.setTime(9000.0);
				c.addOrder(wait);
				local r = this.Math.rand(1, 100);

				if (r <= 15)
				{
					local rival = this.World.FactionManager.getFaction(this.Flags.get("RivalHouseID"));

					if (!f.getFlags().get("Betrayed"))
					{
						this.Flags.set("IsChangingSides", true);
						local i = this.Math.rand(1, 18);
						local item;

						if (i == 1)
						{
							item = this.new("scripts/items/weapons/named/named_axe");
						}
						else if (i == 2)
						{
							item = this.new("scripts/items/weapons/named/named_billhook");
						}
						else if (i == 3)
						{
							item = this.new("scripts/items/weapons/named/named_cleaver");
						}
						else if (i == 4)
						{
							item = this.new("scripts/items/weapons/named/named_crossbow");
						}
						else if (i == 5)
						{
							item = this.new("scripts/items/weapons/named/named_dagger");
						}
						else if (i == 6)
						{
							item = this.new("scripts/items/weapons/named/named_flail");
						}
						else if (i == 7)
						{
							item = this.new("scripts/items/weapons/named/named_greataxe");
						}
						else if (i == 8)
						{
							item = this.new("scripts/items/weapons/named/named_greatsword");
						}
						else if (i == 9)
						{
							item = this.new("scripts/items/weapons/named/named_javelin");
						}
						else if (i == 10)
						{
							item = this.new("scripts/items/weapons/named/named_longaxe");
						}
						else if (i == 11)
						{
							item = this.new("scripts/items/weapons/named/named_mace");
						}
						else if (i == 12)
						{
							item = this.new("scripts/items/weapons/named/named_spear");
						}
						else if (i == 13)
						{
							item = this.new("scripts/items/weapons/named/named_sword");
						}
						else if (i == 14)
						{
							item = this.new("scripts/items/weapons/named/named_throwing_axe");
						}
						else if (i == 15)
						{
							item = this.new("scripts/items/weapons/named/named_two_handed_hammer");
						}
						else if (i == 16)
						{
							item = this.new("scripts/items/weapons/named/named_warbow");
						}
						else if (i == 17)
						{
							item = this.new("scripts/items/weapons/named/named_warbrand");
						}
						else if (i == 18)
						{
							item = this.new("scripts/items/weapons/named/named_warhammer");
						}

						item.onAddedToStash("");
						this.Contract.m.Item = item;
					}
				}

				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [];

				foreach( obj in this.Contract.m.Objectives )
				{
					if (obj != null && !obj.isNull() && obj.isActive())
					{
						this.Contract.m.BulletpointsObjectives.push("摧毁 " + obj.getName() + "附近" + obj.getSettlement().getName());
						obj.getSprite("selection").Visible = true;
						obj.setAttackable(true);
						obj.setOnCombatWithPlayerCallback(this.onCombatWithLocation.bindenv(this));
					}
				}

				this.Contract.m.BulletpointsObjectives.push("摧毁任何 %feudfamily% 的商队或巡逻队");
				this.Contract.m.BulletpointsObjectives.push("在%days%之后返回");
				this.Contract.m.CurrentObjective = null;
			}

			function update()
			{
				if (this.Flags.get("LastUpdateDay") != this.World.getTime().Days)
				{
					if (this.World.getTime().Days - this.Flags.get("StartDay") >= 5)
					{
						this.Contract.setScreen("TimeIsUp");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Flags.set("LastUpdateDay", this.World.getTime().Days);
						this.start();
						this.World.State.getWorldScreen().updateContract(this.Contract);
					}
				}

				if (this.Contract.m.UnitsSpawned.len() != 0 && this.Time.getVirtualTimeF() - this.Contract.m.LastOrderUpdateTime > 2.0)
				{
					this.Contract.m.LastOrderUpdateTime = this.Time.getVirtualTimeF();
					local party = this.World.getEntityByID(this.Contract.m.UnitsSpawned[0]);
					local playerTile = this.World.State.getPlayer().getTile();

					if (party != null && party.getTile().getDistanceTo(playerTile) > 3)
					{
						local f = this.World.FactionManager.getFaction(this.Flags.get("FeudingHouseID"));
						local nearEnemySettlement = false;

						foreach( s in f.getSettlements() )
						{
							if (s.getTile().getDistanceTo(playerTile) <= 6)
							{
								nearEnemySettlement = true;
								break;
							}
						}

						if (nearEnemySettlement)
						{
							local c = party.getController();
							c.clearOrders();
							local move = this.new("scripts/ai/world/orders/move_order");
							move.setDestination(this.World.State.getPlayer().getTile());
							c.addOrder(move);
							local wait = this.new("scripts/ai/world/orders/wait_order");
							wait.setTime(this.World.getTime().SecondsPerDay * 1);
							c.addOrder(wait);

							if (party.getTile().getDistanceTo(playerTile) <= 8 && this.Time.getVirtualTimeF() - this.Flags.get("SearchPartyLastNotificationTime") >= 300.0)
							{
								this.Flags.set("SearchPartyLastNotificationTime", this.Time.getVirtualTimeF());
								this.Contract.setScreen("SearchParty");
								this.World.Contracts.showActiveContract();
							}
						}
					}
				}

				if (this.Flags.get("IsChangingSides") && this.Contract.getDistanceToNearestSettlement() >= 5 && this.World.State.getPlayer().getTile().HasRoad && this.Math.rand(1, 1000) <= 1)
				{
					this.Flags.set("IsChangingSides", false);
					this.Contract.setScreen("ChangingSides");
					this.World.Contracts.showActiveContract();
				}

				foreach( i, obj in this.Contract.m.Objectives )
				{
					if (obj != null && !obj.isNull() && !obj.isActive() || obj.getSettlement().getOwner().isAlliedWithPlayer() || obj.isAlliedWithPlayer())
					{
						obj.getSprite("selection").Visible = false;
						obj.setAttackable(false);
						obj.getFlags().set("HasNobleProtection", false);
						obj.setOnCombatWithPlayerCallback(null);
					}

					if (obj == null || obj.isNull() || !obj.isActive() || obj.getSettlement().getOwner().isAlliedWithPlayer() || obj.isAlliedWithPlayer())
					{
						this.Contract.m.Objectives.remove(i);
						this.Flags.set("LastUpdateDay", 0);
						break;
					}
				}
			}

			function onCombatWithLocation( _dest, _isPlayerAttacking = true )
			{
				this.Contract.m.CurrentObjective = _dest;

				if (_dest.getTroops().len() == 0)
				{
					this.onCombatVictory("RazeLocation");
					return;
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "RazeLocation";
					p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
					p.LocationTemplate.Template[0] = "tactical.human_camp";
					p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.None;
					p.LocationTemplate.CutDownTrees = true;
					p.LocationTemplate.AdditionalRadius = 5;

					if (_dest.isMilitary())
					{
						p.Music = this.Const.Music.NobleTracks;
					}
					else
					{
						p.Music = this.Const.Music.CivilianTracks;
					}

					p.EnemyBanners = [];

					if (_dest.getSettlement().isMilitary() || _dest.getFlags().get("HasNobleProtection"))
					{
						p.EnemyBanners.push(_dest.getSettlement().getBanner());
					}
					else
					{
						p.EnemyBanners.push("banner_noble_11");
					}

					if (_dest.getFlags().get("HasNobleProtection"))
					{
						local f = this.Flags.get("FeudingHouseID");

						foreach( e in p.Entities )
						{
							if (e.Faction == _dest.getFaction())
							{
								e.Faction = f;
							}
						}
					}

					this.World.Contracts.startScriptedCombat(p, _isPlayerAttacking, true, true);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "RazeLocation")
				{
					this.Contract.m.CurrentObjective.setActive(false);
					this.Contract.m.CurrentObjective.spawnFireAndSmoke();
					this.Contract.m.CurrentObjective.clearTroops();
					this.Contract.m.CurrentObjective.getSprite("selection").Visible = false;
					this.Contract.m.CurrentObjective.setOnCombatWithPlayerCallback(null);
					this.Contract.m.CurrentObjective.setAttackable(false);
					this.Contract.m.CurrentObjective.getFlags().set("HasNobleProtection", false);
					this.Flags.set("Score", this.Flags.get("Score") + 5);

					foreach( i, obj in this.Contract.m.Objectives )
					{
						if (obj.getID() == this.Contract.m.CurrentObjective.getID())
						{
							this.Contract.m.Objectives.remove(i);
							break;
						}
					}

					this.Flags.set("LastUpdateDay", 0);
				}
			}

			function onPartyDestroyed( _party )
			{
				if (_party.getFaction() == this.Flags.get("FeudingHouseID") || this.World.FactionManager.isAllied(_party.getFaction(), this.Flags.get("FeudingHouseID")))
				{
					this.Flags.set("Score", this.Flags.get("Score") + 2);
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"返回" + this.Contract.m.Home.getName()
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;

				foreach( obj in this.Contract.m.Objectives )
				{
					if (obj != null && !obj.isNull() && obj.isActive())
					{
						obj.getSprite("selection").Visible = false;
						obj.setOnCombatWithPlayerCallback(null);
					}
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("Score") <= 9)
					{
						this.Contract.setScreen("Failure1");
					}
					else if (this.Flags.get("Score") <= 15)
					{
						this.Contract.setScreen("Success1");
					}
					else
					{
						this.Contract.setScreen("Success2");
					}

					this.World.Contracts.showActiveContract();
				}
			}

		});
	}

	function createScreens()
	{
		this.importScreens(this.Const.Contracts.NegotiationDefault);
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = "谈判",
			Text = "[img]gfx/ui/events/event_45.png[/img]{你走进%employer%的房间，他立刻开始说话。%SPEECH_ON%{很高兴见到你，雇佣兵。我需要一个掠夺小队去把%feudfamily%的锅碗瓢盆弄得一塌糊涂，你懂我的意思吧？嗯，简单说我需要你进入他们的领地，烧毁你能找到的一切东西。我想持续这样%days%时间会对他们的战争资源造成真正的伤害。但是一定要小心敌人巡逻队。 | 啊，雇佣军。听着，我需要一些勇敢的人穿越%feudfamily%的领地，烧毁他们遇到所有商队和庄稼。这工作不光彩，但有助于结束战争。我需要你在那里呆%days%时间，然后回来。 | 我需要一个掠夺小队潜入%feudfamily%领地%days%，尽可能多地摧毁他们的资源。你们会被憎恨的，敌人会紧追不舍，但是如果你能避开他们的巡逻，这项工作应该会很快很容易完成。你觉得怎么样？ | 我们正在与%feudfamily%开战，但战争需要的不仅仅是军队间的激烈冲突。有时候，战争也需要一些隐秘行动。雇佣兵，我需要你去袭击%feudfamily%的领地，持续%days%。摧毁商队，烧毁庄园，任何有助于我方的行为都行。当然，你应该警惕敌方巡逻队。如果是我知道你要来侵犯我的土地和人民，我会以双倍的力量反击你。那么，你怎么说？ | 我直接说白了，我需要有人去袭击%feudfamily%的领地%days%。当然，他们会对和你类似的人有所准备，所以你要尽力避免任何巡逻队。你有兴趣吗？ | 雇佣兵，我有一份适合你的工作。我要你去袭击%feudfamily%的领地，尽可能地摧毁他们的一切，大约%days%。这种行动可以帮助结束战争。当然，他们也会明白这个道理，并会竭尽全力阻止你。}%SPEECH_OFF% | %employer%欢迎你进入他的房间，指着桌子上铺开的地图。%SPEECH_ON%你是否知道对抗一个人最好的方式是确保他根本无法战斗？我在一本旧书上读到过这个观点。%SPEECH_OFF%这是非常艺术化的战争观，但却是真实的。你点了点头，那人继续说道。%SPEECH_ON%我想让你前往%feudfamily%的领地，尽可能地破坏他们的领地，摧毁商队，烧毁农场等等。在%days%内尽可能地造成更多的损失，然后返回。哦，最后一件事。要警惕敌方巡逻队，他们不会善待你的那些特别行动的。%SPEECH_OFF% | 你发现%employer%正在看一本书，他正在用羽毛笔做笔记。%SPEECH_ON%我爷爷曾经打败了比己方大十倍的军队，他是怎么做到的？那些受我的家族雇佣和供养的历史学家和文书讲述了战场上的宏伟故事，但那不是真相。你知道真相吗？%SPEECH_OFF%你耸了耸肩，猜测他的祖父使用了某种诡计。这位贵族把书狠狠地合上，简短竖了下手指。%SPEECH_ON%正是如此！他带着一小撮人烧了他们所有的农场、谷仓和食物仓库。如果你不能喂饱庞大的军队，那么多的士兵有什么用呢？雇佣兵，我需要你完成同样的事情。进入%feudfamily%领地%days%，尽可能多地摧毁他们的财产。当然，要避开巡逻队。如果他们抓到你，他们肯定会恶战一场来要你项上人头。%SPEECH_OFF% | 你走进%employer%的房间，发现他正在与一位年迈的将军争吵。这个将军站直了身子。%SPEECH_ON%我不会用这样卑鄙的行为来玷污我家族的名誉。如果你想采取这种方式，就找一个出身卑微的人来做吧！%SPEECH_OFF%将军拿起他的东西愤怒地离开，几乎撞到你。当你走进来时，%employer%微笑着。他张开双臂说道。%SPEECH_ON%好啊，说恶魔，恶魔到。雇佣兵，我需要有人去袭击%feudfamily%的领地，为期%days%。我的贵族指挥官认为这件事情太低贱了，但我认为你一样能把事情办好。当然，我们的敌人也会认为这太低贱了，所以如果他们找到你，你要做好准备，因为他们不会手下留情。%SPEECH_OFF% | %employer%盯着洒了的牛奶流过桌面滴下桌边。%SPEECH_ON%你有没有过因为类似这样的小事而毁了一天啊？%SPEECH_OFF%你点了点头，谁没有过呢？他接着说。%SPEECH_ON%我本来打算做奶酪，可现在做不了了，材料都被毁了。雇佣兵，这句话同样适用于战争。我需要你去突袭%feudfamily%的领地，把他们的“牛奶”给扬了，摧毁上回、烧毁农场、弄塌矿井，不惜一切代价。这样做%days%，应该就能达到目的。当然，在你外出期间，要小心他们的巡逻队，如果你在我领地做这些勾当，我一定会把你的脑袋插在木桩上！%SPEECH_OFF% | 一个卫兵领你去见%employer%，他正在花园里修剪一些作物。植物都倒了下来，它们的叶子被侵害的昆虫啃得参差不齐。%employer%拿起一株死亡的植物讲道。%SPEECH_ON%这些作物本来在这个季节很强势，现在却被最小的虫子击败了。我相信对于那些微小的家伙来说，这是一个伟大的时刻。%SPEECH_OFF%他扔掉植物，拍了拍你的肩膀。%SPEECH_ON%雇佣兵，我需要你成为敌人花园里跟恶魔一样的昆虫。至少要袭击%feudfamily%的领地%days%。当然，如果他们抓住你，他们会像对待虫子一样对待你，把你压扁。所以要避开敌人，你知道，就像虫子一样。%SPEECH_OFF% | 在你走进雇主房间的时候，%employer%正在和一个妇女说笑。她迅速收拾好自己的东西，匆匆离开，视线没有正视你。这位相当得意的贵族给自己倒了一杯酒。%SPEECH_ON%不用理她，她是我太太的朋友，仅此而已。%SPEECH_OFF%他把酒瓶放回书桌上。%SPEECH_ON%说到朋友，你能否去掠夺一下%feudfamily%的领地呢？%SPEECH_OFF%这个人在往前迈步的时候踉跄了一下，最终坐在了桌子边缘。他闻了闻自己的手指，耸了耸肩，喝了一口酒。%SPEECH_ON%前往他们的领地，摧毁尽可能多的东西，持续%days%，然后就可以回来了。当然你也可以一直留在那里，但我强烈建议你回来，因为他们的军队不会对你的行为坐视不管。贵族们很少喜欢侵略者，我相信你知道那里面的政治利害。%SPEECH_OFF% | %employer%正被他的指挥官们环绕着。他招手让你走过来，并指着手指，好像在指责你犯下了你根本不知道的罪行。%SPEECH_ON%就是他了! 这个人将会去做这件事情! 佣兵! 我需要老练的战士去掠夺%feudfamily%的土地%days%的时间。摧毁尽可能多的东西，伤害他们进行战争的能力。当然，要保持灵活，他们会迅速粉碎他们发现的一切袭击。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{五天的工期可不便宜。 | 这是 %companyname% 可以解决的事。 | 报酬呢？}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这不值得。 | 我们还有别的地方要去。 | 对战队而言太耗时间了。}",
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "SearchParty",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_90.png[/img]{你接近了一个农场，突然其中一个百叶窗嘭地打开。 一个老妇人用沙哑的声音喊叫着同时摇着一面白旗。%randombrother% 前去检查了一番，听她说了一会后快速赶了回来。%SPEECH_ON%先生，她说 %feudfamily% 知道我们的位置而且一大股敌军正向我们而来。 而且是的，她用了“股”这个词。%SPEECH_OFF% | 在你经过一个农舍时一个小男孩从中跑出来。%SPEECH_ON%噢，你是要去杀强盗的人吗？%SPEECH_OFF%你问他谁说的。他耸耸肩。%SPEECH_ON%我在酒馆晃荡时听说 %feudfamily% 知道了强盗的位置并派出大家伙们去好好揍他们一顿！%SPEECH_OFF%男孩像在碾虫子般拍了下手。 你搓了搓这小子的头发。%SPEECH_ON%当然，那就是我们。现在回家吧。%SPEECH_OFF%你快速向 %companyname% 转告了消息。 | %randombrother% 从山坡上跑下来。 他跑到你边上，大口哈着气。%SPEECH_ON%先生，我…他们…%SPEECH_OFF%他挺起身。%SPEECH_ON%我需要点锻炼。但那不是我过来要告诉你的！ 有一支非常大的部队正向我们靠近。 我想他们知道我们的具体位置，先生。%SPEECH_OFF%你点头并告诉伙计们做好准备。 | 一份侦查任务的报告说有一支巨大的地方巡逻队看起来知晓你的位置并正在靠近！ %companyname% 应该做好准备，不论是要逃还是准备接战。 | 你被发现了并且 %feudfamily% 的一支大部队正在靠近！ 尽可能让伙计们做好准备，因为报告说这些敌人武装精良。 | %randombrother% 向你报告道他从一些当地人打听到的消息。 他们说一大批士兵带着面旗子正在靠近。 你让雇佣兵描述上面的纹章而他细致的描述了出来：它属于 %feudfamily%的人。 他们不知怎么但肯定追上你了。 %companyname% 应该为一场硬仗做好准备！ | 一群正在溪流里洗衣服的女人问你还在这里干什么。 你问她们在说什么。 其中一个笑了起来，似乎有点粗鲁。%SPEECH_ON%再说一遍？我们问你还在这里干什么。 你知道 %feudfamily% 正严厉打击你这样的人。 我听说，他们很快就要追上你了。%SPEECH_OFF%你问她们怎么知道的。 其中另一个女士把一件衣服拍在溪流里。%SPEECH_ON%先生，你可真够笨的。 谣言比任何马跑得都快。 别问怎么。事情就这样。%SPEECH_OFF%如果这些女人说的是实话，那很显然 %companyname% 有场硬仗要打了！ | 你走上丘顶并尽量详细的环顾了四周的状况。 没什么特别的，除了一大群人扛着 %feudfamily% 的旗帜并且看起来正向你靠近。 那可真是番绝景而且很快你就能面对面地看着它了。\n\n 敌人追上了 %companyname%！烧了他们的宝贝的你最好准备面对场硬仗。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "小心点！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "TimeIsUp",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_36.png[/img]{差不多 %maxdays% 了。 战队应该准备回头找 %employer% 拿报酬了。 | 战队已经呆了 %maxdays%。%employer% 现在应该正等着你回去。 | 用了 %maxdays% 掠夺，你达到了时间要求并该回去找 %employer% 领报酬了。 不需要再花一秒钟干你拿不到报酬的事。 | %employer% 雇佣你 %maxdays%。战队不应在不必要的情况下继续待在这里。 该回去找他拿报酬了。 | %companyname% 已经用了 %maxdays% 替 %employer% 办事了。 他付的钱也只要求你干这么久所以你最好现在就回去找他。 | %employer% 付了 %maxdays% 的钱，你也干了这么长时间。 %companyname% 应该快点回去找他拿报酬。 | 尽管你逐渐适应起在这片土地上肆虐的日子，%employer% 只付了 %maxdays% 的钱。 你最好现在就回去找他。 | 你做的很好，但是时候回去找 %employer% 了，因为他只会给你 %maxdays% 的钱。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "是时候回 %townname%。",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ChangingSides",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_51.png[/img]{路上，一个披着黑色斗篷的人缓慢靠近。 他的面容藏在兜帽厚重的阴影中。 他在你面前停下并露出双手。%SPEECH_ON%欢迎。我是 %rivalhouse% 的信使。我们有一个提案。 为 %noblehouse% 放下武器，加入我们。 这边工作少不了你的，而且你的战队永远会优先拿到最好的单子。 作为见面礼，我受命给与你这把极品的武器 %nameditem%。%SPEECH_OFF%你仔细考虑这个主意。 临阵换边是雇佣兵生活的常态。 哪一边的贵族家族对战队更好？ 哪边的家族更有可能赢？ | 你离开路上撒个尿。 在你放松着的时候，一个人突然从湿漉漉的草丛中冒出来，尽管看起来挺干的。 你后跳拔出了匕首，但他举起了双手。%SPEECH_ON%喔噢，佣兵。我是 %rivalhouse% 的信使。我来提议，并且只是提议，给你一份交易。 加入我们。你会优先获得我们发布的单子，意味着最好的任务和最好的报酬，并且听我说，我们永远有活给你。 为表达诚意，我受命向你展示这个。%SPEECH_OFF%他慢慢的掏出一把精工武器。 你告诉他等会，让你把尿撒完。 思绪从你头中涌出同时别的东西从你的另一个头涌出。 | 在侦查地形时，一个披着黑斗篷的人靠近过来。%randombrother% 抓住他的兜帽并把利刃抵在他的脖子上。 这个人举起双手并说他是给 %rivalhouse% 来带个口信的。你点头示意他说，他继续道。%SPEECH_ON%我们有一个提案：加入我们。 抛弃那些你在服侍的落魄贵族并来为我们工作。 你会拿到最好的任务和最好的报酬，并且最好的是，你会站在胜利者这边！ 如果你同意，作为好意，你会得到这把被称作 %nameditem% 的精美武器。如果你同意，当然。%SPEECH_OFF%你仔细考虑了这个提议，因为反边不应该轻描淡写。 | 一个阴暗的人影从小路上走来，一只手拿着一个卷轴。%SPEECH_ON%晚上好，%companyname%。我来自 %rivalhouse% 提供服务。 抛弃你的雇主加入我们。 你会找到更好更丰富的合同，更好的是，你会站在这场战争的胜利一边！ 如果你同意，作为诚意的象征，你将收到一个武器名为 %nameditem%。%SPEECH_OFF%%randombrother% 看着你耸耸肩。%SPEECH_ON%不想越级发表意见，但我想着值得衡量。%SPEECH_OFF%确实是。 | 你从队伍里离开去侦查地形。 在观察着你面前的空地时，一个披着斗篷的人突然冒出来带着什么突出的东西。%randombrother% 出现并把他按在地上并用利刃抵好了他的脖子。 陌生人举起手，手里拿着一张卷起的卷轴。 你告诉他站起来自报身份。 他声称他来自 %rivalhouse% 并且他有个提案给 %companyname%。%SPEECH_ON%换边。作为雇佣兵，这么做也没有什么荣誉可以丢的，而且这会是完全意料之中的。 逐利，对吧？ 那么，我们有最多的任务和最好的报酬。 那就是你想要的，不是吗？%SPEECH_OFF%信使整理了他的服装，像一个稍受尴尬的使节一样挺直身子。%SPEECH_ON%额外的，如果你决定接受，我受命给予你这把被称为 %nameditem% 的武器，以示善意。 那么，怎么样？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "有趣的提议。我接受。",
					function getResult()
					{
						return "AcceptChangingSides";
					}

				},
				{
					Text = "你在浪费时间。 滚，不然你就挂在那棵树上。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "AcceptChangingSides",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_51.png[/img]{你接受这个提议。 神秘的信使带你到一片隐秘的矮林并在草丛后挖出了武器交给你。%SPEECH_ON%交易愉快，佣兵。%SPEECH_OFF%%employer% 和他的家族现在肯定相当恨你了。 | 在你接受交易后，信使带你离开路上去从些灌木丛后取出武器。 将它交给你时，他与你握了握手。%SPEECH_ON%你做了正确的决定，佣兵。%SPEECH_OFF%%employer% 现在无疑会生气所以不用回去找他了，当然，除非你的新雇主要求这么做。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "%companyname% 从此将为 %rivalhouse% 工作！",
					function getResult()
					{
						this.Contract.m.Item = null;
						local f = this.World.FactionManager.getFaction(this.Contract.getFaction());
						f.addPlayerRelation(-f.getPlayerRelation(), "在战争中改变了立场");
						f.getFlags().set("Betrayed", true);
						local a = this.World.FactionManager.getFaction(this.Flags.get("RivalHouseID"));
						a.addPlayerRelationEx(50.0 - a.getPlayerRelation(), "在战争中改变了立场");
						a.makeSettlementsFriendlyToPlayer();
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractBetrayal);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				this.updateAchievement("NeverTrustAMercenary", 1, 1);
				this.World.Assets.getStash().makeEmptySlots(1);
				this.World.Assets.getStash().add(this.Contract.m.Item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + this.Contract.m.Item.getIcon(),
					text = "你获得了" + this.Contract.m.Item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer% welcomes you into his room. 他给你装着 %reward_completion% 克朗的袋子。%SPEECH_ON%在那边做得好，佣兵。 你几乎做到了我能要求的一切。%SPEECH_OFF% | %employer% 被找到时正照顾着一群鸡。 你驱赶着从鸡群中开出一条路靠近他以向他报告。他积极地回应道。%SPEECH_ON%啊是吗？那很好。 你想以鸡食还是克朗结算？%SPEECH_OFF%贵族一本正经地看着你直到嘴角背叛了他。%SPEECH_ON%你可以在那边站着的卫兵那里找到 %reward_completion% 克朗。 他会知道要交给你的。%SPEECH_OFF% | %employer% 没空见你，但他的一个卫兵交给你的 %reward_completion% 克朗看起来足够丰满以证明他对你工作的满意。 | %employer% 把一根手指插入酒杯。%SPEECH_ON%掠夺是脏活，但你在那边干的不错。 得承认，我有点希望你给我的敌人带来末日，但我想你做的够好了。%SPEECH_OFF%他收回手指舔了一下丢给你装着 %reward_completion% 克朗的袋子。 | %employer% 坐在他的椅子上，手耷拉在扶手上，翘着脚。%SPEECH_ON%你 %reward_completion% 的报酬就在那。%SPEECH_OFF%他向房间角落里点头，那里一个包裹抵着墙。 你走过去拿上它，同时他继续说道。%SPEECH_ON%我得说你干的不错。 那袋子的重量代表着我的满意。%SPEECH_OFF% | 你发现 %employer% 在狗笼喂着它的狗。%SPEECH_ON%做得好，佣兵。如果我们的士兵们都有你的体质和意志，这场战争会在第一次见到月亮前结束。 真遗憾，不是吗？%SPEECH_OFF%他突然转向你，眼神很认真。 你想这是一种委婉的试图招募你加入他的军队。 你礼貌的给出了一个非常正式的拒绝后询问起报酬的事。 他继续说起来，用耷拉着的培根指着路另一边站着的一个人。%SPEECH_ON%那个卫兵手里。总共 %reward_completion% 克朗。%SPEECH_OFF% | %employer% 感谢你的服务。 那就是他所说的全部内容，然后交给了你 %reward_completion% 克朗。 | 你看到 %employer% 被他的指挥官们围了起来。 他们在根据你的工作结果调整战略地图。 贵族起身看着结果。%SPEECH_ON%这不是我所能要求的一切，但不错。非常好。 我那边站着的卫兵会给你取来 %reward_completion% 克朗。%SPEECH_OFF% | %employer% 站在墙上的地图前。 他用一支毛笔记笔记而且你意识到这些标记跟着 %companyname% 在 %feudfamily%的领地内的行动路线。 贵族哼了一声并点了点头。他没有看向你就这么说道。%SPEECH_ON%这不是最好的结果，但是还不错。%reward_completion% 克朗就在角落里等着你。%SPEECH_OFF% | %employer%的一个指挥官阻止了你进入他的房间。 He hands over a satchel of %reward_completion% crowns.%SPEECH_ON%大人很忙。 请拿上你的报酬然后离开。%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "诚实的工作得到诚实的报酬。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "掠夺敌人的土地");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isCivilWar())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnCommonContract);
						}

						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Success2",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer% 和他的指挥官们在你进入他们的房间时都喝醉了。 其中一个高大的将军拍了拍你的肩膀，看起来想说什么，然后转身开始呕吐。 你赶快走开并找到了 %employer% 本人。%SPEECH_ON%啊，佣兵！我－嗝－好吧，这。%reward_completion% 克朗。%SPEECH_OFF%他举起一个袋子，你快速的拿上了它以免它遭遇仍在你背后呕吐的指挥官相似的命运。%employer% 软绵绵的往后晃荡到倚在他的办公桌上。%SPEECH_ON%你他妈的几乎在 %feudfamily%的战争能力上一拳打出了个大洞。 干的－嗝－真他妈的好！ 我听过的最他妈的工作，好的，好工作。%SPEECH_OFF%你从房间里撤出，在活动与呕吐物的城市中来回躲闪。 | %employer% 把酒杯拍下，把里面的酒大部分都撒到了他的身上。%SPEECH_ON%好极了！太棒了！完美！这是我得对你的表现说的，佣兵。天啊，我们甚至抓到了几个从 %feudfamily%的军队里跑来的逃兵，他们很担心他们那一边已经输了！ 这，拿上 %reward_completion% 克朗。算我的。%SPEECH_OFF%这人爆笑起来并长饮一口。 | 你走进 %employer%的房间发现他正在研究这一张战略地图。 他用笔挠着它的下巴，自言自语并时不时的点着头。%SPEECH_ON%你知道的，我刚刚为了记录你穿越 %feudfamily% 领土的路线而用光了墨水。 你干的太他妈好了，佣兵。 你能在那边的角落里找到 %reward_completion% 克朗。%SPEECH_OFF% | 一个人拿着沉重的袋子在 %employer%的房门外迎接你。%SPEECH_ON%%reward_completion% 克朗，为你的服务。 我的殿下很忙，但非常高兴。 希望这能表达他对你工作成果的满意程度。%SPEECH_OFF%这可真是份沉重的满意，确实。 | 一个卫兵领你到 %employer%，他在一面上锁的门后面。 里面有个女人和他在一起而且他看起来状态有点…喜庆。 卫兵想了想要不要敲门，然后决定不这么做。%SPEECH_ON%我受命来通知他你来了，但他不喜欢被打扰。 不是这种时候。 你懂的。好时候。%SPEECH_OFF%你点头并问你的报酬在哪。 卫兵带你到了账房。 你见了一个坐在成堆的纸和硬币后长着鹰钩鼻的人。 他向你推过来 %reward_completion% 克朗然后在一张卷轴上记录下这逼交易。 | %employer% 在他的花园会见了你。 他在视察着一些仆人在沃土中的栽培工作。%SPEECH_ON%你的花园里有些什么，佣兵？%SPEECH_OFF%你客气的告诉他你不是会搞园艺的类型。 他点头好像这对他而言很有趣。%SPEECH_ON%我在思考要不要种点蔓菁给下个季度。 不论如何，闲话少说。 看到那边流着汗的仆人了吗？ 他带着那个沉重的袋子。 它重是因为装着 %reward_completion% 克朗。 作为你很出色的完成了工作的报酬，佣兵。 或许你可以给自己买个院子了！%SPEECH_OFF% | %employer% 和他的指挥官们挤在一张战略地图前。 其中一人推着一颗带有你战队纹章的代币。 他追踪着那枚代币越过整张地图，用一张带墨的木棍不时的点下标记。 你叉起手大声说道。%SPEECH_ON%享受着我的工作，是吗？%SPEECH_OFF%贵族和他的指挥官们抬头看向你。%employer% 笑起来快速走过房间。%SPEECH_ON%你不知道吗！ 你做的非常棒，雇佣兵。真的。 那边那个卫兵拿着你的 %reward_completion% 克朗的报酬。%SPEECH_OFF% | %employer% 站在他的指挥官们中间。 他在你进入房间时高喊。%SPEECH_ON%天，啊，小伙子！你几乎摧毁了他们有的一切！ 像我这样的人，除了从天上射出一道霹雳，还能要求什么呢？ 你会拿到 %reward_completion% 克朗的报酬，我觉得这对于这样一份高质量的工作来说是绰绰有余的！%SPEECH_OFF% | 你看到 %employer% 坐在他的房间里。 他看起来和你在一起很高兴。%SPEECH_ON%{好家伙，这不是今天的天选之人吗。 我听了一大群小鸟从我窗中飞过来向我叙述你的成果。 当你做的那么好时消息传得可快了！%feudfamily% 受到重挫而且战争向结束迈出了许多步！ 我准备好了 %reward_completion% 克朗的袋子，就在那边的角落里。 | 你应该更喜庆点，佣兵。 你对 %feudfamily% 的成果超出了我所要求的一切。 我很惊讶你没有就那么再进一步就那么杀光他们整条血脉。 啊，一切会有时候的。 现在，你有 %reward_completion% 克朗就在那边的角落里等着你呢。}%SPEECH_OFF% | 你发现 %employer% 蹲在一张摆着战略地图的桌子前。 他的眼睛沿着边缘，扫描这一条代币组成的地平线。%SPEECH_ON%欢迎，佣兵。%SPEECH_OFF%他跃起身, 用一只手，他缓慢地拿起代表着 %feudfamily% 的代币并开始把它们丢到一边。%SPEECH_ON%好好享受你的手艺吧，佣兵。 你毫不费力地成功重创了我的敌人！ 我为自己发声，但你做的远超任何大型战役的效果！%reward_completion% 就在那边角落里等着你。 我希望那份报酬足够，因为你的成果显然够好。%SPEECH_OFF% | 你发现 %employer% 和他的指挥官们以及一群女人穿着不太适合任何你所知的战斗的衣服。%SPEECH_ON%佣兵！快进来%SPEECH_OFF%%employer% 向后倒，一边抱着一个女人。 你尽力跟着他。 一个女人试图把你拽进排队，但一个将军征用了她。%employer% 倒在椅子上，女人坐在他的大腿上。%SPEECH_ON%你是这场庆典的缘由，雇佣兵。 你在 %feudfamily%的领地掠夺，好到我想你做的比起任何大战都更让我们接近了结这场战争！干杯！%SPEECH_OFF%你看了看四周。%SPEECH_ON%活动不错，但我不用为了女人和酒去战斗。 你欠我钱。%SPEECH_OFF%你的雇主点头。%SPEECH_ON%当然，当然！ 去见我的司库，给他看看你的印章。 他那里有 %reward_completion% 克朗等着你呢。%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "诚实的工作得到诚实的报酬。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess * 2);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess * 2, "掠夺敌人的土地");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isCivilWar())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnCriticalContract);
						}

						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_45.png[/img]{你走进 %employer%的房间准备好面对他的愤怒。 而且他确实很愤怒。%SPEECH_ON%让我把这说清楚，佣兵。 我提出雇你去劫掠 %feudfamily%的领地。 你接受了这个交易因为，我想它是，一个非常好的提案而且双方都有利可图。 现在你站在我面前说你对我们的约定放了个屁。 为什么你还要走过那扇门你个狗杂种？ 不，你比那更糟，你这令人作呕的蠕虫试图对一个进行着高尚工作的贵族行窃。 在我爆脾气之前离开这里。%SPEECH_OFF%尽管 %employer% 是在虚张声势，他才是在陷入愤怒的人。 你在你的脾气带着一个贵族的命一起爆掉前快速离开了。 | 你找到 %employer% 但一个卫兵将你阻在门外。%SPEECH_ON%他已经知道你做的，或者我应该说没做的。 你最好不要进去。%SPEECH_OFF%被掀翻的桌子的敲打声震的门直响。 一声尖叫随之而来。 你接受了卫兵的建议并离开了。 | %employer% 手指划过他杯子的边缘。 它随着他缠绕大声地呜咽着，一次又一次。%SPEECH_ON%真是甜蜜，美妙的音调。 一个简单的杯子，怎么会比你更好呢，雇佣兵？ 我想这就是这个世界有时候的样子。 我让什么人去做点事，然后他们不去做它。 还有什么可说的呢？请，出去。%SPEECH_OFF% | 你发现 %employer% 给他的狗们喂垃圾。 边上看着的仆人们看起来遭遇这种待遇时宁愿做狗。%employer% 转向你，一只狗轻轻的从他手中滑出一块培根。%SPEECH_ON%狗对肉很感兴趣。 这，我喂给它们一只猪的遗骸。 它是头好猪。 一头一生都过得不错的猪，当然，直到一个非常坏的时刻。 现在它喂了我的狗。 你，佣兵，在你自己的生命中给我带来了一个非常坏的时刻。 我应不应该把你也喂给我的狗？ 不？那么滚出我的房间。%SPEECH_OFF% | %employer% 拒绝与你见面。 两个他的卫兵解释说他对你没能对 %feudfamily%的领地造成任何伤害非常生气。 很合理。你为卫兵们使你免于一个贵族无意义的羞辱和愤怒轰炸向他们致谢。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "去你妈的！",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "掠夺敌人的土地失败");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"noblehouse",
			this.World.FactionManager.getFaction(this.m.Faction).getName()
		]);
		_vars.push([
			"rivalhouse",
			this.m.Flags.get("RivalHouseName")
		]);
		_vars.push([
			"feudfamily",
			this.m.Flags.get("FeudingHouseName")
		]);
		_vars.push([
			"maxdays",
			"5天"
		]);
		local days = 5 - (this.World.getTime().Days - this.m.Flags.get("StartDay"));
		_vars.push([
			"days",
			days > 1 ? "" + days + "天" : "1天"
		]);

		if (this.m.Item != null)
		{
			_vars.push([
				"nameditem",
				this.m.Item.getName()
			]);
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			foreach( obj in this.m.Objectives )
			{
				if (obj != null && !obj.isNull() && obj.isActive())
				{
					obj.clearTroops();
					obj.setAttackable(false);
					obj.getSprite("selection").Visible = false;
					obj.getFlags().set("HasNobleProtection", false);
					obj.setOnCombatWithPlayerCallback(null);
				}
			}

			this.m.Item = null;
			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (!this.World.FactionManager.isCivilWar())
		{
			return false;
		}

		return true;
	}

	function onSerialize( _out )
	{
		_out.writeU8(this.m.Objectives.len());

		foreach( o in this.m.Objectives )
		{
			if (o != null && !o.isNull())
			{
				_out.writeU32(o.getID());
			}
			else
			{
				_out.writeU32(0);
			}
		}

		if (this.m.Item != null)
		{
			_out.writeBool(true);
			_out.writeI32(this.m.Item.ClassNameHash);
			this.m.Item.onSerialize(_out);
		}
		else
		{
			_out.writeBool(false);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local numObjectives = _in.readU8();

		for( local i = 0; i != numObjectives; i = ++i )
		{
			local o = _in.readU32();

			if (o != 0)
			{
				this.m.Objectives.push(this.WeakTableRef(this.World.getEntityByID(o)));
				local obj = this.m.Objectives[this.m.Objectives.len() - 1];

				if (!obj.isMilitary() && !obj.getSettlement().isMilitary() && !obj.getFlags().get("HasNobleProtection"))
				{
					local garbage = [];

					foreach( i, e in obj.getTroops() )
					{
						if (e.ID == this.Const.EntityType.Footman || e.ID == this.Const.EntityType.Greatsword || e.ID == this.Const.EntityType.Billman || e.ID == this.Const.EntityType.Arbalester || e.ID == this.Const.EntityType.StandardBearer || e.ID == this.Const.EntityType.Sergeant || e.ID == this.Const.EntityType.Knight)
						{
							garbage.push(i);
						}
					}

					garbage.reverse();

					foreach( g in garbage )
					{
						obj.getTroops().remove(g);
					}
				}
			}
		}

		local hasItem = _in.readBool();

		if (hasItem)
		{
			this.m.Item = this.new(this.IO.scriptFilenameByHash(_in.readI32()));
			this.m.Item.onDeserialize(_in);
		}

		this.contract.onDeserialize(_in);
	}

});

