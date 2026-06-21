this.barbarian_king_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Threat = null,
		LastHelpTime = 0.0,
		IsPlayerAttacking = false,
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

		this.m.Type = "contract.barbarian_king";
		this.m.Name = "野蛮人国王";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 5.0;
		this.m.MakeAllSpawnsAttackableByAIOnceDiscovered = true;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 1700 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"追捕野蛮人国王和他的战团",
					"据最新报告，他位于%region%地区，在你的%direction%"
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
				local f = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians);
				local nearest_base = f.getNearestSettlement(this.World.State.getPlayer().getTile());
				local party = f.spawnEntity(nearest_base.getTile(), "Barbarian King", false, this.Const.World.Spawn.Barbarians, 125 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.setDescription("一个强大的野蛮部落的战斗部，由自称为野蛮人国王的人联合起来。");
				party.getSprite("body").setBrush("figure_wildman_04");
				party.setVisibilityMult(2.0);
				this.Contract.addUnitsToEntity(party, this.Const.World.Spawn.BarbarianKing, 100);
				this.Contract.m.Destination = this.WeakTableRef(party);
				party.getLoot().Money = this.Math.rand(150, 250);
				party.getLoot().ArmorParts = this.Math.rand(10, 30);
				party.getLoot().Medicine = this.Math.rand(3, 6);
				party.getLoot().Ammo = this.Math.rand(10, 30);
				party.addToInventory("supplies/roots_and_berries_item");
				party.addToInventory("supplies/dried_fruits_item");
				party.addToInventory("supplies/pickled_mushrooms_item");
				party.getSprite("banner").setBrush(nearest_base.getBanner());
				party.setAttackableByAI(false);
				local c = party.getController();
				local patrol = this.new("scripts/ai/world/orders/patrol_order");
				patrol.setWaitTime(20.0);
				c.addOrder(patrol);
				this.Contract.m.UnitsSpawned.push(party.getID());
				this.Contract.m.LastHelpTime = this.Time.getVirtualTimeF() + this.Math.rand(10, 40);
				this.Flags.set("HelpReceived", 0);
				local r = this.Math.rand(1, 100);

				if (r <= 15)
				{
					this.Flags.set("IsAGreaterThreat", true);
					c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
				}

				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.BulletpointsObjectives.clear();
				this.Contract.m.BulletpointsObjectives = [
					"追捕野蛮人国王和他的战团",
					"据最新报告，他的战团位于%direction%的%terrain%，在%region%地区，靠近%nearest_town%"
				];

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onCombatWithKing.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					this.Contract.setState("Return");
				}
				else if (!this.Contract.isPlayerNear(this.Contract.m.Destination, 600) && this.Flags.get("HelpReceived") < 4 && this.Time.getVirtualTimeF() >= this.Contract.m.LastHelpTime + 70.0)
				{
					this.Contract.m.LastHelpTime = this.Time.getVirtualTimeF() + this.Math.rand(0, 30);
					this.Contract.setScreen("Directions");
					this.World.Contracts.showActiveContract();
				}
				else if (!this.Contract.isPlayerNear(this.Contract.m.Destination, 600) && this.Flags.get("HelpReceived") == 4)
				{
					this.Contract.setScreen("GiveUp");
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatWithKing( _dest, _isPlayerAttacking = true )
			{
				this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;

				if (!_dest.isInCombat() && !this.Flags.get("IsKingEncountered"))
				{
					this.Flags.set("IsKingEncountered", true);

					if (this.Flags.get("IsAGreaterThreat"))
					{
						this.Contract.setScreen("AGreaterThreat1");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setScreen("Approach");
						this.World.Contracts.showActiveContract();
					}
				}
				else
				{
					this.Flags.set("IsAGreaterThreat", false);
					_dest.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(true);
					local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					properties.Music = this.Const.Music.BarbarianTracks;
					this.World.Contracts.startScriptedCombat(properties, this.Contract.m.IsPlayerAttacking, true, true);
				}
			}

		});
		this.m.States.push({
			ID = "Running_GreaterThreat",
			function start()
			{
				this.Contract.m.BulletpointsObjectives.clear();
				this.Contract.m.BulletpointsObjectives = [
					"和野蛮人国王一起旅行，共同面对更大的威胁"
				];

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.setFaction(2);
					this.World.State.setEscortedEntity(this.Contract.m.Destination);
				}
			}

			function update()
			{
				if (this.Flags.get("IsContractFailed"))
				{
					if (this.Contract.m.Threat != null && !this.Contract.m.Threat.isNull())
					{
						this.Contract.m.Threat.getController().clearOrders();
					}

					if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
					{
						this.Contract.m.Destination.getController().clearOrders();
						this.Contract.m.Destination.setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians).getID());
					}

					this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
					this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "战团撕毁了一份合同");
					this.World.Contracts.finishActiveContract(true);
					return;
				}

				if (this.Contract.m.Threat == null || this.Contract.m.Threat.isNull() || !this.Contract.m.Threat.isAlive())
				{
					this.Contract.setScreen("AGreaterThreat5");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					if (!this.Contract.m.IsEscortUpdated)
					{
						this.World.State.setEscortedEntity(this.Contract.m.Destination);
						this.Contract.m.IsEscortUpdated = true;
					}

					this.World.State.setCampingAllowed(false);
					this.World.State.getPlayer().setPos(this.Contract.m.Destination.getPos());
					this.World.State.getPlayer().setVisible(false);
					this.World.Assets.setUseProvisions(false);
					this.World.getCamera().moveTo(this.World.State.getPlayer());

					if (!this.World.State.isPaused())
					{
						this.World.setSpeedMult(this.Const.World.SpeedSettings.FastMult);
					}

					this.World.State.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.FastMult;
				}

				if (this.Contract.isPlayerAt(this.Contract.m.Threat))
				{
					this.Contract.setScreen("AGreaterThreat4");
					this.World.Contracts.showActiveContract();
				}
			}

			function end()
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
			}

			function onRetreatedFromCombat( _combatID )
			{
				this.Flags.set("IsContractFailed", true);
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
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("IsAGreaterThreat"))
					{
						this.Contract.setScreen("Success2");
					}
					else
					{
						this.Contract.setScreen("Success1");
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
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer%正用他的手指旋转着一个轻薄的王冠。它看上去由廉价金属打造，但毫无疑问是来自某处的王冠。随着锡在他的指甲上来回的摩擦，他上下打量着你。%SPEECH_ON%我猜我能预想到现状的到来。人们追寻权力，而那些野蛮人也不例外。%SPEECH_OFF%他让王冠滑落到他的指关节上，王冠无力地垂在那里。%SPEECH_ON%%direction%%region%地区的野蛮人正在一个所谓国王的手下联合起来。一个又强壮又难缠的蛮子，他威胁要组织一大群人，在那之后，好吧，我想他会想向南扩张他的领土。我需要你去这个地区，找到这个人，把他砍倒。%SPEECH_OFF% | %employer%的一个仆人把你带到一个花园，在那里你发现那个男人正在照料一株西红柿。他正在用山羊剪刀修剪它，并对自己的工作满意的点着头。他很随意的说道。%SPEECH_ON%我的斥候告诉我在一个北方蛮子正在%region%集结一支军队。一群白痴聚在一起对于这些原始人来说也算稀松平常，但我相信这个人正在宣称自己是国王。而国王们，好吧，他们希望成为更多东西的宗主，而非满足于他们已有的东西。他们想要别人拥有的东西，包括我的。%SPEECH_OFF%那人停下来向你点头。%SPEECH_ON%我要你去%region%地区，找到这个所谓的蛮子国王，然后杀了他。这不会很容易，但你会得到丰厚的报酬。%SPEECH_OFF% | %employer%与他的副官在一起。他们对你嗤之以鼻，但%employer%无视他们的判断并做出了自己的判断。%SPEECH_ON%啊，佣兵，我真觉得你们这类人正好就是我正在找的人。一个野蛮人在%region%地区宣称了自己是国王。他甚至戴着某种王冠，可能是用骨头和鹿角做的，但重要的是它的形状和意图。不仅对他很重要，对我们也很重要。我们不能让他活下去。我要你去找到这个原始人，在他集结的军队大到我这些副官们对付不了之前干掉他。%SPEECH_OFF% | %employer%用一杯麦酒欢迎你。他自己也在享受一杯红酒。%SPEECH_ON%我把你带到这里是因为在需要你去杀死%region%地区的一个原始人。他自称国王，呵呵，所有蛮子们的宗主。好吧，虽然我一点也不尊重他的王权，但我能明白我看到是萌芽中的威胁。我不能等着这个野蛮人把村子们联合起来并召集一支军队。我要你找到他然后杀了他。这不容易，但你会得到丰厚的报酬。%SPEECH_OFF%你现在在想他给你麦酒是不是就是为了让你动摇以接受这个荒谬的任务。 | %employer%拿着一对鹿角，鹿冠还连在下面。当他把它放在桌子上时，它笔直地立着，好像还连在原主人身上一样。%SPEECH_ON%有消息说一个蛮子正在%region%地区集结军队。他宣称自己是国王，如果他能在让那些原始人们加入他的旗下，那毫无疑问他将成为一个强大的王八蛋。这也意味着如果他不被摆平的话，我们很快就会深陷屎坑。%SPEECH_OFF%那人砸翻鹿角，它的尖端落地发出中空的响声。%SPEECH_ON%所以这就是你来这里的目的，佣兵。我需要你找到这个野蛮人，在他对自己都是什么的宗主有更多想法前把他干掉。%SPEECH_OFF% | %employer%坐在椅子上抿着嘴。他正摸弄着一把匕首，匕首的尖端和桌上一道凹痕对应。%SPEECH_ON%我派往%direction%的斥候不久前就开始失踪了。然后幸存者们陆续进来，讲述了一个野蛮人宣称自己是%region%的国王的故事。现在，我需要考虑一下，一个蛮子成为一大群原始人的统治者会有什么问题呢？%SPEECH_OFF%你告诉他你可以想象到这会让他夜不能寐。%employer%咧嘴笑道。%SPEECH_ON%是的，确实如此。所以我需要一个像你这样的人，一个魁梧，善良，文明的佣兵。我要你去找这个所谓的国王，在他让那些该死的白痴在他的旗帜下进军之前杀了他。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我们来谈谈多少克朗？ | 这可不是一件小事。 | 如果你能付出合适的价格。 | 像这样的工作最好有丰厚报酬。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{我们不打算去对抗一支军队。 | 这不是我们要找的那类工作。 | 我不会让战团去冒险对付这样的敌人。}",
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
			ID = "Directions",
			Title = "在途中…",
			Text = "{[img]gfx/ui/events/event_59.png[/img]一群难民经过战团。有传言说野蛮人国王在%direction%%distance%的位置。路上的许多人都来自%nearest_town%，他们似乎对等着蛮子的海洋淹过来不感兴趣。 | [img]gfx/ui/events/event_41.png[/img]一个商人驾驶者一辆空的货车与战队在路上相遇。尽管他没什么可兜售的，但他确实说道路上到处流传着一个蛮子自称国王的谣言。他说野蛮人在你所处位置的%direction%，在%region%附近。他点头对你的旅途致敬。%SPEECH_ON%如果你要走那条路，那就让那些原始人混球们得到他们的报应。%SPEECH_OFF% | [img]gfx/ui/events/event_94.png[/img]发现一个半裸的男人盘腿坐在路边。他说一个带着军队的原始人烧了他了农庄，侮辱了妇女，把所有带把儿的人都杀了。%SPEECH_ON%我躲在灌木丛里，双手捂着嘴活了下来。%SPEECH_OFF%那人擦了擦他的鼻子。%SPEECH_ON%我看到你们带着武器。如果你要找这个野蛮人，那我可以告诉你们，看上去他们朝%direction%去了，在%region%附近离这%distance%%terrain%。%SPEECH_OFF% | [img]gfx/ui/events/event_94.png[/img]你发现了一个小村庄被烧毁的遗迹。它的一些幸存者留下来，他们的外观就跟从他们烧毁的家里飘出来的烟差不多。一种说法是，一个作出国王姿态的人来了，在前往%direction%之前杀死了所有他们逮的到的人。 | [img]gfx/ui/events/event_60.png[/img]你遇到过很多翻了的马车或燃烧的货车。他们都被抢劫一空，所有的货物都不见了，只有主人们的尸体还在。有几个孩子正在其中一个在这样的废墟上捡东西。当你问他们是谁干的时，一个厚脸皮的男孩大声说。%SPEECH_ON%从北方来的蛮子们，但他们现在朝%direction%去了。我看见他们了。我敢打赌他们在%distance%的%terrain%。%SPEECH_OFF%他抠了抠他的鼻子。%SPEECH_ON%顺便说一句，他们是杀手。看上去跟你们是一类，但更大，可能也更强。%SPEECH_OFF% | [img]gfx/ui/events/event_76.png[/img]%employer%的一名斥候在路上遇见你。他报告说野蛮人国王被发现在%region%附近，在%direction%距离这里%distance%%terrain%。你问斥候愿不愿意和你一起战斗，那人笑了。%SPEECH_ON%不了，先生，我这样很好。我来回跑，侦查，然后报告。就像是我在两个妓女之间那样的奔波。这是一个美好的生活，我不需要为了你的佣兵工作毁了它！%SPEECH_OFF%很合理。 | [img]gfx/ui/events/event_132.png[/img]%randombrother%首先发现它们。有一场小规模冲突的痕迹，烧焦的尸体，淡化的脚印和货车的轨迹，很明显有一支军队经过了这里。%SPEECH_ON%看来他们在战斗结束后向%direction%前进了，团长。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们正在他屁股后面。",
					function getResult()
					{
						this.Flags.increment("HelpReceived", 1);
						this.Contract.getActiveState().start();
						this.World.Contracts.updateActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "GiveUp",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_45.png[/img]{现在已经毫无疑问了。由于你所遇到的种种痕迹，以及人们给你的各种消息，你终于确切地知道了野蛮人国王和他战团的具体去向。唯一剩下的就是直接面对他。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们应该加速前进。",
					function getResult()
					{
						this.Flags.increment("HelpReceived", 1);
						this.Contract.m.Destination.setVisibleInFogOfWar(true);
						this.World.getCamera().moveTo(this.Contract.m.Destination);
						this.Contract.getActiveState().start();
						this.World.Contracts.updateActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Approach",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_135.png[/img]{野蛮人国王带着他的战团来到战场，一群体型硕大的恶棍、咆哮的战士、窘迫的奴隶和嚎叫的女人。这是一支由一个人组织起来的军队，他从这片土地上收集了每一点资源，每一寸优势，并且毫无疑问最终会像雪球变成血崩那样，将文明收入囊中。你让手下们准备战斗。 | 野蛮人国王的战团在地面上移动着，没有丝毫训练的痕迹，甚至连队形都没有。但你知道，只要那个蛮子挥挥手，他就可以让一大群杀人狂扑向敌人，他们的杀戮欲望足以弥补任何协同方面的欠缺。你让手下们准备战斗。 | 野蛮人战团如疯狂的梦境显现，仿佛来自世界各地的冒险者从地平线涌出，他们没有制服或盔甲，而是用身上的装饰嘲讽那些被他们征服的失败者。战士胳膊上缠着婚纱绸缎，战奴身上裹着皇家颜料浸染的礼服，还有些人穿着骨头制成咔咔作响的护甲，像是他们掠劫后的剩饭。他们是恐怖的农夫，种植世界各地的村庄，收货四季不休的战争。\n\n你看着这一幕摇了摇头，让手下们准备战斗。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.Contract.getActiveState().onCombatWithKing(this.Contract.m.Destination, this.Contract.m.IsPlayerAttacking);
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
			Text = "[img]gfx/ui/events/event_145.png[/img]{野蛮人国王死了。虽然他自封了王室头衔，他还是和他的子民一样倒在地上。一个蛮子，一个原始人，有着稍微强健点的身体，以及一些来自交战、掠夺和破坏的装备，除此之外他没有什么特别之处。你用剑砍向他的脖子，用脚踩着他的脸将头从肩膀上卸下来。%randombrother%拿走沉重的头部并放入一个袋子。你命令手下们尽他们所能地搜刮战场，然后准备回去找 %employer%。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{%companyname%取得了胜利！ | 胜利！}",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.setState("Return");
			}

		});
		this.m.Screens.push({
			ID = "AGreaterThreat1",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_136.png[/img]{你找到了野蛮人国王，但对方要求阵前谈判。野蛮人国王和一位长者跨过原野亲自迎接你。尽管明知危险，你仍前去与之交涉。野蛮人国王说话，长老翻译。%SPEECH_ON%我们来这里不是为了征服，而是为了打败数量巨大的亡者。%SPEECH_OFF%你怀疑翻译有误，请他们解释。国王和长老继续道。%SPEECH_ON%死亡离开了这片土地，如果没有死亡，一个被杀的人将迷失在世界之间，并将再次爬起。一大群亡者，也就是亡灵，正在行军。我们不是为你或你的贵族而来。你若帮助我们消灭它们，我们就离开此地，不再搅扰你们的百姓。只针对这些亡者。%SPEECH_OFF%%randombrother%倾身低语。%SPEECH_ON%我们当然可以加入他们，但我们也可以现在就攻击他们。他们显然没有全力以赴，不管他们在这里说什么，事实是他们一直在蹂躏土地，因为他们是原始的蛮子。团长，强暴和掠夺正是他们的血液。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们会攻击他们为北方消灭这个所谓的王。",
					function getResult()
					{
						return "AGreaterThreat2";
					}

				},
				{
					Text = "我们会和他们一起向亡者进军。",
					function getResult()
					{
						return "AGreaterThreat3";
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "AGreaterThreat2",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_136.png[/img]{你朝长老点头吐口水。%SPEECH_ON%我们走过被烧的房子，被强奸的女人，和被杀的男人，只是为了找到你们这群可悲玩意，现在你想联合起来吗？我们不是盟友。我们不是朋友。告诉你所谓的‘国王’去向着你们的狗屁神明们祈祷去吧…%SPEECH_OFF%长老举起手来，用他们的母语与王说话。两个人点头，转身离开。%randombrother%笑着说道。%SPEECH_ON%简洁是轻蔑的灵魂，团长。%SPEECH_OFF%你叫那个人回到阵线中，为即将到来的战斗做准备。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "准备战斗。",
					function getResult()
					{
						this.Flags.set("IsAGreaterThreat", false);
						this.Contract.getActiveState().onCombatWithKing(this.Contract.m.Destination, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "AGreaterThreat3",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_136.png[/img]{你向长老点头。%SPEECH_ON%好吧，我们会和你们一起努力对付这个更大的威胁。%SPEECH_OFF%长老微笑着，双手的拇指搓在一起，用母语说了几段话。野蛮人国王用拳头猛击他的胸部，然后用拳头猛拍你的肩膀，之后用手划过天空。长老解释道。%SPEECH_ON%所以我们一起战斗，但如果我们倒下，他不会变成亡灵与你战斗。如果被杀，国王会自己去找到死神，把它的镰刀放在自己的脖子上。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "准备进军。",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				local playerTile = this.World.State.getPlayer().getTile();
				local nearest_undead = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getNearestSettlement(playerTile);
				local tile = this.Contract.getTileToSpawnLocation(playerTile, 9, 15);
				local party = this.World.FactionManager.getFaction(nearest_undead.getFaction()).spawnEntity(tile, "The Untoward", false, this.Const.World.Spawn.UndeadArmy, 260 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.getSprite("banner").setBrush(nearest_undead.getBanner());
				party.setDescription("一大群行尸，向活着的人索取曾经属于他们的东西。");
				party.setSlowerAtNight(false);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				this.Contract.m.UnitsSpawned.push(party);
				this.Contract.m.Threat = this.WeakTableRef(party);
				party.setAttackableByAI(false);
				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				local wait = this.new("scripts/ai/world/orders/wait_order");
				wait.setTime(99999);
				c.addOrder(wait);
				this.Contract.m.Destination.setFaction(2);
				this.Contract.m.Destination.getSprite("selection").Visible = false;
				this.Contract.m.Destination.setOnCombatWithPlayerCallback(null);
				c = this.Contract.m.Destination.getController();
				c.clearOrders();
				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(party.getTile());
				c.addOrder(move);
				this.Contract.setState("Running_GreaterThreat");
			}

		});
		this.m.Screens.push({
			ID = "AGreaterThreat4",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_73.png[/img]{这些蛮子并没有说谎：古代亡灵已经派出了一支军队。它是一支由腐败的面孔和生锈的盔甲所组成的战团，是一大群叹息着、呻吟的怪物，光落在它们身上立刻就会消失。这无疑是一支黑暗的军队。如果你或是野蛮人单独与之战斗，你肯定会输，但联合起来你们可能还有机会！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "准备战斗。",
					function getResult()
					{
						this.World.Contracts.showCombatDialog(false, true, true);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "AGreaterThreat5",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_136.png[/img]{古代死者最终被赶尽杀绝。当你的手下和原始人们在原野里翻捡时，野蛮人国王和长老来到你身边。这位大块头勇士点头咕哝，长老翻译。%SPEECH_ON%他说你做得很好，非常好，他希望像你还有你战队这样的人能和他并肩作战，但他明白这是不可能的。我们生活在一个由许多世界组成的迷宫里，在这个迷宫中我们都会停留，迷失，有时会听到彼此的喊叫，永远没有足够的时间去互相了解。他说谢谢，同时也祝你好运。%SPEECH_OFF%你问向长老，问他是不是从一个简单的咕噜声中听到了这些。长老微笑道。%SPEECH_ON%一个咕噜声，是的，还有一生的友谊。祝你好运，持剑之人。%SPEECH_OFF%长老递给你一顶角盔，就是你看到野蛮人国王自己有时戴的那顶。他什么也没说，只拍了拍胸口，指着天空，就这样。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "再会，国王。",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull() && this.Contract.m.Destination.isAlive())
				{
					this.Contract.m.Destination.die();
					this.Contract.m.Destination = null;
				}

				local item = this.new("scripts/items/helmets/barbarians/heavy_horned_plate_helmet");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%employer%拿过野蛮人国王的脑袋并将其从袋子里倒出来。它自由地翻滚，把一盘酒杯撞翻并四处散落，噼啪作响。即使是死了，这蛮子也是混乱的传播者。%SPEECH_ON%谢谢你，佣兵。%SPEECH_OFF%你的雇主说道，他一边点头一边把脑袋摆正，用脖子的断面稳住。%SPEECH_ON%他是个丑八怪，不是吗？看看这些牙齿。看看他们！这排牙齿中有个空洞。真恶心。%SPEECH_OFF%你告诉那个人付钱给你，他照着约定的做了。但他不停地摇头，露出自己的牙齿，模仿要挑牙齿缝。%SPEECH_ON%你怎么能那样刷牙？用绳子吗？%SPEECH_OFF%一边耸着肩，你朝门外走去，不想告诉%employer%你的人对那该死的头做的第一件事就是用刀把金子从他嘴里撬出来。 | 你把野蛮人国王的脑袋丢到了%employer%的桌子上。他盯着它，然后盯着你。%SPEECH_ON%那是我见过的最大的脑袋。%SPEECH_OFF%点着头，你要求你的报酬，然后报酬确实被以合适的数目支付了。你的雇主开始推着野人的脸转来转去，仿佛是一个想窃取它秘密的术士。%SPEECH_ON%我敢打赌这就是食人魔的故事的来源，不是吗？比如一个孩子看到这个丑陋的东西就在那里，他的想象力被点燃，于是怪物诞生了。%SPEECH_OFF%要是事情就是这么简单就好了。 | 即使没有它庞大的身体，野蛮人国王的头颅在被展示给%employer%时也引起了轰动。一大群贵族和仆人哦哦啊啊着惊叹着它的大小。一个穿黑袍的人很快将你应得的钱给了你。%employer%亲自将这头颅抬到空中，去感觉它的重量。%SPEECH_ON%旧神啊，它真的很重！哦%randomname%。%SPEECH_OFF%一个仆人迈步而来。你的雇主咧嘴一笑。%SPEECH_ON%给我拿杆长枪来，我们要把这个恐怖的脑袋举到天顶上去。%SPEECH_OFF%确实是个适合蛮子待的地方。 | 就在将野蛮人国王的脑袋交给%employer%后不久，它就被用作玩物。贵族的孩子们将其在石头地板上来回滚动，那个蛮子的脑袋撞倒了高脚杯组成的墙壁和餐盘组成的堡垒。一只狗在追着来回滚动的脑袋时不停吠叫。%employer%拍拍你的肩膀。%SPEECH_ON%出色的工作，佣兵，实打实的。我的斥候们告诉我，那是一场地狱般的战斗，你自己也几乎像个原始人。但我想这就是必须的代价，对吧？一个蛮子去和一个蛮子战斗？这种原始的精神没法被包容在我们的文明生活中！%SPEECH_OFF%其中一个孩子踢中了国王的脸，折断了他的下巴，上面的牙齿割伤了孩子。那孩子尖叫着求助，也许是为了保护主人，狗扑向了脑袋，开始用脖子把它甩来甩去。%employer%再次笑了。%SPEECH_ON%你的报酬在外面等着你。全部都在，正如约定。%SPEECH_OFF% | 一个身穿骑士盔甲的人从你身上拿走了野蛮人国王的脑袋。你立刻就拔出了剑，但是%employer%跳进来制止了将要开始的暴力。%SPEECH_ON%唔，佣兵，没事的。你的报酬，正如约定。%SPEECH_OFF%那人递给你一袋克朗，你却看见在他身后，有人把脑袋给了一个身穿黑斗篷的人。你点头问他们打算怎么处理它。%employer%咧嘴笑道。%SPEECH_ON%坦白地说，大杯啤酒在等我，佣兵，我很渴。%SPEECH_OFF%那人很快从你身边走过。你看不到任何啤酒，也看不到任何饮料，他只是跟着那个穿斗篷的人。 | %employer%盯着野蛮人国王的头，就像猫会卑鄙地盯着自己以外的东西那样。%SPEECH_ON%很有趣，我想我会把它填充一下然后放我的斗篷顶上。%SPEECH_OFF%你稍微有些不合时宜的提醒你的雇主，他指的是一个人头。%employer%耸了耸肩。%SPEECH_ON%所以？这是一个怪兽。文明与野蛮之间是不可能共存的。靠着适当的处理它，我能将这一现实记在心底。你会怎么做？再给我个建议？%SPEECH_OFF%抿着嘴，你索要你的报酬。那人指向角落。%SPEECH_ON%在那里的袋子里。你做的很好，佣兵，但不要再这样跟我说话了。再见。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "当之无愧。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "杀了一个自称的野蛮人国王");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				local money = this.Contract.m.Payment.getOnCompletion();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了[color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color]克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Success2",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%employer%不情愿地欢迎你。%SPEECH_ON%你明白我到处都有斥候和密探，不是吗？%SPEECH_OFF%你抬起你空着的双手，向他解释说你无意撒谎，但‘野蛮人国王’不会再打扰这片土地了。你的雇主敲了几下手指然后点头。%SPEECH_ON%你的诚实令人耳目一新，尽管我不得不说那人和他的战团还活着是很不幸的。尽管如此，所有的汇报都表明他们要离开了，所以我想你的工作还是一样完成了，不管有没有一个大号的异教徒脑袋。这是你的报酬，正如约定。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "当之无愧。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "解决了一个自称是野蛮人国王的威胁");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				local money = this.Contract.m.Payment.getOnCompletion();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了[color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color]克朗"
				});
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		if (this.m.Destination != null && !this.m.Destination.isNull() && this.m.Destination.isAlive())
		{
			local distance = this.World.State.getPlayer().getTile().getDistanceTo(this.m.Destination.getTile());
			distance = this.Const.Strings.Distance[this.Math.min(this.Const.Strings.Distance.len() - 1, distance / 30.0 * (this.Const.Strings.Distance.len() - 1))];
			local region = this.World.State.getRegion(this.m.Destination.getTile().Region);
			local settlements = this.World.EntityManager.getSettlements();
			local nearest;
			local nearest_dist = 9999;

			foreach( s in settlements )
			{
				local d = s.getTile().getDistanceTo(this.m.Destination.getTile());

				if (d < nearest_dist)
				{
					nearest = s;
					nearest_dist = d;
				}
			}

			_vars.push([
				"region",
				region.Name
			]);
			_vars.push([
				"nearest_town",
				nearest.getName()
			]);
			_vars.push([
				"distance",
				distance
			]);
			_vars.push([
				"direction",
				this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Destination.getTile())]
			]);
			_vars.push([
				"terrain",
				this.Const.Strings.Terrain[this.m.Destination.getTile().Type]
			]);
		}
		else
		{
			local nearest_base = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians).getNearestSettlement(this.World.State.getPlayer().getTile());
			local region = this.World.State.getRegion(nearest_base.getTile().Region);
			_vars.push([
				"region",
				region.Name
			]);
			_vars.push([
				"nearest_town",
				""
			]);
			_vars.push([
				"distance",
				""
			]);
			_vars.push([
				"direction",
				this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(region.Center)]
			]);
			_vars.push([
				"terrain",
				this.Const.Strings.Terrain[region.Type]
			]);
		}
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
			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		return true;
	}

	function onIsTileUsed( _tile )
	{
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

		if (this.m.Threat != null && !this.m.Threat.isNull())
		{
			_out.writeU32(this.m.Threat.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local obj = _in.readU32();

		if (obj != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(obj));
		}

		obj = _in.readU32();

		if (obj != 0)
		{
			this.m.Threat = this.WeakTableRef(this.World.getEntityByID(obj));
		}

		this.contract.onDeserialize(_in);
	}

});

