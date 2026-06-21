this.holywar_occupied_south_event <- this.inherit("scripts/events/event", {
	m = {
		News = null
	},
	function create()
	{
		this.m.ID = "event.crisis.holywar_occupied_south";
		this.m.Title = "在路上…";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_%image%.png[/img]{消息传来，镀金者们征服了 %holysite%。至于他们打算用它做什么，谁知道呢。 或许立起一圈镶金的栅栏来把北方人挡在外面？ 你最担心的是这场战斗可能接近尾声，随着所有那些 %companyname% 享受着的甜蜜的宗教甜点一起。 | 镀金者的光辉想必前所未有的闪亮：%holysite% 现在处于南方人的控制下。 或许镀金的人们会希望 %companyname% 来帮忙守住它，又或许旧神需要些真正有勇气的人来帮他们夺回它。 不论如何，%companyname% 依旧坐在让钱袋子变大的座位上。}",
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

		if (this.World.Statistics.hasNews("crisis_holywar_holysite_south"))
		{
			this.m.Score = 2000;
		}
	}

	function onPrepare()
	{
		this.m.News = this.World.Statistics.popNews("crisis_holywar_holysite_south");
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

