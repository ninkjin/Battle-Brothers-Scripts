this.greenskins_town_destroyed_event <- this.inherit("scripts/events/event", {
	m = {
		News = null
	},
	function create()
	{
		this.m.ID = "event.crisis.greenskins_town_destroyed";
		this.m.Title = "在路上…";
		this.m.Cooldown = 7.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_94.png[/img]{路上的坏消息。难民和商人报告说 %city% 已经被绿皮摧毁了！ 如果这种情况持续下去，当一切尘埃落定的时候，就不会有一个地方叫做家了。 | 你发现一位贵族的信使正在路边给他的马浇水。 他声称，绿皮已经消灭了 %city% 周围的人类军队，并摧毁了这个城镇！ | 你遇到一个制图师和一个推着空车的商人。 他们正在重画一张地图，其中有一些奇怪的地方：地图制作者正在从纸上擦去 %city%。 当你问为什么时，他挑了挑眉毛。%SPEECH_ON%噢，你没听说吗？%city% 被摧毁了。 绿皮越过了防御工事，杀死了他们能抓到的每一个人。%SPEECH_OFF% | 你在路上碰到一个商人。 他的货车空了，少了一些牲畜。 他的脸上和衣服上都有血迹。 You ask the man for his story. 他挺起身。%SPEECH_ON%我的故事吗？不，这不是我的故事。 我在去 %city% 的路上，却发现那里到处都是绿皮。 我差点没逃过一劫。 这座城市本身已经完蛋了。 如果那是你的方向，不要自找麻烦了。 它不见了。完全消失了。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们输掉这场战争了么？",
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

		if (this.World.Statistics.hasNews("crisis_greenskins_town_destroyed"))
		{
			this.m.Score = 2000;
		}
	}

	function onPrepare()
	{
		this.m.News = this.World.Statistics.popNews("crisis_greenskins_town_destroyed");
	}

	function onPrepareVariables( _vars )
	{
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

