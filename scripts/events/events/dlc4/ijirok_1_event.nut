this.ijirok_1_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.ijirok_1";
		this.m.Title = "在途中…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_143.png[/img]%randombrother% 把你叫下来，说有些东西你应该来看一眼。 毫无疑问，在这片冰天雪地中所隐藏的一些东西是值得一看的。\n\n 佣兵把你带到一个地底的洞穴。 他点燃火把，走了进去，你跟了进去。 在底下你发现了几个你的队员。 他们站在一个看起来像冰做的石棺的周围，只是没有盖子。 黑色的冰冻物质在石棺边缘结成硬块。 房间的角落的墙上贴着一具冰冷的尸体。 他的双手垂在身体两侧，冰冷的血液从手腕流出。 旁边是挂在冰钩上的一件衣服，但没有身体。 衣服上淌出一些其他人的血迹吸引了其他队员，然后引导他们走出了洞穴。%SPEECH_ON%我不知道这该怎么解释，先生。%SPEECH_OFF%一个雇佣兵说道。你问他们是否在侦察中看到了什么，你指的是附近他妈的任何东西。 但他们都摇头说不。 如果石棺里有什么东西，那它肯定是出来了。 你告诉他们离开洞穴，回到营地去。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你还要保持脑子清醒。",
					function getResult( _event )
					{
						this.World.Flags.set("IjirokStage", 1);
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
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (!this.World.Flags.has("IjirokStage") || this.World.Flags.get("IjirokStage") >= 5)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Snow)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 10)
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

