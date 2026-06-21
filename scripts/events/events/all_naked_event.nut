this.all_naked_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.all_naked";
		this.m.Title = "在路上…";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_16.png[/img]行军途中，你看到一个旅行者持续前后摇摆，而他的手却始终不知道是遮蔽阳光还是蒙住自己双眼。 他摇摇头，吐了一口唾沫。%SPEECH_ON%我听到你们的消息了。 在一个邪恶的国度里，没有穿裤子的人，就像一些恶魔戏剧般的冒了出来。 你在搞什么鬼？%SPEECH_OFF%你耸耸肩告诉那个人，到目前为止，你不需要皮革，盘子或腰布。 在一次地，旅行者摇摇头并吐了一口唾沫。%SPEECH_ON%扯蛋。一个身无分文的人在战斗中会比他出生的那天更一丝不挂！ 我觉得讽刺的是，如果我们－我是说任何人－我们－发现你死在田野里，我们会把你打扮的更体面然后下葬，绝对比你现在要体面。 这并不难，因为你以后不会再有衣服穿了。%SPEECH_OFF%你挥了挥手，感谢旅行者的忠言，然后继续愉快的行程。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "真是美好的一天！",
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
		if (this.World.getTime().Days < 14)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			if (bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null)
			{
				return;
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

