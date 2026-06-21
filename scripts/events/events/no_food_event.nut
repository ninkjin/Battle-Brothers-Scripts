this.no_food_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.no_food";
		this.m.Title = "在途中…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_52.png[/img]{食物储备已经用完了！ 尽管这个世界有着一堆恐怖的事物，但是 %companyname% 也不可能驱使一群不吃不喝的骷髅去战斗！ 在他们离开之前，你要让他们快点吃饭。 | 就算最忠诚的成员也只能支持两天没有食物补给。 在那之后，任何人都倾向于离开为了填饱自己的肚子。 买些食物－在团队解散之前赶快行动！ | 你错误地计算了食物储备并且把 %companyname% 置于一个巨大的危机之中－断粮。 即使是最冷血的团队也会在几天内分崩离析如果你不迅速改变现在的状况你的团队也将如此！}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我得给他们弄点吃的。",
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
		if (this.World.Assets.getFood() > 0)
		{
			return;
		}

		this.m.Score = 150;
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

