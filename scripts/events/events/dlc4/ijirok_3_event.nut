this.ijirok_3_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.ijirok_3";
		this.m.Title = "在途中…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_76.png[/img]{当我们在北部荒原宿营的时候，一个轮廓出现了，一个扁平的黑色物体，它的外形似乎是从稀薄的空气中切割出来的。 当它接近时，橙色的光芒从一个火焰之角中绽放。 战队拔出他们的武器，为应对可能出现的黑影或者虚惊一场？ 什么“东西”穿越了这么荒凉的土地？ 但你发现他只是一个秃头红鼻子的老人。 如果能用雪把人从花岗岩上雕刻出来，那就是他的模样。 那个陌生人穿过营地，同伙们都转向他大喊大叫，但没有一个佣兵靠近他。 他终于俯下身，把号角放在地上，雪熄灭了它的火焰。 然后他起身继续走，很快就消失在夜色中。\n\n  %randombrother% 捡起号角，把它翻转过来。 一朵玫瑰凋谢了，即使在黑暗中，它的花瓣也是透明的，柔软的，但已经在严寒中卷曲。 你四处寻找那位老人，发现他的足迹仍未消失。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这片荒地上全是奇怪的东西。",
					function getResult( _event )
					{
						this.World.Flags.set("IjirokStage", 3);
						local locations = this.World.EntityManager.getLocations();

						foreach( v in locations )
						{
							if (v.getTypeID() == "location.icy_cave_location")
							{
								this.Const.World.Common.addFootprintsFromTo(this.World.State.getPlayer().getTile(), v.getTile(), this.Const.GenericFootprints, 0.5);
								break;
							}
						}

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
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (!this.World.Flags.has("IjirokStage") || this.World.Flags.get("IjirokStage") == 0 || this.World.Flags.get("IjirokStage") >= 4)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Snow || currentTile.Type != this.Const.World.TerrainType.SnowyForest)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 10)
			{
				return;
			}
		}

		local locations = this.World.EntityManager.getLocations();

		foreach( v in locations )
		{
			if (v.getTypeID() == "location.icy_cave_location")
			{
				if (v.getTile().getDistanceTo(currentTile) > 10)
				{
					return;
				}
			}
		}

		this.m.Score = 25;
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

