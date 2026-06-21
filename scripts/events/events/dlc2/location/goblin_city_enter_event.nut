this.goblin_city_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.goblin_city_enter";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_119.png[/img]{%randombrother%摇了摇头。%SPEECH_ON%愿古老的神明怜悯我们，允许这样的景象出现。%SPEECH_OFF%哥布林城市被隔离在对峙的山脉之间。说哥布林在山脉周围建城就像是说一个士兵将剑鞘插在敌人的胸膛里一样。这些叽叽喳喳的绿皮族并没有为这片土地增色添彩，相反却亵渎了这里，砍伐原有的树木以建矿井，修建锈迹斑斑的棚户和临时屋舍，竖立邪教图腾并挖掘起始祭坑，不顾一切地堆积未使用的木材，仿佛山脉的残缺已经没有达到最极端，需要毫不掩饰地浪费。\n\n但是在哥布林废墟之外，还有一座城市中央的核心，几座塔楼鲜明地脱颖而出，与其他废物区隔开来。这里显然是古代的征战据点，那里的建筑石雕不同于你所见过的任何建筑，肯定也不在绿皮族能力之内。在城墙上徘徊的哥布林站得笔直，显得非常自豪，仿佛走进了这样神圣的地方。堡垒内还有一些似乎高贵的住户，穿着讲究的哥布林闲逛着，意味着与人类一样：掠夺是有好处的。\n\n罕见的是奔跑的幼小生命。如果那真是绿皮族的家庭，那么这里的战斗将是残酷的。这些小虫子不仅仅要保卫他们的狂野和贪婪，同时也要保卫超越自身恶行的部分，而那将使他们变得更加脆弱。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "有什么计划吗？",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "让我们现在离开吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("IsGoblinCityVisited", true);

				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().setVisited(false);
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_119.png[/img]{观察了城市一段时间后，你知道不能直接攻打它。术数太多，加上已经站在他们那边的数量更是如此，甚至可能会有地精家族的人加入屠杀，最终你只能将全城归为自己的经验。所以你选择等待和思考。然后那个人走过来了。\n\n他穿着轻便的盔甲，带着一顶迷彩罩兜盔，内里藏着金属，一堆刀从他的腰上咔嗒咔嗒地摆动着，一枝长矛顶在他的背上，一把斧头顶在另一侧，一条药带不断地地沉了下去。你看不到他的脸，更看不到他的眼睛，他浑身满是鲜血。%SPEECH_ON%尽管他们行为残暴，样貌也很凶残，但地精从某种意义上来说，是一个文明的集团。他们会对基于无意义暴行的暴力做出反应。如果你希望引出他们，那么你必须像兽人一样行事。我的计划是尽可能多地屠杀那些在田野，侦察队，哨兵等方面发现的敌人，但他们的营地被摧毁也同样好。为了震慑他们的恐惧，我们会用两个屠杀合成一枚千钧之钉，因为他们最害怕的是那些不顾一切的兽人，并会试图抢先将它们消灭掉。%SPEECH_OFF%那个人点了点头，好像你已经同意了某些事情一样。%SPEECH_ON%所以，旅行者，你可以选择你想让这个城市被摧毁的方式。是屠杀他们的侵略队伍和侦察兵，还是烧毁他们前线的据点？无论你做什么，我都会做另一个，独自一人行动，我们将在这里相遇，当我们的行动摆在显眼的地方时。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们要杀掉他们的侦察兵和掠夺队伍。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "我们会担任前锋。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_119.png[/img]{你告诉他%companyname%会屠杀在田野中的哥布林。他点了点头。%SPEECH_ON%啊，旅行者，这是个好选择。这些团的失踪将会给绿皮兽带来一定的压力。他们天生是侦察兵和掠夺者，因此当那些以他们为代表的人失踪，他们就会感到内心不安。前沿哨站将会撤退并传播谣言，然后一支远征部队就会出场。当你在田野中击败他们的时候，我会去破坏他们的大部队。根据我的经验，你需要消灭至少%goblinkillcount%个团，那样就足够了。%SPEECH_OFF%他走了，但是你大声问他是谁，或许一起合作会是个更好的想法。他完全忽视了你，走了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们会在 %goblinkillcount% 哥布林队伍被消灭之后返回。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("IsGoblinCityScouts", true);
				this.World.Flags.set("GoblinCityCount", 0);
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_119.png[/img]{你告诉陌生人%companyname%将追击摧毁营地，他点头赞许。%SPEECH_ON%很好，旅行者，太好了！哥布林经常派遣袭击队，当他们看到被彻底摧毁时，便会回来，传播毁灭的消息，并被带出来。很好。我们有一个计划，根据我的经验，你只需要走下去找到%goblinpostcount%个营地。你拿下他们的哨所，我拿下他们的队伍。%SPEECH_OFF%他向前走去，但你喊道询问他是谁，或者也许一起行动会更好。他完全无视你，走开了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们会在五个前哨点被清除之后返回。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("IsGoblinCityOutposts", true);
				this.World.Flags.set("GoblinCityCount", 0);
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_119.png[/img]{你回到了城市，但你之前遇见的陌生人已经不见了。不过，你看到了一支庞大的哥布林军队正在他们的城市中行进。他们脚步一致，发出尖锐的嘈杂声。他们的领袖骑在驯服的狼背上，手握着战旗，好像准备起航。城门口站着哥布林家庭，他们手里拿着骨头朝前方的行军队伍投掷。有时候你会看到一条狗或者一个人的身体被抛下去，哥布林们把它们像奖杯一样高高举起，周围的队伍欢呼着。整支军队经过需要一个小时的时间，城门口的哥布林们也逐渐散去，留下了一些守卫。\n\n虽然剩下的人仍然足够进行艰苦的战斗，但是却不够对付%companyname%。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "准备进攻。",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setAttackable(true);
							this.World.State.getLastLocation().m.IsShowingDefenders = true;
						}

						this.World.Events.showCombatDialog(true, true, true);
						return 0;
					}

				},
				{
					Text = "暂时撤退。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_119.png[/img]{哥布林城仍受大量绿皮卫兵的保护。你记得%companyname%需要摧毁几个巡逻和侦查小队，才能将军队引开城市。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们会在 %goblinkillcount% 哥布林队伍被消灭之后返回。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().setVisited(false);
				}
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_119.png[/img]{哥布林城仍然由一群小绿皮护卫。你记得%companyname%还需要摧毁几个他们的营地和前哨站，以将军队引开城市。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们会在 %goblinpostcount% 前哨点被清除之后返回。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().setVisited(false);
				}
			}

		});
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"goblinkillcount",
			"10"
		]);
		_vars.push([
			"goblinpostcount",
			"5"
		]);
	}

	function onDetermineStartScreen()
	{
		if (!this.World.Flags.get("IsGoblinCityVisited"))
		{
			return "A";
		}
		else if (this.World.Flags.get("IsGoblinCityOutposts") && this.World.Flags.get("GoblinCityCount") >= 5 || this.World.Flags.get("IsGoblinCityScouts") && this.World.Flags.get("GoblinCityCount") >= 10)
		{
			return "E";
		}
		else if (this.World.Flags.get("IsGoblinCityScouts"))
		{
			return "F";
		}
		else if (this.World.Flags.get("IsGoblinCityOutposts"))
		{
			return "G";
		}
		else
		{
			return "A";
		}
	}

	function onClear()
	{
	}

});

