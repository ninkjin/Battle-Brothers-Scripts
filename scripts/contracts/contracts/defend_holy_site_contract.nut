this.defend_holy_site_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Target = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.defend_holy_site";
		this.m.Name = "保卫圣地";
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
				if (v.getTypeID() == s && v.getFaction() != 0 && this.World.FactionManager.isAllied(this.getFaction(), v.getFaction()))
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
		this.m.Payment.Pool = 1250 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
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

		local cityStates = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);
		this.m.Flags.set("DestinationName", this.m.Destination.getName());
		this.m.Flags.set("DestinationIndex", targetIndex);
		this.m.Flags.set("EnemyID", cityStates[this.Math.rand(0, cityStates.len() - 1)].getID());
		this.m.Flags.set("MapSeed", this.Time.getRealTime());
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"前往%holysite%并保卫它免受南方异教徒的攻击"
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

				if (r <= 25)
				{
					this.Flags.set("IsQuartermaster", true);
				}

				local r = this.Math.rand(1, 100);

				if (r <= 30)
				{
					this.Flags.set("IsSallyForth", true);
				}
				else if (r <= 60)
				{
					this.Flags.set("IsAlliedSoldiers", true);
				}

				local cityStates = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

				foreach( c in cityStates )
				{
					c.addPlayerRelation(-99.0, "在战争选择了阵营");
				}

				this.Contract.m.Destination.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);

				if (this.Contract.getDifficultyMult() >= 0.95)
				{
					local cityState = cityStates[this.Math.rand(0, cityStates.len() - 1)];
					local party = cityState.spawnEntity(this.Contract.m.Destination.getTile(), "Regiment of " + cityState.getNameOnly(), true, this.Const.World.Spawn.Southern, this.Math.rand(100, 150) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + cityState.getBannerString());
					party.setDescription("忠于城邦的应征士兵。");
					party.getLoot().Money = this.Math.rand(50, 200);
					party.getLoot().ArmorParts = this.Math.rand(0, 25);
					party.getLoot().Medicine = this.Math.rand(0, 3);
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
					local roam = this.new("scripts/ai/world/orders/roam_order");
					roam.setAllTerrainAvailable();
					roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
					roam.setTerrain(this.Const.World.TerrainType.Shore, false);
					roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
					roam.setPivot(this.Contract.m.Destination);
					roam.setMinRange(4);
					roam.setMaxRange(8);
					roam.setTime(300.0);
				}

				local entities = this.World.getAllEntitiesAtPos(this.Contract.m.Destination.getPos(), 1.0);

				foreach( e in entities )
				{
					if (e.isParty())
					{
						e.getController().clearOrders();
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
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Flags.get("IsQuartermaster") && this.Contract.isPlayerAt(this.Contract.m.Home) && this.World.Assets.getStash().getNumberOfEmptySlots() >= 3)
				{
					this.Contract.setScreen("Quartermaster");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Contract.isPlayerAt(this.Contract.m.Destination))
				{
					this.Contract.setScreen("Approaching" + this.Flags.get("DestinationIndex"));
					this.World.Contracts.showActiveContract();
				}
			}

		});
		this.m.States.push({
			ID = "Running_Defend",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"保卫%holysite%免受南方异教徒的侵犯",
					"摧毁或击溃附近的敌方部队",
					"不要走得太远"
				];

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
				}

				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Flags.get("IsFailure") || !this.Contract.isPlayerNear(this.Contract.m.Destination, 700) || !this.World.FactionManager.isAllied(this.Contract.getFaction(), this.Contract.m.Destination.getFaction()))
				{
					this.Contract.setScreen("Failure");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsSallyForthNextWave"))
				{
					this.Contract.setScreen("SallyForth3");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsVictory"))
				{
					if (!this.Contract.isEnemyPartyNear(this.Contract.m.Destination, 400.0))
					{
						this.Contract.setScreen("Victory");
						this.World.Contracts.showActiveContract();
					}
				}
				else if (!this.Flags.get("IsTargetDiscovered") && this.Contract.m.Target != null && !this.Contract.m.Target.isNull() && this.Contract.m.Target.isDiscovered())
				{
					this.Flags.set("IsTargetDiscovered", true);
					this.Contract.setScreen("TheEnemyAttacks");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsArrived") && this.Flags.get("AttackTime") > 0 && this.Time.getVirtualTimeF() >= this.Flags.get("AttackTime"))
				{
					if (this.Flags.get("IsSallyForth"))
					{
						this.Contract.setScreen("SallyForth1");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsAlliedSoldiers"))
					{
						this.Contract.setScreen("AlliedSoldiers1");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Flags.set("AttackTime", 0.0);
						local party = this.Contract.spawnEnemy();
						party.setOnCombatWithPlayerCallback(this.Contract.getActiveState().onDestinationAttacked.bindenv(this));
						this.Contract.m.Target = this.WeakTableRef(party);
					}
				}
			}

			function onDestinationAttacked( _dest, _isPlayerInitiated = false )
			{
				if (this.Flags.get("IsSallyForthNextWave"))
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "DefendHolySite";
					p.Music = this.Const.Music.OrientalCityStateTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.Entities = [];
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southern, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
					p.EnemyBanners = [
						this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
					];

					if (this.Flags.get("IsLocalsRecruited"))
					{
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.PeasantsArmed, 10, this.Contract.getFaction());
						p.AllyBanners.push("banner_noble_11");
					}

					this.World.Contracts.startScriptedCombat(p, false, true, true);
				}
				else if (this.Flags.get("IsSallyForth"))
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "DefendHolySite";
					p.Music = this.Const.Music.OrientalCityStateTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.Entities = [];
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southern, (this.Flags.get("IsEnemyReinforcements") ? 130 : 100) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
					p.EnemyBanners = [
						this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
					];

					if (this.Flags.get("IsLocalsRecruited"))
					{
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.PeasantsArmed, 50, this.Contract.getFaction());
						p.AllyBanners.push("banner_noble_11");
					}

					this.World.Contracts.startScriptedCombat(p, false, true, true);
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
					p.LocationTemplate.OwnedByFaction = this.Const.Faction.Player;
					p.CombatID = "DefendHolySite";

					if (this.Contract.isPlayerAt(this.Contract.m.Destination))
					{
						p.MapSeed = this.Flags.getAsInt("MapSeed");
						p.LocationTemplate.Template[0] = "tactical.southern_ruins";
						p.LocationTemplate.Fortification = this.Flags.get("IsPalisadeBuilt") ? this.Const.Tactical.FortificationType.WallsAndPalisade : this.Const.Tactical.FortificationType.Walls;
						p.LocationTemplate.CutDownTrees = true;
						p.LocationTemplate.ShiftX = -2;
						p.Music = this.Const.Music.OrientalCityStateTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineForward;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
						p.AllyBanners = [
							this.World.Assets.getBanner()
						];

						if (this.Flags.get("IsAlliedReinforcements"))
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 50 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
							p.AllyBanners.push(this.World.FactionManager.getFaction(this.Contract.getFaction()).getPartyBanner());
						}

						if (this.Flags.get("IsLocalsRecruited"))
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.PeasantsArmed, 50, this.Contract.getFaction());
							p.AllyBanners.push("banner_noble_11");
						}
					}

					this.World.Contracts.startScriptedCombat(p, false, true, true);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "DefendHolySite")
				{
					if (this.Flags.get("IsSallyForthNextWave"))
					{
						this.Flags.set("IsSallyForthNextWave", false);
						this.Flags.set("IsSallyForth", false);
						this.Flags.set("IsVictory", true);
					}
					else if (this.Flags.get("IsSallyForth"))
					{
						this.Flags.set("IsSallyForthNextWave", true);
					}
					else
					{
						this.Flags.set("IsVictory", true);
					}
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "DefendHolySite")
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
			Text = "[img]gfx/ui/events/event_45.png[/img]{%SPEECH_START%沙丘符文混蛋们。%SPEECH_OFF%这是你进入%employer%房间后听到的第一件事。他不情愿地向你挥手示意进去。%SPEECH_ON%与南方的战争继续，但他们已经打破了不成文的协议:他们正在%holysite%上行动，而我没有任何手段来保护它。我不会拖延多久就决定关闭它，但我如果这么做肯定会被公众割掉我的蛋蛋。既然我很喜欢我的蛋蛋，我会在桌子上放%reward%克朗给你，让你去那里保卫%holysite%。%SPEECH_OFF% | 你发现%employer%正在试图说服一群农民。南方士兵正在接近%holysite%。%SPEECH_ON%我们有不成文的规定，这片神圣的土地，它们，它们...它们是神圣的！%SPEECH_OFF%看到你，贵族为你让出一条路，宣布你是他一周前召唤来的勇敢的战士。然而，当他靠近时，他在低语中掩护他的声音。%SPEECH_ON%这些白痴不需要知道你们是卖剑客。看，南方人在这件事上对我可是拿着棍打的疼。野蛮人真的在攻击%holysite%，我需要你们去那里制止他们。考虑到这个任务，%reward%克朗应该是足够的，是吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{%companyname% 可以为此帮你。 | 防御南方的敌人最好付出高昂的代价。 | 我很感兴趣，继续。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这不值得。 | 我们还有别的地方要去。 | 我不会冒险将战团置于南方的战争机器之下。}",
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
			ID = "Approaching1",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{这个巨破火山口旁的忠实而稀少的居民大部分已经被驱散。 即使是战争的最微小的迹象，都已经将这些信徒驱散到他们各自的修道院的庇护下了。 总而言之，在接下来的几个小时这儿将会决出胜者败者。 某些小伙子可能会恳求前者不要把自己太过沉溺于正义当中…}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们会在这里扎营。",
					function getResult()
					{
						return "Preparation1";
					}

				}
			],
			function start()
			{
				this.Flags.set("IsArrived", true);
			}

		});
		this.m.Screens.push({
			ID = "Approaching0",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{神谕已经不是你上一次记忆中的样子了：许多忠实信徒已经离开，战争之音已经来到这所古庙的门前台阶上。 这已经不重要了。 你无启可寻，你无梦可解，你只是来给你的敌人带来噩梦。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们会在这里扎营。",
					function getResult()
					{
						return "Preparation1";
					}

				}
			],
			function start()
			{
				this.Flags.set("IsArrived", true);
			}

		});
		this.m.Screens.push({
			ID = "Approaching2",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{讽刺的是，这座位于半山腰下的特别城市最终还是被反常地抛弃了。 少数忠实信徒还在城里游荡，其余的早在宗教冲突闯入他们的帐篷城市和精神世界前离开了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们会在这里扎营。",
					function getResult()
					{
						return "Preparation1";
					}

				}
			],
			function start()
			{
				this.Flags.set("IsArrived", true);
			}

		});
		this.m.Screens.push({
			ID = "Preparation1",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{你坚信你已经做出了对 %holysite% 来说适当的防卫。 剩下的时间不多了，你的 %companyname% 至少还能完成一项重要任务。 现在问题是如何将战队保持在最佳状态。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "建起木栅栏来加强壁垒！",
					function getResult()
					{
						return "Preparation2";
					}

				},
				{
					Text = "搜索这片土地，看看有没有对我们有用的东西！",
					function getResult()
					{
						return "Preparation3";
					}

				},
				{
					Text = "招募一些忠实信徒来帮助我们防守！",
					function getResult()
					{
						return "Preparation4";
					}

				}
			],
			function start()
			{
				this.Contract.setState("Running_Defend");
			}

		});
		this.m.Screens.push({
			ID = "Preparation2",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{抢劫圣地本身，这是一件你吩咐你的队员不要做的事情，还有偷拿被抛弃的原属于忠实信徒的所有物，你打算收集足够多的木头围在角落的一系列墙体旁来巩固 %holysite%。 那地方就在你估计是进攻者最佳入侵之处，并因此也是你最想守住的地方。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "现在我们等着。",
					function getResult()
					{
						this.Flags.set("AttackTime", this.Time.getVirtualTimeF() + this.Math.rand(5, 10));
						return 0;
					}

				}
			],
			function start()
			{
				this.Flags.set("IsPalisadeBuilt", true);
			}

		});
		this.m.Screens.push({
			ID = "Preparation3",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{你让人在这里搜寻战斗物资。 一大串东西被挪用并叠了起来。 整个 %holysite% 曾被彻底地搜寻过，你和你的人花了一些时间认出哪些东西是比较有用的…}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "现在我们等着。",
					function getResult()
					{
						this.Flags.set("AttackTime", this.Time.getVirtualTimeF() + this.Math.rand(5, 10));
						return 0;
					}

				}
			],
			function start()
			{
				for( local i = 0; i < 2; i = ++i )
				{
					local r = this.Math.rand(1, 12);
					local item;

					switch(r)
					{
					case 1:
						item = this.new("scripts/items/weapons/oriental/saif");
						break;

					case 2:
						item = this.new("scripts/items/tools/throwing_net");
						break;

					case 3:
						item = this.new("scripts/items/weapons/oriental/polemace");
						break;

					case 4:
						item = this.new("scripts/items/weapons/ancient/broken_ancient_sword");
						break;

					case 5:
						item = this.new("scripts/items/armor/ancient/ancient_mail");
						break;

					case 6:
						item = this.new("scripts/items/supplies/ammo_item");
						break;

					case 7:
						item = this.new("scripts/items/supplies/armor_parts_item");
						break;

					case 8:
						item = this.new("scripts/items/shields/ancient/tower_shield");
						break;

					case 9:
						item = this.new("scripts/items/loot/ancient_gold_coins_item");
						break;

					case 10:
						item = this.new("scripts/items/loot/silver_bowl_item");
						break;

					case 11:
						item = this.new("scripts/items/weapons/wooden_stick");
						break;

					case 12:
						item = this.new("scripts/items/helmets/oriental/spiked_skull_cap_with_mail");
						break;
					}

					if (item.getConditionMax() > 1)
					{
						item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 50) * 0.01));
					}

					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "你获得了" + item.getName()
					});
				}

				local amount = this.Math.rand(10, 30);
				this.World.Assets.addArmorParts(amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_supplies.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + amount + "[/color] 工具和补给"
				});
			}

		});
		this.m.Screens.push({
			ID = "Preparation4",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{仍在 %holysite% 旁逗留的少数忠实信徒一定是充满热情和狂热的。 因为你在这里代表北方，你让这些人挑选了一些看起来很坚强的老神狂热者，并询问了他们是否愿为他们的神而战。 如果有的话，那么这将是一个方便的招募办法，他们可以很快的武装自己，接受最短时间的训练。 你只能希望这些人能在即将到来的实战中有些作用。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "现在我们等着。",
					function getResult()
					{
						this.Flags.set("AttackTime", this.Time.getVirtualTimeF() + this.Math.rand(5, 10));
						return 0;
					}

				}
			],
			function start()
			{
				this.Flags.set("IsLocalsRecruited", true);
			}

		});
		this.m.Screens.push({
			ID = "TheEnemyAttacks",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_164.png[/img]{南方人出现在地平线上。他们的盔甲闪烁着光芒，即使在远处也能看到，因此“镀金者的追随者”是一个恰当的描述。%randombrother%吐了口唾沫并环顾四周。%SPEECH_ON% 他们看起来太时髦了，像一群死人。你是否曾经想过如果我们穿得像一群精灵，并带着所有小鬼子自信地出发，那些南方人会不会就这样离开？ %SPEECH_OFF%微笑着，你拔出剑命令士兵准备战斗。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "列阵！",
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
			ID = "Quartermaster",
			Title = "在 %townname%",
			Text = "[img]gfx/ui/events/event_158.png[/img]{当你离开%townname%时，有个人驾着一辆马车向你飞奔而来，他挂着%employerfaction%的旗帜。他自称是雇主的军需官，并表示他有一些物资可以提供。 %SPEECH_ON%我这里有几只战犬、渔网和投掷长矛。你可以选择其中之一，但不能全部拿走，因为周围还有很多需要武器的士兵。 %SPEECH_OFF%}",
			Image = "",
			Banner = "",
			List = [],
			Options = [
				{
					Text = "我们会带上战犬。",
					function getResult()
					{
						for( local i = 0; i < 3; i = ++i )
						{
							local item = this.new("scripts/items/accessory/wardog_item");
							this.World.Assets.getStash().add(item);
						}

						return 0;
					}

				},
				{
					Text = "我们会拿这些网。",
					function getResult()
					{
						for( local i = 0; i < 4; i = ++i )
						{
							local item = this.new("scripts/items/tools/throwing_net");
							this.World.Assets.getStash().add(item);
						}

						return 0;
					}

				},
				{
					Text = "我们会拿投矛。",
					function getResult()
					{
						if (this.Const.DLC.Wildmen)
						{
							for( local i = 0; i < 4; i = ++i )
							{
								local item = this.new("scripts/items/weapons/throwing_spear");
								this.World.Assets.getStash().add(item);
							}
						}
						else
						{
							for( local i = 0; i < 4; i = ++i )
							{
								local item = this.new("scripts/items/weapons/javelin");
								this.World.Assets.getStash().add(item);
							}
						}

						return 0;
					}

				},
				{
					Text = "我们已经拥有了所有需要的东西。为其他人留着吧。",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.Flags.set("IsQuartermaster", false);
				this.Banner = this.World.FactionManager.getFaction(this.Contract.getFaction()).getUIBanner();
			}

		});
		this.m.Screens.push({
			ID = "SallyForth1",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_164.png[/img]{南方人出现了，虽然并非主力部队，但也不一定只是他们的侦察兵。 看起来他们在路途中花了一些时间来保持队形而不是散开来自由行军。 如果你现在发动攻击，你很有很可能打他们个措手不及。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们需要抓住这个机会。 让伙计们准备出发！",
					function getResult()
					{
						return this.Math.rand(1, 100) <= 50 ? "SallyForth2" : "SallyForth4";
					}

				},
				{
					Text = "我们在这里有可防守的位置。 我们留在原地。",
					function getResult()
					{
						return "SallyForth5";
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "SallyForth2",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_50.png[/img]{%SPEECH_START%好办法。%SPEECH_OFF%%randombrother% 许诺遵从你的指令。 快速步伐，%companyname% 出发追击南方人，在他们集结全部力量之前击溃他们。. 在他们察觉之前，你不知不觉的到了他们身边。 你看见他们还在卸下行李和装备，在你的视线中，一些随军仆人站起来开始逃命。 剩余的士兵匆忙将武器拿起。\n\n通过他的尖锐的声音判断，在这里的唯一的指挥官并没有接受过应对突袭的训练，他扯着嗓子发号施令，几近破音，同时军队正尝试摆出阵列的样子来。 不要浪费时间，你们冲入战斗！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "冲锋！",
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
			ID = "SallyForth3",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_90.png[/img]{你们解决掉了最后一个士兵，惊讶的神情仍然可怕地凝固在他的脸上。%SPEECH_ON%队长，其余的人都来了。%SPEECH_OFF%%randombrother% 一边说着，一边从地平线凝视中转过头来。 你点点头，命令你的人准备好。 这次，南方人以良好的队形接近，虽然在看到你和死尸遍布你的脚下时短暂地动摇了。他们的旗帜在天空中升起，南方人重新振作精神，愤怒而有活力地冲了过来。“为吉尔德而战！”的呼喊声在空气中荡漾。你指着你的剑向前冲。%SPEECH_ON%他们的信仰虽然令人钦佩，但在这里他们不会找到任何神，只有%companyname%等待着他们，而我们只有一个祷告。%SPEECH_OFF%战斗开始，战士们咆哮着。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "集合！集合！准备好！",
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
			ID = "SallyForth4",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_164.png[/img]{%SPEECH_START%好办法。%SPEECH_OFF%%randombrother% 许诺遵从你的指令。 快速步伐，%companyname% 出发追击南方人，在他们集结全部力量之前击溃他们。. 在他们察觉之前，你不知不觉的到了他们身边。 你看见他们还在卸下行李和装备，在你的视线中，一些随军仆人站起来开始逃命。 剩余的士兵匆忙将武器拿起。 就在你认为自己有先手时，另外一支小分队从侧边袭入。%SPEECH_ON%镶金工只向那些值得拥有他的光辉的人微笑，王冠！%SPEECH_OFF% 南方指挥官讥讽地喊道。由于防线太远，敌人又太近，现在只有一个地方可去。 你举起了你的剑，准备让你的人冲锋。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们要杀出一条血路！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			],
			function start()
			{
				this.Flags.set("IsEnemyReinforcements", true);
			}

		});
		this.m.Screens.push({
			ID = "SallyForth5",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{你认为最好是固守不动。 这或许会让机会流逝，但反过来这也是所有可能选项中最安全的。%SPEECH_ON%我们本应该出去。我们这样就失去了一次机会，队长。%SPEECH_OFF%你抬起头，看见 %randombrother% 正在耸肩。 你告诉他别嚼舌根子，不然他的身体也会失去某些东西。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "所有人，准备好。 他们很快就会全力进攻。",
					function getResult()
					{
						this.Flags.set("IsSallyForth", false);
						this.Flags.set("AttackTime", 1.0);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "AlliedSoldiers1",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_78.png[/img]{等待南方人的时候，一支北方军队到来了。他们的队长向你们点了点头。%SPEECH_ON%当他们告诉我要出来帮助一个自由佣兵时，我说他们可以把那个命令塞到他们的屁股里。但你知道是什么让我相信了吗？就是因为那佣兵团是你们 %companyname%。你们的声望很高，而我有很多人可以为这场战斗而战。%SPEECH_OFF%从他们的装备来看，他们最适合用作掩护部队，或许可以把来犯的部分敌军引开。 那么，也许最好的方法是将他们纳入战团，用来加强战团的战斗力。.}",
			Image = "",
			Banner = "",
			List = [],
			Options = [
				{
					Text = "中尉，我需要你和你的士兵去包抄他们的炮手。",
					function getResult()
					{
						this.Flags.set("IsEnemyLuredAway", true);
						this.Flags.set("AttackTime", this.Time.getVirtualTimeF() + this.Math.rand(5, 10));
						return "AlliedSoldiers2";
					}

				},
				{
					Text = "我需要你的你和你的人去引诱走他们的一些步兵，军官。",
					function getResult()
					{
						this.Flags.set("IsEnemyLuredAway", true);
						this.Flags.set("AttackTime", this.Time.getVirtualTimeF() + this.Math.rand(5, 10));
						return "AlliedSoldiers2";
					}

				},
				{
					Text = "我需要你和你的人来我们这边和我们一起战斗，军官。",
					function getResult()
					{
						this.Flags.set("IsAlliedReinforcements", true);
						this.Flags.set("AttackTime", this.Time.getVirtualTimeF() + this.Math.rand(5, 10));
						return "AlliedSoldiers3";
					}

				}
			],
			function start()
			{
				this.Banner = this.World.FactionManager.getFaction(this.Contract.getFaction()).getUIBanner();
				this.Flags.set("IsAlliedSoldiers", false);
			}

		});
		this.m.Screens.push({
			ID = "AlliedSoldiers2",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_78.png[/img]{你拿出了一个望远镜，开始仔细观察战场。 北方军队以翼形编队向敌人冲锋，然后分别在两翼上分开奔跑。这似乎是一个自杀性的冲锋，但令你惊讶的是，他们成功地进行了一次诱敌深入的撤退，南方人也果然忍不住追击了。你看着吉尔德的追随者没有留心这个假动作，反而大败亏输追逐着。%SPEECH_ON%太妙了，队长。%SPEECH_OFF%%randombrother%说。}",
			Image = "",
			Banner = "",
			List = [],
			Options = [
				{
					Text = "非常好。",
					function getResult()
					{
						this.Flags.set("IsAlliedSoldiers", false);
						this.Flags.set("AttackTime", this.Time.getVirtualTimeF() + this.Math.rand(5, 10));
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
			ID = "AlliedSoldiers3",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_78.png[/img]{你宁愿士兵和你待在一起。军官点了点头。%SPEECH_ON%是的，队长，那么，您叫什么名字？%SPEECH_OFF%不理他，您告诉%randombrother%给北部军队安排防御。%SPEECH_ON%确保他们知道得很好，但不要太详细。%SPEECH_OFF%雇佣兵凑近耳边耳语。%SPEECH_ON%啊，如果他们是间谍，我们不想给他们太多细节，是吧，队长？%SPEECH_OFF%您凑近他s的耳朵小声说。%SPEECH_ON%不。把他们放在我们最薄弱的地方。希望他们都在前线死掉，然后我们就可以得到他们的财物。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Banner = "",
			Options = [
				{
					Text = "现在我们接着等吧。",
					function getResult()
					{
						this.Flags.set("IsAlliedSoldiers", false);
						this.Flags.set("AttackTime", this.Time.getVirtualTimeF() + this.Math.rand(5, 10));
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
			ID = "Victory",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_168.png[/img]{最后一个南方士兵仰着头看着你。%SPEECH_ON%Gilder的灿烂，让我准备好了。%SPEECH_OFF%你拔出剑。%SPEECH_ON%可如果只有我在这里，而你在那里，那么这个灿烂有什么用呢？%SPEECH_OFF%在他回答之前，你把剑刺穿了他的脖子。你让雇佣兵抢夺尸体并准备返回%employer%。 | 你找到了最后一个南方士兵，他斜靠在石头上，手臂搭在顶部，仿佛那是他的好伙伴。他吐出一口血，点了点头。%SPEECH_ON%或许我的路并没有那么有希望。%SPEECH_OFF%你回点头告诉他，他马上就可以向Gilder自己询问。%SPEECH_ON%关于你，我也会问问他。%SPEECH_OFF%他回答道。你停顿了一会儿，然后用剑刺穿了他的身体。剩余的尸体需要被抢夺。%employer%肯定会很高兴见到你。 | 战斗结束，死者满地。你站在最后一个有呼吸的南方人身上。他目光呆滞地望着天空。当你问他是否认为他的“Gilder”在看着时，这个人微笑了。%SPEECH_ON%他正看着我们俩。%SPEECH_OFF%你点了点头，然后结束了他的生命。你发出一个尖锐的口哨，得到了%companyname%的注意。你的命令很简单：抢掠值钱的东西，然后准备返回%employer%。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "胜利！",
					function getResult()
					{
						this.Contract.spawnAlly();
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Failure",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{南方人已经在%holysite%升起了他们的旗帜。%SPEECH_ON%我想这就是结束了。%SPEECH_OFF%%randombrother%说道。如果你的意思是没有理由去找%employer%终止合同，那么确实如此。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "灾难！",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "没能保卫圣地");
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
			Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%我猜南方的那些家伙在你结束他们的胡闹后肯定大声抱怨了。%SPEECH_OFF%%employer% 在你还没来得及回应之前咬下了半个鸡胸肉。不过他仍然继续说话，只有口中含着食物，直到它们没有被吞下去并散落在桌子上为止。%SPEECH_ON%你知道吗，以前我对古老的神持怀疑态度，但现在看来，我可以看到他们的方式是正确的，并且他们的神性是最正义的。 %SPEECH_OFF% 他将剩下的东西吞下去并把鸡肉扔在盘子里。 %SPEECH_ON%给佣兵付钱吧。 %SPEECH_OFF% | 你在几个僧侣、他们的领袖和一些未婚女子的陪伴下找到%employer%。贵族露出了满脸笑容。 %SPEECH_ON%我们几天前就听说了你最近的成就。古老的神灵为你的士兵举起酒杯，雇佣兵。我相信你给了那些南方人应得的惩罚。这是承诺中的报酬.%SPEECH_OFF% 几个女子走向你，但很快被其他人拉回去了。 %SPEECH_ON%女士们，请在雇佣兵周围表现得体些.%SPEECH_OFF%%employer% 指着一个装有 %reward% 克朗的箱子。 | 你在一个修道院里找到了%employer%。他独自在祭坛前祈祷，等他结束后没有转身就说话了。%SPEECH_ON%我相信昨晚古老的神灵跟我说话了。告诉我你会带着好消息回来，果然如此。因为我们现在是独处，所以我会告诉你一些事情。那些骑马穿过沙漠的“镀金者”，我认为他们是真心实意的人。无论他们在哪座建筑中祈祷，现在都正在这样做。你并没有动摇他们的信仰，总有一天我们会再次出发去那里.%SPEECH_OFF% 贵族站起来转过身来%SPEECH_ON%，失败使信徒更加坚定不移. 我已经吃够苦头了, 现在轮到他们承担. 当你完成任务领取报酬时，请为它做最后一次祈福.%SPEECH_OFF% 虽然您不打算这么做, 但觉得向开放心扉之人讲真话是不合适的。拿着吧, 这袋子里装着 %reward% 克朗。}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "保卫圣地");
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
			this.logInfo("姓名：" + s.getName());

			if (s.isMilitary())
			{
				candidates.push(s);
			}
		}

		local party = f.spawnEntity(tiles[0].Tile, candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly() + " Company", true, this.Const.World.Spawn.Noble, this.Math.rand(100, 150) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
		party.setDescription("为地方领主服务的专业士兵。");
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
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(this.m.Destination.getTile());
		c.addOrder(move);
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

		local party = f.spawnEntity(tiles[0].Tile, "Regiment of " + candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly(), true, this.Const.World.Spawn.Southern, (this.m.Flags.get("IsEnemyLuredAway") ? 130 : 160) * this.getScaledDifficultyMult());
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
		party.setDescription("忠于城邦的应征士兵。");
		party.setAttackableByAI(false);
		party.setAlwaysAttackPlayer(true);
		party.getLoot().Money = this.Math.rand(50, 200);
		party.getLoot().ArmorParts = this.Math.rand(0, 25);
		party.getLoot().Medicine = this.Math.rand(0, 3);
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
		local occupy = this.new("scripts/ai/world/orders/occupy_order");
		occupy.setTarget(this.m.Destination);
		occupy.setTime(10.0);
		occupy.setSafetyOverride(true);
		c.addOrder(occupy);
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
			"employerfaction",
			this.World.FactionManager.getFaction(this.m.Faction).getName()
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
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
			foreach( i, s in sites )
			{
				if (v.getTypeID() == s && v.getFaction() != 0 && this.World.FactionManager.isAllied(this.getFaction(), v.getFaction()))
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

