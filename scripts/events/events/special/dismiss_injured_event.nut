this.dismiss_injured_event <- this.inherit("scripts/events/event", {
	m = {
		Fired = null
	},
	function setFired( _f )
	{
		this.m.Fired = _f;
	}

	function create()
	{
		this.m.ID = "event.dismiss_injured";
		this.m.Title = "在途中…";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img]%dismissed%的伤势实在太重了：那个人没有死，但是在你看来，他还是死了的好，因为他已经不适合战斗了。 你让他走了。 虽然这可能是一个拯救这个佣兵生命的举动，但战队的其他人不这么认为。 他们看到的是，你只因受了一次伤，就能够把一个人解雇掉。 现在她们担心，如果他们受伤了，你也会对他们做同样的事情，就像自私的人骑着瘸腿的马一样。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他们会适应的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getSkills().hasSkill("trait.player"))
					{
						continue;
					}

					if (bro.getSkills().hasSkillOfType(this.Const.SkillType.PermanentInjury))
					{
						bro.worsenMood(1.5, "害怕因为他受到损伤而被解雇");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (this.Math.rand(1, 100) <= 33)
					{
						bro.worsenMood(this.Const.MoodChange.BrotherDismissed, "对战队的团结失去信心");

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
		if (this.World.Statistics.hasNews("dismiss_injured"))
		{
			this.m.Score = 2000;
		}

		return;
	}

	function onPrepare()
	{
		local news = this.World.Statistics.popNews("dismiss_injured");
		this.m.Fired = news.get("Name");
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"dismissed",
			this.m.Fired
		]);
	}

	function onClear()
	{
		this.m.Fired = null;
	}

});

