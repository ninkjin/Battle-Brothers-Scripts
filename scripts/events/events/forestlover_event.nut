this.forestlover_event <- this.inherit("scripts/events/event", {
	m = {
		Forestlover = null
	},
	function create()
	{
		this.m.ID = "event.forestlover";
		this.m.Title = "在途中…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_25.png[/img] {%forestlover% 抬头看向林中树冠，手嬉戏般的在泻下的阳光中撩拨。 他看着你。%SPEECH_ON%我小时候常在这些森林中玩耍。%SPEECH_OFF%你表示赞同，接着大声发出质疑。%SPEECH_ON%我以为你的出生地附近是 %randomtown% ？%SPEECH_OFF%%forestlover% 放下他的手，注视着地面。%SPEECH_ON%噢，是的，你说对了。 好了，我们该动身了对吧？%SPEECH_OFF%在你能说点什么出来之前，这个人脸红着走了。 | 你发现 %forestlover% 似乎最近心情变好了。 原来，他很熟悉森林，重返绿荫让他散发出一种温暖的怀乡气氛。 | 即使你曾踏足过不少森林，这样的青翠景致仍使你印象深刻。 毫无疑问 %forestlover% 爱极了重返浓郁的绿荫。 | 树木粗壮的的枝干在你头顶延伸开来。%forestlover% 似乎沉浸于它们的环绕中。 你发现他最近一直在笑，好似重返森林也重返了那些美好的日子。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "为他感到高兴。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Forestlover.getImagePath());
				_event.m.Forestlover.improveMood(1.0, "喜欢在森林里");

				if (_event.m.Forestlover.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Forestlover.getMoodState()],
						text = _event.m.Forestlover.getName() + this.Const.MoodStateEvent[_event.m.Forestlover.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest)
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
			if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.lumberjack")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() > 0)
		{
			this.m.Forestlover = candidates[this.Math.rand(0, candidates.len() - 1)];
			this.m.Score = candidates.len() * 10;
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"forestlover",
			this.m.Forestlover.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Forestlover = null;
	}

});

