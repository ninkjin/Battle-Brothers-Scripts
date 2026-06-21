this.holywar_flavor_south_settlement_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.holywar_flavor_south_settlement";
		this.m.Title = "在路上…";
		this.m.Cooldown = 20.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_97.png[/img]孩子们从沙丘后探出头来，错过了另一群躲在遮蔽物阴影下的孩子。 当第一批士兵越过顶端，埋伏着的孩子们跳出来用木棍扎他们并将他们击倒。%SPEECH_ON%死吧北方人，让镀金者的目光沐浴我们！%SPEECH_OFF%被击倒的孩子们耷拉着滑下沙丘，直到他们突然跳起并开始争论是时候让他们来扮演“好家伙.” 看来圣战已经激励了下一代，让他们在时机成熟时做好准备。 | [img]gfx/ui/events/event_166.png[/img]一排又一排的忠实信徒们趴向沙漠以向镀金者祈祷。 各种各样的人，男人，女人，儿童，也有不同之处，一些贫穷的乞丐旁边还有富商。 唯一的突出者是维齐尔与议员们，他们都在游行队伍前面的牧师旁边祈祷 这是说如果他们真的在祈祷的话：至少从你这里看，议会成员间在轻声低语着什么，有的对仪式毫无关注。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "奇怪的时代。",
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
				if (t.isSouthern() && t.getTile().getDistanceTo(playerTile) <= 5 && t.isAlliedWithPlayer())
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

