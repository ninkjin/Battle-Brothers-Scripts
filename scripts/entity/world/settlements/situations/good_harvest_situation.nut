this.good_harvest_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.good_harvest";
		this.m.Name = "五谷丰登";
		this.m.Description = "农作物生长的条件一直很完美。食物很容易买到，价格也较低。";
		this.m.Icon = "ui/settlement_status/settlement_effect_17.png";
		this.m.Rumors = [
			"如果你需要补充食物储备，就去%settlement%吧。那些幸运的混蛋今年度过了一个丰收的季节。",
			"我从%settlement%来这里卖我们富裕的产品。众神一直对我们微笑，赐予我们多年来最好的收成！",
			"我刚刚了解到，%settlement%的粮仓和食物贮藏室因为丰收的缘故塞的满满当当的。"
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 7;
	}

	function getAddedString( _s )
	{
		return _s + "受益于" + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + "不再受益于" + this.m.Name;
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
	}

	function onUpdate( _modifiers )
	{
		_modifiers.FoodRarityMult *= 2.0;
		_modifiers.FoodPriceMult *= 0.5;
	}

});

