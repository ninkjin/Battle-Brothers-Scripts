this.butcher_gives_pointers_event <- this.inherit("scripts/events/event", {
	m = {
		Butcher = null,
		Flagellant = null
	},
	function create()
	{
		this.m.ID = "event.pointers_from_butcher";
		this.m.Title = "露营时…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_38.png[/img]你发现 %butcher% 这个屠夫在 %flagellant% 裸露的后背上用手指划着什么。 他在肌肉和伤疤之间找到一个点，然后轻敲它。%SPEECH_ON%Here. If you strike yourself here, the largest amount of meat - I mean muscle, will be hit.%SPEECH_OFF%苦修者抬起头。%SPEECH_ON%那会痛么？%SPEECH_OFF%屠夫的脸上露出了笑容。%SPEECH_ON%噢，是的，非常爽。%SPEECH_OFF%似乎这个家伙在给苦修者指点，如何放飞自我。 在你能插话之前，%flagellant% 拿起鞭子，打在 %butcher% 之前指给他的地方。 皮革，纤维和嶙峋的骨头在他背上劈啪作响，抽到肉里去了，然后他皮开肉绽了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你他妈为啥给他展示这个？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Butcher.getImagePath());
				this.Characters.push(_event.m.Flagellant.getImagePath());
				_event.m.Flagellant.getFlags().add("pointers_from_butcher");
				_event.m.Flagellant.getBaseProperties().MeleeSkill += 2;
				_event.m.Flagellant.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.Flagellant.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] 近战技能"
				});
				local injury = _event.m.Flagellant.addInjury(this.Const.Injury.Flagellation);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Flagellant.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Butcher.improveMood(2.0, "从别人的痛苦中得到快乐");

				if (_event.m.Butcher.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Butcher.getMoodState()],
						text = _event.m.Butcher.getName() + this.Const.MoodStateEvent[_event.m.Butcher.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_butcher = [];
		local candidates_flagellant = [];

		foreach( bro in brothers )
		{
			if (bro.getFlags().has("pointers_from_butcher"))
			{
				continue;
			}

			if (bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.butcher")
			{
				candidates_butcher.push(bro);
			}
			else if (bro.getBackground().getID() == "background.flagellant" || bro.getBackground().getID() == "background.monk_turned_flagellant")
			{
				candidates_flagellant.push(bro);
			}
		}

		if (candidates_butcher.len() == 0 || candidates_flagellant.len() == 0)
		{
			return;
		}

		this.m.Butcher = candidates_butcher[this.Math.rand(0, candidates_butcher.len() - 1)];
		this.m.Flagellant = candidates_flagellant[this.Math.rand(0, candidates_flagellant.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"butcher",
			this.m.Butcher.getNameOnly()
		]);
		_vars.push([
			"flagellant",
			this.m.Flagellant.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Butcher = null;
		this.m.Flagellant = null;
	}

});

