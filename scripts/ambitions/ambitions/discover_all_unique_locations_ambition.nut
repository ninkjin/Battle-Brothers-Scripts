this.discover_all_unique_locations_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.discover_all_unique_locations";
		this.m.Duration = 7.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "世界各地的传说地点，隐藏着奇妙的秘密。\n在我们不找到它们的每一个前绝不罢休！";
		this.m.UIText = "发现世界上所有传奇地点";
		this.m.TooltipText = "通过自己探索荒野，发现世界上所有传奇宝藏。 出发前一定要储备好食物！";
		this.m.SuccessText = "[img]gfx/ui/events/event_45.png[/img]你地图的边缘已磨损，其折痕磨损得很厉害，以至于你可以手指明显感觉到。 这张纸比它看起来要重要，它是用来保护你免受雨雪侵袭的，它被塞进了你睡觉的稻草下面，而且它还被威胁在危急时刻用作引火物。 但它也比它看起来要轻，因为风已经直接从你的手指上偷走了它好几次了，你一直在田野里追逐它，而你却像一只要失去追逐目标的豺狼一样大喊大叫，在它扭来扭去逃跑时，还骂它是婊子干的活。\n\n根据最初制图师的作品，你的战队不会离开道路或城镇。 他曾写过诸如“厄运和厄运只会”和“这里有强盗和他们不好的母亲”之类的警告。 你忽略了其中的许多内容，用你自己的探索性画界的蜿蜒线条画在了它上面。 这些地方不是信念中的地方，而是 %companyname% 想去也确实去过的地方。 由于在一张松软的地图上蚀刻线条，你已经成为世界上长期闭关自守的地方的臭名昭著的准探险家了。 除了这个地方之外，还有什么别的地方呢？";
		this.m.SuccessButtonText = "我们绘制自己的地图。";
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.discover_unique_locations").isDone())
		{
			return;
		}

		if (!this.World.Flags.has("LegendaryLocationsDiscovered"))
		{
			this.World.Flags.set("LegendaryLocationsDiscovered", 0);
		}

		if (this.World.Flags.get("LegendaryLocationsDiscovered") >= 11)
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		return this.World.Flags.get("LegendaryLocationsDiscovered") >= 11;
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
	}

});

