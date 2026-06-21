this.holywar_flavor_north_settlement_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.holywar_flavor_north_settlement";
		this.m.Title = "在路上…";
		this.m.Cooldown = 20.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_41.png[/img]一辆载重货车停在路边。 你发现一个人照看着多种多样的商品。 他转身面向你说道。%SPEECH_ON%啊，一个佣兵。我想你也参加了圣战，哏？ 我希望你做了你的神认为是正确的事情。 我知道钱是重要的，但是生命中有更多含义，以及更多在那之后，懂吗？%SPEECH_OFF% | [img]gfx/ui/events/event_97.png[/img]你发现几个儿童在玩战争游戏，有些穿着似南方沙漠中的的宽松衣服。 他们轻松的被更北方穿着的孩子们用木剑击中。%SPEECH_ON%啊哈！镀金者倒下了，让旧神拥有我们赢来的荣誉！%SPEECH_OFF%孩子们冷静下来便回到预定位置上。 这一次，他们互换队伍，每个人交换着衣服直到“坏家伙”成为“好家伙”然后他们再从头开始。 未来的圣战不会缺少忠诚的战士，这一点是可以肯定的。 | [img]gfx/ui/events/event_40.png[/img]你遇到一个正在阅读一份卷轴的僧侣。 他声称胜利是旧神们的旨意，而荣光将永照大地什么什么的。 你问他如果北方人输了怎么办。 一个厚脸皮的问题，当然，但是他带着微笑接下了它。%SPEECH_ON%不要骗自己，佣兵，特别是认为我们今天的圣战就是全部了。 这些战争会延续下去直到一个显而易见的结果，而这个结果将会是我们拥有最多的荣誉。 我祈祷我活到见证它的那一天，但是我的父亲与他的父亲都这么祈祷过，所以最终我相信我的儿子将能见证圣战正义的结局。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你说是就是。",
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

		if (this.World.FactionManager.isHolyWar())
		{
			local playerTile = this.World.State.getPlayer().getTile();
			local towns = this.World.EntityManager.getSettlements();
			local nearTown = false;

			foreach( t in towns )
			{
				if (!t.isSouthern() && t.getTile().getDistanceTo(playerTile) <= 5 && t.isAlliedWithPlayer())
				{
					nearTown = true;
					break;
				}
			}

			if (!nearTown)
			{
				return;
			}

			this.m.Score = 10;
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

