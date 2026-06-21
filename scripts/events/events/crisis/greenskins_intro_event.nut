this.greenskins_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.greenskins_intro";
		this.m.Title = "露营时…";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_59.png[/img]%randombrother% 进入你的帐篷。%SPEECH_ON%先生，外面有一群难民想和你谈谈。%SPEECH_OFF%你把羽毛笔放在一边去见他们。 他们简直是一团糟，看起来更像是被扔到泥里的抹布，而不是人。 一个，一个男人抱着一个曾经是他手的地方，走上前说话。%SPEECH_ON%我猜你是这里的头儿？%SPEECH_OFF%你点了点头，随后问他发生了什么，为什么会来找你。 他一边解释，一边用他剩下的一只手做着手势。%SPEECH_ON%那些绿皮开始进攻了。%SPEECH_OFF%好吧，这不是什么新鲜事。 你问他们在哪里，他们是哥布林还是兽人。 他摇起头来。%SPEECH_ON%好吧，这就是问题所在。 两者都有。他们…他们聚在一起。 他们成群结队，就像我们脚下的草叶一样多。 从某种程度上看，我说错了。 我应该说的是，他们不仅仅是在攻击，他们是在侵略。 所有的绿皮。一起。 这是一种前所未有的灾难，你还不明白吗？%SPEECH_OFF%你看着这群难民。 孩子们蜷缩在母亲的裙子下，男人们看起来很迷茫。这个人接着说。%SPEECH_ON%我父亲是一名参加过许多大战役的老兵。 他总是说他们会回来，现在我想他是对的。 据说贵族家族惊慌失措，他们可能会为了某些利益联合起来，以免我们都被入侵！ 如果你需要我的建议，我建议你不要插手。 那些成群结队的…没有什么能阻止他们。 他们做的事…%SPEECH_OFF%你抓住他的衬衫。%SPEECH_ON%他们做的事我不担心。 离开这里，农民，把战斗留给战士们去打。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "战争就要来了。",
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
	}

	function onUpdateScore()
	{
		if (this.World.Statistics.hasNews("crisis_greenskins_start"))
		{
			this.m.Score = 6000;
		}
	}

	function onPrepare()
	{
		this.World.Statistics.popNews("crisis_greenskins_start");
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

