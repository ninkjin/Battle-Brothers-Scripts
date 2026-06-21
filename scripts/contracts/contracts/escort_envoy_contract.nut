this.escort_envoy_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.escort_envoy";
		this.m.Name = "护送特使";
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

		local settlements = this.World.EntityManager.getSettlements();
		local candidates = [];

		foreach( s in settlements )
		{
			if (s.getID() == this.m.Home.getID())
			{
				continue;
			}

			if (!s.isDiscovered() || s.isMilitary())
			{
				continue;
			}

			if (s.getOwner() == null || s.getOwner().getID() == this.getFaction())
			{
				continue;
			}

			if (s.isIsolated() || !this.m.Home.isConnectedTo(s) || this.m.Home.isCoastal() && s.isCoastal())
			{
				continue;
			}

			candidates.push(s);
		}

		this.m.Destination = this.WeakTableRef(candidates[this.Math.rand(0, candidates.len() - 1)]);
		local distance = this.getDistanceOnRoads(this.m.Home.getTile(), this.m.Destination.getTile());
		this.m.Payment.Pool = this.Math.max(250, distance * 7.0 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult());

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		local titles = [
			"特使",
			"使者"
		];
		this.m.Flags.set("EnvoyName", this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
		this.m.Flags.set("EnvoyTitle", titles[this.Math.rand(0, titles.len() - 1)]);
		this.m.Flags.set("DestinationName", this.m.Destination.getName());
		this.m.Flags.set("Bribe", this.beautifyNumber(this.m.Payment.Pool * this.Math.rand(75, 150) * 0.01));
		this.m.Flags.set("EnemyName", this.m.Destination.getOwner().getName());
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"护送%envoy_title% %envoy%至" + this.Contract.m.Destination.getName() + "位于%direction%向"
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

				if (r <= 10)
				{
					if (this.Contract.getDifficultyMult() >= 1.0)
					{
						this.Flags.set("IsShadyDeal", true);
					}
				}

				local envoy = this.World.getGuestRoster().create("scripts/entity/tactical/humans/envoy");
				envoy.setName(this.Flags.get("EnvoyName"));
				envoy.setTitle(this.Flags.get("EnvoyTitle"));
				envoy.setFaction(1);
				this.Flags.set("EnvoyID", envoy.getID());
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.Destination.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.World.getGuestRoster().getSize() == 0)
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Contract.isPlayerAt(this.Contract.m.Destination))
				{
					this.Contract.setScreen("Arrival");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsShadyDeal"))
				{
					if (!this.Flags.get("IsShadyDealAnnounced"))
					{
						this.Flags.set("IsShadyDealAnnounced", true);
						this.Contract.setScreen("ShadyCharacter1");
						this.World.Contracts.showActiveContract();
					}
					else if (this.World.State.getPlayer().getTile().HasRoad && this.Math.rand(1, 1000) <= 1)
					{
						local enemiesNearby = false;
						local parties = this.World.getAllEntitiesAtPos(this.World.State.getPlayer().getPos(), 400.0);

						foreach( party in parties )
						{
							if (!party.isAlliedWithPlayer)
							{
								enemiesNearby = true;
								break;
							}
						}

						if (!enemiesNearby && this.Contract.getDistanceToNearestSettlement() >= 6)
						{
							this.Contract.setScreen("ShadyCharacter2");
							this.World.Contracts.showActiveContract();
						}
					}
				}
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_actor.getID() == this.Flags.get("EnvoyID"))
				{
					this.World.getGuestRoster().clear();
				}
			}

		});
		this.m.States.push({
			ID = "Waiting",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"在" + this.Contract.m.Destination.getName() + "附近待命，直到%envoy_title% %envoy%搞定为止。"
				];
				this.Contract.m.Destination.getSprite("selection").Visible = true;
			}

			function update()
			{
				this.World.State.setUseGuests(false);

				if (this.Contract.isPlayerAt(this.Contract.m.Destination) && this.Time.getVirtualTimeF() >= this.Flags.get("WaitUntil"))
				{
					this.Contract.setScreen("Departure");
					this.World.Contracts.showActiveContract();
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"护送 %envoy% %envoy_title% 回到" + this.Contract.m.Home.getName()
				];
				this.Contract.m.Destination.getSprite("selection").Visible = false;
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				this.World.State.setUseGuests(true);

				if (this.World.getGuestRoster().getSize() == 0)
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("Success1");
					this.World.Contracts.showActiveContract();
				}
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_actor.getID() == this.Flags.get("EnvoyID"))
				{
					this.World.getGuestRoster().clear();
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
			Text = "[img]gfx/ui/events/event_63.png[/img]{%employer% 边上站着一个人。你几乎看不到他的脸，当你试图换个位置好好看看时，他也转过身去以避开你。%SPEECH_ON%请放心，雇佣兵。这是 %envoy%。你不需要看到他的脸。 我只需要你把他带到 %objective%。他要去那里说服他们来加入我们。 当然，%enemynoblehouse% 不欢迎这个，所以保密是比较重要的。%SPEECH_OFF%你点头，很理解贵族间政治斗争的复杂程度。%SPEECH_ON%很好，雇佣兵。那么，有兴趣吗？%SPEECH_OFF% | 一个人，就像是从 %employer% 房间的阴影中现身的一般的人，伸出手靠近了你。 你握了握，然后他开始了自我介绍。%SPEECH_ON%我是 %envoy% 服务于这里的 %employer%。我们有…%SPEECH_OFF%%employer% 插进来。%SPEECH_ON%我需要你护送这个人去 %objective%。那里是 %enemynoblehouse% 领地，所以显然，这会需要藏着点。 这就是你们派上用场的地方。 你只需要确保这个人到地方。 在那之后，再把他带回来拿你的报酬。 这符合你的工作专长吗？%SPEECH_OFF% | %employer% 把一张卷轴拍到了你胸上。%SPEECH_ON%有个人，一个特使，站在我门外。 他的名字是 %envoy% 而且他要去 %objective% 说服他们加入我们。%SPEECH_OFF%拿下卷轴，你询问起眼下显而易见的问题：那里是 %enemynoblehouse%的领地。%employer% 点头。%SPEECH_ON%是的，没错。这就是为什么是你而不是我的士兵站在这里。 没必要开战，对吧？ 我只需要你把 %envoy% 带到那里再带回来。 如果你有兴趣，让我们谈谈价钱然后你就可以把那个卷轴给特使准备出发了。%SPEECH_OFF% | 看着张地图，%employer% 问起你对政治了解多少。 你耸耸肩，他点头说。%SPEECH_ON%我想也是。好吧，不幸的是，我需要你处理点政治相关的事情。 我需要你保护一个叫 %envoy% 的特使。他要去 %objective% 做…额，做点政治工作，说服那里的人们加入我们，没什么好担心的。 显然，那里不是我们的领地，这也是为什么我要雇一个像你这样不知名的人。没有冒犯的意思。%SPEECH_OFF%你摆手告诉他不要紧。%employer% 继续道。%SPEECH_ON%好，如果你有兴趣的话，只要把它带到那里再带回来。 听起来很简单，对吧？ 都不需要你去开口！%SPEECH_OFF% | %employer% 研究着一张地图，更准确来说是上面用来对比他和 %enemynoblehouse% 的边界的色块。他一拳拍在对方的领地上。%SPEECH_ON%好的，雇佣兵。我需要些猛士保护 %envoy%，我的一个特使。 他要到 %objective%，如果你有点政治知识的话，那里不是我的领地。%SPEECH_OFF%你点头，让贵族知道你理解他所要求的含义。%SPEECH_ON%你把他带去那儿，让他去谈，然后你把他再带回来。 至于你要做的，只是做好一群跟着他走来走去的无属猛男，懂了吗？ 那么如果你有兴趣，让我们谈谈价钱，怎么样？%SPEECH_OFF% | %employer% 把一团破破烂烂的纸丢到他的桌上，很显然上面不是什么好消息。%SPEECH_ON%我的女儿们要出嫁，但我没有足够的领地去收足够的税来给她们应有的祝贺。%SPEECH_OFF%你对这件事没有兴趣并让他有话直说。%SPEECH_ON%好的，好吧。糟心事放一边，我需要你护送我的一个特使，%envoy%，前往 %objective%。他要去试图说服他们加入我们旗下。 不过现在，那个小地方是 %enemynoblehouse%的领地而且他们肯定不会很高兴知道我们出现在他们的地盘里。 这也是为什么我要雇你，无名佣兵，去保护好我的特使。%SPEECH_OFF%他把手收到腰间。%SPEECH_ON%这点小差事有兴趣吗？ 你只需要把他带过去再带回来。简单的差事，相当简单！%SPEECH_OFF% | 读着一张卷轴，%employer% 突然开始大笑并看起来完全无法停下来。%SPEECH_ON%好消息，佣兵！%enemynoblehouse% 的人民看来对他们的治理不满！%SPEECH_OFF%你扬起眉头，开玩笑似地点头。 把椅子挪到桌边并读起摆在上面的一张地图，他继续道。%SPEECH_ON%更好的消息是我有个名为 %envoy% 的特使今天正要去 %objective% 去做点…谈话。 很显然，路上到处都是毛贼而 %enemynoblehouse% 的领主比他们更鸡贼，所以这个人需要些保护！那正是你派上用场的地方。 你要做的只是护送他一个来回。%SPEECH_OFF% | %employer% 边上站着一个人。他与你握手并自我介绍道他是 %envoy%，某种意义上的特使。 你询问起他的重要性，%employer% 很快解释道。%SPEECH_ON%他要去 %objective%，%enemynoblehouse% 的领地，如果你不知道的话。 我们可能可以说服那里的人们加入我们麾下。 现在你了解了他和他的任务，你一定明白了为什么我让你在这里，而不是我的一个士兵。\n\n我需要你把这个人带到 %objective% 然后，当他办完事，把他带回来。 在那之后，你就可以拿到报酬。有兴趣吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我们来谈谈价钱。 | 这对你来说值多少钱？ | 报酬如何？}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{你得去别的地方找保镖了。 | 这不是我们要找的工作。}",
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
			ID = "Arrival",
			Title = "在 %objective%",
			Text = "[img]gfx/ui/events/event_20.png[/img]{你到了 %objective%。%envoy% %envoy_title% 进入了一栋建筑，悄悄地关上了身后的门。 你一只脚踩着墙等着他回来。 几个农民来来往往。 鸟鸣。你有段时间没注意过它们的歌声了。\n\n看来，这可能要点时间。 或许你应该利用好这个时间给回程买点补给？ | 特使进入了 %objective% 的一栋议会大厅。你安全打把他带到了那里，现在就是他来完成剩下的工作了。 你花了段时间听了听谈话，伏在其中一扇窗户上。 他话讲的很快而且他召集人们的能力比你和几把剑可强多了。 特使看到了窗户后的你并轻轻摆手让你离开。 你走开来等他完事。 | 几名穿着精美的人欢迎你进入 %objective%。他们问 %envoy%  %envoy_title% 你是不是一起的。 他点头并快速的像议员们传了点悄悄话。 他们回以点头，很快他们都溜进一间当地的酒馆。你在外面等着。 或许你应该用这时间筹备点回程的物资？ | %employer% 对 %objective% 可能转向他效忠的怀疑看来是真的：这里的人已经在街上大规模游行了。 一排卫兵站在一栋大房子外用横着的长矛推后平民。 一个富人从一扇窗户探出来试图用言语解散人群，但他们的耳朵被愤怒塞满了。%envoy% 轻松地溜过人群并与几位穿着斗篷的议员会了面。 他们溜到了附近的一栋建筑里，而你就在外面等。 | %objective% 看起来有点荒凉，街上的农民们，或对某样东西发火或者对什么都没有干劲。 这两个都不是一个健康社区该有的样子。%envoy%  %envoy_title% 走进当地的一个酒吧，一群勾着身子的人小心地欢迎了他。 他挥手让你离开，所以你站在外面并等他办完事。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "{别耗太久。 | 我们会呆在附近。}",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.World.getGuestRoster().get(0).getImagePath());
				this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(20, 60) * 1.0);
				this.Contract.setState("Waiting");
			}

		});
		this.m.Screens.push({
			ID = "Departure",
			Title = "在 %objective%",
			Text = "[img]gfx/ui/events/event_20.png[/img]{过了段时间，特使出来了。 你问他有遇到什么麻烦吗，他说没有。是时候回去找 %employer%。 | 门打开了，特使从中走出。 他让你带他回家。 | 挺快特使就出来了。 他告诉你他办完事了而且他需要回去找 %employer%。 | %envoy% 匆忙回到你边上。 他告诉你，他需要尽快回去找 %employer%。 | 特使回来时他说谈的很顺利，而且你需要尽快把他带回 %employer%。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "{终于，我们出发！ | 你怎么花了这么长时间？}",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.World.getGuestRoster().get(0).getImagePath());
				this.Contract.setState("Return");
			}

		});
		this.m.Screens.push({
			ID = "ShadyCharacter1",
			Title = "在 %townname%",
			Text = "[img]gfx/ui/events/event_51.png[/img]{你正要离开，一个穿着斗篷的人过来跟你说话。 他把面孔藏在他的围巾之下，你只能不时看到他的牙齿以及他尖锐下巴的末端。%SPEECH_ON%当时候到来，你会避而不见吗，雇佣兵？%SPEECH_OFF%在你能回答之前，他消失了。 | 在准备离开的时候，一个人撞到了你。 他没有道歉，相反从漆黑的长斗篷中向外张望。%SPEECH_ON%未来你会遇到一个不得回避的抉择。 留下战斗，或者离开活过那一天。 金钱会在第二条路上跟上你，而铲子在第一条路上为你掘墓…%SPEECH_OFF%你伸手去抓他，但他轻松的后退一步，融入了一片正巧路过的闲人。 | 你正准备离开 %townname%，一个身着黑色斗篷的人走到了你身边。 他没有看你，就这么说着。%SPEECH_ON%我的施主事先知道了你。%employer% 选择雇用你很聪明。 然而，你有选择，而且当时候到了…你会选择哪条路？%SPEECH_OFF%你告诉他去找别人说这些神神叨叨的。 | 一个黑衣人截住了正在离开 %employer% 的你。 他越过你的肩头看了看，然后悄悄说道。%SPEECH_ON%%employer%的报酬丰富，但我知道个会给你更多的人。 当时候到来，看向另一边…%SPEECH_OFF%陌生人后退了一步并溜到了一扇门后。 当你打开它试图追赶时，他已经不见了。 只有一个厨房的助手站在那里，看起来好像 {he'd | she'd} 什么都没看到。 | 带着 %employer%的任务，你准备出发。 在准备补给时，一个身着斗篷的陌生人靠了过来。 他的声音好似含着砂石一般。%SPEECH_ON%许多鸟正看着你，佣兵。 小心你的下一步。 你还有机会摆脱这一切。 当时候到来，我们只要求你站在一边。%SPEECH_OFF%你拔出剑威胁他，但他溜走了，他飘动的斗篷滑入了看起来被你的突然拔剑吓到的农民中。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "{这会变得很有趣… | 看来麻烦正在发酵。}",
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
			ID = "ShadyCharacter2",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_07.png[/img]{在路上，一群武装人员不知道从哪里冒出来拦住了你。 在他们中站着你之前看到的人。 他们报上了从你手上带走特使的企图。 作为回报，你会拿到一大笔钱－ %bribe% 克朗。\n\n不然，那，他们就要以武力夺取他了… | 你正在适应情况，听着特使满嘴跑轱辘，无视它，希望他就一个人走到森林里别回来，这时你惊讶地发现了一群武装人员。 跟他们站在一起的是你早先遇到的人。 他们声称特使必须被交过来。 相应的，你会拿到总共 %bribe% 克朗。 如果你拒绝，那，他们就要用点更暴力的手段了。\n\n在你思索选项时，特使，终于，完全安静了。 | 在路上行进着，一群武装人员冲出来拦住了你。 你认出来了之前的陌生人，他正跟他们站在一起。 他们要求你把特使交过来，动作暗示向非常大的一袋克朗，他们声称总共 %bribe% 克朗。 他们同时暗示向他们的武器，提出他们也准备好了你拒绝时的办法。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "当你能白拿克朗时为什么要流血呢？ 我们成交。",
					function getResult()
					{
						return "ShadyCharacter3";
					}

				},
				{
					Text = "如果你想要他，就来自己来拿啊。",
					function getResult()
					{
						return "ShadyCharacter4";
					}

				}
			],
			function start()
			{
				this.Characters.push(this.World.getGuestRoster().get(0).getImagePath());
				this.Flags.set("IsShadyDeal", false);
			}

		});
		this.m.Screens.push({
			ID = "ShadyCharacter3",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你正思索着选项，特使来到你身边，悄声说道。%SPEECH_ON%你肯定不会让他们带走我，对吧？%employer% 让你保护我可付了不少钱。%SPEECH_OFF%你点头，把一只手放在他的肩膀上悄悄回答道。%SPEECH_ON%你说的没错。他确实是。 但他们要给我更多。%SPEECH_OFF%之后，你把它推向前。 他抗议，但被一把剑截断了。 血溅到了地上，内脏跟着刃身被拔了出来。 神秘的陌生人交给你说好的克朗。%SPEECH_ON%很高兴和你做生意，佣兵。%SPEECH_OFF% | 你看了看特使然后看了看神秘人，并向他们点了点头。 他抓紧你的衬衫，哀求道。%SPEECH_ON%不，不要！你向 %employer% 保证过我的安全！%SPEECH_OFF%你把他交了出去。 他们马上割了他的喉咙，他跪在地上，手指捂着他的伤口，但血不停地流出。 他的凶手把他踢来踢去，特使慢慢地静止了下来，人们嘲笑着他逝世的过程。 一个袋子落到了你的手里，将它放在那的人拍了拍你的肩膀。%SPEECH_ON%谢谢你的合作，佣兵。 你真的不辜负你的头衔。%SPEECH_OFF% | 你瞟了眼特使并摇了摇头。%SPEECH_ON%我是个佣兵，而且我的价钱就是这样。%SPEECH_OFF%特使哭喊着，但一个人拿着把小型弩上前将一支弩箭射到了他的两眼之间，箭杆从他的头后部突出，裹在血肉中。 神秘人丢给你一袋克朗。%SPEECH_ON%这对于所有参与者而言意味着什么，遗憾，或恩赐？%SPEECH_OFF%你数了数克朗并回答道。%SPEECH_ON%同时都有，直到你那边的人给特使的头骨来了点木工。 现在只有恩赐了。%SPEECH_OFF%神秘人讽刺地笑道。%SPEECH_ON%真遗憾。我个人喜欢多样的意见。 像他们说的，那会增加戏剧性。%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "{轻松的克朗。 | 人人皆赢。}",
					function getResult()
					{
						this.World.FactionManager.getFaction(this.Contract.getFaction()).getFlags().set("Betrayed", true);
						this.World.Assets.addMoney(this.Flags.get("Bribe"));
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractBetrayal);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "没能保护特使");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				this.updateAchievement("NeverTrustAMercenary", 1, 1);
				this.Characters.push(this.World.getGuestRoster().get(0).getImagePath());
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Flags.get("Bribe") + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "ShadyCharacter4",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_50.png[/img]{你一只手将特使推到身后同时另一只手拔出了你的剑。 神秘人点头并缓慢地藏到了他自己的阵线后。%SPEECH_ON%这很遗憾，但我依然有个生意要做。 I'm sure you understand.%SPEECH_OFF% | 神秘人张开一只手，手指卷起好似要把特使从你身边卷走。 与之相对，你将特使推到了你的战线后。 神秘人马上点了个头。%SPEECH_ON%可以理解。但不可行。 我们都有我们各自的雇主，佣兵。 你肯定，和我一样，都是忠诚的。 让我们中活下来的人去领取那些将信心交给我们的人的报酬吧。%SPEECH_OFF% | 特使向你哀求，但你告诉他闭嘴然后转身面向了杀手们。%SPEECH_ON%特使要站着离开这里。%SPEECH_OFF%点了点头，神秘人直接躲到了他的战线后。%SPEECH_ON%我理解。生意就是生意，那么现在，事必须被办完。%SPEECH_OFF%他的手下走上前来，拔出他们的剑。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Mercs";
						p.Entities = [];
						p.Parties = [];
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Mercenaries, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.World.getGuestRoster().get(0).getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你会到了 %employer% 的地方，特使站在你身边。%SPEECH_ON%啊，佣兵，看来你按照我的要求做了。而你，特使…？%SPEECH_OFF%%envoy% 低身向前并向贵族耳语起来。 他倚后，点着头。%SPEECH_ON%好，很好。让我们好好谈谈…噢，还有佣兵，你的报酬就在外面等着你。 随便问哪个卫兵。%SPEECH_OFF%两个人转身走开了。 你离开到走廊上，一个结实的人在那等着，并给了你装着 %reward_completion% 克朗的袋子。 | 回到 %employer%, 的地方，特使离开了你身边并快速地，而且悄悄地，告诉了他一些消息。%employer% 点着头，没有表露任何信息，然后向附近的一个卫兵打了个响指。 那个装备武器的人走上前来交给了你一个袋子。 当你拿上它并抬头时，贵族和特使都不见了。 | 你保护了 %envoy% 的安全，特使对此向你表示感谢。%employer% 则没这么友善，无视了你直接去与密使谈话。 在你站着等报酬时，一个卫兵摸过来把一个木箱子拍给你抱着。%SPEECH_ON%这是 %reward_completion% 克朗。如果你想你可以数一下。%SPEECH_OFF% | 你几乎不知道 %employer% 那个鬼鬼祟祟的小代表在那个镇上做什么。 特使和你的雇主致意后马上开始了谈话，紧紧地弓在一起并压着他们的嗓门。 当你走近一步询问报酬时，一个卫兵拦住了你，把一个袋子塞给你抱着。%reward_completion% 克朗都在里面，如同约定的。 因为对政治没有兴趣，你没有逗留过久去了解那两个人想干什么。 | %employer% 张开双臂欢迎你。%SPEECH_ON%啊，你护住了 %envoy%！%SPEECH_OFF%他抱了抱特使，但只与你握了握手，同时还传过来一包克朗。%SPEECH_ON%我知道我能信任你，雇佣兵。那么，请…%SPEECH_OFF%他向门示意。你离开了，留他们二人谈话。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "来之不易的克朗。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "安全护送特使");
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
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "战斗之后",
			Text = "[img]gfx/ui/events/event_60.png[/img]{特使没能活下来。%employer% 可以接受点损失，但他不会乐于知道这件事的。 尽量不要再让他失望了。 | 很遗憾，%envoy% %envoy_title% 死在了你的脚边。 对于一个被承诺了安全的这真是太糟了！哦，好吧。 在未来，最好不要继续辜负 %employer%。 | 好吧，你能看看吗：特使死了。 你唯一的工作就是让他能继续呼吸。 现在，他做不到了。 你不必和 %employer% 谈了，就知道他不会为此感到高兴。 | 你保证过会保护特使免于伤害。 很难说有什么伤害能超过死亡，所以看起来在这个工作上你失败的挺彻底的。 | 保护特使。确保他还活着。 特使必须活下来。 嘿，我是特使，我很重要，不能死！\n\n 这些词语肯定被充耳不闻了，因为特使确实死了。 | 当这世界想要他死时是很难保护一个人的。 很遗憾，%envoy% %envoy_title% 没能完成他的旅途。%employer% 不大可能对此人的过世感到高兴。}",
			Image = "",
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "该死的！",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "没能保护特使");
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
			"objective",
			this.m.Flags.get("DestinationName")
		]);
		_vars.push([
			"bribe",
			this.m.Flags.get("Bribe")
		]);
		_vars.push([
			"envoy",
			this.m.Flags.get("EnvoyName")
		]);
		_vars.push([
			"envoy_title",
			this.m.Flags.get("EnvoyTitle")
		]);
		_vars.push([
			"enemynoblehouse",
			this.m.Flags.get("EnemyName")
		]);
		_vars.push([
			"direction",
			this.m.Destination != null && !this.m.Destination.isNull() ? this.Const.Strings.Direction8[this.m.Home.getTile().getDirection8To(this.m.Destination.getTile())] : ""
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			this.m.Destination.getSprite("selection").Visible = false;
			this.m.Home.getSprite("selection").Visible = false;
			this.World.State.setUseGuests(true);
			this.World.getGuestRoster().clear();
		}
	}

	function onIsValid()
	{
		if (this.World.FactionManager.isCivilWar())
		{
			return false;
		}

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
			local settlements = this.World.EntityManager.getSettlements();
			local hasPotentialDestination = false;

			foreach( s in settlements )
			{
				if (!s.isDiscovered() || s.isMilitary() || s.isIsolated())
				{
					continue;
				}

				if (s.getOwner() == null || s.getOwner().getID() == this.getFaction())
				{
					continue;
				}

				hasPotentialDestination = true;
				break;
			}

			if (!hasPotentialDestination)
			{
				return false;
			}

			return true;
		}
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

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local dest = _in.readU32();

		if (dest != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(dest));
		}

		this.contract.onDeserialize(_in);
	}

});

