this.holywar_occupied_north_event <- this.inherit("scripts/events/event", {
	m = {
		News = null
	},
	function create()
	{
		this.m.ID = "event.crisis.holywar_occupied_north";
		this.m.Title = "在路上…";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_%image%.png[/img]{信息传的很快，带着一点宗教味的刺激性：%holysite% 被北方十字军占领了！ | 来自北方的十字军占领了 %holysite%。你不确定这意味着战争是否很快就要结束了。 如果是的话那真是可惜，想想这场斗争创造了多少好机会。 | %holysite% 陷落于北方十字军旗下！ 毫无疑问，在旧神们欢呼时，镀金者的追随者将会试图夺回它。 这个可能的机会来到了 %companyname%。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "宗教动乱之火熊熊燃烧。",
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

		if (this.World.Statistics.hasNews("crisis_holywar_holysite_north"))
		{
			this.m.Score = 2000;
		}
	}

	function onPrepare()
	{
		this.m.News = this.World.Statistics.popNews("crisis_holywar_holysite_north");
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"holysite",
			this.m.News.get("圣地")
		]);
		_vars.push([
			"image",
			this.m.News.get("Image")
		]);
	}

	function onClear()
	{
		this.m.News = null;
	}

});

