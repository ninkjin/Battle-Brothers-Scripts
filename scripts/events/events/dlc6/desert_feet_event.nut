this.desert_feet_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.desert_feet";
		this.m.Title = "在途中…";
		this.m.Cooldown = 80.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_161.png[/img]{在沙丘间行军数日让手下们的靴子里钻进了不少砂砾。 几个人停下，清理他们的靴子，其他人显示出他们已经被磨得像地面一样粗糙的脚。 这看来可真是个地狱般的地形，不论是上面的太阳还是下面的沙地，都在给你带来麻烦。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那些盘旋在上面的是秃鹫吗？",
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
					if (bro.m.Ethnicity == 1)
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 50)
					{
						bro.worsenMood(0.75, "他的脚被沙漠的沙子磨了");

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
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert || currentTile.HasRoad || this.World.Retinue.hasFollower("follower.scout"))
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.southern_quickstart" || this.World.Assets.getOrigin().getID() == "scenario.manhunters")
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 5)
			{
				return;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local numNortherners = 0;

		foreach( bro in brothers )
		{
			if (bro.m.Ethnicity == 1)
			{
				continue;
			}

			numNortherners = ++numNortherners;
		}

		if (numNortherners < 3)
		{
			return;
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

