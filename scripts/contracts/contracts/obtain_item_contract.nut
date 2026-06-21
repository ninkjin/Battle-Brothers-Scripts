this.obtain_item_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		RiskItem = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.obtain_item";
		this.m.Name = "取得神器";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		local camp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getNearestSettlement(this.m.Home.getTile());
		this.m.Destination = this.WeakTableRef(camp);
		this.m.Flags.set("DestinationName", camp.getName());
		local items = [
			"格哈特爵士的指骨",
			"圣母血瓶",
			"创始人裹尸布",
			"长者石",
			"有远见的人",
			"太阳的印记",
			"星图光盘",
			"祖先的卷轴",
			"石化年鉴",
			"伊斯特万爵士外套",
			"丰收的人",
			"先知的小册子",
			"祖先的规则",
			"海豹王",
			"放荡者的长笛",
			"命运之骰子",
			"丰产神物"
		];
		this.m.Flags.set("ItemName", items[this.Math.rand(0, items.len() - 1)]);
		this.m.Payment.Pool = 500 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"在%location%获得%item%"
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
				this.Contract.m.Destination.clearTroops();
				this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.UndeadArmy, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.setLootScaleBasedOnResources(100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());

				if (this.Contract.getDifficultyMult() <= 1.15 && !this.Contract.m.Destination.getFlags().get("IsEventLocation"))
				{
					this.Contract.m.Destination.getLoot().clear();
				}

				this.Contract.m.Destination.setDiscovered(true);
				this.Contract.m.Destination.m.IsShowingDefenders = false;
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
				local r = this.Math.rand(1, 100);

				if (r <= 10)
				{
					this.Flags.set("IsRiskReward", true);
					local i = this.Math.rand(1, 6);
					local item;

					if (i == 1)
					{
						item = this.new("scripts/items/weapons/ancient/ancient_sword");
					}
					else if (i == 2)
					{
						item = this.new("scripts/items/weapons/ancient/bladed_pike");
					}
					else if (i == 3)
					{
						item = this.new("scripts/items/weapons/ancient/crypt_cleaver");
					}
					else if (i == 4)
					{
						item = this.new("scripts/items/weapons/ancient/khopesh");
					}
					else if (i == 5)
					{
						item = this.new("scripts/items/weapons/ancient/rhomphaia");
					}
					else if (i == 6)
					{
						item = this.new("scripts/items/weapons/ancient/warscythe");
					}

					this.Contract.m.RiskItem = item;
				}

				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"在%origin% %direction%的%location%获取%item%。"
				];

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.m.IsShowingDefenders = false;
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					if (this.Flags.get("IsRiskReward"))
					{
						this.Contract.setState("Return");
					}
					else
					{
						this.Contract.setScreen("LocationDestroyed");
						this.World.Contracts.showActiveContract();
					}
				}
				else if (this.TempFlags.get("GotTheItem"))
				{
					this.Contract.setState("Return");
				}
			}

			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;

				if (!this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);

					if (this.Flags.get("IsRiskReward"))
					{
						this.Contract.setScreen("RiskReward");
					}
					else
					{
						this.Contract.setScreen("SearchingTheLocation");
					}

					this.World.Contracts.showActiveContract();
				}
				else
				{
					local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					properties.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					properties.EnemyBanners.push(this.Contract.m.Destination.getBanner());
					this.World.Contracts.startScriptedCombat(properties, _isPlayerAttacking, true, true);
				}
			}

			function end()
			{
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull() && this.Contract.m.Destination.isAlive())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = false;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(null);
					this.Contract.m.Destination = null;
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
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("IsFailure"))
					{
						this.Contract.setScreen("Failure1");
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
			Text = "{[img]gfx/ui/events/event_43.png[/img]%employer% 欢迎你并带走向 %townname%的广场。 这里有一群农民漫无目的的乱转，但当他们看到你来了他们立马围上来并且开始说的好像他们一直在期盼你的到来。 他们都用标志成分来描述：和人一样高！ 你没有见过的盔甲！ 像小贩的舌头一样锋利的长矛！ 你举起手问他们在说什么。%employer% 笑了。%SPEECH_ON%这里的人们说他们在 %location% 在你现在位置的 %direction% 看见了一些怪事。 他们出来自然不是没有原因的。 他们在找叫 %item% 的东西，一个对镇子珍贵的用来祈求食物和住所的圣物。%SPEECH_OFF%一个农民说。%SPEECH_ON%他已经尽力找它了！%SPEECH_OFF%%employer% nods.%SPEECH_ON%当然。他们失败的地方，也许你们可以成功？ 为我拿回圣物，我会为你的服务付很多钱。 不用对他们的童话上心。 我确定没什么可担心的。%SPEECH_OFF% | [img]gfx/ui/events/event_62.png[/img]%employer% 欢迎你进入他的房间还给你倒了一杯水。 他羞羞的笑笑着把水杯给你。%SPEECH_ON%如果我有酒一定就给你倒酒了，但是你知道现在的日子怎么样。%SPEECH_OFF%他喝了一口然后清了清嗓子。%SPEECH_ON%当然，我不缺钱，不然我们也不会有这次对话，对吧？ 我需要你去 %location% 在你现在位置的 %direction% 然后取回叫 %item% 的圣物。很简单，不是吗？%SPEECH_OFF%你问这个圣物有什么好的。他解释道。%SPEECH_ON%镇民对它祈祷。 通过它，他们获得平静，祈雨，操羊，我不在乎。 他们相信它，它让他们有动力。 就凭这点它值得被拿回来。%SPEECH_OFF% | [img]gfx/ui/events/event_62.png[/img]你走进 %employer%的房间看到一个盯着地图的人。 他摇了摇头。%SPEECH_ON%看见这个地方了吗？ 那里是 %location%。%townname% 的人们过去常常礼拜叫 %item% 的圣物，但是镇民说它丢了，好吧，不管他们为什么认为它在那里。 我没可以雇佣的人，路上很危险并且我不会为失败付钱，但是你，佣兵，看起来可以胜任。 你能去那里然后为我们找到 %item% 吗？%SPEECH_OFF% | [img]gfx/ui/events/event_43.png[/img]你发现 %employer% 对着一群农民说话。 看到你，他让农民们都安静下来。%SPEECH_ON%嘘，你们静一下。 这个人能解决我们的问题。%SPEECH_OFF%他带你离开了这里。%SPEECH_ON%佣兵，我们有个麻烦。 我要找一个圣物，一个叫 %item% 的东西。我其实根本不在乎什么狗屁古神，但是这些人们膜拜它来祈雨和庇护。 当然是，它丢了。 不管出于什么原因，人们都认为它是自己跑到了一个叫 %location% 的地方。 没人会去那找他，但是你会去，对吧？ 只要价钱合适，当然。%SPEECH_OFF% | [img]gfx/ui/events/event_62.png[/img]你看到 %employer% 在和一个穿着斗篷比起人更像野兽的德鲁伊僧侣说话。 头盔带着角，盔甲带着熊皮，鹿蹄做的野兽项链在胸前哗啦哗啦的响。 他真是个了不起的人。 看到你，%employer% 向你招手。%SPEECH_ON%佣兵！很高兴见到你－%SPEECH_OFF%德鲁伊在谈话中把他推开。 他说话声音颤抖，好像是从洞穴深处说的。%SPEECH_ON%雇佣兵，哈！你一定是有信仰的人，不是吗？ 我们 %townname% 的人弄丢了 %item%。这个圣物对我们很重要，因为通过它我们能和古神交流并且让我们的祷告得到回复。 它被以某种方式被偷走到了 %location%。去那里把他取回来。%SPEECH_OFF%You glance at %employer% who nods.%SPEECH_ON%对，他说的没错。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{你来找我们是对的。 我们来谈谈报酬。 | 我们来谈谈价钱。 | 听起来很简单。 多少报酬？}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{不感兴趣。 | 我们有更重要的事情要做。 | 我相信你会找到其他人来做的。}",
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
			ID = "SearchingTheLocation",
			Title = "在%location%。",
			Text = "[img]gfx/ui/events/event_73.png[/img]{与其说你走进去，不如说是爬进这个遗迹，在这些石头上跛行像蝙蝠想直立行走一样。 下到最底，你发现几百个陶罐，老旧的战车，和装着生锈的矛和盾的金属水盆。%randombrother% 拿起一个火把把它的火光照在墙上。 伟大的壁画贯穿其中，伟大的艺术作品描绘了你从未听说过的战争。 你走的每一步似乎都会揭开另一个古老的胜利的面纱，直到最后，你来到一幅巨大的彩绘地图前。 在那里，你可以看到一个被帝国统治的大陆，它的腹部镀金，边界变黑。\n\n %randombrother% 走近，拿起 %item%。 你点头告诉他是时候走了。 当你们两个转身，一个一手拿矛一手拿盾的人站在那里。 另一个人加入了他，随后是另一个，他们的脚步带着恶意敲击着石头地面。 你对着雇佣兵们喊着逃跑，你们两个急忙逃出了遗迹，死亡的节拍跟在你的脚后。\n\n 逃到外面你转身下令让人们准备作战。 在第一个佣兵拔出剑之前，一大波装甲士兵涌出废墟，列阵，长矛对准你们。 他们的军官伸出一根腐烂的手指带着沉重的压在胸口的声音说。%SPEECH_ON%帝国复活了。伪王必须死。%SPEECH_OFF% | 进入遗迹的洞口只够一个人通过。 你担心如果所有人一起进入洞口他们万一卡住，你基本上就是像一群老鼠在狭窄的管道里一样毁灭了 %companyname%。 于是你只派了知道自己要找什么并且他相信如果发生了什么你会照顾好他的 %randombrother%。\n\n 几分钟你听到他努力在爬回来－听起来他很急。 他喊着请求帮助然后你和其他几个雇佣兵一起把手伸入了洞口。 他抓住你们的手然后你们一起把他拖出来了。 他拿到了 %item%，但是他脸上看起来很惊恐。 他急忙翻身站起来。%SPEECH_ON%快！拿起武器！%SPEECH_OFF%当雇佣兵们朝着洞里看是不是有东西要出来，你问那个兄弟他看见什么了。他摇了摇头。%SPEECH_ON%我不知道，先生。 那是一个我从来没见过的陵墓。 那里满地都是盔甲和长矛，还有个横跨全世界的帝国的壁画！ 地板延伸到屋顶！ 还有…然后他们从墙里出来了。 我从那里尽快逃了出来然后…%SPEECH_OFF%在他说完之前，洞口在的那摊碎石堆动了起来。 石头滚动然后突然全向外炸了出来，一个怀有恶意军队站在那里—全副武装的人列起阵型，盾在前，矛在上，迈着统一的脚步向前前进。 他们的领袖直指着你。%SPEECH_ON%帝国复活了。伪王必须死。%SPEECH_OFF%你从未听过如此坚定的战吼然后你马上让你的人准备作战。 | 你和 %randombrother% 冒险进入遗迹。 很容易就找到了 %item%，或者说非常容易，但是同时有其他东西吸引了你的注意力。 地板上到处都是罐子。 每一个罐子都放满了长矛，而在墙上挂盾牌的钩子太古老和腐朽用来挂蜘蛛网都费劲，更别说一块金属了。 突然，%randombrother% 抓住你的胳膊。%SPEECH_ON%先生。麻烦来了。%SPEECH_OFF%他指向大厅，你看到一个人站在那里，他步伐灵活，好像他习惯了他的装甲。 突然，他抬起头盯着你。 尽管他现在的位置离你很远，他的声音听起来就在你身边。%SPEECH_ON%伪王也敢侵入这里？ 帝国会再次雄起，但首先你必须死。%SPEECH_OFF%这些毫无疑问是挑衅字眼，你抓着佣兵赶紧溜了。 你们跑出来不远，佣兵们就不用你下令下拿起了武器，因为：随后而来的就是一群一群你从未见过的穿着装甲的士兵方阵。 他们组起龟甲阵向前前进，他们的盾牌紧紧贴近来为整个小队提供保护。 根据遗迹里的那个人，他们毫无意义是来杀掉你和整个战队的！ | 你进入了废墟很容易找到了 %item%。 当你转身，一个穿着生锈的盔甲的人站在那里，手里拿着长矛，用没有眼球的眼眶看着你。 他挥起长矛。%SPEECH_ON%The False King must die.%SPEECH_OFF%长矛向你刺来。%randombrother% 跳过来然后把它打到地上，矛头撞到地板上的火花发出噼啪声。 你看着那个亡灵人，一条虫子从他的鼻子穿过。他又开始说话。%SPEECH_ON%伪王必须…%SPEECH_OFF%你立刻把剑把出鞘砍掉了这个古代死者的头。 这个头颅和头盔噼里啪啦的滚在地上。 你还没来得及仔细看，%randombrother% 抓着你告诉你快跑：更多亡灵从墙里出来了，抖动晃开了陵墓的大理石棺材板。\n\n 一跑出来，你就下令战队的其他人组成阵型。 | 你派了几个人进入遗迹找 %item%。他们很快就都跑回来了，这很不寻常因为他们特别喜欢偷懒混日子然后赚着工钱。 感谢老天，他们其中一个人的手里那个圣物。 不幸的是，他们看起来好像看到幽灵了。 不用他们解释为什么看起来那么害怕，因为一群迈着轻巧步伐的，盔甲叮当作声的亡灵从遗迹出现，并且拿着长矛对着你的战队。 | 到了遗迹，你觉得应该会有一些土匪在这闲逛。 但是实际上没有，取回 %item% 不能更轻松了。 至少，在一群装甲亡灵出现之前，你是这么想的，他们大喊着“伪王”，并要求把你的头放在盘子上。拿起武器！ | 找到并打包 %item% 比预期的要容易。 发现一群亡灵人头顶重型，身披乡村盔甲，挥舞长矛，他们的军事队形甚至比王国里薪水最高的军队都要严苛…没料到。拿起武器！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.TempFlags.set("GotTheItem", true);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination, false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "LocationDestroyed",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_46.png[/img]{战斗结束了，%item% 也拿到了，你告诉伙计们准备回去找 %employer%。你不确定是谁或者什么刚才攻击的你，但是现在是时候领报酬了。 | 随着战斗结束，你看了看攻击你的人。 他们穿着的盔甲你认不出来。%randombrother% 试图撬开其中之一的尸体的头盔但是没有用。 他不敢相信的看着尸体。%SPEECH_ON%它好像卡在那里了，或者它是他的一部分。%SPEECH_OFF%你让伙计们整理好装备准备回去找 %employer%。不管那些人是谁，你是来这里拿 %item% 的，而这东西已经拿到了，所以现在是时候回去领报酬了。 | 你已经拿到 %item%，但是代价是碰到这样一群从未见过的恶魔。它们穿着盔甲，看上去死了，然而又在紧密的阵型的行动。%randombrother% 拿起 %item% 然后问到下一步怎么办。 你告诉兄弟们是时候回去找 %employer%。 | 你看了一眼 %item% 和为了它攻击你的人。 或者，至少你认为他们是为了它攻击你们。 敌人的军官好像说了些什么，但是你记不起来说的是什么了。 啊好吧，是时候回去找 %employer% 领报酬了。 | 你不完全确定刚才你遇到了什么。%randombrother% 问你知不知道他们刚才说的什么。%SPEECH_ON%好像他们刚才特地指着你，先生。%SPEECH_OFF%点了点头，你告诉伙计们你也不确定穿着盔甲的人说的什么，但是那不重要。 你已经拿到 %item% 了是时候回到 %employer% 那里领报酬了。 | %item% 已经到手，但是代价呢？ 奇怪的人，如果你这么称呼他们，攻击了战队还专门的指着你，好像你犯了穿越时空的罪。 噢好吧，你不是会细想这种事的人。 你来这里是为了圣物的，而你已经拿到了，为了一个好的发薪日，回去交给等着你的 %employer%。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们回去吧。",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "RiskReward",
			Title = "在%location%。",
			Text = "[img]gfx/ui/events/event_57.png[/img]{你进入了 %location% 好好看了周围。 不一会 %randombrother% 指着 %item%，圣物就在一个满是苔藓和蜘蛛网的台子上放着。 它还指着屋子里另一个东西：一个很好看的 %risk% 装饰着一个大雕塑的身体。\n\n剩下的地方都是荒废的并且看上去马上就要坍塌在你头上。 %risk% 为什么会在这绝对是一个问题。 | %item% 非常容易就找到了，但屋里的其他东西吸引了你的注意力。 放在巨大雕像旁边的是一个看起来非常奇怪的 %risk%。当然，这回避了一个问题，它到底在外面干什么？ 虽然你认为这是平淡的一天，你应该去抓住它，某些事情告诉你，这可能不是最明智的决定。 | 你找到了 %item%。这比你想象的要容易得多。 但这里也有别的东西。 你发现了一个发光的 %risk% 装饰着一个没有脸的高大男人的雕像。 你不清楚一个雕塑和这种东西在一起干什么，但是它就是在那。 而且看上去一直都在那，这引起你的疑问，这东西到底为什么会在这里？ | %item% 很容易就被找到了，但当你准备去拿镇民们的圣物时突然看见一个闪光的 %risk% 装饰着一个高大且不祥的男人雕像。 你的第一想法是派人直接去拿他，但是然后你不禁想问这东西在这里是怎么回事。} 也许 %companyname% 应该做他们来这里该做的任务？",
			Image = "",
			List = [],
			Options = [
				{
					Text = "那就拿走 %item%。",
					function getResult()
					{
						return "TakeJustItem";
					}

				},
				{
					Text = "趁我们还在这里还是拿走 %risk% 吧。",
					function getResult()
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "TakeRiskItemBad";
						}
						else
						{
							return "TakeRiskItemGood";
						}
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "TakeJustItem",
			Title = "在%location%。",
			Text = "[img]gfx/ui/events/event_57.png[/img]%employer% 要求你拿到 %item% 并且这就是你要去做的事。 {%randombrother% 同意这个方法。%SPEECH_ON%我觉得把 %risk% 留在那挺好的。 我没见过这么明显的陷阱。%SPEECH_OFF% | 摇了摇他的头，%randombrother% 嘲笑你的犹豫不决。%SPEECH_ON%你不会怕了那个大雕塑吧，哏？ 我以为你有更大的胆子，先生。%SPEECH_OFF% | 你拿到圣物后，%randombrother% 手肘顶着墙嘲笑你。%SPEECH_ON%不会有人害怕一个大雕塑吧，哏？ 来吧，我来拿。 我们能拿完他然后两秒钟就就出去了！%SPEECH_OFF%你亲切的提醒了雇佣兵们谁是统领免得他继续“开玩笑”。 | 圣物已经在你手中，%randombrother% 简单的点了个头。%SPEECH_ON%你做得对，先生。要我说我们应该把 %risk% 留在那里。 在那里发光的小玩意除了麻烦什么都不是。 去拿它就像一个傻子在大海里追一个美女！%SPEECH_OFF% | %randombrother% 瞪着 %risk% 然后吐了口唾沫，清了清嗓子然后用手摸了摸他没刮胡子的脸。%SPEECH_ON%对。我们还是把它留在那吧。 如果我在森林里找到一摞黄金，我觉得我会考虑再三要不要去拿它。在这里也是一回事。%SPEECH_OFF% | %randombrother% 同意你的决定。%SPEECH_ON%对，把 %risk% 留在那吧。 在这个世界上没有什么是免费的，没有什么。 当然没有那种光彩。不，先生。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "真简单。",
					function getResult()
					{
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
			ID = "TakeRiskItemGood",
			Title = "在%location%。",
			Text = "[img]gfx/ui/events/event_57.png[/img]{%item% 拿在手里，你觉得也该拿走 %risk%。%randombrother% 去拿起了它，小心的拿出这个雕像的一部分。 一把这块金属蠕动的拿出来，他就停下来了准备被这个雕像突然复活痛打。 但是其实什么都没发生。他紧张的笑了。%SPEECH_ON%易如反掌！%SPEECH_OFF%随着手下们松了一口气，你告诉他们准备好回去找 %employer%。 | 当你拿起 %item%，你看了一眼 %risk% 然后想为什么不给它也拿了。 你爬上雕塑然后盯着已经被别人取走的脸。 不管这个雕像是谁，他们雕刻出了脸颊和可以挂衣服的下巴。 没有看其他的特点，你拿起 %risk%，等待发生点什么。 什么也没发生。%randombrother% 笑了。%SPEECH_ON%你是要跟雕像招呼“欢迎”吗？%SPEECH_OFF%你拍一下雕像的头然后爬下来。 战队现在应该回去找 %employer% 了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "真简单。",
					function getResult()
					{
						this.Contract.m.RiskItem = null;
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				this.World.Assets.getStash().add(this.Contract.m.RiskItem);
				this.List.push({
					id = 10,
					icon = "ui/items/" + this.Contract.m.RiskItem.getIcon(),
					text = "你获得了" + this.Contract.m.RiskItem.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "TakeRiskItemBad",
			Title = "在%location%。",
			Text = "[img]gfx/ui/events/event_73.png[/img]{你派 %randombrother% 上雕像取 %risk%。当他爬上去，你发现 %employer% 丢的小玩意就在台子上。 伸出你的手，希望能拿住它，但是它直接向上飞出，想尘土一样穿过你的手指。 粉末留在你的胳膊上，像烟雾做的蛇。 你跳开然后烟雾射向雕塑，射入了雕像的眼睛然后眼睛变红了。 石头开始动了。 佣兵跳开。 周围不断有身影从墙里出现，雕像裂开给了很多外貌古怪的穿着装甲手里拿着长矛的人生命。\n\n 你命令所有人准备作战！ | 你无法拒绝一个像 %risk% 的东西。你爬上雕像的脸然后伸手够它，但是你的手指刚碰到那块金属雕像就开始摇晃了。%randombrother% 对着你喊让你转身。 它指着正在你眼前慢慢溶解的 %item%！ 它变成了粉末，你只能看着它变成一缕烟，那一缕烟像有了生命，在屋里绕圈，穿过你的脸然后飞到雕像的鼻子前。 它的眼睛变红然后你立马跳开。 一个佣兵走到你身边，他的武器已经拿出来了。%SPEECH_ON%先生，先生！看！%SPEECH_OFF%不断有身影从墙里出现！ 像挂在老人手指上的线偶一样蹒跚前行的雕像。 慢慢的每一个都褪去它的石头外壳然后出现了长相奇怪穿着装甲挥舞着长矛的人。 你马上命令你的人进入战斗队形因为不管你刚才复活的东西是什么肯定都不友好！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "集合！",
					function getResult()
					{
						this.Contract.m.RiskItem = null;
						this.Flags.set("IsFailure", true);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination, false);
						return 0;
					}

				}
			],
			function start()
			{
				this.World.Assets.getStash().add(this.Contract.m.RiskItem);
				this.List.push({
					id = 10,
					icon = "ui/items/" + this.Contract.m.RiskItem.getIcon(),
					text = "你获得了" + this.Contract.m.RiskItem.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{%employer% 在小镇广场上见了你。 你把 %item% 交给了他然后他像抱着他丢的婴儿一样抱着它。 抱着圣物的尴尬时刻过后，它把他举起，让小镇人民看到它。 他们欢呼了一阵。很长时间，真的。 你得用手肘碰碰 %employer% 提醒他该付钱了。 | 你找到 %employer% 的时候他在清理猪圈。 他在到处踢母猪，虽然它们更关心被喂着而不是屁股后面有双皮鞋在踢他们的屁股。 你大声的清了清嗓子。%employer% 突然转身然后他的眼睛看到圣物马上变大了。 他跳过一只猪然后拿起 %item%。他对着聚集过来并且感谢上帝仁慈的镇民们大喊。 没有人感谢你，自然的。 你得提醒 %employer% 他还欠着你钱。 付完钱后你马上就走了。 | 你找到 %employer% 得时候他正坐在小镇广场，他的胳膊伸向空中，眼睛闭着，嘴里念着祈祷文。 镇民们在他身边跪着做着同样的事。 你捡起一块石头扔向风向标，叮当声和生锈得旋转声吸引了所有人得注意力。\n\n你高高举起圣物以便所有人都能看见。%employer% 跳起来然后拿起 %item%。人们高兴得咆哮着，说着即将发生得好事。 你的报酬给了你，对你来说这才是一件“好事”。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "镇民;现在看来精神很好。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "获得了" + this.Flags.get("ItemName"));
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isUndeadScourge())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnCommonContract);
						}

						return 0;
					}

				}
			],
			function start()
			{
				local reward = this.Contract.m.Payment.getOnCompletion();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + reward + "[/color] 克朗"
				});
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/high_spirits_situation"), 3, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_43.png[/img]{%townname% 的镇民急切的等着你的回归。 很遗憾，你没有他们急需的圣物。%employer% 看到你像门外汉一样的失败，他在小镇入口见了你悄悄话小声对你说。%SPEECH_ON%我觉得你没有 %item%。%SPEECH_OFF%你想解释发生了什么，但是他好像不想听。%SPEECH_ON%这不重要，雇佣兵。 我显然不会付你钱，并且镇民不会听你的缺点以免让他们发疯。 他们靠着崇拜物在这个世界上找到平静。 我会自己想出办法的，希望它有效。日安。%SPEECH_OFF% | %employer% 在一群鹅旁边见了你。 他在用手喂鹅，碰巧，一个小男儿路过捡起一只鸟拿去宰杀。 那个男人对你笑的很温暖，但是他的兴奋很快就消失了。%SPEECH_ON%我没看见圣物。 我觉得你没有拿回来是对的吗？%SPEECH_OFF%简单的点头是你仅能给的答案。 他张开胳膊，看起来很疑惑。%SPEECH_ON%那你还回来干什么？ 镇民们认识你。 他们知道你去找它了。 你应该趁他们发现你没有他们的圣物前快走。%SPEECH_OFF% | 你空着手回到了 %employer% 那里。他把你拉到一边悄悄说。pers.%SPEECH_ON%那你还回来干什么？ 你不知道对这些镇民来说圣物对他们多重要吗？ 不能对它祈祷，他们会没有信仰的。 人们需要强烈的信仰安放在某处。 如果他找不到它，他就只能找到他自己。 就像一个丑陋的人只能对着镜子看自己，我们不用急就能看到因为没有圣物变得愤怒和迷茫的人们。 离开吧，佣兵，在人们还没有看到你没有带着 %item% 回来之前，。%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "噢，好吧…",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "没有获得 " + this.Flags.get("ItemName"));
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
			"location",
			this.m.Flags.get("DestinationName")
		]);
		_vars.push([
			"direction",
			this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isAlive() ? "" : this.Const.Strings.Direction8[this.m.Home.getTile().getDirection8To(this.m.Destination.getTile())]
		]);
		_vars.push([
			"item",
			this.m.Flags.get("ItemName")
		]);
		_vars.push([
			"risk",
			this.m.RiskItem != null ? this.m.RiskItem.getName() : ""
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull() && this.m.Destination.isAlive())
			{
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (this.m.IsStarted)
		{
			if (this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isAlive())
			{
				return false;
			}

			return true;
		}
		else
		{
			return true;
		}
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

		if (this.m.RiskItem != null)
		{
			_out.writeBool(true);
			_out.writeI32(this.m.RiskItem.ClassNameHash);
			this.m.RiskItem.onSerialize(_out);
		}
		else
		{
			_out.writeBool(false);
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

		local hasItem = _in.readBool();

		if (hasItem)
		{
			this.m.RiskItem = this.new(this.IO.scriptFilenameByHash(_in.readI32()));
			this.m.RiskItem.onDeserialize(_in);
		}

		this.contract.onDeserialize(_in);
	}

});

