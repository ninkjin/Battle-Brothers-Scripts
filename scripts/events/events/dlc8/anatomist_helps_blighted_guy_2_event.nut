this.anatomist_helps_blighted_guy_2_event <- this.inherit("scripts/events/event", {
	m = {
		MilitiaCaptain = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_helps_blighted_guy_2";
		this.m.Title = "在途中…";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_58.png[/img]{那个解剖学家从字面上把他从坟墓中救出来的那个据说生病的人向前走了过来。他看上去比以往任何时候都要好。他感谢解剖学家的工作，尽管他们几乎没有注意到他。看起来他在生病时更能引起他们的兴趣，他们可以戳戳捏捏并从他的疾病中学到更多信息，还有一些未明言的希望他真的会死，以便他们可以学到更多。看到这一切，那个人就转向你。%SPEECH_ON%这一切都让我非常感激，我希望至少你知道这一点。你不知道我与那些试图活埋我的人一起经历了什么。我认为他们明白我不是什么瘟疫，他们只是想要我的财产。你看，我曾经领导过当地的民兵，但这个位置带来了阴谋和嫉妒的压力。%SPEECH_OFF%他揉了揉后脑勺，然后说出了实话。%SPEECH_ON%那些挖掘者把我所有的东西都拿走了，所以不管我是活是死，我都可能成为后者。所以，好吧，让我说我很高兴为你而战，为我自己在这里谋求新的生活。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很高兴你感觉好些了，%militiacaptain%。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.MilitiaCaptain.getImagePath());
				local bg = this.new("scripts/skills/backgrounds/militia_background");
				bg.m.IsNew = false;
				_event.m.MilitiaCaptain.getSkills().removeByID("background.vagabond");
				_event.m.MilitiaCaptain.getSkills().add(bg);
				_event.m.MilitiaCaptain.getBackground().m.RawDescription = "你发现%name%因携带某种未知疫病而被活埋。解剖学家对他产生兴趣并将其解救，将其护理至康复。现在，他为你而战，运用曾使他成为前世的队长所拥有的技能。";
				_event.m.MilitiaCaptain.getBackground().buildDescription(true);
				_event.m.MilitiaCaptain.improveMood(1.0, "从影响他的瘟疫中恢复过来。");

				if (_event.m.MilitiaCaptain.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.MilitiaCaptain.getMoodState()],
						text = _event.m.MilitiaCaptain.getName() + this.Const.MoodStateEvent[_event.m.MilitiaCaptain.getMoodState()]
					});
				}

				_event.m.MilitiaCaptain.getBaseProperties().MeleeDefense += 4;
				_event.m.MilitiaCaptain.getBaseProperties().RangedDefense += 4;
				_event.m.MilitiaCaptain.getBaseProperties().MeleeSkill += 8;
				_event.m.MilitiaCaptain.getBaseProperties().RangedSkill += 7;
				_event.m.MilitiaCaptain.getBaseProperties().Stamina += 3;
				_event.m.MilitiaCaptain.getBaseProperties().Initiative += 6;
				_event.m.MilitiaCaptain.getBaseProperties().Bravery += 12;
				_event.m.MilitiaCaptain.getBaseProperties().Hitpoints += 5;
				_event.m.MilitiaCaptain.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_defense.png",
					text = _event.m.MilitiaCaptain.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+4[/color] 近战防御"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_defense.png",
					text = _event.m.MilitiaCaptain.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+4[/color] 远程防御"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.MilitiaCaptain.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+8[/color] 近战技能"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_skill.png",
					text = _event.m.MilitiaCaptain.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+7[/color] 远程技能"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/fatigue.png",
					text = _event.m.MilitiaCaptain.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+3[/color] 最大疲劳"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.MilitiaCaptain.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+6[/color] 主动性"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.MilitiaCaptain.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+12[/color] 决心"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/health.png",
					text = _event.m.MilitiaCaptain.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+5[/color] 生命值"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.anatomists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidate;

		foreach( bro in brothers )
		{
			if (!bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury) && !bro.getSkills().hasSkillOfType(this.Const.SkillType.SemiInjury) && bro.getDaysWithCompany() >= 5 && bro.getFlags().get("IsMilitiaCaptain"))
			{
				candidate = bro;
				break;
			}
		}

		if (candidate == null)
		{
			return;
		}

		this.m.MilitiaCaptain = candidate;
		this.m.Score = 20;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"militiacaptain",
			this.m.MilitiaCaptain.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.MilitiaCaptain = null;
	}

});

