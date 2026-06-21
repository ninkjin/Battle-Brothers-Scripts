this.optimist_lost_battle_event <- this.inherit("scripts/events/event", {
	m = {
		Optimist = null
	},
	function create()
	{
		this.m.ID = "event.optimist_lost_battle";
		this.m.Title = "在途中…";
		this.m.Cooldown = 35.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_88.png[/img]尽管最近遭遇挫折，但是 %optimist% 看好你的未来前景 %companyname%。%SPEECH_ON%生命的所有时间不可能总是成功度过，伙计们。 有时候我们必须花点时间重振旗鼓。 但是我们不会永远的失败下去，我坚信着这一点！ 这个团队太棒了根本不适合那些虚度光阴的狗屎。%SPEECH_OFF%这个总是保持乐观的佣兵不被失败打倒的积极性感染了一些人，振奋了他们的精神让他们为明天的到来做好准备。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一个可以一起战斗下去的伙伴。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Optimist.getImagePath());
				_event.m.Optimist.improveMood(0.5, "尽管最近遭遇挫折，但仍然乐观");

				if (_event.m.Optimist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Optimist.getMoodState()],
						text = _event.m.Optimist.getName() + this.Const.MoodStateEvent[_event.m.Optimist.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Optimist.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 50 && !bro.getSkills().hasSkill("trait.pessimist"))
					{
						bro.improveMood(0.5, "被队长振奋着" + _event.m.Optimist.getName() + "的乐观主义");

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
		if (this.World.Statistics.getFlags().getAsInt("LastCombatResult") != 2)
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
			if (bro.getSkills().hasSkill("trait.optimist") && bro.getBackground().getID() != "background.slave" && bro.getLifetimeStats().Battles >= 1)
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 1)
		{
			return;
		}

		this.m.Optimist = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 50;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"optimist",
			this.m.Optimist.getName()
		]);
	}

	function onClear()
	{
		this.m.Optimist = null;
	}

});

