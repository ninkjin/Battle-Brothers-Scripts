this.pessimist_won_battle_event <- this.inherit("scripts/events/event", {
	m = {
		Pessimist = null
	},
	function create()
	{
		this.m.ID = "event.pessimist_won_battle";
		this.m.Title = "在途中…";
		this.m.Cooldown = 35.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img]令人沮丧的是，%pessimist% 没精打采地闲逛着，就像所有令人讨厌的悲观者一样破坏我们胜利的喜悦。 他轻蔑地举起一只手。%SPEECH_ON%我们在享受着胜利，但那又怎样呢？ 我们的胜利就意味着他们的失败，所以没准有一天会有人将他们的胜利建立在我们的失败的基础上，你们不这样认为吗？ 所以我们不要本末倒置，以免将来的阴影在我们享受着现在着荣耀的阳光时偷偷笼罩我们。%SPEECH_OFF%一些佣兵呵斥他不要这么沮丧，但是他那冲击性的事实还是影响到了其他人的热情。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "悲观主义者最糟糕的部分就是他们通常是正确的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Pessimist.getImagePath());
				_event.m.Pessimist.worsenMood(0.5, "尽管最近取得了胜利，但还是很悲观");

				if (_event.m.Pessimist.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Pessimist.getMoodState()],
						text = _event.m.Pessimist.getName() + this.Const.MoodStateEvent[_event.m.Pessimist.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Pessimist.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 50 && !bro.getSkills().hasSkill("trait.optimist"))
					{
						bro.worsenMood(0.4, "经过淬炼的(Tempered by)" + _event.m.Pessimist.getName() + "的悲观情绪");

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
	}

	function onUpdateScore()
	{
		if (this.World.Statistics.getFlags().getAsInt("LastCombatResult") != 1)
		{
			return;
		}

		if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() > 20.0)
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
			if (bro.getSkills().hasSkill("trait.pessimist") && !bro.getSkills().hasSkill("trait.dumb") && bro.getBackground().getID() != "background.slave" && bro.getLifetimeStats().Battles >= 1)
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 1)
		{
			return;
		}

		this.m.Pessimist = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 50;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"pessimist",
			this.m.Pessimist.getName()
		]);
	}

	function onClear()
	{
		this.m.Pessimist = null;
	}

});

