this.shortsighted_shoots_bro_event <- this.inherit("scripts/events/event", {
	m = {
		Shortsighted = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.shortsighted_shoots_bro";
		this.m.Title = "露营时…";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_10.png[/img] 你仔细地长时间地看了这些人一眼，目光从一个人移到另一个人，然后又移回来，同时不停地摇头。%shortsightedtarget% 起头，发际处有一个很大的肿块。 他看着 %shortsighted%，然后看向你。两人耸肩。 你问 %shortsighted% 发生什么事。他解释说。%SPEECH_ON%我以为我看到了什么东西，它不在那里。%SPEECH_OFF%令人难以置信的是，%shortsightedtarget% 竟然伸出手来。%SPEECH_ON%我说了，“嘿，是我”，你还是打了我。%SPEECH_OFF%伸出自己的手，%shortsighted% 保护自己。%SPEECH_ON%嘿，这是我的声音，不是你的言语！ 任何人都能说出这些话！ 我想，凡是存心不良的人，在拿着剑跟在他们后面走之前，一定会把这些话都说出来的，我敢打赌，他一定会的！%SPEECH_OFF%看来是 %shortsighted%的视力不良导致了某种事故。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "检查一下你的伤，%shortsightedtargetshort%。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Shortsighted.getImagePath());
				this.Characters.push(_event.m.OtherGuy.getImagePath());
				local injury = _event.m.OtherGuy.addInjury(this.Const.Injury.PiercingBody, 0.4);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.OtherGuy.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Shortsighted.worsenMood(1.0, "枪击" + _event.m.OtherGuy.getName() + "意外地");
				_event.m.OtherGuy.worsenMood(1.0, "被射中于 " + _event.m.Shortsighted.getName());

				if (_event.m.OtherGuy.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.OtherGuy.getMoodState()],
						text = _event.m.OtherGuy.getName() + this.Const.MoodStateEvent[_event.m.OtherGuy.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates_shortsighted = [];

		foreach( bro in brothers )
		{
			if (!bro.getBackground().isNoble() && bro.getSkills().hasSkill("trait.short_sighted") && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				candidates_shortsighted.push(bro);
			}
		}

		if (candidates_shortsighted.len() == 0)
		{
			return;
		}

		this.m.Shortsighted = candidates_shortsighted[this.Math.rand(0, candidates_shortsighted.len() - 1)];
		this.m.Score = candidates_shortsighted.len() * 5;

		foreach( bro in brothers )
		{
			if (bro.getID() != this.m.Shortsighted.getID() && bro.getBackground().getID() != "background.slave")
			{
				this.m.OtherGuy = bro;
				break;
			}
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"shortsighted",
			this.m.Shortsighted.getName()
		]);
		_vars.push([
			"shortsightedtarget",
			this.m.OtherGuy.getName()
		]);
		_vars.push([
			"shortsightedtargetshort",
			this.m.OtherGuy.getNameOnly()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Shortsighted = null;
		this.m.OtherGuy = null;
	}

});

