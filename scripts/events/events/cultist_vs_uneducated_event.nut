this.cultist_vs_uneducated_event <- this.inherit("scripts/events/event", {
	m = {
		Cultist = null,
		Uneducated = null
	},
	function create()
	{
		this.m.ID = "event.cultist_vs_uneducated";
		this.m.Title = "露营时…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]有几个兄弟来找你，看上去很着急。 他们说 %cultist% 和 %uneducated% 坐在一起已经几个小时了。 当你问他们担心什么时，他们会提醒你，那个额头有伤疤的异教徒，说着令人难以置信的怪事。 Ah, right.\n\n你去看看那两个人。%uneducated% 抬头看着你，微笑着，说这个异教徒有很多东西要教他。 做了个鬼脸，你不知道你是否应该停止这些…课程。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "做你想做的，只要你没有忘记我雇你是干什么的就行。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "停止这种无意义的行为。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
				this.Characters.push(_event.m.Uneducated.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]你点头，转身走开了。 其余的兄弟们摇着头。 第二天早上，%uneducated% 被发现在他的额头上有一个新伤口，血液结了痂。 你问他感觉如何，他只说了几句话。%SPEECH_ON%达库尔就要来了。%SPEECH_OFF%好吧，太好了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "按你自己的意愿行事。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
				this.Characters.push(_event.m.Uneducated.getImagePath());
				local background = this.new("scripts/skills/backgrounds/converted_cultist_background");
				_event.m.Uneducated.getSkills().removeByID(_event.m.Uneducated.getBackground().getID());
				_event.m.Uneducated.getSkills().add(background);
				background.buildDescription();
				background.onSetAppearance();
				this.List = [
					{
						id = 13,
						icon = background.getIcon(),
						text = _event.m.Uneducated.getName() + "已经转化成了异教徒"
					}
				];
				_event.m.Cultist.getBaseProperties().Bravery += 2;
				_event.m.Cultist.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Cultist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] 决心"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]你把这两个人分开，让 %uneducated% 去清点一些存货。 当他离开时，异教徒对你冷笑。%SPEECH_ON%达库尔即将降临。你在梦中看到他了。 你在夜晚看到他了。 他的黑暗就要来了。 没有永远燃烧的光明。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "是啊，很好，在那之前你得为我工作。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
				this.Characters.push(_event.m.Uneducated.getImagePath());
				_event.m.Cultist.worsenMood(2.0, "被剥夺了转化的机会，准备转化的是 " + _event.m.Uneducated.getName());

				if (_event.m.Cultist.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Cultist.getMoodState()],
						text = _event.m.Cultist.getName() + this.Const.MoodStateEvent[_event.m.Cultist.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.cultists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 4)
		{
			return;
		}

		local cultist_candidates = [];
		local uneducated_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getFlags().get("IsSpecial") || bro.getFlags().get("IsPlayerCharacter") || bro.getBackground().getID() == "background.slave")
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
			{
				cultist_candidates.push(bro);
			}
			else if (bro.getBackground().isLowborn() && !bro.getSkills().hasSkill("trait.bright") || !bro.getBackground().isNoble() && bro.getSkills().hasSkill("trait.dumb") || bro.getSkills().hasSkill("injury.brain_damage"))
			{
				uneducated_candidates.push(bro);
			}
		}

		if (cultist_candidates.len() == 0 || uneducated_candidates.len() == 0)
		{
			return;
		}

		this.m.Cultist = cultist_candidates[this.Math.rand(0, cultist_candidates.len() - 1)];
		this.m.Uneducated = uneducated_candidates[this.Math.rand(0, uneducated_candidates.len() - 1)];
		this.m.Score = cultist_candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cultist",
			this.m.Cultist.getName()
		]);
		_vars.push([
			"uneducated",
			this.m.Uneducated.getName()
		]);
	}

	function onClear()
	{
		this.m.Cultist = null;
		this.m.Uneducated = null;
	}

});

