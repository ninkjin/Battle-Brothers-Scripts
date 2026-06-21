this.defend_holy_site_southern_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Target = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.defend_holy_site_southern";
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
		this.m.Payment.Pool = 1200 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
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

		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local houses = [];

		foreach( n in nobles )
		{
			if (n.getFlags().get("IsHolyWarParticipant"))
			{
				houses.push(n);
			}
		}

		this.m.Flags.set("DestinationName", this.m.Destination.getName());
		this.m.Flags.set("DestinationIndex", targetIndex);
		this.m.Flags.set("EnemyID", houses[this.Math.rand(0, houses.len() - 1)].getID());
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"移动到 %holysite%，保卫它，抵御北方的异教者"
				];
				this.Contract.setScreen("Task");
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				if (r <= 25)
				{
					this.Flags.set("IsAlchemist", true);
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

				local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
				local houses = [];

				foreach( n in nobles )
				{
					if (n.getFlags().get("IsHolyWarParticipant"))
					{
						n.addPlayerRelation(-99.0, "在战争选择了阵营");
						houses.push(n);
					}
				}

				this.Contract.m.Destination.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);

				if (this.Contract.getDifficultyMult() >= 0.95)
				{
					local f = houses[this.Math.rand(0, houses.len() - 1)];
					local candidates = [];

					foreach( s in f.getSettlements() )
					{
						if (s.isMilitary())
						{
							candidates.push(s);
						}
					}

					local party = f.spawnEntity(this.Contract.m.Destination.getTile(), candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly() + " Company", true, this.Const.World.Spawn.Noble, this.Math.rand(100, 150) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
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
				if (this.Flags.get("IsAlchemist") && this.Contract.isPlayerAt(this.Contract.m.Home) && this.World.Assets.getStash().getNumberOfEmptySlots() >= 2)
				{
					this.Contract.setScreen("Alchemist1");
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
					"保卫 %holysite% 抵御北方的异教者",
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
					p.Music = this.Const.Music.NobleTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.Entities = [];
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
					p.EnemyBanners = [
						this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
					];

					if (this.Flags.get("IsLocalsRecruited"))
					{
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.PeasantsSouthern, 10, this.Contract.getFaction());
						p.AllyBanners.push("banner_noble_11");
					}

					this.World.Contracts.startScriptedCombat(p, false, true, true);
				}
				else if (this.Flags.get("IsSallyForth"))
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "DefendHolySite";
					p.Music = this.Const.Music.NobleTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.Entities = [];
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, (this.Flags.get("IsEnemyReinforcements") ? 130 : 100) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
					p.EnemyBanners = [
						this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
					];

					if (this.Flags.get("IsLocalsRecruited"))
					{
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.PeasantsSouthern, 50, this.Contract.getFaction());
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
						p.LocationTemplate.Template[0] = "tactical.southern_ruins";
						p.LocationTemplate.Fortification = this.Flags.get("IsPalisadeBuilt") ? this.Const.Tactical.FortificationType.WallsAndPalisade : this.Const.Tactical.FortificationType.Walls;
						p.LocationTemplate.CutDownTrees = true;
						p.LocationTemplate.ShiftX = -4;
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineForward;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
						p.AllyBanners = [
							this.World.Assets.getBanner()
						];

						if (this.Flags.get("IsAlliedReinforcements"))
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southern, 50 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
							p.AllyBanners.push(this.World.FactionManager.getFaction(this.Contract.getFaction()).getPartyBanner());
						}

						if (this.Flags.get("IsLocalsRecruited"))
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.PeasantsSouthern, 50, this.Contract.getFaction());
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
			Text = "{[img]gfx/ui/events/event_163.png[/img]%employer% 不见了。 相反，一名身着文书服的男子走过来，旁边还有一名军官。 他们说，一支由北方士兵组成的小分队正在接近 %holysite%，企图为北方完全拿下这个地方。 由于城邦的士兵在其他地方，他们不得不依靠你赶去那个地方并进行防御。 他们严肃的说话语气暗示着内心的焦虑，毫无疑问这天极有可能是一个沉甸甸的收获日。 | [img]gfx/ui/events/event_162.png[/img]你被请入 %employer%的房间，房中的维齐尔向你点点头并拍了拍手。%SPEECH_ON%终于，小逐币者来了，准备为我们做件大事。 过来，看看这张地地图。 你看见我的人在哪儿了吗？ 然后你看见 %holysite% 在哪儿了吗？ 就在那儿，那些北方老鼠… 他们离圣地很近，而我的人离得很远。 然而，你就在这里，真的很近，不是吗？ 对于这 %reward% 克朗，我想让你去 %holysite% 并保卫它。%SPEECH_OFF%维齐尔脸上挂着和煦的微笑盯着你们，好像这不是一个问题一样，但这样一个用黄金来衡量的请求，它也许就已经像一个命令一样严肃了。}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{%companyname% 可以为此帮你。 | 抵御北方佬会有更好的报酬。 | 我很感兴趣，继续。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这不值得。 | 我们还有别的地方要去。 | 我不会冒险让战队对抗北方军队。}",
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
				for( local i = 0; i < 3; i = ++i )
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
			}

		});
		this.m.Screens.push({
			ID = "Preparation4",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{仍在 %holysite% 旁逗留的少数忠实信徒一定是充满热情和狂热的。 在这儿你代表南方，你让人挑选了几个镀金者的追随者并询问了他们是否愿为他们的神而战。 如果有的话，那么这将是一个方便的招募办法，他们可以很快的武装自己，接受最短时间的训练。 你只能希望这些人能在即将到来的实战中有些作用。}",
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
			Text = "[img]gfx/ui/events/event_78.png[/img]{北方军队来了。 或者说，至少是一部分。 由于相当繁重的盔甲和武装，长途跋涉已经让士兵有些消瘦，但他们仍然看起来十分有挑战性。 你看向 %randombrother%，他耸耸肩。%SPEECH_ON%{除去这片景色之外，只是另一场战斗罢了，不是吗？ | 我知道每个人都将会谈论这件事，宗教狗屎之类，但是说实话，对我来说这只是另一场战斗。 而且我爱它。}%SPEECH_OFF%点了点头，你拔出你的剑，命令你的人做好准备。}",
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
			ID = "Alchemist1",
			Title = "在 %townname%",
			Text = "[img]gfx/ui/events/event_163.png[/img]{在 %townname% 的大门处，一个男人走进你。根据他胸前挂着的乱七八糟颜色的条纹和护符带来判断，他是一个炼金术士。 他声称他是维齐尔派来的。%SPEECH_ON%我的材料有点短缺，但我有足够的材料来制作非常具体的东西，如果是你说出来的，当然可以。%SPEECH_OFF%他描述他的方案如：火焰罐，闪光罐或者烟雾罐。}",
			Image = "",
			Banner = "",
			List = [],
			Options = [
				{
					Text = "我们要火焰罐。",
					function getResult()
					{
						this.Flags.set("IsFirepot", true);
						return "Alchemist2";
					}

				},
				{
					Text = "我们要闪光罐。",
					function getResult()
					{
						this.Flags.set("IsFlashpot", true);
						return "Alchemist2";
					}

				},
				{
					Text = "我们要烟雾罐。",
					function getResult()
					{
						this.Flags.set("IsSmokepot", true);
						return "Alchemist2";
					}

				},
				{
					Text = "我们已经有了我们所需的一切了。",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.Flags.set("IsAlchemist", false);
				this.Banner = this.World.FactionManager.getFaction(this.Contract.getFaction()).getUIBanner();
			}

		});
		this.m.Screens.push({
			ID = "Alchemist2",
			Title = "在 %townname%",
			Text = "[img]gfx/ui/events/event_163.png[/img]{炼金术士迅速开工，他将一大堆原材料粉末泼进碗中，然后将少量你无法认出的材料捣入。 这只花费了令人惊奇的极短时间，你不确定他是天赋异禀还是这整件事只是闹剧。 不管怎样，他如约交付了罐子。%SPEECH_ON%愿镀金者照亮你的道路，愿你的剑将和平带到 %holysite%。%SPEECH_OFF%}",
			Image = "",
			Banner = "",
			List = [],
			Options = [
				{
					Text = "这些应该会派上用场。",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.Banner = this.World.FactionManager.getFaction(this.Contract.getFaction()).getUIBanner();

				for( local i = 0; i < 2; i = ++i )
				{
					local item;

					if (this.Flags.get("IsFirepot"))
					{
						item = this.new("scripts/items/tools/fire_bomb_item");
					}
					else if (this.Flags.get("IsFlashpot"))
					{
						item = this.new("scripts/items/tools/daze_bomb_item");
					}
					else if (this.Flags.get("IsSmokepot"))
					{
						item = this.new("scripts/items/tools/smoke_bomb_item");
					}

					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "你获得了一个 " + item.getName()
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "SallyForth1",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_78.png[/img]{北方人出现了，虽然并非主力部队，但也不一定只是他们的侦察兵。 看起来他们在路途中花了一些时间来保持队形而不是散开来自由行军。 如果你现在发动攻击，你很有很可能打他们个措手不及。}",
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
			Text = "[img]gfx/ui/events/event_156.png[/img]{%SPEECH_START%好办法。%SPEECH_OFF%%randombrother% 许诺遵从你的指令。 %companyname% 快速出发，在北方部队完全集结前开始了进攻。 在他们察觉之前，你不知不觉的到了他们身边。 你看见他们还在卸下行李和装备，在你的视线中，一些随军仆人站起来开始逃命。 剩余的士兵匆忙将武器拿起。 通过他的尖锐的声音判断，在这里的唯一的指挥官并没有接受过应对突袭的训练，他扯着嗓子发号施令，几近破音，同时军队正尝试摆出阵列的样子来。 不要浪费时间，你们冲入战斗！}",
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
			Text = "[img]gfx/ui/events/event_90.png[/img]{你们解决掉了最后一个士兵，惊讶的神情仍然可怕地凝固在他的脸上。%SPEECH_ON%队长，其余的人都来了。%SPEECH_OFF%%randombrother% 一边说着，一边从地平线凝视中转过头来。 你点点头，命令你的人准备好。 这次北方人正排着整齐的阵列靠近，尽管在看见你们和你们脚下的尸体后，他们又放弃了排阵。 旗帜直插天空，北方人重获新生，愤怒而有力地冲向前。 你低头看向 %randombrother%，把他肩上没弄干净的器官掸掉。 当他回头看向你，你微微一笑。%SPEECH_ON%乐趣就在于此，你应该着装整洁些。%SPEECH_OFF%}",
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
			Text = "[img]gfx/ui/events/event_78.png[/img]{%SPEECH_START%好办法。%SPEECH_OFF%%randombrother% 许诺遵从你的指令。 %companyname% 快速出发，在北方部队完全集结前开始了进攻。 在他们察觉之前，你不知不觉的到了他们身边。 你看见他们还在卸下行李和装备，在你的视线中，一些随军仆人站起来开始逃命。 剩余的士兵匆忙将武器拿起。 就在你认为自己有先手时，另外一支小分队从侧边袭入。%SPEECH_ON%真见鬼了，怎么这么多人！%SPEECH_OFF%%randombrother% 说道。防卫部队太远，而敌人太近。 现在只有一条出路。 你举起了你的剑，准备让你的人冲锋。}",
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
			Text = "[img]gfx/ui/events/event_164.png[/img]{在你等待北方人的时候，一小队南方士兵冲向了你。 谢天谢地，他们是你们一边的并且准备提供帮助。%SPEECH_ON%镀金者告诉我们你们应该在这里，虽然你是逐币者，我们还是会服从你的命令，以他的荣耀保卫这片土地。%SPEECH_OFF%从他们的装备来看，他们最适合用作掩护部队，或许可以把来犯的部分敌军引开。 或者现在最好是加入 %companyname%，加强你的军队里已经是最强的地方。}",
			Image = "",
			Banner = "",
			List = [],
			Options = [
				{
					Text = "我需要你和你的人去侧翼攻击他们的弩兵，军官。",
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
			Text = "[img]gfx/ui/events/event_164.png[/img]{你拿出了一个望远镜，开始仔细观察战场。 南方士兵像蚂蚁一样倾巢而出，和北方人开始缠斗。 令你惊奇的是，佯攻起了作用。 你咧嘴一笑，看着北方军队被拆散，被追赶，他们的军队被渐渐削弱了。}",
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
			Text = "[img]gfx/ui/events/event_164.png[/img]{你宁愿士兵和你待在一起。军官点了点头。%SPEECH_ON%镀金者坚信我们已经帮助了你，不管你信不信，他也相信你也这么想。%SPEECH_OFF%好吧，当然。你告诉他们应该去的地方，虽然恼火，但宗教的服从让他们开始行动，继续搜寻关于黄金和光芒一类的东西。}",
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
			Text = "[img]gfx/ui/events/event_87.png[/img]{最后一个奄奄一息北方人已经躺在地上，胸上一道伤口，鲜血潺潺流向地面。 伴随着大势已去的预感，他眼睛愣了很久，镇定地呼吸着。 你拿出了你的剑，但他伸出了他的手。 不是要恳求仁慈，而是为了一些时间。%SPEECH_ON%不需要这个。 我已经看见了它。 它在逝去。它还在逝去。 我不知道为什么会在意这么多。%SPEECH_OFF%他昏倒了，手臂也随之绷紧，从他胸前落下来。%randombrother% 戳了戳他的尸体，然后洗劫了它。 你收起你的剑，告诉伙计们准备回去见维齐尔。 | 你的人解决掉了最后的一些幸存者。 大部分是一些突然开跑的尸体，一两次快速的刺击就可以解决。 有些尸体仍在颤动，但你知道他们已经死透了。 你不确定他们为什么仍会这样动的原因，就好像这个男人曾经把恐惧抛在脑后。 其他的根本没有反应。 突然传来一声试图藏起来的士兵的尖叫声，但他被迅速安静了。 战场遍布着败者的尸体，你让 %companyname% 去尽可能地洗劫，准备回到大臣那儿的旅程。 | 最后一个北方人把他自己委身于岩石缝里，他双手张开巴住两边就好像蜘蛛退回到它隐藏的洞里一样。%SPEECH_ON%旧神不会怜悯你的。%SPEECH_OFF%一道阴影短暂地来到并从他头上掠过，随之一块石头被它扰动，砸坏了那人的头。 他摔向地面，身体抽动着，嘴巴吐着泡沫。%randombrother% 从岩石的顶部看向我们。%SPEECH_ON%这是最后一个了。 我们应该拿走他们的装备然后回到，呃，那个家伙，穿着气派的，维齐…维兹…子爵？%SPEECH_OFF%维齐尔。准确地说。}",
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
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{好吧，%holysite% 现在属于北方人了。 既然你把自己的脑袋看得很重，并希望它一直留在那儿，你不觉得至少在一段时间内回到维齐尔身边有什么意义。}",
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
			Text = "[img]gfx/ui/events/event_04.png[/img]{%employer% 被发现在离他宫殿的一处小修道院里。 在这儿发现他是一件不寻常的事，这儿有一小群贫苦的追随者在他的脚边，聆听他的教诲。 维齐尔盯着你，然后中断了讲话，向另外某人点了点头。 一会时间过后，一个留胡子的男人佩着两把剑走进了你。 他上下打量了你一会，然后走到一边，让两个仆人抬上来一个箱子。%SPEECH_ON%维齐尔希望好好感谢你逐币者。 祝愿你永远在镀金者的道路上继续旅行。%SPEECH_OFF%当然，在钱转交后，你立刻被引领出去了。 身后的门关上时，维齐尔没有向你们点头或者挥手。 | 你们被领着走过一个长长的大厅然后被带入一个空空的房间。 有一瞬间，你好奇这是否意味着你们被背叛了。 背叛通常很少在一尘不染的地方发生。 当你盯着整洁的石头地板时，%employer% 从另一边进来了。 他在离你们好多尺的地方站着，房间回响着他的声音。%SPEECH_ON%据说你们浴血奋战，那些北方人在战斗中证明他们只是一群会叫的狗罢了。 我想这后一种说法只是一个假手段，，意在引起我个人的快乐感。 但是我是一个思考者和现实主义者。 我想你发现了敌人的决心是如此可怕，就像我们的一样。 你会得到我们同意的价格的回报，逐币者。%SPEECH_OFF%一群人突然在维齐尔身后列队走进房间，你再一次怀疑他们在那里是否另有目的。 令你放心的是，他们只是带来了大包硬币。 当你回头看向大门时，%employer% 已经离开了，一会儿后，他的仆人也跟着离开了。 | %employer% 与一些被选中的宗教人物，欢迎并领你到一个房间中。 每个谦虚的修道院院长都在你面前简短地鞠了个躬。 维齐尔没有加入，但是他打了个响指，他的仆人用力地拖出一大箱子克朗。 最终这些宗教人士转向维齐尔，然后一个一个在他面前做了相似的鞠躬礼。 他们还吻了他的脚和戒指，这些不全是你自己的事。%employer% 说。%SPEECH_ON%我们的道路一直金光闪耀，逐币者。 镀金者授予了我如此多的知识，对你来说，许多人会忽视的一个谦逊的佣兵，但却被我看中，我雇佣你保卫 %holysite%。我祈祷如此。果然也是这般。%SPEECH_OFF%你拿走了金子然后离开，你看见的最后一件事情是穿着罩衫的男人来回走了几秒钟。}",
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
			for( local y = o.Y - 6; y <= o.Y - 3; y = ++y )
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
			candidates.push(s);
		}

		local party = f.spawnEntity(tiles[0].Tile, "Regiment of " + candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly(), true, this.Const.World.Spawn.Southern, this.Math.rand(100, 150) * this.getScaledDifficultyMult());
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
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
		local f = this.World.FactionManager.getFaction(this.m.Flags.get("EnemyID"));
		local candidates = [];

		foreach( s in f.getSettlements() )
		{
			if (s.isMilitary())
			{
				candidates.push(s);
			}
		}

		local party = f.spawnEntity(tiles[0].Tile, candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly() + " Company", true, this.Const.World.Spawn.Noble, (this.m.Flags.get("IsEnemyLuredAway") ? 130 : 160) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
		party.setDescription("为地方领主服务的专业士兵。");
		party.setAttackableByAI(false);
		party.setAlwaysAttackPlayer(true);
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

