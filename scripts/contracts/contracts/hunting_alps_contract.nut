this.hunting_alps_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		SpawnAtTime = 0.0,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.hunting_alps";
		this.m.Name = "结束恶梦";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 600 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		local names = [
			"梦魔",
			"窃梦者",
			"窃魂者",
			"夜行者",
			"恶梦魔",
			"扑人鬼",
			"夜魔",
			"夜伏者"
		];
		this.m.Flags.set("enemyName", names[this.Math.rand(0, names.len() - 1)]);
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"结束在晚上困扰" + this.Contract.m.Home.getName() + "的恶梦"
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
					this.Flags.set("IsGoodNightsSleep", true);
				}

				this.Contract.m.Home.setLastSpawnTimeToNow();
				this.Flags.set("StartTime", this.Time.getVirtualTimeF());
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
			}

			function update()
			{
				if (this.World.getTime().IsDaytime)
				{
					this.Contract.m.SpawnAtTime = 0.0;
				}
				else if (this.Contract.m.SpawnAtTime == 0.0 && !this.World.getTime().IsDaytime)
				{
					this.Contract.m.SpawnAtTime = this.Time.getVirtualTimeF() + this.Math.rand(8, 18);
				}

				if (this.Flags.get("IsVictory"))
				{
					this.Contract.setScreen("Victory");
					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
				else if (this.Contract.m.Target == null && !this.World.getTime().IsDaytime && this.Contract.isPlayerNear(this.Contract.m.Home, 600) && this.Contract.m.SpawnAtTime > 0.0 && this.Time.getVirtualTimeF() >= this.Contract.m.SpawnAtTime)
				{
					this.Flags.set("IsEncounterShown", true);
					this.Contract.setScreen("Encounter");
					this.World.Contracts.showActiveContract();
				}
				else if (!this.Flags.get("IsBanterShown") && this.World.getTime().IsDaytime && (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || this.Contract.m.Target.isHiddenToPlayer()) && this.Contract.isPlayerNear(this.Contract.m.Home, 600) && this.Time.getVirtualTimeF() - this.Flags.get("StartTime") >= 6.0 && this.Math.rand(1, 1000) <= 5)
				{
					this.Flags.set("IsBanterShown", true);
					this.Contract.setScreen("Banter");
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "Alps")
				{
					this.Flags.set("IsVictory", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "Alps")
				{
					this.Contract.m.SpawnAtTime = -1.0;
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
			Text = "[img]gfx/ui/events/event_79.png[/img]{%employer% 见到你的时候手里拿着一个枕头。 他边上的一个人触碰了一下上面的亚麻后闻了闻。 他闻了它三遍然后摇了摇头又闻了一遍。%employer% 招手唤你进去。%SPEECH_ON%这片地方的一个平民报告说一个奇怪的灵体入侵着他的睡梦。 他交出了他的晚间用品作为证据，但我们不知道该怎么做。%SPEECH_OFF%你看着那个又把鼻子埋在亚麻枕头里的怪人。 扬起一边眉毛，你说你可以自己调查这件事情。%employer% 点头。%SPEECH_ON%这就是我很高兴你在这里的原因。 我希望你在附近呆一两个晚上看看夜晚有没有什么吓人玩意冒出来。 我相信没什么，但不管出现什么我都会付你报酬的。 怎么样，有兴趣吗？%SPEECH_OFF%那个怪人几乎抓着枕头并张口大吸好像要憋死自己似的。 他问他能不能拿走这个枕头。 | %employer% 把你带到他的办公桌旁，上面散落着几幅画。%SPEECH_ON%我不常把我的笔和纸拿给乡亲们，但是好几个家庭提出要画他们见到的东西。%SPEECH_OFF%你看了看。每一张都不一样，大部分都是些看起来乱七八糟的细长身形。 其中一副更有艺术天分的画描述着一只奇怪的野兽蹲在人边紧紧抱着他们的头好像要偷走它似的。他继续道。%SPEECH_ON%对我而言看起来像是些寻常噩梦，但是调查了他们的住所，看起来都被人动过，好像什么东西在他们睡觉时偷偷摸摸的溜进去过。 我想要你呆在这附近，佣兵，看看来的是什么东西。 可能只是些流氓小偷什么的，但是值得看看。有兴趣吗？%SPEECH_OFF% | 你发现 %employer% 听着一个农民讲故事，但是看到你来了，他便让他跟你复述一遍。 他解释道他和其他的许多家庭最近总在做噩梦。 不仅如此，宠物都不见了而且有报告说孩子被偷走并且不得不在深夜步行回家。%employer% 点头。%SPEECH_ON%整个镇子都因此疑神疑鬼的，佣兵。 我听说过 %enemy% 的故事，食尸鬼般的白痴在一个人的梦中大吃一惊，但我敢肯定，这只是一些该死的孩子在做坏事。 不论如何，一个钱包被集起来而且我准备交出来换取些更正规的保护。有兴趣吗？%SPEECH_OFF% | %employer% 坐在他的办公桌旁。他沉重的叹了口气。%SPEECH_ON%贱民们不停跟我说着些 %enemy% 这个，%enemy% 那个的。 这段时间就像我肩上扛了座粪山，或者说一个山脉的屎！%SPEECH_OFF%他找了个椅子坐下并给他自己倒了杯啤酒。 他很快就喝了下去。%SPEECH_ON%这个说什么食梦者，那个说什么夜潜者，呸！一派胡言。 但是好吧，那群蠢货募集了一箱硬币并且愿意拿来换取一些保护。 我希望你在附近呆一两个晚上看看这些所谓灵体是真的还是我们遇到了些耍诡计的小鬼。有兴趣吗？%SPEECH_OFF% | %employer% 抱着头左右摇摆。 你问他你是不是该换个时候来。 他一拳打到桌子上。%SPEECH_ON%不！现在是最好的时机。 城里的人们连着几天都在抱怨奇怪的梦。 而且昨晚一个噩梦也到了我头上。 我甚至无法理解它。 我站在一片麦田里并看到阴影在麦穗间穿梭。 但它们不只是阴影，它们移动中压平着麦子并且…好吧，当我醒来我看到什么东西的腿，它正好跑出我门口。 我…我是说我们想要你呆一晚上并看看那东西会不会也找上你。有兴趣吗？%SPEECH_OFF% | 你发现 %employer% 时他正翻着一本古典。 灰尘随着每一次翻页飞扬。 他没有抬头就这么说道。%SPEECH_ON%城里的人们集资了一波钱来让你呆一晚上。%SPEECH_OFF%笑着，你问包不包伙食。 他慢慢的合上书。 他平静的看着你好像你什么都没说过一样。%SPEECH_ON%人们害怕着一种奇特的怪物，它们以梦为食。 我以为只是些常见的疑神疑鬼，但它们昨晚找上了我而我的目光深入了他的眼睛。 我醒来发现自己在阁楼向达库尔祈祷。 达库尔是什么鬼？ 天啊我不知道在发生什么，但我非常希望你能接受这个任务。 呆一两个晚上并看看我们所恐惧的是否远超谣言。%SPEECH_OFF% | %employer% 正在指间玩着一个小木制饰品。 它形似一个长角的人。 他把它丢在桌上并对他点头。%SPEECH_ON%木匠做的那个。说它在晚上去见了他。 我说什么时候。他说在他的梦里，而且在他醒来时它就站在床边。 然后，今天，三家人全部来见我跟我说他们见了同样的东西而且他们的狗都不见了。 找不到。单纯就是不见了。 我不知道这不洁的地方都酝酿着什么，佣兵，但我不想在身边没有点钢铁的情况下再过一个晚上。 你有兴趣保护 %townname% 一两个晚上吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{你能拿出多少克朗？ | 我们来谈谈酬劳。 | 我们来谈谈克朗。 | 我们可以调查一下。 只要价钱合适。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这听起来不像是雇佣兵的工作。 | 这听起来不像是适合我们的工作。 | 这不是我们要找的那类工作。}",
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
			ID = "Banter",
			Title = "临近 %townname%…",
			Text = "[img]gfx/ui/events/event_79.png[/img]{路过时，一位老人从小路拐过来。他主动表示，如果你正在寻找白人，最好等到晚上。%randombrother%问他什么是白人。老人笑了。%SPEECH_ON%说实话，它们既不是白色也不是人类，但是我不知道怎样把它们放在这个世界。我们的长辈称它们为%enemy%，是放入你脑子里邪恶念头和幻想的怪兽，然后以种植恐惧为食物。但你们是一个强壮的团体，你们会做得很好的。%SPEECH_OFF%他甩了甩鼻子祝你好运。 | 当你在检查您的地图和了解情况时，%randombrother%带来了一位老年妇女。她看起来像一颗古老的橡树，用颤抖的手招呼着你。你倾听她的话。%SPEECH_ON%他们夜里来。他们和他们的画面一起来。%SPEECH_OFF%她举起一根手指。%SPEECH_ON%只有在夜里才有！他们以腐蚀为生。不是土地的腐蚀，而是你的思想。我的母亲称他们为%enemy%，是幻觉的创造者和非现实的存在。当你找到他们时，你会听到自己理智溜走的嘶嘶声。要牢牢掌握它，你会活下来的。%SPEECH_OFF% | %randombrother% 走到你身边，说他以前听过这些野兽。%SPEECH_ON%关于那些蹲在你窗台上盯着你睡觉的怪兽的古老传说，或者它们爬上你的床头，剥开你的梦境，并且窥视其中。有人说那些传说都不是真的，它们可以在你清醒时给你灌输幻象，让你看到并不存在的事物。%SPEECH_OFF% | %randombrother%皱着眉头走向你。他解释说，很久以前他认识一个因为谋杀而被绞死的人。他砍碎了自己的孩子，但被告声称他只是在屠杀鸡。他看到了鸡和它们的羽毛，说除了禽兽下流之外什么都没有。当他醒来后看到了那种暴行，发现那个野兽在窗台上笑了起来，发出扭曲的尖叫。雇佣兵点点头。%SPEECH_ON%当他们绞刑时，他们说他对着某个东西大喊大叫然后溜走了，他一直奔跑不停，绞索勒破了他的耳朵，但他一直在喊着复仇。%SPEECH_OFF% | %randombrother%拿着侦察报告来见你。他说当地人没有看到野兽，但他们却以不同寻常的方式看到了一些东西。当你询问其原因时，雇佣兵耸了耸肩。%SPEECH_ON%我说不清楚，先生。似乎他们只是看到了一些事物。幻象之类的。我不相信这种胡言乱语，但他们对此事非常认真。%SPEECH_OFF% | 在你消磨时间的时候，一位老人沿着小路走来。他不等任何提示，就说如果你要找苍白之人，最好等到晚上。%randombrother%问他苍白之人是什么意思。老人笑了。%SPEECH_ON%说实话，他们既不苍白也不是人，但我不知道如何将他们放在这个世界上。我们前辈称他们为“阿尔普斯”，一种会将恶梦植入你脑中并以恐惧为食的怪物。%SPEECH_OFF%他捏了捏鼻子，祝你好运。 | 当你查看地图并了解地形时，%randombrother% 与一位老年妇女并肩走近。她像株老橡树一样苍老，颤抖的手招呼着你。你倾听她嘶哑的话语。%SPEECH_ON%他们只在夜里来。%SPEECH_OFF%她抬起一根手指。%SPEECH_ON%只有在夜里！他们的侵染不是土地，而是你的心灵。我母亲称他们为%enemy%。当你找到他们时，你会听到你的理智溜走的的嘶嘶声。请一定要紧紧抓住它。%SPEECH_OFF% | %randombrother% 走到你身边。他说，他以前听说过这些野兽。%SPEECH_ON%你偶尔能听到他们的耳语。他们蹲在你的窗台上看你睡觉，或者爬上你的床头，并撕开你的梦看里面。他们叫做alps，据我所知他们只在夜间出来。当然，如果他们真的存在的话。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{睁大眼睛。 | 我们需要为此做好准备。 | 保持清醒，伙计们。}",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Encounter",
			Title = "临近 %townname%…",
			Text = "[img]gfx/ui/events/event_102.png[/img]{%randombrother% 赶到你身边。%SPEECH_ON%有些东西在不远处移动。%SPEECH_OFF%你将目光转向巡逻范围。 不管是什么，它顶多是在滑过地面。 它看起来像一个剥了皮的鹿向后踏步并且它的眼睛喷出黑色的气体向后飘去就好像要把恐怖本身刻在地上。 你让伙计们拿起武器。 | 用火炬检查地图的时候，你突然看到一个黑色的形状跃过一片黑暗。 一团肢体像车轮样滚过地面，以一种不降称的速度甩向前。 它伏在地上低的像条蛇，同时你听到某个人在睡梦中窒息般的低吼。 你命令伙计们拿起武器。 | 一个苍白的身影尾随着战队的巡查边缘。 它蹲在高草丛里盯着你的战队。 终于，你走向前张开手臂并闭上眼睛。 很快，%randombrother% 喊出声来。%SPEECH_ON%退回来先生！哦天啊，先生，还有更多！%SPEECH_OFF%你睁开眼睛并点头。终于，它们来了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "冲锋！",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Alps";
						p.Entities = [];
						p.Music = this.Const.Music.BeastsTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Alps, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Victory",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_122.png[/img]{怪物被消灭了。 你拔出剑砍向其中一个的脖子处。 锋刃轻松的切过并且头掉下来滚进了草里。 它的眼眶是一片无毛的凹坑。 里面什么都没有，没有皮肉，没有肌肉。任何东西。 你告诉兄弟们准备好回去找 %employer%。 | 梦魇们躺在草地里而且尽管你亲眼看到它们受了伤，它们的肉体看起来就好像恢复了，并且他们看起来更像是被你的坚韧意志而不是武器给杀死的。 你拔剑切下了一个脑袋，只发现锋刃轻松划过了皮肤而喉咙则皱起闭上。 你捅了尸体几遍，扭了几下来让肉体无法修复。 肌腱滑了一会便在伤口里停了下来。 不确定怎么判断，你把头放进包里并告诉兄弟们做好准备回去找 %employer%。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "等待报酬。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_79.png[/img]{%employer% 想看看梦魇的遗体。 你从包里拿出了它。 血肉干瘪得扁平而且你拿着的头比起头颅更像头皮。 他用他的手指碰了碰它而梦魇的皮肤像蛇皮一样缩开。 他问它们打的怎么样。你耸耸肩。%SPEECH_ON%显然是很坚韧的生物，但我不会为它们失眠。%SPEECH_OFF%他厌恶的点点头。%SPEECH_ON%好。好吧，这是说好的报酬。 并且把那吓人玩意丢远点。%SPEECH_OFF% | 你把梦魇的头丢到 %employer%的办公桌上。 它沉重的落到木桌上直到它的咽喉大开，它空洞的眼眶沮丧的垂视着上面的世界。%employer% 拿出一个烧铁棍并嘟了嘟头颅之后把它支在半空中。%SPEECH_ON%这玩意可真吓人。 我得跟你说很多乡亲们几个小时前刚过来跟我说他们看到田野沐浴在荣光下的幻象。 好像他们梦到了世界的新生。 所以我不确定这些怪物都滚了，但是看起来 %townname%的问题被很好的解决了。 我会确保你拿到你说好的报酬的。%SPEECH_OFF% | %employer% 在他的房间里会见了你并且笑起了你带来的小包。 他摇着头给自己倒了一杯。%SPEECH_ON%你不用给我看那吓人玩意的脸，佣兵。 它几个小时前刚过来找过我，当时我正坐在这处理文书，一场梦境的入侵，一场它死亡的景象，好像它的灵魂被从我身上斩断而我被迫看着它去死。 而在它的离去中我看到你站在那里，手里拿着剑，胜利的姿态，然后梦就结束了。%SPEECH_OFF%你点头并问你看起来帅不帅啊。他笑道。%SPEECH_ON%你看起来就像个屠杀三千世界的屠夫，很显然屠杀掉了那个生物的世界而且，我还是有点怕，或许还有一部分我的世界。 被永远地偷走了。好吧，不重要，我身为人是完整还是残缺，我都承诺过要给你一份丰厚的报酬而且它就在这里。%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "一场成功的狩猎。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "让小镇摆脱不自然的噩梦");

						if (this.Flags.get("IsGoodNightsSleep"))
						{
							return "GoodNightsSleep";
						}
						else
						{
							this.World.Contracts.finishActiveContract();
							return 0;
						}
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
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "GoodNightsSleep",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_33.png[/img]{你寻思兄弟们应得点休息并在 %townname% 修整一顿。兄弟们睡得如此沉就像群死猪一样。 醒来后，兄弟们伸展着打起哈欠。 没有一个人有梦或噩梦要谈，一段短暂且沉静的小盹，还是相当需要的。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我觉得神清气爽！",
					function getResult()
					{
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 75)
					{
						bro.improveMood(1.0, "睡了一夜好觉，神清气爽");
						bro.getSkills().removeByID("effects.exhausted");
						bro.getSkills().removeByID("effects.drunk");
						bro.getSkills().removeByID("effects.hangover");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Target.getTile())]
		]);
		_vars.push([
			"enemy",
			this.m.Flags.get("enemyName")
		]);
		_vars.push([
			"enemyC",
			this.m.Flags.get("enemyName").toupper()
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/terrifying_nightmares_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Target != null && !this.m.Target.isNull())
			{
				this.m.Target.getSprite("selection").Visible = false;
				this.m.Target.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}

		if (this.m.Home != null && !this.m.Home.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Home.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(3);
			}
		}
	}

	function onIsValid()
	{
		return true;
	}

	function onSerialize( _out )
	{
		if (this.m.Target != null && !this.m.Target.isNull())
		{
			_out.writeU32(this.m.Target.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.m.Flags.set("SpawnAtTime", this.m.SpawnAtTime);
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}

		if (!this.m.Flags.has("StartTime"))
		{
			this.m.Flags.set("StartTime", 0);
		}

		this.contract.onDeserialize(_in);

		if (this.m.Flags.has("SpawnAtTime"))
		{
			this.m.SpawnAtTime = this.m.Flags.get("SpawnAtTime");
		}
	}

});

