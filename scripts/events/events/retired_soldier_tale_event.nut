this.retired_soldier_tale_event <- this.inherit("scripts/events/event", {
	m = {
		Soldier = null
	},
	function create()
	{
		this.m.ID = "event.retired_soldier_tale";
		this.m.Title = "露营时…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]%retiredsoldier% 坐在篝火旁讲述着他的战争故事。 就算他说了谎话，那也一定只是一种修辞，因为遍布他全身的每处伤疤都无声地诉说着真相。 每当听完一个故事后，人们都变得更加专注、信心百倍，准备着回到战场上去书写他们自己的故事。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "杀人放火的确是很好的睡前故事。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Soldier.getImagePath());
				_event.m.Soldier.improveMood(0.25, "讲述了他的一个战争故事");

				if (_event.m.Soldier.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Soldier.getMoodState()],
						text = _event.m.Soldier.getName() + this.Const.MoodStateEvent[_event.m.Soldier.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Soldier.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 50)
					{
						bro.improveMood(1.0, "感到振奋。" + _event.m.Soldier.getName() + "的战争故事");

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

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 3 && bro.getBackground().getID() == "background.retired_soldier")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Soldier = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"retiredsoldier",
			this.m.Soldier.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Soldier = null;
	}

});

