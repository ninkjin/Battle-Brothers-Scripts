this.lose_fear_beasts_event <- this.inherit("scripts/events/event", {
	m = {
		Casualty = null
	},
	function create()
	{
		this.m.ID = "event.lose_fear_beasts";
		this.m.Title = "露营时…";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{战团在篝火旁享受着休息和美食，当时%fearful%站了起来。鉴于其他人都坐着，他似乎已经获得了“发言”的特权。%SPEECH_ON%如果人们害怕野兽，那么人就会成为野兽！但是我们有房屋、火和贸易和金钱！是我们！不是他们！他们睡在他们拉屎的地方，他们真的有用吗？%SPEECH_OFF%尽管他的话十分奇怪，但一些人举起了酒杯，热情地喊出了“耳听为虚，眼见为实”的口号。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "讲得好，讲得好！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Casualty.getImagePath());
				local trait = _event.m.Casualty.getSkills().getSkillByID("trait.fear_beasts");
				this.List.push({
					id = 10,
					icon = trait.getIcon(),
					text = _event.m.Casualty.getName() + "不再害怕野兽"
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

		if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID())
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

		foreach( bro in brothers )
		{
			if (!bro.getSkills().hasSkill("trait.fear_beasts") || bro.getLifetimeStats().Battles < 25 || bro.getLifetimeStats().Kills < 50 || bro.getLifetimeStats().BattlesWithoutMe != 0)
			{
				continue;
			}

			candidates.push(bro);
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Casualty = candidates[this.Math.rand(0, candidates.len() - 1)];
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
	}

	function onClear()
	{
		this.m.Casualty = null;
	}

});

