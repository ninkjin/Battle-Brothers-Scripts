this.encounter_gnomes_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.encounter_gnomes";
		this.m.Title = "在途中…";
		this.m.Cooldown = 200.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_25.png[/img]你放松了一下手中的武器，决定亲自前去侦查前方的树林。出发没过五分钟，你就听到了一个稳定的嗡嗡声，似乎是在唱歌。你拔出剑，翻过一座倒下的树木堆看向下方。你看到了一个由一打看起来像是小人的人围成的圆舞曲。有一半吹着低沉的口哨，而另一半则一遍遍地重复着你从未听过的某个词语。在这无聊的表演的中央，有一棵蘑菇和一只看起来很无聊的蟾蜍。在偶尔的情况下，有一个小人会跑上去碰一下蘑菇或者蟾蜍，然后在回到圆舞曲时露出偷窃的表情。\n\n这太过诡异。你向前爬去，想要更仔细地看一看，却没想到碰到一根枝条，发出砰的一声巨响。小人们立刻停止唱歌，像一群猎物一样看向你。其中一个用含糊不清的语言喊叫着，然后所有人都跳着蹦着逃开了，躲进了树洞或灌木丛中。当你到达地面寻找他们时，你却什么都没找到。他们已经完全消失了。你走到树桩旁，发现蟾蜍被一把匕首刺到了最后，而蘑菇已经消失不见了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Strange.",
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

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 25)
			{
				return false;
			}
		}

		this.m.Score = 10;
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

