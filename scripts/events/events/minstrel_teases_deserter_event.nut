this.minstrel_teases_deserter_event <- this.inherit("scripts/events/event", {
	m = {
		Minstrel = null,
		Deserter = null
	},
	function create()
	{
		this.m.ID = "event.minstrel_teases_deserter";
		this.m.Title = "露营时…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img] 当营火劈啪作响的时候，%minstrel% 这个吟游诗人站了起来并且站在高高的树桩上。 他捶了一下自己的胸口并且指着 %deserter%。%SPEECH_ON%哟，没错逃兵总是在如何逃跑上面下了很大的功夫，所以总是在被打之前逃脱！ 逃兵！噢，要记住一件事情逃兵！ 逃兵永远都是逃兵！ 遗留在过去的勇气，已经被玷污了的荣耀，还有被抹杀掉的气概！这就是逃兵！%SPEECH_OFF%吟游诗人迅速地拍了拍手又坐回座位上。 吟游诗人还没坐下多久 %deserter%的手就掐住了他的脖子。 成员们一片哗然，不知道应该分开两人还是在旁边幸灾乐祸。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一个本不应该出现的奇景！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Minstrel.getImagePath());
				this.Characters.push(_event.m.Deserter.getImagePath());
				_event.m.Deserter.worsenMood(2.0, "在战队面前感到丢脸");

				if (_event.m.Deserter.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Deserter.getMoodState()],
						text = _event.m.Deserter.getName() + this.Const.MoodStateEvent[_event.m.Deserter.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates_minstrel = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.minstrel")
			{
				candidates_minstrel.push(bro);
			}
		}

		if (candidates_minstrel.len() == 0)
		{
			return;
		}

		local candidates_deserter = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.deserter")
			{
				candidates_deserter.push(bro);
			}
		}

		if (candidates_deserter.len() == 0)
		{
			return;
		}

		this.m.Minstrel = candidates_minstrel[this.Math.rand(0, candidates_minstrel.len() - 1)];
		this.m.Deserter = candidates_deserter[this.Math.rand(0, candidates_deserter.len() - 1)];
		this.m.Score = (candidates_minstrel.len() + candidates_deserter.len()) * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"minstrel",
			this.m.Minstrel.getNameOnly()
		]);
		_vars.push([
			"deserter",
			this.m.Deserter.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Minstrel = null;
		this.m.Deserter = null;
	}

});

