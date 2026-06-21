this.vulcano_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.vulcano_enter";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_151.png[/img]{帝国的终点。尘埃之城。大灭绝。\n\n不论怎么称呼它，这座古老的城市现在只是一片广阔的灰色遗迹。 它坐落在一座没有山峰的山脊下，曾经的荣光在一场巨大的喷发中湮灭。 爆炸的威力是如此巨大，以至于冲击波使圆石铺成的街道崩开，送上天的砖块如下雨一般洒落在城市上。 庞大的花岗岩石块让街区变为弹坑，沸腾的石流蒸发着路上经过的一切。 流动的岩浆在最后到来，将大部分的城市烧成一滩黑色的烂泥，缓慢爬行的岩浆边缘呈一种难看的圆弧轮廓，直到它看起来就好像一片黑烟固化了一般。 这是一幅可怕的景象，部分是因为大地的怒火将许多受害者困在了永恒的静止之中：古代人类的灰色模具至今耸立着，维持着鲜活的姿势，比如一对夫妇在握手，一个人在照看着灶台，另一个在抚摸一只狗。\n\n当然，对人而言很自然而然的会看到这样一座毁灭的遗迹，尽管距离遥远，但他们聚集到它的遗骸，并通过信仰替代性的给与这一暴行新生。 镀金者的追随者们将它看做一个警告，以使他们远离浪费与贪婪。 北方人则将它看做旧神间的交锋，从人类诞生至今罕见的。 不论哪个宗教，都共同地在这里向失去生命的人致敬…至少，目前，还保持着敬意。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们的命运将再次引领我们来到这里。",
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

