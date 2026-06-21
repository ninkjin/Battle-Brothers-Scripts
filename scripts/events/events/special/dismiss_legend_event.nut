this.dismiss_legend_event <- this.inherit("scripts/events/event", {
	m = {
		Fired = null
	},
	function setFired( _f )
	{
		this.m.Fired = _f;
	}

	function create()
	{
		this.m.ID = "event.dismiss_legend";
		this.m.Title = "在途中…";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img]这个你解雇的男人不只是战队的一个佣兵而已：他曾是一个传奇。 很多人都知道 %dismissed%的大名，不仅仅是你和一些雇佣兵知道，现在解雇他就如在战斗结束前解雇一个英勇的将军一样。 这个决定，很自然的，在其他佣兵之中反响不是很好。",
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

					bro.worsenMood(this.Const.MoodChange.VeteranDismissed, "你解雇了" + _event.m.Fired + "，该战团的传奇");

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

		});
	}

	function onUpdateScore()
	{
		if (this.World.Statistics.hasNews("dismiss_legend"))
		{
			this.m.Score = 2000;
		}

		return;
	}

	function onPrepare()
	{
		local news = this.World.Statistics.popNews("dismiss_legend");
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

