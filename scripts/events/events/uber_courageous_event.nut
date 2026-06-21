this.uber_courageous_event <- this.inherit("scripts/events/event", {
	m = {
		Juggernaut = null
	},
	function create()
	{
		this.m.ID = "event.uber_courageous";
		this.m.Title = "在途中…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_50.png[/img]%juggernaut% 带着勇气的烙印一部分来自胆量，另一部分来自疯狂。 他给敌人带来的紧迫感将鼓舞人心，如果不去怀疑有理智和理性的头脑是愚蠢的。 但这就是 %companyname%，一群被剑与金钱的简单生活吸引的人。%juggernaut% 不屈不挠的天性已经在为了杀与被杀斗争的佣兵生活中消磨掉了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "如果所有的人都像他，这将是一个疯狂的世界。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Juggernaut.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Juggernaut.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 75)
					{
						bro.improveMood(0.5, "受启发于" + _event.m.Juggernaut.getName() + "的勇气");

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
			if (bro.getSkills().hasSkill("trait.fearless") && (bro.getSkills().hasSkill("trait.determined") || bro.getSkills().hasSkill("trait.deathwish")))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 1)
		{
			return;
		}

		this.m.Juggernaut = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"juggernaut",
			this.m.Juggernaut.getName()
		]);
	}

	function onClear()
	{
		this.m.Juggernaut = null;
	}

});

