this.fainthearted_is_shellshocked_event <- this.inherit("scripts/events/event", {
	m = {
		Rookie = null
	},
	function create()
	{
		this.m.ID = "event.fainthearted_is_shellshocked";
		this.m.Title = "露营时…";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_12.png[/img]你发现 %fainthearted% 在营火前踟躇。 他的脸上有几点已经干了的血迹，他的手在颤抖。 有几个队员试着和他说话，但没有一个人能奏效。 最近一场残酷战斗让这个懦弱的人感到恐慌。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让他自己待会儿。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Rookie.getImagePath());
				_event.m.Rookie.worsenMood(1.5, "对战争的恐怖感到震惊");

				if (_event.m.Rookie.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Rookie.getMoodState()],
						text = _event.m.Rookie.getName() + this.Const.MoodStateEvent[_event.m.Rookie.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local fallen = this.World.Statistics.getFallen();

		if (fallen.len() < 2)
		{
			return;
		}

		if (this.World.getTime().Days - fallen[0].Time > 1 || this.World.getTime().Days - fallen[1].Time > 1)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 4 && bro.getSkills().hasSkill("trait.fainthearted") && bro.getPlaceInFormation() <= 17 && bro.getLifetimeStats().Battles >= 1)
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 1)
		{
			return;
		}

		this.m.Rookie = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"fainthearted",
			this.m.Rookie.getName()
		]);
	}

	function onClear()
	{
		this.m.Rookie = null;
	}

});

