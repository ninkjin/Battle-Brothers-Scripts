this.wound_heals_event <- this.inherit("scripts/events/event", {
	m = {
		Injured = null
	},
	function create()
	{
		this.m.ID = "event.wound_heals";
		this.m.Title = "露营时…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{欢迎回来。 | 看起来不错。}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local bg = _event.m.Injured.getBackground().getID();

				if (bg == "background.monk" || bg == "background.flagellant" || bg == "background.pacified_flagellant" || bg == "background.monk_turned_flagellant" || bg == "background.cultist")
				{
					this.Text = "[img]gfx/ui/events/event_34.png[/img]{你去慰问 %hurtbrother%，他不久前受了重伤，有时候仅仅让他知道有人关心他，就能令他精神振奋。 就像医师在为他疗伤时，你会惊讶地发现他很健康。 伤口以肉眼可见的速度愈合，以至于其他人称之为奇迹。 | %hurtbrother% 在战斗中受伤，你认为最好去看看他怎么样了。 令人惊讶的是，他恢复的相当不错。 他的伤口愈合得如此之快，以至于你差点以为他在没人的时候，接触并使用了黑魔法。 然而周围没有黑魔法的痕迹，只有一个坚强并杀不死的血肉之躯。 | %hurtbrother% 进入了你的帐篷，把他的伤口给你看，伤疤几乎都没有了。 那个狰狞的伤口似乎已经完全愈合了。 这个雇佣兵面带甜笑地看着你。%SPEECH_ON%队长，他们想要干掉我得用出吃奶的力气。%SPEECH_OFF% | %hurtbrother% 进入你的帐篷，给你看了他的一个旧伤，他激动地说。%SPEECH_ON%这是奇迹还是什么？%SPEECH_OFF%伤口几乎完全愈合了。 你告诉他，他是由更坚韧的东西制成的，而神与之无关。他摇了摇头。%SPEECH_ON%你需要更多信仰。%SPEECH_OFF% | 你去看望伤者 %hurtbrother%，那个你上次看到伤的非常重的雇佣兵，然而，他居然兴致高昂。 然而，这个人心情很好。 他在磨他的铁剑，发现你过来，转身面对你。%SPEECH_ON%先生，你需要点什么？%SPEECH_OFF%你询问他的伤势，他耸耸肩。%SPEECH_ON%我不容易死。 {我年轻时吃了很多尖尖的橙色食物。 | 我从小就吃了很多生菜。 人说我很难…额。}%SPEECH_OFF%}";
				}
				else
				{
					this.Text = "[img]gfx/ui/events/event_34.png[/img]{你去慰问 %hurtbrother%，他不久前受了重伤，有时候仅仅让他知道有人关心他，就能令他精神振奋。 就像医师在为他疗伤时，你会惊讶地发现他很健康。 伤口以肉眼可见的速度愈合，以至于其他人称之为奇迹。 | %hurtbrother% 在战斗中受伤，你认为最好去看看他怎么样了。 令人惊讶的是，他恢复的相当不错。 他的伤口愈合得如此之快，以至于你差点以为他在没人的时候，接触并使用了黑魔法。 然而周围没有黑魔法的痕迹，只有一个坚强并杀不死的血肉之躯。 | %hurtbrother% 进入了你的帐篷，把他的伤口给你看，伤疤几乎都没有了。 那个狰狞的伤口似乎已经完全愈合了。 这个雇佣兵面带甜笑地看着你。%SPEECH_ON%队长，他们想要干掉我得用出吃奶的力气。%SPEECH_OFF% | %hurtbrother% 进入你的帐篷，给你看了他的一个旧伤，他激动地说。%SPEECH_ON%这是奇迹还是什么？%SPEECH_OFF%伤口几乎完全愈合了。 你告诉他，他是由更坚韧的东西制成的，而神与之无关。 他点头。%SPEECH_ON%是的，我知道。但如果他们也在照顾我，那就太好了。以防万一…%SPEECH_OFF% | 你去看望伤者 %hurtbrother%，那个你上次看到伤的非常重的雇佣兵，然而，他居然兴致高昂。 然而，这个人心情很好。 他在磨他的铁剑，发现你过来，转身面对你。%SPEECH_ON%先生，你需要点什么？%SPEECH_OFF%你询问他的伤势，他耸耸肩。%SPEECH_ON%我不容易死。 {我年轻时吃了很多尖尖的橙色食物。 | 我从小就吃了很多生菜。 人说我很难…额。}%SPEECH_OFF%}";
				}

				this.Characters.push(_event.m.Injured.getImagePath());
				local injuries = _event.m.Injured.getSkills().query(this.Const.SkillType.TemporaryInjury);
				local injury = injuries[this.Math.rand(0, injuries.len() - 1)];
				this.List = [
					{
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Injured.getName() + "不再遭受" + injury.getNameOnly()
					}
				];
				injury.removeSelf();
				_event.m.Injured.updateInjuryVisuals();
				_event.m.Injured.getSkills().update();
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() != "background.slave" && bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Injured = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"hurtbrother",
			this.m.Injured.getName()
		]);
	}

	function onClear()
	{
		this.m.Injured = null;
	}

});

