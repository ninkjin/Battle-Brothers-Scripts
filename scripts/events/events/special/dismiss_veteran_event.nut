this.dismiss_veteran_event <- this.inherit("scripts/events/event", {
	m = {
		Fired = null
	},
	function setFired( _f )
	{
		this.m.Fired = _f;
	}

	function create()
	{
		this.m.ID = "event.dismiss_veteran";
		this.m.Title = "在途中…";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img]这是一个艰难的决定，但是必须解雇 %dismissed%。 不管怎样，看起来你应该先和其他人商量一下，因为他们都不满意你的选择。 这个雇佣兵在团队中待的时间足够长足以交到很多朋友，就算那些不是和他很熟的人也感觉他在战场上的位置保证了他们的安全。",
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

					bro.worsenMood(this.Const.MoodChange.VeteranDismissed, "你解雇了" + _event.m.Fired + "，该战团的老兵");

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
		if (this.World.Statistics.hasNews("dismiss_veteran"))
		{
			this.m.Score = 2000;
		}

		return;
	}

	function onPrepare()
	{
		local news = this.World.Statistics.popNews("dismiss_veteran");
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

