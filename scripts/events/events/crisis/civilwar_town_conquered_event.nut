this.civilwar_town_conquered_event <- this.inherit("scripts/events/event", {
	m = {
		News = null
	},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_town_conquered";
		this.m.Title = "在路上…";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_45.png[/img]{有消息说 %conqueror% 夺取 %city% 赶走了 %defeated%！ | 路上的信使说 %conqueror% 是 %city% 的新统治者，是在一场可怕的战斗中击败了 %defeated% 得到的。 | 现在地图要重新绘制了！ 难民、信使和商人都在路上谈论一件事情，%city% 现在属于 %conqueror% 了！}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "风水轮流转。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.State.getPlayer().getTile().HasRoad)
		{
			return;
		}

		if (this.World.Statistics.hasNews("crisis_civilwar_town_conquered"))
		{
			this.m.Score = 2000;
		}
	}

	function onPrepare()
	{
		this.m.News = this.World.Statistics.popNews("crisis_civilwar_town_conquered");
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"conqueror",
			this.m.News.get("征服者")
		]);
		_vars.push([
			"defeated",
			this.m.News.get("失败了(Defeated)")
		]);
		_vars.push([
			"city",
			this.m.News.get("City")
		]);
	}

	function onClear()
	{
		this.m.News = null;
	}

});

