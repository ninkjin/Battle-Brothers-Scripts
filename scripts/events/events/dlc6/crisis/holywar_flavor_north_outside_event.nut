this.holywar_flavor_north_outside_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.holywar_flavor_north_outside";
		this.m.Title = "在路上…";
		this.m.Cooldown = 20.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_95.png[/img]农庄被烧毁，它的居民全都被斩首，除了其中一个。 这个不幸的人呈飞鹰状的被压在地上，火势看来是从腹部开始的：他的胸口成了一个灰黑的坑，他的骨瘦如柴四肢亦是焦黑。 他的面部则没有受损，可能是故意的，而从他的表情看来即使是你的敌人也不该如此死去。 | [img]gfx/ui/events/event_02.png[/img]你找到了一些被吊在树上的南方士兵，他们的眼球早已被乌鸦啄走，脚则是那些碰运气的捕食者。 他们无序的在风中摇摆，当地人看起来并不急着把他们放下来。 | [img]gfx/ui/events/event_60.png[/img]一个车队散落在道路的两旁，木材与零件随着它们散布在附近的草地上。 一切有价值的东西都被拿走了，而商人也全都被杀了。 伤口上可以看出是南方人的武器，但是这些致命的雕刻看起来不像你过去看过的一般简洁。 这很有可能是贼匪借着圣战掩护下的作为。 不论如何，这里没有什么有价值的东西留下，于是你让手下们继续前进。 | [img]gfx/ui/events/event_132.png[/img]你找到了一个战场，尽管你的到来对于一个戏剧性的出场而言太迟了：死者到处都是，南方人与北方人，小贩与拾荒者还有恶棍们已经把这场战斗打扫干净了。 通过时不时出现的南方人尸体堆，以及这些尸体堆边仓促的撤退痕迹来看，你可以肯定那帮镀金者让负债者们成为了掩护他们撤退的牺牲品。}",
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

		if (currentTile.SquareCoords.Y > this.World.getMapSize().Y * 0.7)
		{
			return;
		}

		if (!currentTile.HasRoad)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type == this.Const.World.TerrainType.Desert || currentTile.Type != this.Const.World.TerrainType.Oasis || currentTile.TacticalType == this.Const.World.TerrainTacticalType.DesertHills)
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

