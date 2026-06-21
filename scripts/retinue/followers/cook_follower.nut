this.cook_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.cook";
		this.m.Name = "厨师";
		this.m.Description = "一顿热腾腾的饭菜对于恢复身心健康有很大帮助。厨师会确保食物不会被浪费，并为大家提供能够振奋精神的菜肴。";
		this.m.Image = "ui/campfire/cook_01";
		this.m.Cost = 2000;
		this.m.Effects = [
			"使所有的食物都能多维持3天",
			"增加33%的生命值治愈速度"
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
		this.World.Assets.m.FoodAdditionalDays = 3;
		this.World.Assets.m.HitpointsPerHourMult = 1.33;
	}

	function onEvaluate()
	{
		local uniqueProvisions = this.getAmountOfUniqueProvisions();
		this.m.Requirements[0].Text = "拥有" + this.Math.min(8, uniqueProvisions) + "/8种不同类型的食物";

		if (uniqueProvisions >= 8)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

	function getAmountOfUniqueProvisions()
	{
		local provisions = [];
		local items = this.World.Assets.getStash().getItems();

		foreach( item in items )
		{
			if (item != null && item.isItemType(this.Const.Items.ItemType.Food))
			{
				if (provisions.find(item.getID()) == null)
				{
					provisions.push(item.getID());
				}
			}
		}

		return provisions.len();
	}

});

