this.witchhut_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.witchhut_enter";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_115.png[/img]{你停在森林空地上。面前的小屋像个脆弱的面包屑一样。它如此古朴和容易被遗忘，你想知道它是如何存活下来的，但也许它完全平凡和不引人注目的本质是一种自我保护。但你在这个世界上已经待了足够长的时间，知道要相信自己的直觉，现在你的直觉是等待。\n\n很快，小屋的门开了，一个年迈的妇女走了出来。她立刻向你挥手。%SPEECH_ON%就是你，只有你。%SPEECH_OFF%你很困惑，问她为什么只有你，或者更确切地说，你为什么要相信她。她微笑着。%SPEECH_ON%因为我知道伪王晚上梦到了什么。%SPEECH_OFF%你身边的雇佣兵转过身来问她说了什么。你举起一只手告诉他们待在原地，而你自己去和这位神秘的妇女谈谈。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "呆在这里注意防御。",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_115.png[/img]{你持剑走进来，却看到一个女人给你递上一碗炖煮。她建议里面只有兔肉和土豆，而兔肉比土豆更多。你把剑收起来，拿起碗，坐在桌子旁边，对面是她。几支蜡烛在附近燃烧，墙上涂着白色的符号，天花板上挂着类似于网兜的东西。女人的手肘架在桌子上。她的头发里缠着小饰品，有鸟骨和羽毛。她的脸上满是岁月的痕迹，但双眼却闪着年轻的光芒，像大沼泽的珍珠一样。%SPEECH_ON%我知道你会来的，一个幽灵般的朋友，像飞蛾扑向火燃一般，寻找不能被驾驭的真相。%SPEECH_OFF%将碗推回桌子，你问她是不是女巫。她肯定地点了点头，盯着你看，然后又点了点头。%SPEECH_ON%很好，你还没有杀了我，这意味着你正思考。我确实是所谓的女巫，但我是孤独的。完全孤独。而且被别人追捕。你可以叫她们我的“姐妹们”，但这些人和我一样都知道你是谁，他们想要你的血。他们能闻到它的气息，这就是为什么我要和你谈谈的原因。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你想要什么？",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_115.png[/img]{一位女子取出一件长长的东西，用桌布裹起来，然后将其放在桌子上。她掀开布来，露出一把用皮革绑结的锯齿形黑曜石刀片。%SPEECH_ON%切开你的肉，让血染上黑色。巫婆及其卑微的手艺都将前来，然后你将杀死他们。之后，我们可以谈论。佣兵与女巫，女巫与佣兵。%SPEECH_OFF%你问她对你有什么好处。巫婆咯咯地笑了起来。%SPEECH_ON%哦，佣兵，你不是在效忠谁，而是在追求金钱。一个聪明的做法就能让朋友变成敌人。但我能给你更多。一份看不见的真相，一份为虚假王者而设的真相。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们已经付出了这么多。",
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
			ID = "D",
			Text = "[img]gfx/ui/events/event_115.png[/img]{黑色的刀锋放在你的手中，你的倒影被拉伸到每个凹陷和边缘的石头凹槽中，显得扭曲不堪。这是一块简单的石头。一把简单的匕首。仅此而已。虽然不重，但你可以感受到它的分量，就像往坟墓上撒下的尘土，沙子中的重量不仅仅在于沙子本身。这把刀锋可能是胜利或是失败，只有一种方法让你知道结果。女巫点头示意，你也点头并在自己的上臂上划了一道口子。鲜血汇聚到石头上，你的倒影被鲜红的液体覆盖。女巫兴奋地凑近你，恶狠狠地压住刀锋，嘴里咆哮着%SPEECH_ON%再来。再来，佣兵。再来！%SPEECH_OFF%你再次挥刀，并用力收紧肌肉，血液喷溅到石头上。她接过刀子，在伤口上贴上一块干净的布%SPEECH_ON%不错，卖剑客。回去准备吧。%SPEECH_OFF%你站起来看着女人，问道%SPEECH_ON%一旦我杀死你的敌人，我们再谈？%SPEECH_OFF%她微笑着%SPEECH_ON%一语成谶，没错。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那么我将会这么做。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_115.png[/img]{当你走出去告诉战团有敌人来袭时，不久，这些疲惫不堪的女人被发现正在森林的树林之间行走，她们长长的指甲划破了树皮，口水直流的双唇嘶哑着咯咯傻笑。第一个穿过来的女巫有一个狭长的头，形状像一只独木舟。一个婴儿的头骨挂在她的项链上，皮革袋在她的臀部晃动，两只兔脚从袋子里伸出来。她盯着小屋，嗅着空气，然后把目光转向你。%SPEECH_ON%啊，你和那个婊子达成了协定？%SPEECH_OFF%你点点头。%SPEECH_ON%协定已经达成了，没错，最后你会死在这柄剑的下面。我相信她更喜欢被称作女巫。%SPEECH_OFF%另一位女巫走了出来。%SPEECH_ON%我们更喜欢叫她贱货。杀了那些雇佣兵。把队长活捉，但要拿掉他的眼睛和那张贱嘴。%SPEECH_OFF%一片女巫汇聚而来，有些已经变成了风骚的少女，而其他人则在进行着仪式的转动。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "战斗！",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setAttackable(true);
						}

						this.World.State.getLastLocation().setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
						this.World.Events.showCombatDialog(true, true, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
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
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
	}

});

