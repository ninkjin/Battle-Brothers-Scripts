this.ijirok_2_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.ijirok_2";
		this.m.Title = "在途中…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_143.png[/img]{雪原上的斑点吸引了你的眼睛。 你和几个侦察兵一起出去看它是什么，怀疑可能只是一具动物尸体或废弃的营地。 恰恰相反，你发现了一些赤身裸体的尸体，他们蜷缩着身体，就像坐在椅子上一样。 他们密密麻麻围成一个圈，个个脸朝内，有的伸出手来，仿佛在火炉旁取暖。 你推一具尸体。 当身体向后倾斜时，坐在对面的身体就会站起来。%randombrother% 向后跳去。%SPEECH_ON%旧神啊！%SPEECH_OFF%粉末状的雪下刚好有一圈肉，一个环把一具尸体和另一具尸体连接起来，这是一种你无法理解的群体性亵渎行为。 他们的皮肤向内延伸，在一个从雪地里冒出来的像是一个可怕的花盆在血肉支点上汇合。 里面什么都没有。其中一名侦察兵要求安全的返回战队，你非常同意他的意见。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "别对其他人说。",
					function getResult( _event )
					{
						this.World.Flags.set("IjirokStage", 2);
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

		if (!this.World.Flags.has("IjirokStage") || this.World.Flags.get("IjirokStage") == 0 || this.World.Flags.get("IjirokStage") >= 5)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Snow || currentTile.Type != this.Const.World.TerrainType.SnowyForest)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 12)
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

