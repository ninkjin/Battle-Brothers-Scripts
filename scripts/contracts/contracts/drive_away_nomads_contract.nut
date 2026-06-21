this.drive_away_nomads_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Dude = null,
		Reward = 0
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.drive_away_nomads";
		this.m.Name = "驱赶游牧民";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		local banditcamp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getNearestSettlement(this.m.Home.getTile());
		this.m.Destination = this.WeakTableRef(banditcamp);
		this.m.Flags.set("DestinationName", banditcamp.getName());
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

		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"驱逐游牧民族于" + this.Flags.get("DestinationName") + "，位于%origin%的%direction%"
				];
				this.Contract.setScreen("Task");
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				this.Contract.m.Destination.clearTroops();
				this.Contract.m.Destination.setLastSpawnTimeToNow();

				if (this.Contract.getDifficultyMult() <= 1.15 && !this.Contract.m.Destination.getFlags().get("IsEventLocation"))
				{
					this.Contract.m.Destination.getLoot().clear();
				}

				this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.NomadDefenders, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.setLootScaleBasedOnResources(110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.setResources(this.Math.min(this.Contract.m.Destination.getResources(), 70 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
				this.Contract.m.Destination.setDiscovered(true);
				this.Contract.m.Destination.resetDefenderSpawnDay();
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
				local r = this.Math.rand(1, 100);

				if (r <= 10)
				{
					if (this.Contract.getDifficultyMult() >= 0.95 && this.World.Assets.getBusinessReputation() > 700)
					{
						this.Flags.set("IsSandGolems", true);
					}
				}
				else if (r <= 25)
				{
					if (this.Contract.getDifficultyMult() >= 0.95 && this.World.Assets.getBusinessReputation() > 300)
					{
						this.Flags.set("IsTreasure", true);
						this.Contract.m.Destination.clearTroops();
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.NomadDefenders, 150 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
				}
				else if (r <= 35)
				{
					if (this.World.Assets.getBusinessReputation() > 800)
					{
						this.Flags.set("IsAssassins", true);
					}
				}
				else if (r <= 45)
				{
					if (this.World.getTime().Days >= 3)
					{
						this.Flags.set("IsNecromancer", true);
						this.Contract.m.Destination.clearTroops();
						local zombies = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies);
						this.World.FactionManager.getFaction(this.Contract.m.Destination.getFaction()).removeSettlement(this.Contract.m.Destination);
						this.Contract.m.Destination.setFaction(zombies.getID());
						zombies.addSettlement(this.Contract.m.Destination.get(), false);
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.NecromancerSouthern, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
				}
				else if (r <= 50)
				{
					this.Flags.set("IsFriendlyNomads", true);
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
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));

					if (this.Flags.get("IsNecromancer"))
					{
						this.Contract.m.Destination.m.IsShowingDefenders = false;
					}
				}
			}

			function update()
			{
				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					if (this.Flags.get("IsTreasure"))
					{
						this.Flags.set("IsTreasure", false);
						this.Contract.setScreen("Treasure2");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setState("Return");
					}
				}
			}

			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				if (this.Flags.get("IsSandGolems"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("SandGolems");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.Music = this.Const.Music.OrientalBanditTracks;
						properties.EnemyBanners.push(this.Contract.m.Destination.getBanner());
						local e = this.Math.max(1, 70 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult() / this.Const.World.Spawn.Troops.SandGolem.Cost);

						for( local i = 0; i < e; i = ++i )
						{
							properties.Entities.push({
								ID = this.Const.EntityType.SandGolem,
								Variant = 0,
								Row = -1,
								Script = "scripts/entity/tactical/enemies/sand_golem",
								Faction = this.Const.Faction.Enemy
							});
						}

						this.World.Contracts.startScriptedCombat(properties, true, true, true);
					}
				}
				else if (this.Flags.get("IsTreasure") && !this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);
					this.Contract.setScreen("Treasure1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsNecromancer") && !this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);
					this.Contract.setScreen("Necromancer");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsAssassins"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("Assassins");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.Music = this.Const.Music.OrientalBanditTracks;
						properties.EnemyBanners.push(this.Contract.m.Destination.getBanner());
						local e = this.Math.max(1, 30 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult() / this.Const.World.Spawn.Troops.Assassin.Cost);

						for( local i = 0; i < e; i = ++i )
						{
							properties.Entities.push({
								ID = this.Const.EntityType.Assassin,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/humans/assassin",
								Faction = this.Contract.m.Destination.getFaction()
							});
						}

						this.World.Contracts.startScriptedCombat(properties, true, true, true);
					}
				}
				else
				{
					this.World.Contracts.showCombatDialog();
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
			Text = "[img]gfx/ui/events/event_163.png[/img]{你走入 %employer%的房间，里面尽管没有喇叭奏乐，没有庆贺彩纸，没有喧嚷起哄，但仍然有着相当讲究的排场。 技艺纯熟的匠人用着多样的珠宝、金银，把居室装饰得富丽堂皇，闺阁的女子妖艳动人至极，让人觉得，如果能有机会加入这宛若日夜不休的盛宴，他甘愿去做任何事。%employer% 坐在一堆软垫上。%SPEECH_ON%啊，逐币者。我一直在等着你。 但你们可别靠得太近，不然会扰乱我的兴致。 我有个小事让你办。 一伙游牧民抢掠了我的商队，这让我金库里的硬币变少了。 你们应该明白，属于自己的东西被夺走是什么感觉，对吧？ 啊，你看起来好笨。头脑空空。 不管怎样，你只要干好自己的行当。 帮我宰了那些游牧民，我愿意付出 %reward% 克朗来了解此事。 你们的耳朵能明白我说的话对吧？%SPEECH_OFF% | %employer% 的身子一侧靠在一个丝绸软垫制成的宝座，另一侧拥在一群妖艳女子的胴体上。 他抬起手来。%SPEECH_ON%给我止步，你们这些逐币者要是再敢离我近点，那么你们就是不知分寸了，知道吧？ 聪明人知道自己的位置。 我想让你们这些拿剑的做些事。 %townname% 附近的游牧民在抢夺，无恶不作。 那些人让我很不爽，给我灭掉他们，我会给你们不错的奖赏。%SPEECH_OFF% | 你看到 %employer% 在喂一只笼子里的鸟。 这鸟五彩斑斓，其中的一些色彩你之前都没见到过。 觉察到你的赶来，亦或是闻到你的味道，%employer% 转过身来，脸上闪过一丝嫌恶。%SPEECH_ON%你把我的鸟吓到了，逐币者，咱就长话短说，给我的爱鸟图个清静。 在我的领地周边，有些作乱的游牧民，我想让他们被挫骨扬灰。 我知道你们，呃，你们这种人，会很愿意给我做这种小差事吧？%SPEECH_OFF% | 你进入 %employer%的房间。 他正吃着水果，下半身淹没在一片肉体的海洋当中，那是他的后宫在喧嚷地侍奉着。 你无所事事地站着，已经等了太长时间，当你想开口时，这人抬起一只手。 看着他的一个仆人，打了个响指。 仆人穿着丝绸底的凉鞋，走过大理石制成的地板。 他给你一张纸。上面写着：%SPEECH_ON%致有意前来的逐币者，游牧民在 %townname% 周边为非作歹，扰得鸡犬不宁。若能除掉他们，必有 %reward% 克朗的重赏。 无意向者请立马离开。%SPEECH_OFF%仆人看着你，等待你的答复。 | 你进入 %employer% 的房间时，他叹着气。%SPEECH_ON%啊，是逐币者，我都差点忘了我邀请过你们，让你们来毁掉我今天的雅兴。%SPEECH_OFF%你盯着维齐尔，他纵身于软垫当中，一群女子正在按摩抚慰，以至于让维齐尔抽身乏术。%SPEECH_ON%好吧，我想我应该花一个小时来解决这件事。 一伙游牧民正在对我的商队胡作非为，就像他们经常做的那样，这让市场缺了一些我想要的货。 我提供 %reward% 克朗来作为找到并消灭这些沙漠虫子的奖赏。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我们再多谈谈报酬。 | 我能解决掉这个麻烦。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{不感兴趣。 | 我们有更重要的事情要做。 | 我祝你好运，但我们不会参与其中。}",
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
			ID = "Treasure1",
			Title = "在攻击前…",
			Text = "[img]gfx/ui/events/event_54.png[/img]{游牧民出乎意料的按兵不动、人数众多，你发现了这样的原因所在：这些沙漠住民围在地上的一个洞旁边。 用着制作的滑轮，心急火燎地挖着他们能在沙漠里发现的一切。 从监督这次行动的人的笑容来看，这里想必是埋藏着宝物。\n\n你可以现在进攻，这样会面临更多的敌人，或者你可以等到他们挖完东西，带着他们挖出来的东西离开。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们现在进攻！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				},
				{
					Text = "我们等到他们完事，营地防守不那么严密的时候。",
					function getResult()
					{
						return "Treasure1A";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Treasure1A",
			Title = "在攻击前…",
			Text = "[img]gfx/ui/events/event_54.png[/img]{你等待游牧民族取出财宝，果然是一个箱子。他们打开它时脸上露出满足。而且，正如预料的那样，游牧民族分裂了，一部分最强壮的男人带着财宝离开，可能要在别处出售。游牧营地现在变得更脆弱，更容易遭受攻击......}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "准备进攻！",
					function getResult()
					{
						this.Flags.set("IsTreasure", false);
						this.Contract.m.Destination.clearTroops();
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.NomadDefenders, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Treasure2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_168.png[/img]{你把游牧民族杀死后，自然而然地前去看看他们究竟在地下挖出了什么。你站在他们搭建的滑轮上，凝视着那个深坑。可以看到一个箱子，绳索已经绑在了它上面。你感谢已故的游牧民族所做的所有工作，然后轻松地拉起箱子。你打开它发现…}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "宝藏！",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				local e = 2;

				for( local i = 0; i < e; i = ++i )
				{
					local item;
					local r = this.Math.rand(1, 4);

					switch(r)
					{
					case 1:
						item = this.new("scripts/items/loot/ancient_gold_coins_item");
						break;

					case 2:
						item = this.new("scripts/items/loot/silverware_item");
						break;

					case 3:
						item = this.new("scripts/items/loot/jade_broche_item");
						break;

					case 4:
						item = this.new("scripts/items/loot/white_pearls_item");
						break;
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
			ID = "SandGolems",
			Title = "在攻击前…",
			Text = "[img]gfx/ui/events/event_160.png[/img]{当你准备攻击时，一个人突然从沙漠中升起。他被吓到，一边尖叫着一边向着游牧民族的营地滚下沙丘。你紧追不放，手握武器准备杀死他。你在跳跃中可以看到游牧民族相互攀登，倒塌帐篷拿起武器。当你回头看向那个人时，他突然在沙中消失了，连接沙丘的胳膊从地下伸出来，形状上的尘土和沙子落了下来。\n\n你几乎不能理解你所看到的，但所有游牧民族似乎都在喊着同样的话：“伊弗利特！伊弗利特！伊弗利特！”这个没有面孔的，看似无穷无尽的“伊弗利特”在即将到来的战斗中没有任何归属。 | 你朝着游牧民族冲下沙丘，他们被吓到了，大声喊着口令，跑去拿武器。当你接近营地时，一股沙子冲击了营地角落，一些游牧民族被扔飞了。一秒钟后，一个巨石从尘云中飞出来，将一名游牧民族砸成碎片。一只巨大的，由土砾形成的生物咆哮着向前走来。“伊弗利特！伊弗利特！”游牧民族尖叫着，你推测这个“伊弗利特”将没有任何一方站在他的一边。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Assassins",
			Title = "在攻击前…",
			Text = "[img]gfx/ui/events/event_165.png[/img]{你带领队伍冲入营地，此刻刚好看到一名身穿黑衣的男子从其中一座帐篷走出。他正在与游牧民族的领袖握手，这可能不是什么好兆头。两个人在半握手的状态下惊呆了，盯着你的进攻，结果肯定不妙。游牧民族的领袖叫嚷着让他的刺客们放手杀敌。那名黑衣杀手点点头，掏出刀剑，一队刺客随即蜂拥而出，加入游牧民族的阵营，与你展开战斗!}",
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
			]
		});
		this.m.Screens.push({
			ID = "Necromancer",
			Title = "在攻击前…",
			Text = "[img]gfx/ui/events/event_161.png[/img]{摊破的帐篷。篮子散开了。衣服在沙丘上滚动。而在这一切的中心，坐着一个穿着黑斗篷的男人，他那可怖的脸从斗篷的阴影中窥视出来。%SPEECH_ON%你们既迟到了又恰到好处。%SPEECH_OFF%他说着站了起来。帆布哗啦哗啦地响着，篮子倾斜着，衣服被拉扯着，大地犹如活生生地着迷。突然，沙子中峡谷般的通道出现了，冷酷的游牧民族从地下涌出，有些像脱胎换骨般跳出来，仿佛要在清新的空气中重生，有些从脚跟到荷包腰飞起，身体挺直像旗杆一样。他们的动作令人不安，僵硬而又倾斜，而黑衣人在他们摇摆的队列后面露出了一个笑容。他并不是普通的恶棍，而是一个亡灵巫师！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination, false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{一个仆人挡住了见%employer%的路。他递给你一卷卷轴和一个包袋。虽然仆人已经递给了你纸张，但他仍然把手放在后背上，看着天花板背诵。%SPEECH_ON%根据事先的安排，王室成员获得了%reward_completion%克朗的奖励。收到奖励后，他立刻离开了产业。%SPEECH_OFF%仆人低头对你点了点头。%SPEECH_ON%你可以走了。%SPEECH_OFF%他说。 | 你试图进入%employer%的房间，但是一个身上有伤疤的大卫士用长柄武器挡住了门口。%SPEECH_ON%没有访客。%SPEECH_OFF%你说你有事情要找大臣。卫士摇了摇头。一个仆人从你身后走了过来，把一个包袋放在你的手臂上，然后飞快地离开了。卫士把武器收回到自己的身边。%SPEECH_ON%当你第一次离开大臣时，你已经解决了与他的琐事。你不应该再破坏他的心情。现在离开。在你破坏我的心情之前走。%SPEECH_OFF% | 当你走近%employer%的房间时，一个女人从大厅对面鼓掌。你转过头去，她已经离你太近了。四只鸟停在她的肩膀上，随着她的每一步摇曳。%SPEECH_ON%队长。%SPEECH_OFF%她拿出一个包袋递给你。%SPEECH_ON%进入他的房间已经足够了，%employer%不必再闻到你的气息。如果你要侮辱我们，就数一数钱。如果你想让我们高兴，就离开吧。%SPEECH_OFF%她转身走开，异国情调的裙子左右摇摆。其中一只鸟在她的肩上旋转并对你吱吱叫着。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "好吧，我们已经得到了报酬。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "摧毁了一个游牧营地。");
						this.World.Contracts.finishActiveContract();
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
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Home, this.List);
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"totalenemy",
			this.m.Destination != null && !this.m.Destination.isNull() ? this.beautifyNumber(this.m.Destination.getTroops().len()) : 0
		]);
		_vars.push([
			"direction",
			this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isAlive() ? "" : this.Const.Strings.Direction8[this.m.Home.getTile().getDirection8To(this.m.Destination.getTile())]
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0 && this.World.getTime().Days > 3 && this.Math.rand(1, 100) <= 50)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/ambushed_trade_routes_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setOnCombatWithPlayerCallback(null);

				if (this.m.Flags.get("IsNecromancer"))
				{
					local nomads = this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits);
					this.World.FactionManager.getFaction(this.m.Destination.getFaction()).removeSettlement(this.m.Destination);
					this.m.Destination.setFaction(nomads.getID());
					nomads.addSettlement(this.m.Destination.get(), false);
				}
			}

			this.m.Home.getSprite("selection").Visible = false;
		}

		if (this.m.Home != null && !this.m.Home.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Home.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(4);
			}
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

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		this.contract.onDeserialize(_in);
	}

});

