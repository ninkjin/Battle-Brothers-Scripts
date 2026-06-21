this.ancient_watchtower_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.ancient_watchtower";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_108.png[/img]{这座高塔比你见过的任何城堡都要高一倍，而且比任何塔楼都要狭窄。就好像有人拥有建造一座要塞的所有材料，但他们没有建造堡垒，而是建造了高塔。%randombrother%眯着眼睛望着它的高耸。%SPEECH_ON%好像可以一直延伸到天空，该死，几乎要接近云层了。%SPEECH_OFF%你拿着一张地图和几个人进入了这座高塔。在里面，你发现一个玻璃球静静地坐在一个空心的讲台上，球内有一些粉状的遗骸。也许这是魔力的最后一次释放，你不知道。直觉告诉你，住在这个苗条的庇护所里的人并不总是走楼梯。但你不得不走。攀爬是残酷而漫长的。顶部你发现另一个球，这个球是锯齿状的，已经破碎，下面有骸骨，旁边有一根破碎的手杖。你摇了摇头，走向了箭垛。远眺，景象凝聚在地平线上，甚至使整个世界似乎弯曲了，这无疑是眼花的一个诡异技巧。你把地理画在地图上，休息了五分钟，然后开始下山。\n\n当你到达底部时，骸骨和破碎的灯泡还在讲台上。所有人都跑出门，你紧随其后。回头看，高塔的大门慢慢地关闭，发出沉重的金属撞击声。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧, 至少我们有一块土地。",
					function getResult( _event )
					{
						this.World.uncoverFogOfWar(this.World.State.getPlayer().getPos(), 1900.0);
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

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
	}

});

