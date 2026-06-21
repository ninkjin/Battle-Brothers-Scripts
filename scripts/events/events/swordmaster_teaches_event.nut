this.swordmaster_teaches_event <- this.inherit("scripts/events/event", {
	m = {
		Student = null,
		Teacher = null
	},
	function create()
	{
		this.m.ID = "event.swordmaster_teaches";
		this.m.Title = "露营时…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_17.png[/img]一位老人的声音静静地发布命令。%SPEECH_ON%脚步为先，身体跟上。再说一遍。%SPEECH_OFF%你发现 %swordmaster% 这个剑术大师和 %swordstudent% 正在旷野中练习。 这个长者正在为最近看到的剑法摇头。%SPEECH_ON%脚步为先，身体跟上。再说一遍！%SPEECH_OFF%这个学生正在练习他所学的东西。 剑术大师点了点头，又吼着下命令。%SPEECH_ON%现在，反过来做。 脚步后退，身体跟上。 不要总想着后退。 让你的脚步跟上你的想法。 果敢才能生存！犹豫就会败北！ 像适者生存要求的那样行动。 如果一阵风吹向你，是不是要快过你听到树叶的声音？ 我看到了。很好…你正在学。现在…再来一次。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "现在好好利用它。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Teacher.getImagePath());
				this.Characters.push(_event.m.Student.getImagePath());
				local meleeDefense = this.Math.rand(1, 4);
				_event.m.Student.getBaseProperties().MeleeDefense += meleeDefense;
				_event.m.Student.getSkills().update();
				_event.m.Student.getFlags().add("taughtBySwordmaster");
				_event.m.Student.improveMood(0.5, "学习 " + _event.m.Teacher.getName());
				_event.m.Teacher.improveMood(1.0, "教授了" + _event.m.Student.getName() + "某些东西");
				this.List = [
					{
						id = 17,
						icon = "ui/icons/melee_defense.png",
						text = _event.m.Student.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + meleeDefense + "[/color] 近战防御"
					}
				];

				if (_event.m.Teacher.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Teacher.getMoodState()],
						text = _event.m.Teacher.getName() + this.Const.MoodStateEvent[_event.m.Teacher.getMoodState()]
					});
				}

				if (_event.m.Student.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Student.getMoodState()],
						text = _event.m.Student.getName() + this.Const.MoodStateEvent[_event.m.Student.getMoodState()]
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

		local teacher_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 4 && (bro.getBackground().getID() == "background.swordmaster" || bro.getBackground().getID() == "background.old_swordmaster"))
			{
				teacher_candidates.push(bro);
			}
		}

		if (teacher_candidates.len() < 1)
		{
			return;
		}

		local student_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 3 && !bro.getFlags().has("taughtBySwordmaster") && (bro.getBackground().getID() == "background.squire" || bro.getBackground().getID() == "background.bastard" || bro.getBackground().getID() == "background.adventurous_noble" || bro.getBackground().getID() == "background.disowned_noble" || bro.getBackground().getID() == "background.regent_in_absentia"))
			{
				student_candidates.push(bro);
			}
		}

		if (student_candidates.len() < 1)
		{
			return;
		}

		this.m.Student = student_candidates[this.Math.rand(0, student_candidates.len() - 1)];
		this.m.Teacher = teacher_candidates[this.Math.rand(0, teacher_candidates.len() - 1)];
		this.m.Score = teacher_candidates.len() * 4;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"swordstudent",
			this.m.Student.getName()
		]);
		_vars.push([
			"swordmaster",
			this.m.Teacher.getNameOnly()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Student = null;
		this.m.Teacher = null;
	}

});

