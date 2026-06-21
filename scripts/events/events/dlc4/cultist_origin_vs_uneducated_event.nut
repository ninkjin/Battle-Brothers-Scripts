this.cultist_origin_vs_uneducated_event <- this.inherit("scripts/events/event", {
	m = {
		Cultist = null,
		Uneducated = null
	},
	function create()
	{
		this.m.ID = "event.cultist_origin_vs_uneducated";
		this.m.Title = "露营时…";
		this.m.Cooldown = 13.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]有几个兄弟来找你，看上去很着急。 他们说 %cultist% 和 %uneducated% 坐在一起已经几个小时了。 当你问他们担心什么时，他们会提醒你，那个额头有伤疤的异教徒，说着令人难以置信的怪事。 是的。这些都是达库尔的要求，一个关于承诺的范例。 你不知道这会有什么问题。\n\n 你去看看那两个人。%uneducated% 抬头看着你，微笑着，说这个异教徒有很多东西要教他。 也许他是这么想的，但你知道，达库尔的存在根本不需要被感知，如果他渴望被强加到这个世界上，那将是对达库尔奥义的误解。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "向他展示黑暗吧。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "达库尔并不想要他。",
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
			Text = "[img]gfx/ui/events/event_05.png[/img]你点头，转身走开了。 直到第二天早上，%uneducated% 被发现在他的额头上有一个新的伤口，流血的谈话和一些代价必须要付出才能皈依达库尔。 你问他感觉如何，他只说了几句话。%SPEECH_ON%达库尔就要来了。%SPEECH_OFF%摇着头，你纠正他。%SPEECH_ON%达库尔不是就要来了。 达库尔即将降临到我们。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "达库尔即将降临。",
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
			Text = "[img]gfx/ui/events/event_05.png[/img]你把这两个人分开，让 %uneducated% 去清点一些存货。 当他离开时，%cultist% 嘲笑你。%SPEECH_ON%达库尔即将降临。你在梦中看到他了。 你在夜晚看到他了。 他的黑暗就要来了。 没有永远燃烧的光明。%SPEECH_OFF%异教徒停下来，凝视着你的灵魂。 你从回头盯着某个地方，而不是你的身体。 你只能看到周围无限的黑暗和一小束光，%cultist% 正在瞅着呢。 慢慢地，你挪向那道光，发现自己在眨眼睛，并盯着那个男人。他鞠躬。%SPEECH_ON%抱歉，队长，我不知道达库尔还有这样的计划。%SPEECH_OFF%又眨了眨眼睛，你只能点头。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "达库尔即将降临到我们。",
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
				_event.m.Cultist.worsenMood(1.0, "被剥夺了转化的机会，准备转化的是 " + _event.m.Uneducated.getName());

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
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
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
		this.m.Score = cultist_candidates.len() * 9;
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

