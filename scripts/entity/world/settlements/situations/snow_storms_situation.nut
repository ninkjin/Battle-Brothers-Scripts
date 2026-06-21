this.snow_storms_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.snow_storms";
		this.m.Name = "暴风雪";
		this.m.Description = "暴风雪或多或少地将这个定居点与外界的贸易隔离开来。因为进入市场的新商品很少，所以选择有限，价格也较高。";
		this.m.Icon = "ui/settlement_status/settlement_effect_20.png";
		this.m.Rumors = [
			"%settlement%那边正遭受坏天气，看起来像是一场暴风雪。"
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 3;
	}

	function getAddedString( _s )
	{
		return _s + "遭受" + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + "不再遭受" + this.m.Name;
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
	}

	function onUpdate( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.2;
		_modifiers.SellPriceMult *= 1.1;
		_modifiers.RarityMult *= 0.75;
	}

});

