this.holywar_flavor_south_outside_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.holywar_flavor_south_outside";
		this.m.Title = "在路上…";
		this.m.Cooldown = 20.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_132.png[/img]你找到了一片杂乱的战场遗迹：干瘪的尸体凌乱的散步着，很难说他们是哪边的。 拾荒者无疑拿走了一切有用的东西。 | [img]gfx/ui/events/event_132.png[/img]一驾载重货车散发着黑烟，它的主人躺在一边，没有头，剩下的尸体也露出了白骨。 随着这场战争持续下去，很难说到底谁该为此负责。 | [img]gfx/ui/events/event_132.png[/img]你找到了一杆旧神的旗帜，上面的神像被抹去面容，扎在沙地里，一个无头的尸体被插在上面。 无疑是一个北方人，尸体随着沙漠蜥蜴们为最后一点食物进出而看似起泡一般。 更多的尸体零星的散步在沙地上，大多数被甲虫爬满或者被蛇还有什么其他食腐动物拖拽着。 | [img]gfx/ui/events/event_167.png[/img]你找到一个撑在沙漠上的北方人尸体，他的手脚绑在一个木制椅子上。 在其前方是一个大号的柱子，带有框架与角落上耷拉着的绳索。 看起来它曾经挂着什么大而圆的东西。 尸体的头上有一个洞，一种你没见过的伤口：就好像纯粹的热能就这么钻了过去。 也许镀金的家伙们用了一个很大的吊坠来强化太阳光的反射？ 很难说。 | [img]gfx/ui/events/event_167.png[/img]你在沙地中找到了一排尸体，在更近距离的观察后辨认出是一群南方女人以及一个看起来可能出现在维齐尔议会上的男人。 它们的头在移除后放在它们的背上，眼睛面向它们的臀部。 你不确定这些都有什么含义，不过这无疑是维齐尔内部纠纷的结果。 看起来再没有什么有价值的东西所以你让手下继续前进。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "战争从未改变。",
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
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (!this.World.FactionManager.isHolyWar())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert && currentTile.Type != this.Const.World.TerrainType.Oasis && currentTile.TacticalType != this.Const.World.TerrainTacticalType.DesertHills && currentTile.Type != this.Const.World.TerrainType.Steppe)
		{
			return;
		}

		if (!currentTile.HasRoad)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 5)
			{
				return;
			}
		}

		this.m.Score = 10;
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

