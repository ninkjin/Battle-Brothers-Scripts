this.walkers_bond_event <- this.inherit("scripts/events/event", {
	m = {
		Walker1 = null,
		Walker2 = null
	},
	function create()
	{
		this.m.ID = "event.walkers_bond";
		this.m.Title = "在途中…";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_16.png[/img]{四处漂泊中遇到路人，%walker1% 和 %walker2% 分享他们的旅行经历。 你并不真正了解到处旅行有什么好处，但这两个人的经历让你受益良多，这对你来说已经足够好了。 | %walker1% 和 %walker2% 见过大千世界。 他们花了好几年的时间四处漂流，现在他们相遇，互相讲述那些年的奇遇。\n\n他们互相吹牛的同时，心心相惜之感与日俱增，精彩绝伦的故事让你激动异常。 | 大多数男人都觉得旅行很单调无聊，但总有那么一些人认为旅行乐趣无穷，以至于他们一直在前进的路上。 不出所料，%walker1% 和 %walker2% 因他们关于……四处走动的故事而结下了不解之缘。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们继续前进。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Walker1.getImagePath());
				this.Characters.push(_event.m.Walker2.getImagePath());
				_event.m.Walker1.improveMood(1.0, "建立友谊与 " + _event.m.Walker2.getName());
				_event.m.Walker2.improveMood(1.0, "建立友谊与 " + _event.m.Walker1.getName());

				if (_event.m.Walker1.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Walker1.getMoodState()],
						text = _event.m.Walker1.getName() + this.Const.MoodStateEvent[_event.m.Walker1.getMoodState()]
					});
				}

				if (_event.m.Walker2.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Walker2.getMoodState()],
						text = _event.m.Walker2.getName() + this.Const.MoodStateEvent[_event.m.Walker2.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
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
			if (bro.getBackground().getID() == "background.vagabond" || bro.getBackground().getID() == "background.messenger" || bro.getBackground().getID() == "background.refugee" || bro.getBackground().getID() == "background.nomad")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 2)
		{
			return;
		}

		this.m.Walker1 = candidates[this.Math.rand(0, candidates.len() - 1)];

		do
		{
			this.m.Walker2 = candidates[this.Math.rand(0, candidates.len() - 1)];
		}
		while (this.m.Walker2 == this.m.Walker1);

		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"walker1",
			this.m.Walker1.getName()
		]);
		_vars.push([
			"walker2",
			this.m.Walker2.getName()
		]);
	}

	function onClear()
	{
		this.m.Walker1 = null;
		this.m.Walker2 = null;
	}

});

