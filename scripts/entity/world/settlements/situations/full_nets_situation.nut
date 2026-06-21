this.full_nets_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.full_nets";
		this.m.Name = "渔获颇丰";
		this.m.Description = "水里满是鱼群。新鲜的鱼获极多，而且价格低廉。";
		this.m.Icon = "ui/settlement_status/settlement_effect_19.png";
		this.m.Rumors = [
			"每年这个时候，总会有一大批鱼来到%settlement%附近。他们所需要做的就是把一些网扔进水里，然后拉出比他们能吃掉的更多的鱼！幸运的混蛋们！",
			"明天我要去%settlement%用鱼装满我的货车。有传言说那边的渔民们走运了！",
			"你是做贸易的吗？我听说在%settlement%那边他们的渔网里装满了鱼。"
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 3;
	}

	function getAddedString( _s )
	{
		return _s + "现在有" + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + "不再有" + this.m.Name;
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

