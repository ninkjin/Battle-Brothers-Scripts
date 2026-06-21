this.minstrel_regals_refugee_event <- this.inherit("scripts/events/event", {
	m = {
		Minstrel = null,
		Refugee = null
	},
	function create()
	{
		this.m.ID = "event.minstrel_regals_refugee";
		this.m.Title = "露营时…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img] 当 %minstrel% 这个吟游诗人注意到难民时团队的人正围绕在火边，%refugee%，一个人严肃地坐着。 不一会儿，这位吟游诗人就站起来，站在树桩上，张开双臂。%SPEECH_ON%吼，%refugee% 的镇子很小，地方风俗也很奇怪，并且那里的食物，好吧，也有一点嗯重口。 但是我们必须承认！那里全部都是伟大的人！ 因为现在就有他们的亲人和我们一起并肩作战，世间渴求他的灵魂，死神在他身后虎视眈眈，但是他还是在这里和我们一起，并且我们只能祝贺－并且将他的回报！－交给他！ 这是团队给他的报酬，也是我们对兄弟最好的认可。%SPEECH_OFF%这位吟游诗人坐下来向难民道谢。 %companyname% 的人都站了起来并且欢呼，给 %refugee%的脸上带来了难得的微笑。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好哇！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Minstrel.getImagePath());
				this.Characters.push(_event.m.Refugee.getImagePath());
				_event.m.Refugee.improveMood(1.0, "被授予 " + _event.m.Minstrel.getName());

				if (_event.m.Refugee.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Refugee.getMoodState()],
						text = _event.m.Refugee.getName() + this.Const.MoodStateEvent[_event.m.Refugee.getMoodState()]
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

		local candidates_refugee = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.refugee")
			{
				candidates_refugee.push(bro);
			}
		}

		if (candidates_refugee.len() == 0)
		{
			return;
		}

		this.m.Minstrel = candidates_minstrel[this.Math.rand(0, candidates_minstrel.len() - 1)];
		this.m.Refugee = candidates_refugee[this.Math.rand(0, candidates_refugee.len() - 1)];
		this.m.Score = (candidates_minstrel.len() + candidates_refugee.len()) * 5;
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
			"refugee",
			this.m.Refugee.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Minstrel = null;
		this.m.Refugee = null;
	}

});

