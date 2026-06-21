this.more_action_event <- this.inherit("scripts/events/event", {
	m = {
		Bro1 = null,
		Bro2 = null
	},
	function create()
	{
		this.m.ID = "event.more_action";
		this.m.Title = "露营时…";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img]你坐在帐篷里面享受着片刻的宁静，成就和收获每天都在不断的增加，以某种方式不断的累积起来，让今天比昨天更令人愉快。 突然，%combatbro1% 和 %combatbro2% 进来。 他们要求和你谈一谈。 你同意了，你拍了拍桌子邀请他们坐下来。 他们这样做了并很快表示他们已经有很长时间没有战斗了。 你感觉十分莫名其妙，你靠在椅背。%SPEECH_ON%这不是件好事吗？%SPEECH_OFF%%combatbro1% 摇了摇头并且举起自己的手在空气不断比划着。%SPEECH_ON%不，我们是被雇来战斗的，并且我们也想要战斗。 我们想要战斗，我想要屠戮，更重要的是在完成这两者后所获得金钱和荣耀。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们很快就会看到战斗－你记住我的话！",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "无论哪种方式你都会得到报酬－现在你甚至可以享受生活和花你的钱。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bro1.getImagePath());
				this.Characters.push(_event.m.Bro2.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_64.png[/img]你点了点头。%SPEECH_ON%我了解了。你们两个是钟情于战斗的人。 你们甚至让我想起了我自己，不过通过对于你们能力的认识，我可以向你们保证通过这段时间休息以后你们的表现会变得更好。 你们都是好战士，但是无论是哪场战斗都会给你一样的报酬不是吗？ 为什么这么担心战斗？ 它们总归会来的。我雇你们不是让你们来享受的。 我雇佣你们是为了让你们为我而战。%SPEECH_OFF%那两人互相交流了一下眼神然后耸耸肩点了点头。 他们一同起身。%SPEECH_ON%你是对的，先生。 并且，希望你不要忘记，我们时刻准备为你而战！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "享受战火热爱战火实在是不可多得的人才。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bro1.getImagePath());
				this.Characters.push(_event.m.Bro2.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_64.png[/img]你尝试向他们解释，无论他们是否有在战斗，他们都会得到报酬。 但是他们似乎不在意钱。 他们是真的希望战斗，然而你的话根本没有动摇他们坚定的态度。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "But...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bro1.getImagePath());
				this.Characters.push(_event.m.Bro2.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().isCombatBackground() && this.Math.rand(1, 100) <= 50)
					{
						bro.worsenMood(1.0, "对你的领导失去信心");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_64.png[/img]你站起来并且用手掌撑着桌子看着他们。%SPEECH_ON%你们想要战斗？%SPEECH_OFF%这两个男人交换了下眼神并且快速的对你点了点头。%SPEECH_ON%马上就会有战斗伙计们！ 不用害怕剑一直会在鞘里面，雇佣兵们。 我将会团里面准备好以后找到一场报酬丰厚的战斗！%SPEECH_OFF%他们站起身来，和你握手。 当他们离开帐篷的时候还不忘对你说谢谢。 他们一走你就在地图上面寻找最近的出气筒。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "享受战火热爱战火实在是不可多得的人才。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bro1.getImagePath());
				this.Characters.push(_event.m.Bro2.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().isCombatBackground() && this.Math.rand(1, 100) <= 25)
					{
						bro.improveMood(1.0, "很快就要开战了");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.trader")
		{
			return;
		}

		if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() < this.World.getTime().SecondsPerDay * 10)
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
			if (bro.getBackground().isCombatBackground() && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 2)
		{
			return;
		}

		this.m.Bro1 = candidates[0];
		this.m.Bro2 = candidates[1];
		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"combatbro1",
			this.m.Bro1.getName()
		]);
		_vars.push([
			"combatbro2",
			this.m.Bro2.getName()
		]);
	}

	function onClear()
	{
		this.m.Bro1 = null;
		this.m.Bro2 = null;
	}

});

