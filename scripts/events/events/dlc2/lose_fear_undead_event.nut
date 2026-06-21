this.lose_fear_undead_event <- this.inherit("scripts/events/event", {
	m = {
		Casualty = null,
		Other = null
	},
	function create()
	{
		this.m.ID = "event.lose_fear_undead";
		this.m.Title = "露营时…";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{%fearful%在休息时突然发表演讲。%SPEECH_ON%我杀了和埋葬了这么多人，你知道吗？如果他们值得一试，那么他们就不会有回来成为不死族的机会！如果他们是从古代回来的，那我该死，因为他们非常顽强！但他们不是我。我还活着，我还在呼吸。我希望保持这样的状态。当我的时间到了，我打算变成死人，因为我有勇气知道我已经给这个世界带来了足够的麻烦。%SPEECH_OFF%%otherbrother%鼓掌并递上一盘食物。%SPEECH_ON%好吧，现在别再打扰我们了！%SPEECH_OFF%男人们笑了起来，%fearful%也跟着笑了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这个世界属于活人。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Casualty.getImagePath());
				local trait = _event.m.Casualty.getSkills().getSkillByID("trait.fear_undead");
				this.List.push({
					id = 10,
					icon = trait.getIcon(),
					text = _event.m.Casualty.getName() + "不再害怕亡灵"
				});
				_event.m.Casualty.getSkills().remove(trait);
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID() && this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getID())
		{
			return;
		}

		if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() > this.World.getTime().SecondsPerDay * 1.0)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (!bro.getSkills().hasSkill("trait.fear_undead") || bro.getLifetimeStats().Battles < 25 || bro.getLifetimeStats().Kills < 50 || bro.getLifetimeStats().BattlesWithoutMe != 0)
			{
				candidates_other.push(bro);
			}
			else
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0 || candidates_other.len() == 0)
		{
			return;
		}

		this.m.Casualty = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = this.m.Casualty.getLifetimeStats().Kills / 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"fearful",
			this.m.Casualty.getName()
		]);
		_vars.push([
			"otherbrother",
			this.m.Other.getName()
		]);
	}

	function onClear()
	{
		this.m.Casualty = null;
		this.m.Other = null;
	}

});

