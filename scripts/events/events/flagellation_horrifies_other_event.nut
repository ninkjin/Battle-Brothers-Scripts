this.flagellation_horrifies_other_event <- this.inherit("scripts/events/event", {
	m = {
		Flagellant = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.flagellation_horrifies_other";
		this.m.Title = "露营时…";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_38.png[/img]皮开肉绽。人类身体的某些部分显得很难理解。 空气中弥漫着血腥味。 当你的兄弟召唤你时，你发现这些事情。\n\n %flagellant% 这个苦修者俯身在一根树桩上，全身一动不动，只剩下一只胳膊拿着酒杯和带刺的鞭子抽打自己的背。 一个含着口水的打嗝声把你的眼睛吸引到 %weakbro% 身上，他正在高高的草丛中弯腰，把午餐吐出来了。 当意识到他在打扰别人时，%flagellant% 露出一丝微笑，笑得一点也不像他自己隐藏的那样恐怖。%SPEECH_ON%恐惧不是死神，%weakbro%，我将流更多的血来拯救你的灵魂。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{一个奇怪的风俗。 | 这样可能不健康。}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Flagellant.getImagePath());
				this.Characters.push(_event.m.OtherGuy.getImagePath());
				_event.m.OtherGuy.worsenMood(1.0, "震惊于" + _event.m.Flagellant.getName() + "的鞭笞");

				if (_event.m.OtherGuy.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.OtherGuy.getMoodState()],
						text = _event.m.OtherGuy.getName() + this.Const.MoodStateEvent[_event.m.OtherGuy.getMoodState()]
					});
				}

				_event.m.Flagellant.improveMood(1.0, "对他的鞭打感到满意");

				if (_event.m.Flagellant.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Flagellant.getMoodState()],
						text = _event.m.Flagellant.getName() + this.Const.MoodStateEvent[_event.m.Flagellant.getMoodState()]
					});
				}

				if (this.Math.rand(1, 100) <= 50)
				{
					local injury = _event.m.Flagellant.addInjury(this.Const.Injury.Flagellation);
					this.List.push({
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Flagellant.getName() + " 遭受 " + injury.getNameOnly()
					});
				}
				else
				{
					_event.m.Flagellant.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Flagellant.getName() + "遭受轻伤"
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidate_flagellant = [];

		foreach( bro in brothers )
		{
			if ((bro.getBackground().getID() == "background.flagellant" || bro.getBackground().getID() == "background.monk_turned_flagellant") && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				candidate_flagellant.push(bro);
			}
		}

		if (candidate_flagellant.len() == 0)
		{
			return;
		}

		local candidate_other = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() != "background.flagellant" && bro.getBackground().getID() != "background.monk_turned_flagellant" && (bro.getBackground().isOffendedByViolence() || bro.getSkills().hasSkill("trait.fainthearted")))
			{
				candidate_other.push(bro);
			}
		}

		if (candidate_other.len() == 0)
		{
			return;
		}

		this.m.Flagellant = candidate_flagellant[this.Math.rand(0, candidate_flagellant.len() - 1)];
		this.m.OtherGuy = candidate_other[this.Math.rand(0, candidate_other.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"flagellant",
			this.m.Flagellant.getNameOnly()
		]);
		_vars.push([
			"weakbro",
			this.m.OtherGuy.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Flagellant = null;
		this.m.OtherGuy = null;
	}

});

