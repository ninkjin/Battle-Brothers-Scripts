this.surgeon_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.surgeon";
		this.m.Name = "外科医生";
		this.m.Description = "这位外科医生是人体结构的活百科。在雇佣兵战团中既可以将这些知识应用于治疗，也可以更多地了解人类的内部构造，对他而言是个理想的地方。";
		this.m.Image = "ui/campfire/surgeon_01";
		this.m.Cost = 3500;
		this.m.Effects = [
			"使每个没有永久伤势的人都能在一般会致命的伤害中幸存下来",
			"使每个伤势治愈所需时间均减少一天"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

	function onUpdate()
	{
		this.World.Assets.m.IsSurvivalGuaranteed = true;
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "在寺庙治疗" + this.Math.min(5, this.World.Statistics.getFlags().getAsInt("InjuriesTreatedAtTemple")) + "/5次手下的伤势";

		if (this.World.Statistics.getFlags().getAsInt("InjuriesTreatedAtTemple") >= 5)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

