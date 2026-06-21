this.conquer_holy_site_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Target = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.conquer_holy_site";
		this.m.Name = "征服圣地";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		if (this.m.Home == null)
		{
			this.setHome(this.World.State.getCurrentTown());
		}

		local sites = [
			"location.holy_site.oracle",
			"location.holy_site.meteorite",
			"location.holy_site.vulcano"
		];
		local locations = this.World.EntityManager.getLocations();
		local target;
		local targetIndex = 0;
		local closestDist = 9000;
		local myTile = this.m.Home.getTile();

		foreach( v in locations )
		{
			foreach( i, s in sites )
			{
				if (v.getTypeID() == s && v.getFaction() != 0 && !this.World.FactionManager.isAllied(this.getFaction(), v.getFaction()))
				{
					local d = myTile.getDistanceTo(v.getTile());

					if (d < closestDist)
					{
						target = v;
						targetIndex = i;
						closestDist = d;
					}
				}
			}
		}

		this.m.Destination = this.WeakTableRef(target);
		this.m.Destination.setVisited(true);
		local b = -1;

		do
		{
			local r = this.Math.rand(0, this.Const.PlayerBanners.len() - 1);

			if (this.World.Assets.getBanner() != this.Const.PlayerBanners[r])
			{
				b = this.Const.PlayerBanners[r];
				break;
			}
		}
		while (b < 0);

		this.m.Payment.Pool = 1350 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
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

		this.m.Flags.set("DestinationName", this.m.Destination.getName());
		this.m.Flags.set("DestinationIndex", targetIndex);
		this.m.Flags.set("MercenaryPay", this.beautifyNumber(this.m.Payment.Pool * 0.5));
		this.m.Flags.set("Mercenary", this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
		this.m.Flags.set("MercenaryCompany", this.Const.Strings.MercenaryCompanyNames[this.Math.rand(0, this.Const.Strings.MercenaryCompanyNames.len() - 1)]);
		this.m.Flags.set("MercenaryBanner", b);
		this.m.Flags.set("Commander", this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
		this.m.Flags.set("EnemyID", target.getFaction());
		this.m.Flags.set("MapSeed", this.Time.getRealTime());
		this.m.Flags.set("OppositionSeed", this.Time.getRealTime());
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"从南方异教徒手中解放%holysite%",
					"摧毁或击溃附近的敌方部队"
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
				local r = this.Math.rand(1, 100);

				if (r <= 20)
				{
					this.Flags.set("IsAlliedArmy", true);
				}
				else if (r <= 40)
				{
					this.Flags.set("IsSallyForth", true);
				}
				else if (r <= 60)
				{
					this.Flags.set("IsMercenaries", true);
				}
				else if (r <= 80)
				{
					this.Flags.set("IsCounterAttack", true);
				}

				if (this.Contract.getDifficultyMult() >= 1.15)
				{
					this.Contract.spawnEnemy();
				}
				else if (this.Contract.getDifficultyMult() <= 0.85)
				{
					local entities = this.World.getAllEntitiesAtPos(this.Contract.m.Destination.getPos(), 1.0);

					foreach( e in entities )
					{
						if (e.isParty())
						{
							e.getController().clearOrders();
						}
					}
				}

				local cityStates = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

				foreach( c in cityStates )
				{
					c.addPlayerRelation(-99.0, "在战争选择了阵营");
				}

				this.Contract.m.Destination.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setOnEnterCallback(this.onDestinationAttacked.bindenv(this));
				}

				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onCounterAttack.bindenv(this));
				}
			}

			function update()
			{
				if (this.Flags.get("IsFailure"))
				{
					this.Contract.setScreen("Failure");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsVictory"))
				{
					if (this.Flags.get("IsCounterAttack"))
					{
						this.Contract.setScreen("CounterAttack1");
						this.World.Contracts.showActiveContract();
					}
					else if (!this.Contract.isEnemyPartyNear(this.Contract.m.Destination, 400.0))
					{
						this.Contract.setScreen("Victory");
						this.World.Contracts.showActiveContract();
					}
				}
			}

			function onCounterAttack( _dest, _isPlayerInitiated )
			{
				if (this.Flags.get("IsCounterAttackDefend") && this.Contract.isPlayerAt(this.Contract.m.Destination))
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
					p.LocationTemplate.OwnedByFaction = this.Const.Faction.Player;
					p.LocationTemplate.Template[0] = "tactical.southern_ruins";
					p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.Walls;
					p.LocationTemplate.ShiftX = -4;
					p.CombatID = "ConquerHolySiteCounterAttack";
					p.MapSeed = this.Flags.getAsInt("MapSeed");
					p.Music = this.Const.Music.OrientalCityStateTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineForward;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
					this.World.Contracts.startScriptedCombat(p, false, true, true);
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "ConquerHolySiteCounterAttack";
					p.Music = this.Const.Music.OrientalCityStateTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					this.World.Contracts.startScriptedCombat(p, false, true, true);
				}
			}

			function onDestinationAttacked( _dest )
			{
				if (this.Flags.getAsInt("OppositionSeed") != 0)
				{
					this.Math.seedRandom(this.Flags.getAsInt("OppositionSeed"));
				}

				if (this.Flags.get("IsVictory") || this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					return;
				}
				else if (this.Flags.get("IsAlliedArmy"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("AlliedArmy");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						p.LocationTemplate.OwnedByFaction = this.Flags.get("EnemyID");
						p.CombatID = "ConquerHolySite";
						p.MapSeed = this.Flags.getAsInt("MapSeed");
						p.LocationTemplate.Template[0] = "tactical.southern_ruins";
						p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.Walls;
						p.Music = this.Const.Music.OrientalCityStateTracks;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 70 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southern, 200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						p.AllyBanners = [
							this.World.Assets.getBanner(),
							this.World.FactionManager.getFaction(this.Contract.getFaction()).getPartyBanner()
						];
						p.EnemyBanners = [
							this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
						];
						this.World.Contracts.startScriptedCombat(p, true, true, true);
					}
				}
				else if (this.Flags.get("IsSallyForth"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("SallyForth");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "ConquerHolySite";
						p.Music = this.Const.Music.OrientalCityStateTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southern, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						p.AllyBanners = [
							this.World.Assets.getBanner()
						];
						p.EnemyBanners = [
							this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
						];
						this.World.Contracts.startScriptedCombat(p, false, true, true);
					}
				}
				else if (this.Flags.get("IsMercenaries"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("Mercenaries1");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						p.LocationTemplate.OwnedByFaction = this.Flags.get("EnemyID");
						p.CombatID = "ConquerHolySite";
						p.MapSeed = this.Flags.getAsInt("MapSeed");
						p.LocationTemplate.Template[0] = "tactical.southern_ruins";
						p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.Walls;
						p.Music = this.Const.Music.OrientalCityStateTracks;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southern, (130 + (this.Flags.get("MercenariesAsAllies") ? 30 : 0)) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						p.AllyBanners = [
							this.World.Assets.getBanner()
						];
						p.EnemyBanners = [
							this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
						];

						if (this.Flags.get("MercenariesAsAllies"))
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Mercenaries, 50 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
							p.AllyBanners.push(this.Flags.get("MercenaryBanner"));
						}
						else
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Mercenaries, 50 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
							p.EnemyBanners.push(this.Flags.get("MercenaryBanner"));
						}

						this.World.Contracts.startScriptedCombat(p, true, true, true);
					}
				}
				else if (this.Flags.get("IsCounterAttack") && this.Flags.get("IsVictory"))
				{
					if (this.Flags.get("IsCounterAttackDefend"))
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						p.LocationTemplate.OwnedByFaction = this.Const.Faction.Player;
						p.LocationTemplate.ShiftX = -2;
						p.CombatID = "ConquerHolySiteCounterAttack";
						p.MapSeed = this.Flags.getAsInt("MapSeed");
						p.LocationTemplate.Template[0] = "tactical.southern_ruins";
						p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.Walls;
						p.Music = this.Const.Music.OrientalCityStateTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineForward;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southern, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						p.AllyBanners = [
							this.World.Assets.getBanner()
						];
						p.EnemyBanners = [
							this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
						];
						this.World.Contracts.startScriptedCombat(p, false, true, true);
					}
					else
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "ConquerHolySiteCounterAttack";
						p.Music = this.Const.Music.OrientalCityStateTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southern, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						p.AllyBanners = [
							this.World.Assets.getBanner()
						];
						p.EnemyBanners = [
							this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
						];
						this.World.Contracts.startScriptedCombat(p, false, true, true);
					}
				}
				else if (!this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);
					this.Contract.setScreen("Attacking");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
					p.LocationTemplate.OwnedByFaction = this.Flags.get("EnemyID");
					p.CombatID = "ConquerHolySite";
					p.MapSeed = this.Flags.getAsInt("MapSeed");
					p.LocationTemplate.Template[0] = "tactical.southern_ruins";
					p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.Walls;
					p.Music = this.Const.Music.OrientalCityStateTracks;
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southern, (this.Flags.get("IsCounterAttack") ? 110 : 130) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
					p.AllyBanners = [
						this.World.Assets.getBanner()
					];
					p.EnemyBanners = [
						this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
					];
					this.World.Contracts.startScriptedCombat(p, true, true, true);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "ConquerHolySiteCounterAttack")
				{
					this.Flags.set("IsCounterAttack", false);
					this.Flags.set("IsVictory", true);
				}
				else if (_combatID == "ConquerHolySite")
				{
					this.Flags.set("IsVictory", true);
					this.Flags.set("OppositionSeed", this.Time.getRealTime());
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "ConquerHolySite" || _combatID == "ConquerHolySiteCounterAttack")
				{
					this.Flags.set("IsFailure", true);
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

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = false;
					this.Contract.m.Destination.setOnEnterCallback(null);
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("Success");
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
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer%被一群神圣的男人包围着，每一个人看起来似乎都比上一个人更清楚古神的意愿和愿望。但对话中有明显的思路：南方人已经占领了%holysite%，必须要夺回来。领主指向了你。%SPEECH_ON%%companyname%将努力结束这场噩梦！%SPEECH_OFF%把首长们推到一旁，%employer%接近你，声音变得低沉。%SPEECH_ON%当然是要给出足够的报酬。我手下的人不多，但神圣的土地对人民和我都非常重要。你们必须前去那里，把异教徒驱逐出去，这样古代神灵不会抛弃我们，不论我们曾经失败多少次。%SPEECH_OFF% | %employer%的房间门猛地开了，一群神圣之人匆匆出去。有几人停下脚步注视着你，却没有一个对你的到来感到高兴。%employer%挥手让你进去。%SPEECH_ON%别在意他们那些可怜又盛气凌人的眼神，佣兵。%holysite%已经落到南方人的手中，我这群兵就算了，他们大概是铁棒捣鼓，也不至于这样。虽然我这样的人常常会发牢骚，但那些神圣之地还是让我很在意的。这群修道者只是希望用适当的王室颜色夺回%holysite%，但我已经派兵把绯闻处理了。然后，以适当的酬劳雇佣你的山猫去做这件事吧。%SPEECH_OFF% | %SPEECH_ON%身为佣兵，你会被老祖宗们看中的。%SPEECH_OFF% %employer%转动着酒杯，红酒溢出来滴在台面上，留下了一片紫色的光泽。%SPEECH_ON% %holysite%已经落入南方人的手中，毫无疑问，他们已经亵渎了整个圣地。在我看来，看着南方人呆在所谓上帝的崇高境地，不如等狗尿在那里更不值一提。是吉尔德人吗？真是胡扯。你去把他们全都干掉，让%holysite%恢复正常状态。%SPEECH_OFF% | %employer%在他的花园里被发现，他几乎是独来独往，围栏旁的男人和女人看起来都害怕甚至看一眼。你毫不在意自由地走近他。他正在盯着一堆踢翻的蚂蚁窝，昆虫们正匆忙地重建。贵族叹了一口气。%SPEECH_ON%我有时想知道，旧神是否会这样看待我们。%SPEECH_OFF%你说你只有在蚂蚁咬你时才会注意到它们。贵族站起来了。%SPEECH_ON%你应该知道它们对花园有好处，佣兵。如果它们咬了，我认为那是没有激情的。它们只是在做它们知道的事情，就像在我踢翻它们的家时，它们知道要重建一样。正如当我得知南部的蟑螂已经非正式地侵犯了%holysite%，我通过旧神的方式，知道他们必须被根除和摧毁。%SPEECH_OFF%你似乎预料到贵族会把你比作蚂蚁，但他只是简单地给了你很多克朗，让你前往圣地并攻击它的居民。%SPEECH_ON%你会像花园里的黄蜂一样，也许。%SPEECH_OFF%贵族说道，你用沉默的点头回应了他。 | %SPEECH_ON%我不喜欢做陶器，佣兵，所以当我说南方的家伙们比屎贩子的露骨堕落还要卑鄙时，你应该知道他们的入侵，已经迫使我走上了吟游诗人这个职业。%SPEECH_OFF%你或许要告诉%employer% 他也许指的是“诗歌”，不过，从某种程度上来说，他确实在“打破规矩”。此外，他毫无疑问认为你是一个软蛋。%SPEECH_ON%野蛮人占领了%holysite%，而传言说他们甚至杀了所有的“非信徒”。我的士兵分散开来，战场很多。但你是有时间的。你是个贪婪的家伙，当然，我知道%companyname%是我们需要以全力争取赶走这些混蛋离开圣地的确切力量。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我相信你会为这样的袭击付出充分的报酬。 | 我们已经准备好尽自己的一份力了。 | 我们再多谈谈报酬。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这不值得。 | 这太远了。 | 我们有更紧迫的事情要处理。 | 我们还有别的地方要去。}",
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
			ID = "Attacking",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{南方人已经在%holysite%内外设防。他们有时间筑起了坚固的防御，但这对于%companyname%来说并不是问题。你拔出剑，准备发动进攻。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "开始进攻！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "AlliedArmy",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_78.png[/img]{%holysite%已经被扛着%employerfaction%旗帜的人包围了。当你走近时，一个人迎面走来。他举起手，然后放到腰带上。%SPEECH_ON%我得到了消息，他们打算派遣一名雇佣兵，而你似乎就是他。%companyname%对吧？那么，我是%employer%的少尉，%commander%。我将和你一起清除这些沙漠老鼠。我担心，正如你肯定担心的那样，如果我们不尽快完成这个任务，古老的神灵将惩罚我们所有人。%SPEECH_OFF%少尉吐了口口水，用粗糙的手擦了擦脸。%SPEECH_ON%好吧。让古老的神灵看到我们的真实面目，我们将以最正义的方式屠杀这些沙丘骗子。%SPEECH_OFF% | %holysite%已经被扛着%employerfaction%旗帜的人包围了。领袖走出来大声说道。%SPEECH_ON%我是%employer%军队的少尉%commander%，你们是%companyname%吧？我来和你们一起去%holysite%，从每一个角落清除这些南方卑鄙无耻之徒。古老的神灵照看我们所有人，即使是像你们这种雇佣兵，今天的失败也肯定会将我们送到地狱之中。%SPEECH_OFF%好的，你们只是想确保，无论帮不帮忙，%employer%都将支付你们应得的全部报酬。 | %holysite%已经被扛着%employerfaction%旗帜的人包围了。看起来是一群神圣的人和士兵们的大会，领导军队的少尉挥舞着剑，然后将剑瞄准%holysite%。%SPEECH_ON%南方的小人要么离开，要么我们将凭借我们的钢铁之力，将他们转换成古老神灵的地狱。在这件事上，没有其他选择。来吧，雇佣兵们！%SPEECH_OFF%显然，%companyname%将在这个努力中得到一些帮助，尽管你们完全期望仍能获得承诺的全部报酬。}",
			Image = "",
			Banner = "",
			List = [],
			Options = [
				{
					Text = "开始进攻！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			],
			function start()
			{
				this.Banner = this.World.FactionManager.getFaction(this.Contract.getFaction()).getUIBanner();
			}

		});
		this.m.Screens.push({
			ID = "SallyForth",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{ %holysite% 的守卫者得到了增援! 但值得庆幸的是，还有一线希望: 额外的援军使得使他们有信心离开圣地的自然防御并在开阔的战场上接近你。 | 你惊讶地看到防守者离开 %holysite% 并徒步穿过开阔的战场。一份迅速的侦查报告传达道: 他们在过去几天中得到了增援, 因此变得很有底气。 一方面，他们深深的阵列有点令人不安，但另一方面，在平坦的战场上面对他们会更容易。经过理智评估, 他们选择在开阔战场直面 %companyname% 将是一个致命的错误。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "那就是一场野战了。",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Mercenaries1",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_134.png[/img]{当 %holysite% 出现在视野中时，一个看起来几乎与你相似得有些诡异的男人走了过来。他身边有一名财务主管和几个雇佣兵。%SPEECH_ON%晚上好，队长。我是来自 %mercenarycompany% 的雇佣兵 %mercenary%，像你一样为钱而来。现在，我打赌那个肥胖的贵族为你和你的士兵签下了一份非常优厚的合同，但如果您支付给我 %pay% 克朗，我将帮助您完成这项任务？除非您想让我去向另一方提供服务。%SPEECH_OFF% | 一个小组人接近了你们, 其中一个人的步态和体格都与你自己奇怪地相似. 他自称为 %mercenary%, 是 %mercenarycompany% 的领队。 %SPEECH_ON% 我认为 %employer% 可能会派他的专业军队来看守这个圣地。领队，我必须向您承认，我曾经帮助过那些疯子占领了这座著名的纪念碑。然而，如果以 %pay% 克朗作为报酬，我愿意帮助你们一方夺回它。作为一个同行的雇佣兵，我相信你能看到这对所有人都是一个好交易。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [],
			function start()
			{
				if (this.World.Assets.getMoney() > this.Flags.get("MercenaryPay"))
				{
					this.Options.push({
						Text = "你被雇佣了!",
						function getResult()
						{
							return "Mercenaries2";
						}

					});
				}
				else
				{
					this.Options.push({
						Text = "恐怕我们没有那么多的钱币。",
						function getResult()
						{
							return "Mercenaries3";
						}

					});
				}

				this.Options.push({
					Text = "自己找工作去，%mercenary%。我们不需要帮助。",
					function getResult()
					{
						return "Mercenaries3";
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "Mercenaries2",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_134.png[/img]{队长露出笑容，拍了拍你的肩膀。%SPEECH_ON%啊哈，就是这样！就是这种高尚的雇佣兵精神！嗯，作为 %companyname% 的指挥官，让我们一起前往战场，在那里并肩作战吧！%SPEECH_OFF% | 交易达成后，雇佣军队的队长靠近你。他几乎贴在你身边，呼出来气息令人不悦。%SPEECH_ON%你知道吗？像我们这样的人，伙计们、朋友们——我们是朋友对吧？像我们这样的好朋友必须互相支持。在接下来的战斗中，我们会紧密合作。%SPEECH_OFF%他点了点头，并猛地拍了一下你的肩膀。 %SPEECH_ON%等到战斗结束之后, 我希望以后还能做好兄弟, 你说呢? %SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "开始进攻！",
					function getResult()
					{
						this.Flags.set("MercenariesAsAllies", true);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			],
			function start()
			{
				this.World.Assets.addMoney(-this.Flags.get("MercenaryPay"));
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + this.Flags.get("MercenaryPay") + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Mercenaries3",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_134.png[/img]{%SPEECH_START%真遗憾。%SPEECH_OFF%%mercenary%说着，迅速回到了%mercenarycompany%的队伍中。他向后退着，正好撞到保卫%holysite%的士兵身上。他的胳膊张开，像是在顶着一股逆流游泳。%SPEECH_ON%真是太遗憾了！好了，%companyname%的队长，接下来我们看看哪边雇到了更好的佣兵？%SPEECH_OFF%佣兵拔出武器，%holysite%后面的南方士兵也做同样的动作。自然地，你也拔出了武器。是时候战斗了。 | %SPEECH_ON%好的，好的，我知道了。不过我本来就没抱太大指望。毕竟，我也是一名佣兵。而现在......%SPEECH_OFF%他向后走到他的队伍中，队伍则向后走到保卫%holysite%的南方士兵的队伍中。%SPEECH_ON%现在，南方证明了他们出价更高。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们将在战场上再见。开始进攻！",
					function getResult()
					{
						this.Flags.set("MercenariesAsAllies", false);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "CounterAttack1",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_164.png[/img]{战斗结束了，但远处的金色闪光引起了你的注意。当你凝视着地平线时，一队南方人出现了，他们鲜艳的外表无疑是为了被看到。这是一次反击！ | 当你收起剑来 %randombrother% 喊道。他指向地平线上正在接近的一行南方人，他们的盔甲闪闪发光，步态自信。这些反攻者希望被看到，并且毫无疑问打算获胜...}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们将坚守这个地点进行防御！",
					function getResult()
					{
						return "CounterAttack2";
					}

				},
				{
					Text = "我们会在开阔地见他们！",
					function getResult()
					{
						return "CounterAttack3";
					}

				},
				{
					Text = "我们无法再战斗。撤退！",
					function getResult()
					{
						return "Failure";
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "CounterAttack2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_164.png[/img]{南方人的进攻一直持续着。%SPEECH_ON%蟑螂永远都不会消失(俗语, 指问题不会消失)。%SPEECH_OFF%你看到%randombrother%摇了摇头。他抬起靴子，用脚趾弹掉一只虫子。他把脚放下，向着攻击者点点头。%SPEECH_ON%别担心，队长，我们会让%holysite%的防御处于最佳状态来对付那些野蛮的混蛋们。%SPEECH_OFF% | 你命令士兵们保卫这个地点。%SPEECH_ON%在%holysite%作战，真是一个令人兴奋的时刻。%SPEECH_OFF%%randombrother%说道。你点了点头，告诉他你希望这段经历总有一天会成为他的回忆。他笑了笑，问怎么可能会忘记。另一个雇佣兵插话说有一种可以让他忘记的方法，但是你打断了他，并告诉士兵要专注于手头任务。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "集合！",
					function getResult()
					{
						this.Flags.set("IsCounterAttackDefend", true);
						this.Flags.set("IsVictory", false);
						local party = this.Contract.spawnEnemy();
						party.setOnCombatWithPlayerCallback(this.Contract.getActiveState().onCounterAttack.bindenv(this.Contract.getActiveState()));
						this.Contract.m.Target = this.WeakTableRef(party);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "CounterAttack3",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_164.png[/img]{防御看起来不如以前坚固了。你下令%companyname%采取阵型，在没有造假的结构妨碍你的指挥的地方站立。南方中尉向你问好。%SPEECH_ON%你以血亵渎%holysite%，为此，吉尔德亲自命令你到战场像合格的男人一样死去。你有何话可说？%SPEECH_OFF%你拔出你的剑。%SPEECH_ON%不是我的血。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "冲锋！",
					function getResult()
					{
						this.Flags.set("IsCounterAttackDefend", false);
						this.Flags.set("IsVictory", false);
						local party = this.Contract.spawnEnemy();
						party.setOnCombatWithPlayerCallback(this.Contract.getActiveState().onCounterAttack.bindenv(this.Contract.getActiveState()));
						this.Contract.m.Target = this.WeakTableRef(party);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Victory",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{当你收起武器，让同伴开始搜刮尸体时，你有一种奇怪的感觉，好像这不是第一次发生在 %holysite% 的血腥事件。无论如何，如果有人注定要在这场争斗中死去，你很高兴那个人不是你。几个北方士兵进来保护圣地时，你动身前往 %employer%。 | 你打败了敌人，成功收复了 %holysite%。信徒们缓缓涌入，迈过死者后跪拜在圣地前。没有一个人对你说谢谢。虽然这并不重要，因为那是 %employer% 的工作。一队北方士兵在你出门的路上经过，每个战士都用嘲笑和咒骂的眼神看着你。 | 战斗结束后，一些忠诚的人开始聚集在%holysite%的角落里。你不知道这些人从哪里来，他们不在意你，而你也不在意他们。现在重要的是有大量克朗在 %employer% 那等待着你回去领取。几个北方士兵经过后，你就离开了。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "胜利！",
					function getResult()
					{
						this.Contract.m.Destination.setFaction(this.Contract.getFaction());
						this.Contract.m.Destination.setBanner(this.World.FactionManager.getFaction(this.Contract.getFaction()).getPartyBanner());
						this.updateAchievement("NewManagement", 1, 1);
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.spawnAlly();
			}

		});
		this.m.Screens.push({
			ID = "Failure",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{%holysite%已被南方人攻陷。一名雇佣军摇了摇头。%SPEECH_ON%嗯，我猜他们今后将无所适从。%SPEECH_OFF%的确如此。由于神圣文本已经丢失，除非你想看到另一种圣洁的景象，否则不必再回到%employer%那里了。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "灾难！",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "未能征服一个圣地");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Success",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{%townname%的修道院里涌入了比你以往所见到的农民还要多。%employer%在台阶外迎接你，手放在你的肩膀上。%SPEECH_ON%欢迎回来，雇佣兵。你或许会是一个费力得来的家伙，但你带着古老神明的愤怒。%holysite%现在属于它了。%SPEECH_OFF%这位贵族响了几下手指，几个肥胖的僧侣拖着%reward% 克朗的宝箱走了出来。%employer%跟着他们上了台阶。%SPEECH_ON%我会替你向人群传递一句话，你叫什么来着？啊，我确信你希望以整个%companyname%的名义接受表彰。%SPEECH_OFF% | %employer%正在观看他的战争地图。%SPEECH_ON%我将我的手下派往的地方都遭遇了失败，但是当古老的神明发怒时，我却雇佣了一个雇佣兵，并取得了胜利。有了%holysite%再次回到我们的掌控中，我希望我的手下能够像%companyname%一样战斗。对于%reward% 克朗，你让那些南方佬退回了他们那沙漠中的地狱，让整个战争的努力得到了推动。雇佣兵，我几乎要说你价值连城了。几乎。%SPEECH_OFF% | %SPEECH_ON%侦察兵返回来时，第一件事就是去了修道院。这就是我知道你成功的方式。我还让他们每个人待了一天的地牢，因为他们擅离了任务。%SPEECH_OFF% %employer%坐在一个奇怪的垫子上，也许是在与南方人打仗时想到的什么。他在酒杯里搅拌着酒。%SPEECH_ON%你的%reward% 克朗外面等着。我必须问一下，当你在那下面时，你有没有听到什么?也许是古老的神明的耳语？甚至是他们所谓的吉尔德的耳语？%SPEECH_OFF%你摇了摇头。贵族耸了耸肩。%SPEECH_ON%真是太遗憾了。人们必须思考到底需要什么样的东西才能再次得到神的恩宠。%SPEECH_OFF%你告诉他，把%reward% 克朗投入特定方向将是一个很好的开始。这位贵族得意地微笑着，满足了你的愿望。 | %employer%正和一名明显来自南方的年轻棕色女子在一起。他环视着她。%SPEECH_ON%古老的神明送给了我这个人，就像他们送给了你一样。%SPEECH_OFF%他有点结巴，清了清嗓子。%SPEECH_ON%我的意思是，当然是另一种方式。你在%holysite%的胜利使手下们振奋了精神，打破了失败的魔咒。这些僧侣现在在他们的羊群中有了信仰，通过我们的勤勉工作，我们将向古老的神明证明我们的价值。%SPEECH_OFF%他把女人推开，试图站起来，但垫子太深了，也许太舒适了。他坐着不动。%SPEECH_ON%你的%reward% 克朗在外面等着。请召唤我其中的一个仆人，让她在修道院为这位女人祈祷。%SPEECH_OFF% | 你在城镇的一座庙宇里找到了%employer%，他站在一尊古老神明的雕像下。%SPEECH_ON%我听说了你的成功。镇上欢欣鼓舞，整个地区都在欢呼。他们不会谈论你，当然，他们会谈论我。%SPEECH_OFF%贵族似乎很满意自己。他转过身来拍了拍你的肩膀。%SPEECH_ON%我希望那些南方佬没有给你带来太多麻烦。我的副手会给你带来%reward% 克朗。告诉我，你认为%holysite%值得一去吗？我从没去过。其实，在哪里都一样，我都被祝福了。%SPEECH_OFF%你噘起嘴唇，当贵族离开时。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "当之无愧的报酬。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "征服了一个圣地");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isHolyWar())
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
	}

	function spawnAlly()
	{
		local o = this.m.Destination.getTile().SquareCoords;
		local tiles = [];

		for( local x = o.X - 4; x < o.X + 4; x = ++x )
		{
			for( local y = o.Y + 4; y <= o.Y + 6; y = ++y )
			{
				if (!this.World.isValidTileSquare(x, y))
				{
				}
				else
				{
					local tile = this.World.getTileSquare(x, y);

					if (tile.Type == this.Const.World.TerrainType.Ocean)
					{
					}
					else
					{
						local s = this.Math.rand(0, 3);

						if (tile.Type == this.Const.World.TerrainType.Mountains)
						{
							s = s - 10;
						}

						if (tile.HasRoad)
						{
							s = s + 10;
						}

						tiles.push({
							Tile = tile,
							Score = s
						});
					}
				}
			}
		}

		if (tiles.len() == 0)
		{
			tiles.push({
				Tile = this.m.Destination.getTile(),
				Score = 0
			});
		}

		tiles.sort(function ( _a, _b )
		{
			if (_a.Score > _b.Score)
			{
				return -1;
			}
			else if (_a.Score < _b.Score)
			{
				return 1;
			}

			return 0;
		});
		local f = this.World.FactionManager.getFaction(this.getFaction());
		local candidates = [];

		foreach( s in f.getSettlements() )
		{
			if (s.isMilitary())
			{
				candidates.push(s);
			}
		}

		local party = f.spawnEntity(tiles[0].Tile, candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly() + " Company", true, this.Const.World.Spawn.Noble, 170 * this.getDifficultyMult() * this.getScaledDifficultyMult());
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
		party.setDescription("为地方领主服务的专业士兵。");
		party.getLoot().Money = this.Math.rand(50, 200);
		party.getLoot().ArmorParts = this.Math.rand(0, 25);
		party.getLoot().Medicine = this.Math.rand(0, 5);
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
		local occupy = this.new("scripts/ai/world/orders/occupy_order");
		occupy.setTarget(this.m.Destination);
		occupy.setTime(10.0);
		c.addOrder(occupy);
		local guard = this.new("scripts/ai/world/orders/guard_order");
		guard.setTarget(this.m.Destination.getTile());
		guard.setTime(240.0);
		c.addOrder(guard);
		return party;
	}

	function spawnEnemy()
	{
		local cityState = this.World.FactionManager.getFaction(this.getFaction());
		local o = this.m.Destination.getTile().SquareCoords;
		local tiles = [];

		for( local x = o.X - 4; x < o.X + 4; x = ++x )
		{
			for( local y = o.Y - 4; y <= o.Y - 3; y = ++y )
			{
				if (!this.World.isValidTileSquare(x, y))
				{
				}
				else
				{
					local tile = this.World.getTileSquare(x, y);

					if (tile.Type == this.Const.World.TerrainType.Ocean)
					{
					}
					else
					{
						local s = this.Math.rand(0, 3);

						if (tile.Type == this.Const.World.TerrainType.Mountains)
						{
							s = s - 10;
						}

						if (tile.HasRoad)
						{
							s = s + 10;
						}

						tiles.push({
							Tile = tile,
							Score = s
						});
					}
				}
			}
		}

		if (tiles.len() == 0)
		{
			tiles.push({
				Tile = this.m.Destination.getTile(),
				Score = 0
			});
		}

		tiles.sort(function ( _a, _b )
		{
			if (_a.Score > _b.Score)
			{
				return -1;
			}
			else if (_a.Score < _b.Score)
			{
				return 1;
			}

			return 0;
		});
		local f = this.World.FactionManager.getFaction(this.m.Flags.get("EnemyID"));
		local candidates = [];

		foreach( s in f.getSettlements() )
		{
			candidates.push(s);
		}

		local party = f.spawnEntity(tiles[0].Tile, "Regiment of " + candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly(), true, this.Const.World.Spawn.Southern, this.Math.rand(100, 140) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
		party.setDescription("忠于城邦的应征士兵。");
		party.setAttackableByAI(false);
		party.setAlwaysAttackPlayer(true);
		party.getLoot().Money = this.Math.rand(50, 200);
		party.getLoot().ArmorParts = this.Math.rand(0, 25);
		party.getLoot().Medicine = this.Math.rand(0, 5);
		party.getLoot().Ammo = this.Math.rand(0, 30);
		local r = this.Math.rand(1, 4);

		if (r <= 2)
		{
			party.addToInventory("supplies/rice_item");
		}
		else if (r == 3)
		{
			party.addToInventory("supplies/dates_item");
		}
		else if (r == 4)
		{
			party.addToInventory("supplies/dried_lamb_item");
		}

		local c = party.getController();
		local attack = this.new("scripts/ai/world/orders/attack_zone_order");
		attack.setTargetTile(this.m.Destination.getTile());
		c.addOrder(attack);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(this.m.Destination.getTile());
		c.addOrder(move);
		local guard = this.new("scripts/ai/world/orders/guard_order");
		guard.setTarget(this.m.Destination.getTile());
		guard.setTime(999.0);
		c.addOrder(guard);
		return party;
	}

	function onPrepareVariables( _vars )
	{
		local illustrations = [
			"event_152",
			"event_154",
			"event_151"
		];
		_vars.push([
			"illustration",
			illustrations[this.m.Flags.get("DestinationIndex")]
		]);
		_vars.push([
			"holysite",
			this.m.Flags.get("DestinationName")
		]);
		_vars.push([
			"pay",
			this.m.Flags.get("MercenaryPay")
		]);
		_vars.push([
			"employerfaction",
			this.World.FactionManager.getFaction(this.m.Faction).getName()
		]);
		_vars.push([
			"mercenary",
			this.m.Flags.get("Mercenary")
		]);
		_vars.push([
			"mercenarycompany",
			this.m.Flags.get("MercenaryCompany")
		]);
		_vars.push([
			"commander",
			this.m.Flags.get("Commander")
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setOnEnterCallback(null);
			}

			if (this.m.Target != null && !this.m.Target.isNull())
			{
				this.m.Target.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (!this.World.FactionManager.isHolyWar())
		{
			return false;
		}

		local sites = [
			"location.holy_site.oracle",
			"location.holy_site.meteorite",
			"location.holy_site.vulcano"
		];
		local locations = this.World.EntityManager.getLocations();

		foreach( v in locations )
		{
			foreach( s in sites )
			{
				if (v.getTypeID() == s && v.getFaction() != 0 && !this.World.FactionManager.isAllied(this.getFaction(), v.getFaction()))
				{
					return true;
				}
			}
		}

		return false;
	}

	function onIsTileUsed( _tile )
	{
		if (this.m.Destination != null && !this.m.Destination.isNull() && _tile.ID == this.m.Destination.getTile().ID)
		{
			return true;
		}

		return false;
	}

	function onSerialize( _out )
	{
		if (this.m.Destination != null && !this.m.Destination.isNull())
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		if (this.m.Target != null && !this.m.Target.isNull())
		{
			_out.writeU32(this.m.Target.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}

		this.contract.onDeserialize(_in);
	}

});

