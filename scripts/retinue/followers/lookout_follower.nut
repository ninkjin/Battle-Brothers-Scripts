this.lookout_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.lookout";
		this.m.Name = "观察员";
		this.m.Description = "拥有一名行动迅速目光敏锐的观察员在战队前面侦查是极其有用的，可以在其它人发现战团之前发现危险和有价值的地点。";
		this.m.Image = "ui/campfire/lookout_01";
		this.m.Cost = 2500;
		this.m.Effects = [
			"使你的视野范围增大25%",
			"显示更多关于足迹的信息"
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
		this.World.Assets.m.VisionRadiusMult = 1.25;
		this.World.Assets.m.IsShowingExtendedFootprints = true;
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "独力发现" + this.Math.min(10, this.World.Statistics.getFlags().getAsInt("LocationsDiscovered")) + "/10个地点";

		if (this.World.Statistics.getFlags().getAsInt("LocationsDiscovered") >= 10)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

