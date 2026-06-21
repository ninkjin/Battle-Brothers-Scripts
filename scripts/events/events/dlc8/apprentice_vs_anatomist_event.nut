this.apprentice_vs_anatomist_event <- this.inherit("scripts/events/event", {
	m = {
		Apprentice = null,
		Anatomist = null
	},
	function create()
	{
		this.m.ID = "event.apprentice_vs_anatomist";
		this.m.Title = "露营时…";
		this.m.Cooldown = 90.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你在解剖学家%anatomist%的翅膀下找到了学徒%apprentice%。这是一个有点可怕的景象，你短暂地想到蛋头是否在策划一些邪恶的事情。但是%apprentice%只是从他那里学到了一些东西，就像他在战团里的大多数人一样。这一次，解剖学家不是知晓战争事务而学徒不知道，而是关于思考、记忆以及召回方法。你看到%anatomist%轻拍自己的脑袋。%SPEECH_ON%现在记住，最微不足道的墨水，比最不可思议的头脑更加强大。所有你所记得的，你都要写下来，但也要记住这一点：你的头脑会记得你认为自己已经忘记的事情。如果在需要的时刻，不要沉浸在你的思考中，但是让它们自己浮现，它们将会自己走向光明，而不需要帮助，但如果你去寻找它们，它们只会变得更加难以找到，希望被遗忘。%SPEECH_OFF%学徒专注地点头并记笔记。只要这些谈话不涉及动物解剖和质疑古老的神灵，你对此并没有真正的担忧。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "只是不要花太多时间在一起。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Apprentice.getImagePath());
				this.Characters.push(_event.m.Anatomist.getImagePath());
				local effect = this.new("scripts/skills/effects_world/new_trained_effect");
				effect.m.Duration = 3;
				effect.m.XPGainMult = 1.35;
				effect.m.Icon = "skills/status_effect_76.png";
				this.List.push({
					id = 10,
					icon = effect.getIcon(),
					text = _event.m.Apprentice.getName() + "获得训练经验"
				});
				_event.m.Apprentice.getSkills().add(effect);
				_event.m.Apprentice.getFlags().add("learnedFromAnatomist");
				_event.m.Apprentice.improveMood(1.0, "学习 " + _event.m.Anatomist.getName());
				_event.m.Anatomist.improveMood(0.5, "教授了" + _event.m.Apprentice.getName() + "某些东西");

				if (_event.m.Apprentice.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Apprentice.getMoodState()],
						text = _event.m.Apprentice.getName() + this.Const.MoodStateEvent[_event.m.Apprentice.getMoodState()]
					});
				}

				if (_event.m.Anatomist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local apprentice_candidates = [];
		local teacher_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.apprentice" && !bro.getFlags().has("learnedFromAnatomist") && !bro.getSkills().hasSkill("effects.trained"))
			{
				apprentice_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.anatomist")
			{
				teacher_candidates.push(bro);
			}
		}

		if (apprentice_candidates.len() == 0 || teacher_candidates.len() == 0)
		{
			return;
		}

		this.m.Apprentice = apprentice_candidates[this.Math.rand(0, apprentice_candidates.len() - 1)];
		this.m.Anatomist = teacher_candidates[this.Math.rand(0, teacher_candidates.len() - 1)];
		this.m.Score = (apprentice_candidates.len() + teacher_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"apprentice",
			this.m.Apprentice.getNameOnly()
		]);
		_vars.push([
			"anatomist",
			this.m.Anatomist.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Apprentice = null;
		this.m.Anatomist = null;
	}

});

