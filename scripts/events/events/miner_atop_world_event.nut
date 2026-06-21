this.miner_atop_world_event <- this.inherit("scripts/events/event", {
	m = {
		Miner = null
	},
	function create()
	{
		this.m.ID = "event.miner_atop_world";
		this.m.Title = "在途中…";
		this.m.Cooldown = 80.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_42.png[/img]战队进入山区，%randombrother% 把这里起了个富有诗意的名字“王国之巅”。 云层开始在与眼睛齐平的地方飘过空气变得如此稀薄就像通过细小的孔洞呼吸一样。 你把雪嘎吱嘎吱地踩在脚下刺骨的寒风威胁着你的眼睛似乎要把你的眼睛冻成冰块。 尽管有陡峭的悬崖和危险的裂缝要跨越，但是 %miner% 这名矿工似乎相当高兴能够到达这么高的地方。%SPEECH_ON%我们现在就像站在世界的巅峰一样！ 这难道不是最棒的事情吗？%SPEECH_OFF%他很快就因为过度兴奋而喘不过气来开始大口喘息起来，但是这名矿工太高兴了根本不在乎这些。 多年以来往地表之下发掘让他现在看到这幅景色显得莫名的激动。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，至少有些人很享受。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Miner.getImagePath());
				_event.m.Miner.improveMood(2.0, "从山顶欣赏风景");

				if (_event.m.Miner.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Miner.getMoodState()],
						text = _event.m.Miner.getName() + this.Const.MoodStateEvent[_event.m.Miner.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Mountains)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
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
			if (bro.getLevel() <= 3 && bro.getBackground().getID() == "background.miner")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Miner = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 25;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"miner",
			this.m.Miner.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Miner = null;
	}

});

