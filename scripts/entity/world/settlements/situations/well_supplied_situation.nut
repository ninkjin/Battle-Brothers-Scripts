this.well_supplied_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.well_supplied";
		this.m.Name = "供给充足";
		this.m.Description = "这个地方最近被供应了新鲜的货物，其中许多现在可以以合适的价格买到。";
		this.m.Icon = "ui/settlement_status/settlement_effect_03.png";
		this.m.Rumors = [
			"跟%settlement%的贸易正在蓬勃发展，我的朋友！安全的道路和充足的库存，希望它能一直保持这样…",
			"我在%settlement%的表哥一直在吹嘘那边有多好，存货充足的市场摊位等等。不像这个烂地方。"
		];
		this.m.IsStacking = false;
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
		_settlement.removeSituationByID("situation.ambushed_trade_routes");
		_settlement.resetShop();
	}

	function onUpdate( _modifiers )
	{
		_modifiers.PriceMult *= 0.9;
		_modifiers.RarityMult *= 1.15;
	}

});

