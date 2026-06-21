this.alchemist_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.alchemist";
		this.m.Name = "炼金术士";
		this.m.Description = "炼金术士在使用奇异材料制作各种神秘的装置及药剂方面有着丰富的知识，只需让他能够使用剥制屋的设备，并且他会消耗掉更少的材料。";
		this.m.Image = "ui/campfire/alchemist_01";
		this.m.Cost = 2500;
		this.m.Effects = [
			"有25%的几率在制作时不消耗你使用的原料组件",
			"解锁‘蛇油’配方，使用各种低阶材料制作以谋取利润"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

	function isValid()
	{
		return this.Const.DLC.Unhold;
	}

	function onUpdate()
	{
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "在剥制屋里制造 " + this.Math.min(15, this.World.Statistics.getFlags().getAsInt("ItemsCrafted")) + "/15件物品";

		if (this.World.Statistics.getFlags().getAsInt("ItemsCrafted") >= 15)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

