this.enter_friendly_town_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null
	},
	function create()
	{
		this.m.ID = "event.enter_friendly_town";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_85.png[/img]{你到达 %townname% 大概是为了庆祝一下。 镇上的一位议员向你问好，提供点心。 | %townname% 对你照顾他们的生意表示了感谢，因此他们为你的队员们献上了一些点心。%randombrother% 碰掉了几个杯子，年轻的女服务员被吓坏了。 他擦了擦嘴。%SPEECH_ON%谢谢啊。请再来点。%SPEECH_OFF% | %townname% 的生意一直很好，而那里的人似乎越来越感激你：今天你们的到来，他们给予你 { 大量无用的口头感谢 | 暴风雨般的称颂 | 一大堆对你来说没啥用鲜花 | 你平时会扔掉的那种小饰品和其他东西，因为就算农民们都看不上 | 一盘被你的队员们迅速干掉的啤酒 | 一桶被你的队员们口无遮拦的批评为“木头味道”的啤酒， | 几个你会求婚，被你的优雅地拒绝 | a few marriage proposals which you can't turn down fast enough | 一个丑女村妇的求婚。她的脸能挡住日晷，所以你必然拒绝 | 一场语无伦次的表演，虽然他们的语气似乎很愉快 | 后背几个大巴掌. 你提醒他们下次这么干可能会被剁手 | 送你一些孤儿。 你不知道是什么让他们产生了你会接受这样一份礼物的想法，总之你把孩子们送回了他们悲伤的家 -- 也被称为街道}。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "总是很高兴在 %townname%。",
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
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();
		local nearTown = false;
		local town;

		foreach( t in towns )
		{
			if (t.isMilitary() || t.isSouthern())
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer() && t.getFactionOfType(this.Const.FactionType.Settlement).getPlayerRelation() > 80)
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		this.m.Town = town;
		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Town = null;
	}

});

