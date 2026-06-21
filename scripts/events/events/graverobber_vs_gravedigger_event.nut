this.graverobber_vs_gravedigger_event <- this.inherit("scripts/events/event", {
	m = {
		Graverobber = null,
		Gravedigger = null
	},
	function create()
	{
		this.m.ID = "event.graverobber_vs_gravedigger";
		this.m.Title = "在途中…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_28.png[/img]在埋葬了一位亲人之后，%gravedigger%把铲子扔进地里，抓住了%graverobber% 的衣领，把他往后一拉，同时将他举起。甚至在说话或威胁之前，挂在半空中的男人就朝他的攻击者的裆部踢了一脚。他们俩都摔倒在地，立刻开始在泥泞中滚动。泥巴使他们无法辨认，但他们的愤怒情绪可以清晰听到。\n\n扒墓人爬到了盖墓人的身上，开始往对手的脸上堆泥。%SPEECH_ON%我告诉过你了，对吧？我说过关于偷窃那些看不到你的肮脏小手的人的事，对吧？%SPEECH_OFF%凭借着一次好的摔跤经验，扒墓人将他的攻击者扔了出去，爬到了他的身上。他抓起一大把草和泥巴，塞进了盖墓人的脸里。奇怪的是，盗墓贼认为现在是为自己争取利益的时候了。%SPEECH_ON%只是他的鞋子！只是他的手套！死者不需要行走或者拿东西，让它们变成我的吧！%SPEECH_OFF% 啊，看起来掘墓人和盗墓贼在埋葬什么和不应该出土什么方面有些分歧。让他们解决问题吧——他们俩之间没有什么伤害，而且对于公司的其他人来说，这也是一种娱乐。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "别掉进坟墓里就行。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Graverobber.getImagePath());
				this.Characters.push(_event.m.Gravedigger.getImagePath());

				if (this.Math.rand(1, 100) <= 50)
				{
				}
				else
				{
					_event.m.Graverobber.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Graverobber.getName() + "遭受轻伤"
					});
				}

				_event.m.Graverobber.worsenMood(0.5, "发生斗殴和 " + _event.m.Gravedigger.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Graverobber.getMoodState()],
					text = _event.m.Graverobber.getName() + this.Const.MoodStateEvent[_event.m.Graverobber.getMoodState()]
				});

				if (this.Math.rand(1, 100) <= 50)
				{
				}
				else
				{
					_event.m.Gravedigger.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Gravedigger.getName() + "遭受轻伤"
					});
				}

				_event.m.Gravedigger.worsenMood(0.5, "发生斗殴和 " + _event.m.Graverobber.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Gravedigger.getMoodState()],
					text = _event.m.Gravedigger.getName() + this.Const.MoodStateEvent[_event.m.Gravedigger.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		local fallen = this.World.Statistics.getFallen();

		if (fallen.len() < 1 || fallen[0].Time != this.World.getTime().Days)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_graverobber = [];
		local candidates_gravedigger = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.graverobber")
			{
				candidates_graverobber.push(bro);
			}
			else if (bro.getBackground().getID() == "background.gravedigger")
			{
				candidates_gravedigger.push(bro);
			}
		}

		if (candidates_graverobber.len() == 0 || candidates_gravedigger.len() == 0)
		{
			return;
		}

		this.m.Graverobber = candidates_graverobber[this.Math.rand(0, candidates_graverobber.len() - 1)];
		this.m.Gravedigger = candidates_gravedigger[this.Math.rand(0, candidates_gravedigger.len() - 1)];
		this.m.Score = 50;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"graverobber",
			this.m.Graverobber.getName()
		]);
		_vars.push([
			"gravedigger",
			this.m.Gravedigger.getName()
		]);
	}

	function onClear()
	{
		this.m.Graverobber = null;
		this.m.Gravedigger = null;
	}

});

