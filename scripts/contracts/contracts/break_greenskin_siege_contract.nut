this.break_greenskin_siege_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Troops = null,
		IsPlayerAttacking = true,
		IsEscortUpdated = false
	},
	function create()
	{
		this.contract.create();
		local r = this.Math.rand(1, 100);

		if (r <= 70)
		{
			this.m.DifficultyMult = this.Math.rand(90, 105) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
		}

		this.m.Type = "contract.break_greenskin_siege";
		this.m.Name = "解除围城";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.MakeAllSpawnsResetOrdersOnContractEnd = false;
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

		this.m.Flags.set("ObjectiveName", this.m.Origin.getName());
		local nearest_orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getNearestSettlement(this.m.Origin.getTile());
		this.m.Flags.set("OrcBase", nearest_orcs.getID());
		local nearest_goblins = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getNearestSettlement(this.m.Origin.getTile());
		this.m.Flags.set("GoblinBase", nearest_goblins.getID());
		this.m.Payment.Pool = 1500 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"前往%objective%",
					"打破绿皮的围城"
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
				local okLocations = 0;

				foreach( l in this.Contract.m.Origin.getAttachedLocations() )
				{
					if (l.isActive())
					{
						okLocations = ++okLocations;
					}
				}

				if (okLocations < 3)
				{
					foreach( l in this.Contract.m.Origin.getAttachedLocations() )
					{
						if (!l.isActive() && !l.isMilitary())
						{
							l.setActive(true);
							okLocations = ++okLocations;

							if (okLocations >= 3)
							{
								break;
							}
						}
					}
				}

				local faction = this.World.FactionManager.getFaction(this.Contract.getFaction());
				local party = faction.spawnEntity(this.Contract.getHome().getTile(), this.Contract.getHome().getName() + " Company", true, this.Const.World.Spawn.Noble, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.getSprite("banner").setBrush(faction.getBannerSmall());
				party.setDescription("为地方领主服务的专业士兵。");
				this.Contract.m.Troops = this.WeakTableRef(party);
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
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(this.Contract.getOrigin().getTile());
				c.addOrder(move);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
				}

				this.World.State.setEscortedEntity(this.Contract.m.Troops);
			}

			function update()
			{
				if (this.Flags.get("IsContractFailed"))
				{
					this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
					this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "战团撕毁了一份合同");
					this.World.Contracts.finishActiveContract(true);
					return;
				}

				if (this.Contract.m.Troops != null && !this.Contract.m.Troops.isNull())
				{
					if (!this.Contract.m.IsEscortUpdated)
					{
						this.World.State.setEscortedEntity(this.Contract.m.Troops);
						this.Contract.m.IsEscortUpdated = true;
					}

					this.World.State.setCampingAllowed(false);
					this.World.State.getPlayer().setPos(this.Contract.m.Troops.getPos());
					this.World.State.getPlayer().setVisible(false);
					this.World.Assets.setUseProvisions(false);
					this.World.getCamera().moveTo(this.World.State.getPlayer());

					if (!this.World.State.isPaused())
					{
						this.World.setSpeedMult(this.Const.World.SpeedSettings.FastMult);
					}

					this.World.State.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.FastMult;
				}

				if ((this.Contract.m.Troops == null || this.Contract.m.Troops.isNull() || !this.Contract.m.Troops.isAlive()) && !this.Flags.get("IsTroopsDeadShown"))
				{
					this.Flags.set("IsTroopsDeadShown", true);
					this.World.State.setCampingAllowed(true);
					this.World.State.setEscortedEntity(null);
					this.World.State.getPlayer().setVisible(true);
					this.World.Assets.setUseProvisions(true);

					if (!this.World.State.isPaused())
					{
						this.World.setSpeedMult(1.0);
					}

					this.World.State.m.LastWorldSpeedMult = 1.0;
					this.Contract.setScreen("TroopsHaveDied");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Contract.isPlayerNear(this.Contract.m.Origin, 1200))
				{
					if (this.Contract.m.Troops == null || this.Contract.m.Troops.isNull())
					{
						this.Contract.setScreen("ArrivingAtTheSiegeNoTroops");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.m.Troops.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(true);
						this.Contract.setScreen("ArrivingAtTheSiege");
						this.World.Contracts.showActiveContract();
					}

					this.World.State.setCampingAllowed(true);
					this.World.State.setEscortedEntity(null);
					this.World.State.getPlayer().setVisible(true);
					this.World.Assets.setUseProvisions(true);

					if (!this.World.State.isPaused())
					{
						this.World.setSpeedMult(1.0);
					}

					this.World.State.m.LastWorldSpeedMult = 1.0;
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				this.Flags.set("IsContractFailed", true);
			}

		});
		this.m.States.push({
			ID = "Running_BreakSiege",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"摧毁所有绿皮的攻城器械",
					"摧毁%objective%周围的所有绿皮"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = false;
				}

				foreach( id in this.Contract.m.UnitsSpawned )
				{
					local e = this.World.getEntityByID(id);

					if (e != null)
					{
						e.getSprite("selection").Visible = true;

						if (e.getFlags().has("SiegeEngine"))
						{
							e.setOnCombatWithPlayerCallback(this.onCombatWithSiegeEngines.bindenv(this));
						}
					}
				}
			}

			function update()
			{
				if (this.Contract.m.UnitsSpawned.len() == 0)
				{
					this.Contract.setScreen("TheAftermath");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Contract.m.Origin == null || this.Contract.m.Origin.isNull() || !this.Contract.m.Origin.isAlive())
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatWithSiegeEngines( _dest, _isPlayerAttacking = true )
			{
				this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
				local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
				p.Music = this.Const.Music.GoblinsTracks;
				p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Edge;
				p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
				p.EnemyBanners = [
					this.World.getEntityByID(this.Flags.get("GoblinBase")).getBanner()
				];
				this.World.Contracts.startScriptedCombat(p, this.Contract.m.IsPlayerAttacking, true, true);
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"返回" + this.Contract.m.Home.getName()
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = false;
				}

				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("Success1");
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
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer%递给你一杯酒。%SPEECH_ON%喝光它。%SPEECH_OFF%你几乎可以从他的呼吸中嗅到坏消息的味道。你一口气喝下了这杯酒，向那个人点了点头。他也向你点头。%SPEECH_ON%大群绿皮正在这个地区肆虐，它们计划夺取%objective%。%SPEECH_OFF%他又倒了一杯酒，一口喝掉，然后又倒了一杯。%SPEECH_ON%如果这个地方被攻陷，那么我想我们也可以预计到整个地区会一同失陷。不知道你对于十年前这些牲口上次侵袭的事情了解多少，但这附近应该没几个人希望看到那种情况再次发生。目前我的探子告诉我围攻刚刚开始，绿皮还未准备万全，这意味着我们现在可以在事情失控前主动出击。我真心希望你对此感兴趣，因为我需要你去那里并打破围城！%SPEECH_OFF% | 卫兵们围着%employer%。他们的头盔已经取下，头上满是汗水，有些人在护甲中颤抖。%employer%透过绝望的人群看到了你，招手示意你过去。%SPEECH_ON%佣兵！我有一些……特别可怕的消息。也许你已经听说了，时间紧迫所以我会快速地概括一下：绿皮可能已经入侵了这个地区，并威胁着夺取%objective%。他们目前正在围攻它，但据报告说绿皮还没有准备万全。我需要你去那里赶在事情失控前打破围城。%SPEECH_OFF% | %employer%身边站着几名文书，他们轮流低声细语，贵族只是点头应答。最终，%employer%将注意力转向了你。%SPEECH_ON%佣兵，你曾打破过围城吗？这附近的%objective%正被绿皮围攻。在它们将其攻陷前，我们已经没多少时间，接下来它们或许会占领整个该死的地区！在这之后……我相信你知道十年前发生了什么。%SPEECH_OFF%文书们一起点头，然后将头低下。%employer%继续道。%SPEECH_ON%那么，你有兴趣参与一些军事行动吗？%SPEECH_OFF% | %employer%面带担忧地欢迎您。%SPEECH_ON%佣兵，我们遭遇了一些困难，需要你的帮助！%objective%已经遭受绿皮的围攻，而我没有足够的部队去独力解围。但我相信你有能力完成这个任务，不是吗？我会付给你丰厚的报酬。%SPEECH_OFF% | %employer%站在桌前交叉着手臂。他的肩膀耸了起来，就像一只盯着猎物的乌鸦。他摇了摇头。%SPEECH_ON%佣兵，我需要更多的人手来帮忙解决围攻%objective%的绿皮军队。你能胜任吗？我需要立刻得到回复。%SPEECH_OFF% | %employer%一见到你就站了起来，额头上挂着汗珠，脸上挤出一个急促难堪的微笑。%SPEECH_ON%佣兵！真的太高兴你来了！据消息称绿皮已经包围了%objective%，我需要你的帮助！你有兴趣吗？我需要你快点做出决定。%SPEECH_OFF% | 你发现%employer%深深埋在他的椅子里，仿佛他希望椅背能将永远他关离到这个世界之外一般。他懒散地朝桌子上的一张地图做出手势。%SPEECH_ON%好吧，有消息说绿皮已经回来了而且他们正在围攻%objective%。我需要尽可能多的人前去那里解围。将会有适宜的薪酬，你接受吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{你认为拯救%objective%值多少钱？ | 打破围城是%companyname%能胜任的事。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这不划算。 | 我们还有其他要事。}",
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
			ID = "PreparingForBattle",
			Title = "在%townname%…",
			Text = "[img]gfx/ui/events/event_78.png[/img]{你走出%employer%的居所，去让战团做好准备，四周骑士和士兵在各处奔走。其中一些围绕在一名教士的周围，默默的为赴死做好准备。%SPEECH_ON%还带要预定一下。%SPEECH_OFF%%randombrother%一边说一边走到你的旁边。他冲你咧嘴一笑。%SPEECH_ON%怎么，太阴暗了吗？%SPEECH_OFF% | 在%employer%的住所外，士兵们在四处奔忙。一些人把补给放入货车后面，其他人则在磨利他们的武器，而若干侍从则带着一大堆盔甲来回穿梭。你走到你手下的前面，命令他们做好准备。%randombrother%向忙碌的人群点了点头。%SPEECH_ON%我想这次会有伙伴与我们同行吧？%SPEECH_OFF% | %employer%的房间外面就有士兵，大厅里也有士兵。你走过充满惊恐的妇女和儿童以及宁愿失聪的失明老人的房间。在外面，你必须挤过一群拿着武器盔甲的侍从。%companyname%在等待你。%SPEECH_ON%让我们出发吧。这些人必须为战斗做好准备，但我们早就准备好了，对吧伙计们？%SPEECH_OFF% | 离开%employer%的地方后，你发现%randombrother%正在等你。他正看着四周忙碌的战斗准备：侍从们拿着盔甲四处奔跑，士兵们往货车里装补给，教士们短暂的平息着年轻士兵的恐惧。你告诉你的佣兵们做好准备，你们将随同这些士兵一同解除围城。 | 你出门发现%employer%的士兵们正在做准备。他们正在把装备装上马车，而一位教士正在他们中间走动。女性、儿童和老人站在路边。%companyname%的人们正尽责地站着。你走过去告诉他们手头的任务。 | 走出门，你发现%employer%的士兵正在武装自己准备好作战。儿童们在那里奔跑，玩耍，对战争的实情一无所知。有些女性已经失去了丈夫，她们更加深沉而忧伤。你走过队伍去找%companyname%，并告诉他们任务的细节。 | %employer%的士兵们正在为战争做好准备。年轻人紧张不安，用虚假的勇气和硬挤出的笑容掩饰他们的恐惧。老兵们则专注于任务，他们脸上的神情表明他们清楚有些旧友永远无法一同回来。而那些疯狂的、眼中冒血的家伙们，则为即将到来的战争表现出令人不安的兴奋。你穿过他们，去通知%companyname%需要完成的事物。 | 当你走出来时，发现%employer%的军队正在为行军做准备。武器堆起了一个大堆，供人挑选。这是一个奇怪的景象，显示出组织的缺失。这可能不是什么好的征兆，但你选择无视它并前去告知%companyname%最新的合同。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们出发！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "TroopsHaveDied",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]所有贵族士兵在前去解围的路上全部阵亡了。但至少死的不是你。%companyname%将继续前往%objective%。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们必须继续前进。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ArrivingAtTheSiege",
			Title = "临近%objective%…",
			Text = "[img]gfx/ui/events/event_68.png[/img]{你终于来到了围城的现场。绿皮们包围了%objective%，你看着它们的攻城器械向空中发射出燃烧着的石头。半个城镇已经被火光所吞噬，你看到小小的人影匆忙地跑来跑去扑灭火势。贵族士兵的尉官命令你前去攻击攻城器械，之后重新汇合并消灭剩余的敌人。 | %objective%看起来更像是一个巨大的篝火而不是一个城镇。你看着绿皮们的攻城器械发射出猛烈的轰炸，天空中充满了黑色的石头、死牛和燃烧的木材。贵族士兵的尉官命令你去摧毁攻城器械。他和他的士兵们将攻击绿皮军队的主力，然后你们两个将重新汇合消灭任何残存的敌人。 | 围城仍然在持续，%objective%也仍然在坚持。看起来你们来得正是时候，因为绿皮们从攻城器械中投射出的破坏如此巨大，可能几个小时后连城镇都没了。看着这一幕，贵族士兵的尉官命令你侧翼攻击并摧毁攻城器械。他和他的士兵们将攻击绿皮军队的主力，之后你们重新汇合并消灭任何幸存者。 | 你在看到轰击之前就听到了它的声音。攻城器械投射的弹矢像狂风一般掠过空气，而它们坠落后的撞击无疑是最为残酷的尾声。终于，你爬上了一个小山得以好好观察%objective%。它正被绿色的蛮子们包围着，攻城器械正前后摇摆着发起攻击，石头、死牛、人类尸体堆，这帮杂种发射一切它们能找到的东西。\n\n贵族士兵的尉官跟你介绍了他的计划。你需要从侧翼攻击攻城器械。他和他的士兵们将攻击绿皮兽军的核心，成功之后，你们两个将重新汇合并消灭剩余的敌人。 | 一名年轻女子和一群孩子就像寒冬中的狼崽一样偎缩在一起。干燥了的血迹粘在她的头侧，但她用几缕凌乱的头发掩盖住了。她解释说，如果你要去%objective%，那你必须赶紧。绿皮们已经设置好了他们的攻城器械，并发起了疯狂的轰击。你和贵族士兵们继续前进，给女子留下一些面包来喂孩子们。\n\n在登顶下一个山丘后，你看到了一幕能证明难民话语的情景。贵族士兵的尉官迅速下达命令。你和%companyname%将进攻攻城器械，而士兵们则进攻绿皮军队的核心。完成这些任务后，你们将会汇合并消灭任何残留的敌人。 | 你和士兵们翻过了最近的山丘以前往%objective%。城镇还在那里，但它比起一个村镇更像一堆废墟。绿皮们毫无疑问已经用它们简陋的攻城器械将它轰击了好一阵子，而它们似乎并没有打算就此停止。\n\n贵族士兵的尉官命令你去迂回敌人并攻击攻城武器。与此同时，士兵们将攻击敌军的核心部队。完成两项任务后，你们会重新汇合并摧毁剩余的敌军残部。 | 你发现一个老人正在沿路推着一辆手推车，车上是一名双腿破碎的年轻人。他昏迷了过去，双手还抓着破碎的膝盖。老人说%objective%就在附近的山丘另一边，并且正在遭受攻城器械的轰击。所以如果你们要采取行动，那最好抓紧时间。%companyname%和士兵们继续前进，留下老人独自推车。\n\n那名老者没有说谎：%objective%正在燃烧，并且在一堆蛮子们的攻城器械围攻下正慢慢变成废墟。亲眼目睹这一幕后，贵族士兵的尉官迅速制定了一个行动计划：%companyname%将从侧翼攻击攻城器械，而士兵们则与绿皮的主力作战。一旦两项任务完成，你们将汇合并消灭剩余的敌人。 | 你发现一群野狗正沿着道路跑来。它们没有靠近你们这群人，但你注意到它们的尾巴夹在两腿中间并且耸拉着脑袋。它们毫不停留的快速的越过了你们。\n\n爬上下一个山头，你看到混乱的原因：绿皮们正在用简陋的攻城机械不停地轰击%objective%。贵族士兵的尉官对此点了点头，并迅速下达了命令。%companyname%将侧翼迂回并直接攻击攻城武器。完成任务后，你们需要绕回来与士兵们汇合，然后一并前进。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "做好战斗准备！",
					function getResult()
					{
						this.Contract.setState("Running_BreakSiege");
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.spawnSiege();
			}

		});
		this.m.Screens.push({
			ID = "ArrivingAtTheSiegeNoTroops",
			Title = "临近%objective%…",
			Text = "[img]gfx/ui/events/event_68.png[/img]{你终于看到了%objective%，并且它处于极度危险之中。城镇正在遭受绿皮攻城器械的一连串轰炸。你下令%companyname%准备行动：你将侧翼包抄敌军，并直接攻击这些攻城机械。 | 由于所有贵族士兵都已死亡，你独自到达了%objective%。绿皮们还在继续用简陋的攻城器械轰击这个可怜的城镇。你认为最好的行动方案是侧翼包抄这些蛮子并攻击他们的攻城器械。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "做好战斗准备！",
					function getResult()
					{
						this.Contract.setState("Running_BreakSiege");
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.spawnSiege();
			}

		});
		this.m.Screens.push({
			ID = "SiegeEquipmentAhead",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_68.png[/img]{绿皮们在附近建造起了一些攻城器械，你必须摧毁它们以解除围城！ | 你的手下发现了附近的几个攻城器械。绿皮们一定在准备突入城镇！摧毁这些器械将有助于解除围城！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "开战！",
					function getResult()
					{
						this.Contract.getActiveState().onCombatWithSiegeEngines(null, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Shaman",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_48.png[/img]{当你接近围城中的哥布林时，你看到了一个独特的身影站在它们的队伍之中。那是一个萨满。你告诉你的手下为之做好充分准备。 | 一个独特的身影在哥布林中脱颖而出。你看到它用它们认为是语言的可怕腔调发出命令。这个可恶的东西被奇怪的植物缠绕着，并佩戴着动物骨头制成的项链。%SPEECH_ON%那是一个萨满。%SPEECH_OFF%%randombrother%一边说一边站到了旁边。%SPEECH_ON%我会提醒其他人的。%SPEECH_OFF% | %randombrother%侦查后返回。他分享的消息表明有一个地精萨满在入侵的绿皮队伍中。那个人似乎相当恼火。%SPEECH_ON%我喜欢杀哥布林，但这次这些怪胎会让我们头疼。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "开战！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Warlord",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_49.png[/img]{当你接近围城的绿皮时，你注意到了一个几乎无法忽视的东西：一位高大威猛的兽人军阀。这个可恶玩意的盔甲在它转身用兽人语言叫喊命令时闪闪发光，将手下的绿皮们鼓舞进入充满暴力的狂热。你让%randombrother%通告消息并让手下做好准备。 | 当你靠近围城部队时，你认出了一位兽人军阀高大而残暴的身影。即使在这样的距离，你也能听到他朝着手下怒吼的声音。这场战斗将会更加扣人心弦。 | 你靠近绿皮们的围城营地，结果听到了一位兽人军阀典型的咆哮。它正在用它们那种恶心而大声的语言喊出命令。他的出现让任务稍稍更有挑战，你通知了手下相关事宜。 | %randombrother%侦查后返回，他说有一个兽人军阀在绿皮的营地里。虽然这是个坏消息，但现在就知道并做好准备总比一头扎进去再吃惊要好。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "开战！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "TheAftermath",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{战斗结束了，绿皮从战场上溃败。%objective%被拯救，%employer%应该会非常高兴。你跨过了成堆的人兽尸体，集合你的手下准备返回。 | 战场上到处都是尸体，成群的苍蝇已经开始围绕和繁忙起来。你集合你的手下，准备回去找%employer%拿取报酬。 | %objective%被拯救了！好吧，至少是还剩下的那些。士兵和绿皮，死了的和没死透的，散布在你视线所及之处。这是一个残酷的景象，而且刚刚产生。你下令%companyname%准备回去找%employer%拿取报酬。 | 尸体堆叠了两到三层，有时甚至有四层。幸存者被埋在这些死人下面，在地面上也处于六英尺之下。这是一个可怕的景象，更加令人不安的是重伤和垂死之人的呼救声。在尸山血海中寻找他们就像是在浩渺黑暗的海洋上寻找漂浮的水手。你转身离开这一幕去集合%companyname%的人员。%employer%应该很乐于见到你们返回。 | 战斗以胜利告终，你看着长枪手们小心地在战场上踱步。他们用长兵器的优势去安全地处决任何躺在地上受伤未死的绿皮。其余的贵族士兵都倒在地上，喝水，洗掉脸上的血迹。你没有时间去做这样的休息，反之迅速召集你的佣兵以回去找%employer%。 | 血液泥泞了大地，你的靴子深深陷入泥潭。尸体散落在周围，躯体形状被变的陌生，肢体断开并远离了它们的主人。斩下的头颅到处都是，惊恐之意在双目中冻结。折断的箭矢，劈裂的长矛，遗弃的剑。碎裂的铠甲破片在脚下叮当作响。这是一场硬仗，并且毫无疑问留下的它的痕迹，供所有人观摩。\n\n由于%objective%已经被拯救，你慢慢地召集%companyname%去返回%employer%处领取丰厚的报酬。 | 战斗结束了，贵族士兵们立刻开始砍下他们能找到的每一个绿皮的脑袋。他们将这些头颅穿刺在长枪上高高举起，模仿着他们刚消灭掉的蛮子们那种野蛮的行径。你没有时间参与这样的戏剧性演出。%objective%已经得救，这才是你收钱办事的目标。%companyname%迅速集结，准备回去找%employer%。 | 战斗结束后，你小心翼翼地穿过战场。每一个尸体都诉说着它们临终的故事。有些被人从背面刺杀，有些的脑袋不知道去了哪里，还有些的肠子被挖了出来，他们紧紧地抓这它们，表情震惊的见证着本不应该发生的事情。陈词滥调而已，唯独地点不同。最重要的是%objective%仍然屹立不倒。你召集%companyname%去回去找%employer%领取报酬。 | %randombrother%走到你身边。他拿着一个绿皮的头，但是很快就把它扔掉了，就好像新奇的感觉已经消逝。他把双手放在臀部，点着头看着战场。%SPEECH_ON%好吧，有点了不得。%SPEECH_OFF%尸体散落在地上，有时候会堆叠成三四层，肢体扭曲，表情狰狞，血液涌出。士兵们穿过这一切，仿佛穿越小溪一般，只不过溅起的是血。%objective%虽然还在燃烧，但依旧在远方屹立不倒，这对你来说才最为重要。%companyname%现在应该返回%employer%处领取报酬。 | 围攻已经被解除，尽管绿皮不是自愿放弃的。死去的人和野兽散落在你眼前的整片土地上，基本没有给你留下什么想象空间。%randombrother%走到你身边。他从肩膀上揭起一块绿色的肉，像一块湿抹布一样甩开。%SPEECH_ON%真是一场硬仗，长官。%SPEECH_OFF%你点点头，命令他让手下们做好准备。%employer%听到%objective%得以被拯救的消息一定会非常高兴的。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "胜利！",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你带着%employer%的一些尉官回到了他面前。他们报告了最新的消息，你的雇主很快点了点头，递给你一大袋克朗。在你离去的时候，他的尉官们递给了你一些嫉妒的目光。 | 围城被解除，你向%employer%报告了这个消息。他点头并给了你一个装满克朗的小口袋。%SPEECH_ON%他们会传颂你的。我是说，那些还未诞生的人们。%SPEECH_OFF% | 你向%employer%报告了围城被解除的消息。他站起来和你握手。%SPEECH_ON%以旧神之名，你今日之功劳将用不会被忘记！%SPEECH_OFF%但你脑袋里却在想，同样的话是否也曾对着一个现在已经只剩骨与灰的人说过。总之你还是拿到了报酬，将传承和历史留给了哲学家。 | %employer%欣然欢迎你的回归，他立刻站起来，过程中差点被他的一只狗绊倒。%SPEECH_ON%雇佣兵，我已经听到了这个好消息！围城已被解除，所以你确实值得一份了不得的报酬！%SPEECH_OFF%他将一个沉重的箱子放到桌子上，你接过来点清克朗，然后离开了。 | 当你进入时%employer%正坐在他的桌子后面。%SPEECH_ON%进来吧，‘英雄’。他们在你的名字后面会记录什么？%SPEECH_OFF%你询问他到底在指什么。%SPEECH_ON%请不要这么谦虚，佣兵。你所完成的事情甚至值得那些尚未出生的人传颂！%SPEECH_OFF%你点点头。%SPEECH_ON%嗯，当然，那很不错。我的钱呢？%SPEECH_OFF%你的雇主嘴唇紧抿。他也点头回应并递给你一个小包。%SPEECH_ON%我相信你是一个任务众多的人，这个任务对你来说无所谓，但对我们而言却不同！%SPEECH_OFF% | 当你进入时，%employer%正低头看着他的脚。有人藏在他的桌子下面，而他并没有试图隐藏他的情妇。%SPEECH_ON%欢迎回来，佣兵！你的报酬在那个角落里。那边的那个角落。别试图偷看。%SPEECH_OFF%你拿到报酬，朝门口走去。%employer%向你喊叫，并竖起了大拇指。%SPEECH_ON%顺便说一句，干得好。%SPEECH_OFF%你点了点头，离开了。 | 你带着%employer%的一些尉官进入了的他房间。他看到你们后站起来，但很快就挥手让他的士兵们出去。他们听从了他的指示，懒洋洋地离开了。你摇了摇头。%SPEECH_ON%他们也参加了战斗。%SPEECH_OFF%%employer%挥手打断你。%SPEECH_ON%他们当然参加了战斗，而他们也在领取薪酬。不过，你是按合同雇佣的，并且合同已经履行。顺便说一句，最好不要让那些人看到我给你的报酬，这样也许更好。%SPEECH_OFF%你拿到了你的报酬，数额毫无疑问能引起嫉妒，你在走出大厅之前就将其藏了起来。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "%objective%得救了。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "解除围城于" + this.Flags.get("ObjectiveName"));
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isGreenskinInvasion())
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
					text = "你获得了[color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color]克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "在%objective%附近",
			Text = "[img]gfx/ui/events/event_68.png[/img]{你花费的时间太久，现在%objective%已经被摧毁了。绿皮使用震慑战术冲破了城墙，从飘来的血腥味不难发现城内所有人均已被屠杀。 | %companyname%没能及时解围，现在%objective%付出了代价。他们本以为你将会拯救他们，但你却让他们失望了。如果说有好消息的话，那就是没有人幸存下来诉说你的失败。然而你的雇主%employer%则是另一回事。这位贵族毫无疑问会对你的无为感到愤怒。 | %objective%已经被攻破！兽人驱动可怕的攻城器械抵达城墙，并摧毁了防御。凶残的绿皮涌入城镇，见人就杀，或是将人掳掠去了不知哪里。你的雇主%employer%对你的失败感到非常愤怒！ | 你没有及时解围%objective%！绿皮已经击破了正门，并且城镇已经被抹去。考虑到%employer%付你钱想要达到的目标正相反，可以肯定他对此感到不满。 | 由于你拖沓不干正事，%objective%已被绿皮攻陷！愿旧神怜悯城内居民，但不要期望你的雇主%employer%会对这个结果感到满意。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "%objective%陷落了。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "未能解除围城于" + this.Flags.get("ObjectiveName"));
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
	}

	function spawnSiege()
	{
		if (this.m.Flags.get("IsSiegeSpawned"))
		{
			return;
		}

		this.m.SituationID = this.m.Origin.addSituation(this.new("scripts/entity/world/settlements/situations/besieged_situation"));
		local originTile = this.m.Origin.getTile();
		local orcBase = this.World.getEntityByID(this.m.Flags.get("OrcBase"));
		local goblinBase = this.World.getEntityByID(this.m.Flags.get("GoblinBase"));
		local numSiegeEngines;

		if (this.m.DifficultyMult >= 1.15)
		{
			numSiegeEngines = this.Math.rand(1, 2);
		}
		else
		{
			numSiegeEngines = 1;
		}

		local numOtherEnemies;

		if (this.m.DifficultyMult >= 1.25)
		{
			numOtherEnemies = this.Math.rand(2, 3);
		}
		else if (this.m.DifficultyMult >= 0.95)
		{
			numOtherEnemies = 2;
		}
		else
		{
			numOtherEnemies = 1;
		}

		for( local i = 0; i < numSiegeEngines; i = ++i )
		{
			local tile;
			local tries = 0;

			while (tries++ < 500)
			{
				local x = this.Math.rand(originTile.SquareCoords.X - 2, originTile.SquareCoords.X + 2);
				local y = this.Math.rand(originTile.SquareCoords.Y - 2, originTile.SquareCoords.Y + 2);

				if (!this.World.isValidTileSquare(x, y))
				{
					continue;
				}

				tile = this.World.getTileSquare(x, y);

				if (tile.getDistanceTo(originTile) <= 1)
				{
					continue;
				}

				if (tile.Type == this.Const.World.TerrainType.Ocean)
				{
					continue;
				}

				if (tile.IsOccupied)
				{
					continue;
				}

				break;
			}

			local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).spawnEntity(tile, "Siege Engines", false, this.Const.World.Spawn.GreenskinHorde, this.Math.rand(100, 120) * this.getDifficultyMult() * this.getScaledDifficultyMult());
			this.m.UnitsSpawned.push(party.getID());
			party.setDescription("一大群绿皮和他们的攻城车。");
			local numSiegeUnits = this.Math.rand(3, 4);

			for( local j = 0; j < numSiegeUnits; j = ++j )
			{
				this.Const.World.Common.addTroop(party, {
					Type = this.Const.World.Spawn.Troops.GreenskinCatapult
				}, false);
			}

			party.updateStrength();
			party.getLoot().ArmorParts = this.Math.rand(0, 15);
			party.getLoot().Ammo = this.Math.rand(0, 10);
			party.addToInventory("supplies/strange_meat_item");
			party.getSprite("body").setBrush("figure_siege_01");
			party.getSprite("banner").setBrush(goblinBase != null ? goblinBase.getBanner() : "banner_goblins_01");
			party.getSprite("banner").Visible = false;
			party.getSprite("base").Visible = false;
			party.setAttackableByAI(false);
			party.getFlags().add("SiegeEngine");
			local c = party.getController();
			c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
			c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
			local wait = this.new("scripts/ai/world/orders/wait_order");
			wait.setTime(9000.0);
			c.addOrder(wait);
		}

		local targets = [];

		foreach( l in this.m.Origin.getAttachedLocations() )
		{
			if (l.isActive() && l.isUsable())
			{
				targets.push(l);
			}
		}

		if (targets.len() == 0)
		{
			foreach( l in this.m.Origin.getAttachedLocations() )
			{
				if (l.isUsable())
				{
					targets.push(l);
				}
			}
		}

		for( local i = 0; i < numOtherEnemies; i = ++i )
		{
			local tile;
			local tries = 0;

			while (tries++ < 500)
			{
				local x = this.Math.rand(originTile.SquareCoords.X - 4, originTile.SquareCoords.X + 4);
				local y = this.Math.rand(originTile.SquareCoords.Y - 4, originTile.SquareCoords.Y + 4);

				if (!this.World.isValidTileSquare(x, y))
				{
					continue;
				}

				tile = this.World.getTileSquare(x, y);

				if (tile.getDistanceTo(originTile) <= 1)
				{
					continue;
				}

				if (tile.Type == this.Const.World.TerrainType.Ocean)
				{
					continue;
				}

				break;
			}

			local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).spawnEntity(tile, "Greenskin Horde", false, this.Const.World.Spawn.GreenskinHorde, this.Math.rand(90, 110) * this.getDifficultyMult() * this.getScaledDifficultyMult());
			this.m.UnitsSpawned.push(party.getID());
			party.setDescription("一大群迈向战争的绿皮。");
			party.getLoot().ArmorParts = this.Math.rand(0, 15);
			party.getLoot().Ammo = this.Math.rand(0, 10);
			party.addToInventory("supplies/strange_meat_item");
			party.getSprite("banner").setBrush(orcBase != null ? orcBase.getBanner() : "banner_orcs_01");
			local c = party.getController();
			local raidTarget = targets[this.Math.rand(0, targets.len() - 1)].getTile();
			c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
			local raid = this.new("scripts/ai/world/orders/raid_order");
			raid.setTime(30.0);
			raid.setTargetTile(raidTarget);
			c.addOrder(raid);
			local destroy = this.new("scripts/ai/world/orders/destroy_order");
			destroy.setTime(60.0);
			destroy.setSafetyOverride(true);
			destroy.setTargetTile(originTile);
			destroy.setTargetID(this.m.Origin.getID());
			c.addOrder(destroy);
		}

		if (this.m.Troops != null && !this.m.Troops.isNull())
		{
			local c = this.m.Troops.getController();
			c.clearOrders();
			local intercept = this.new("scripts/ai/world/orders/intercept_order");
			intercept.setTarget(this.World.getEntityByID(this.m.UnitsSpawned[this.m.UnitsSpawned.len() - 1]));
			c.addOrder(intercept);
			local guard = this.new("scripts/ai/world/orders/guard_order");
			guard.setTarget(originTile);
			guard.setTime(120.0);
		}

		this.m.Origin.spawnFireAndSmoke();
		this.m.Origin.setLastSpawnTimeToNow();
		this.m.Flags.set("IsSiegeSpawned", true);
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"objective",
			this.m.Flags.get("ObjectiveName")
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			this.World.State.setCampingAllowed(true);
			this.World.State.setEscortedEntity(null);
			this.World.State.getPlayer().setVisible(true);
			this.World.Assets.setUseProvisions(true);

			if (!this.World.State.isPaused())
			{
				this.World.setSpeedMult(1.0);
			}

			this.World.State.m.LastWorldSpeedMult = 1.0;

			if (!this.m.Flags.get("IsSiegeSpawned"))
			{
				this.spawnSiege();
			}

			foreach( id in this.m.UnitsSpawned )
			{
				local e = this.World.getEntityByID(id);

				if (e != null && e.isAlive())
				{
					e.setAttackableByAI(true);

					if (e.getFlags().has("SiegeEngine"))
					{
						local c = e.getController();
						c.clearOrders();
						local wait = this.new("scripts/ai/world/orders/wait_order");
						wait.setTime(120.0);
						c.addOrder(wait);
					}
				}
			}

			if (this.m.Origin != null && !this.m.Origin.isNull())
			{
				this.m.Origin.getSprite("selection").Visible = false;
			}

			if (this.m.Home != null && !this.m.Home.isNull())
			{
				this.m.Home.getSprite("selection").Visible = false;
			}
		}

		if (this.m.Origin != null && !this.m.Origin.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Origin.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(2);
			}
		}
	}

	function onIsValid()
	{
		if (!this.World.FactionManager.isGreenskinInvasion())
		{
			return false;
		}

		local numAttachments = 0;

		foreach( l in this.m.Origin.getAttachedLocations() )
		{
			if (l.isActive() && l.isUsable())
			{
				numAttachments = ++numAttachments;
			}
		}

		if (numAttachments < 2)
		{
			return false;
		}

		return true;
	}

	function onSerialize( _out )
	{
		if (this.m.Troops != null && !this.m.Troops.isNull())
		{
			_out.writeU32(this.m.Troops.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local troops = _in.readU32();

		if (troops != 0)
		{
			this.m.Troops = this.WeakTableRef(this.World.getEntityByID(troops));
		}

		this.contract.onDeserialize(_in);
	}

});

