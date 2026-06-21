this.lose_fear_greenskins_event <- this.inherit("scripts/events/event", {
	m = {
		Casualty = null
	},
	function create()
	{
		this.m.ID = "event.lose_fear_greenskins";
		this.m.Title = "露营时…";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{%fearful%盯着篝火喃喃自语，这是一个令人担忧的景象，但几乎就在这样的想法出现的同时他开口了。%SPEECH_ON%你知道吗？那些绿皮根本什么都不是。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "如果它流血了，我们可以杀了它。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Casualty.getImagePath());
				local trait = _event.m.Casualty.getSkills().getSkillByID("trait.fear_greenskins");
				this.List.push({
					id = 10,
					icon = trait.getIcon(),
					text = _event.m.Casualty.getName() + "不再害怕绿皮"
				});
				_event.m.Casualty.getSkills().remove(trait);
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getID() && this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getID())
		{
			return;
		}

		if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() > this.World.getTime().SecondsPerDay * 1.0)
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
			if (!bro.getSkills().hasSkill("trait.fear_greenskins") || bro.getLifetimeStats().Battles < 25 || bro.getLifetimeStats().Kills < 50 || bro.getLifetimeStats().BattlesWithoutMe != 0)
			{
				continue;
			}

			candidates.push(bro);
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Casualty = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = this.m.Casualty.getLifetimeStats().Kills / 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"fearful",
			this.m.Casualty.getName()
		]);
	}

	function onClear()
	{
		this.m.Casualty = null;
	}

});

