this.have_y_renown_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.have_y_renown";
		this.m.Duration = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "我们已经在这片大陆的一些地方为人所知，但我们还远远不是一个传奇战队。 我们将进一步提高我们的声望！";
		this.m.UIText = "达到“荣耀”声望";
		this.m.TooltipText = "以“荣耀”（2750声望）闻名于大陆。 你可以通过完成合同和赢得战斗来提高自己的声望。";
		this.m.SuccessText = "[img]gfx/ui/events/event_82.png[/img]穿过森林，穿过平原，这支队伍粉碎了所有被派去追捕的敌人。 践踏敌人，粉碎战线，让脑袋飞起来，%companyname% 发现他们很少是单独行动。 当他们行军时，乌鸦在队伍上空盘旋；当人们吃晚饭时，乌鸦歌唱；当他们完成日常工作后，它们往往会饱餐一顿。\n\n在他们身后，他们留下了焦土和古怪的谣言，每一个故事都在讲述，直到每个人，从挤奶女工到铁匠，再到市长，似乎都在谈论你的功绩。 流言是一种货币，在这片土地的每个角落都有价值，无论是宽阔的河流还是高耸的山峰都不能减缓你胜利的故事，反过来，你现在可以要求你的服务的价格。";
		this.m.SuccessButtonText = "人们现在知道 %companyname% 了！";
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 30)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() >= 2650)
		{
			this.m.IsDone = true;
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.Assets.getBusinessReputation() >= 2750)
		{
			return true;
		}

		return false;
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

