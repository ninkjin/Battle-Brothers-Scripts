this.goblin_city_reminder_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.goblin_city_reminder";
		this.m.Title = "在途中…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_119.png[/img]{这么多哥布林被消灭，他们的死亡和灭绝的消息很可能会传回绿皮族的城市。 如果那个哥布林专家像他看起来一样有学问，哥布林们就会过度反应并派出他们的军队，使城门大部分失去防守。或许现在是返回哥布林城并查看陌生人的总结是否正确的时候了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们应该回去了。",
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
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.Flags.get("IsGoblinCityDestroyed"))
		{
			return;
		}

		if (this.World.Flags.get("IsGoblinCityOutposts") && this.World.Flags.get("GoblinCityCount") >= 5 || this.World.Flags.get("IsGoblinCityScouts") && this.World.Flags.get("GoblinCityCount") >= 10)
		{
			this.m.Score = 500;
		}
		else
		{
			return;
		}
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

