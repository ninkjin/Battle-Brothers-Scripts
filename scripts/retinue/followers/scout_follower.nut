this.scout_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.scout";
		this.m.Name = "斥候";
		this.m.Description = "斥候在寻找山口，穿越险恶沼泽，以及引导人们安全穿越最黑暗的森林方面都是一名专家。";
		this.m.Image = "ui/campfire/scout_01";
		this.m.Cost = 2500;
		this.m.Effects = [
			"使战团在任意地形上的行进速度均提高15%",
			"防止因地形造成的伤病和事故"
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
		for( local i = 0; i < this.World.Assets.m.TerrainTypeSpeedMult.len(); i = ++i )
		{
			this.World.Assets.m.TerrainTypeSpeedMult[i] *= 1.15;
		}
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "赢得" + this.Math.min(5, this.World.Statistics.getFlags().getAsInt("BeastsDefeated")) + "/5场与野兽的战斗";

		if (this.World.Statistics.getFlags().getAsInt("BeastsDefeated") >= 5)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

