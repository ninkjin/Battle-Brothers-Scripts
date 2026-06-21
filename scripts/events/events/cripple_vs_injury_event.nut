this.cripple_vs_injury_event <- this.inherit("scripts/events/event", {
	m = {
		Cripple = null,
		Injured = null
	},
	function create()
	{
		this.m.ID = "event.cripple_vs_injury";
		this.m.Title = "露营时…";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]最近的战斗在 %injured% 身上留下了可怕而的永久性损伤。 当他闷闷不乐地坐在营火旁时，%cripple% 坐到他的身旁。%SPEECH_ON%原来你坐在这里，为一些无关紧要的事而烦恼。 看着我。就看看我！ 看看我在哪里！ 我失去了那些无法挽回的东西，但我是否曾深陷其中？ 不。我挺过去了。 我加入了 %companyname%。因为那些，那些旧伤已经过去了。我就说这些…%SPEECH_OFF%瘸子轻轻敲着他的头。%SPEECH_ON%这里所说的一切都是可以重头再来的。 在这里你会想，是的，那确实发生了，但我还是一个男人，我还在这里。 如果这个世界想要我死，它就必须带走给予我的一切，因为我不会放弃直到最后一个我消失！%SPEECH_OFF%%injured% 点头，似乎他的情绪好了很多。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很好地鼓舞了那个人。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cripple.getImagePath());
				this.Characters.push(_event.m.Injured.getImagePath());
				_event.m.Injured.improveMood(1.0, "精神振奋，来自 " + _event.m.Cripple.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Injured.getMoodState()],
					text = _event.m.Injured.getName() + this.Const.MoodStateEvent[_event.m.Injured.getMoodState()]
				});
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

		local cripple_candidates = [];
		local injured_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.cripple")
			{
				cripple_candidates.push(bro);
			}
			else if (bro.getSkills().hasSkillOfType(this.Const.SkillType.PermanentInjury))
			{
				foreach( n in bro.getMoodChanges() )
				{
					if (n.Text == "Suffered a permanent injury")
					{
						injured_candidates.push(bro);
						break;
					}
				}
			}
		}

		if (cripple_candidates.len() == 0 || injured_candidates.len() == 0)
		{
			return;
		}

		this.m.Cripple = cripple_candidates[this.Math.rand(0, cripple_candidates.len() - 1)];
		this.m.Injured = injured_candidates[this.Math.rand(0, injured_candidates.len() - 1)];
		this.m.Score = (cripple_candidates.len() + injured_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cripple",
			this.m.Cripple.getNameOnly()
		]);
		_vars.push([
			"injured",
			this.m.Injured.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Cripple = null;
		this.m.Injured = null;
	}

});

