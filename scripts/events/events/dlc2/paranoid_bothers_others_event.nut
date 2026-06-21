this.paranoid_bothers_others_event <- this.inherit("scripts/events/event", {
	m = {
		Paranoid = null
	},
	function create()
	{
		this.m.ID = "event.paranoid_bothers_others";
		this.m.Title = "露营时…";
		this.m.Cooldown = 35.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img]{你听到了一阵喧闹的声音，走过去看到%paranoid%正挥舞着武器对着其他雇佣兵。%SPEECH_ON%我知道你是谁，也知道你不是我的朋友！%SPEECH_OFF% %randombrother%看着他耸了耸肩：%SPEECH_ON%我从来没有说过你是我的朋友。%SPEECH_OFF%这个偏执的雇佣兵还在继续大喊大叫，要求所有人远离他，否则他会伤害他们。你设法让他冷静下来，主要是解释了他的日薪以及没有工作他将如何艰难度日。但这毫无疑问只是一个短期的解决方案。 | 你发现%paranoid%越来越多疑地独自一人蹲坐着，双手搂在膝盖上。尽管姿势很像是儿童，但他的眼神却很坚定，对周围的一切保持着谨慎的观察。当你问他怎么样时，他只是笑了笑。%SPEECH_ON%我不知道，先生，只是被一群只为赚钱的混蛋包围着，他们会在合适的时候捅我一刀。%SPEECH_OFF%从某种角度来说，您理解他的心情，但您希望这种情绪不会传染给战团中其他的雇员。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "别那么多疑了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Paranoid.getImagePath());
				_event.m.Paranoid.worsenMood(0.5, "猜疑他的战友们");

				if (_event.m.Paranoid.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Paranoid.getMoodState()],
						text = _event.m.Paranoid.getName() + this.Const.MoodStateEvent[_event.m.Paranoid.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
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
			if (bro.getSkills().hasSkill("trait.paranoid"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 1)
		{
			return;
		}

		this.m.Paranoid = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"paranoid",
			this.m.Paranoid.getName()
		]);
	}

	function onClear()
	{
		this.m.Paranoid = null;
	}

});

