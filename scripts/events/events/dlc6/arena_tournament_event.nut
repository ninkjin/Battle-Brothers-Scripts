this.arena_tournament_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null
	},
	function create()
	{
		this.m.ID = "event.arena_tournament";
		this.m.Title = "在路上…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_97.png[/img]几个孩子快速跑过你，其中一个举着一个玩具盾牌，另一个用着一个非常真实的草叉嘟着它。 你夺下这些农具并把孩子赶走，孩子哭喊着说他们只是在玩而已。 其中更年长的一个解释道他们只是对于即将到来的竞技场角斗感到很兴奋。 他们说 %town% 在举办一系列的角斗比赛而且奖励很丰厚。非常有趣。 拿着草叉，你把孩子们赶下路并把草叉丢到了另一边。 | [img]gfx/ui/events/event_97.png[/img]你找到两个男孩在试图把一条狗赶到张网里。 狗欢快的左蹦右跳，但是最终他们圈住了它。 狗，好像承认了它的命运，趴下了。 你想他们或许准备抓了吃掉它，但是男孩们只是把它放出来再次开始了游戏。 询问下，他们解释道 %town% 的角斗士会在战斗中使用网。 但更有趣的是他们宣称一系列大型比赛要开始了而且有一份不菲的奖励等着胜利者。 | [img]gfx/ui/events/event_92.png[/img]一个信使，穿着双厚底靴，几秒钟里从路上跑过时丢给你一张卷轴。 你解开羊皮纸发现这是一张布告：%town% 正在举办大型角斗比赛。 挺过数轮的胜者将赢得一份奖励，当然还有赞美与名誉。 | [img]gfx/ui/events/event_34.png[/img]你找到一个男人半蹲在路边。 半裸，而且根据他衣服的状况，不是他自己脱的。 他解释道他本来是要去 %town% 参加角斗比赛，但是一群无赖抢劫了他。 对他的不幸没有兴趣，你询问他这些比赛的事情。 他解释道那是一系列像个斗技场一样的角斗，最终的胜利者会有一份丰厚的奖励。他摇起头来。.%SPEECH_ON%我想我拿到的唯一奖项就是我给人打了一顿。 嘿，你看起来需要帮手，你说我…%SPEECH_OFF%你走开了，思索着是否去寻找 %town% 和它的节日竞技场。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Interesting.",
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

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (currentTile.SquareCoords.Y >= this.World.getMapSize().Y * 0.6)
		{
			return;
		}

		local town;
		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.isSouthern() && t.hasSituation("situation.arena_tournament"))
			{
				town = t;
				break;
			}
		}

		if (town == null)
		{
			return;
		}

		this.m.Town = town;
		this.m.Score = 50;
	}

	function onPrepare()
	{
		this.m.Town.getSituationByID("situation.arena_tournament").setValidForDays(5);
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"town",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Town = null;
	}

});

