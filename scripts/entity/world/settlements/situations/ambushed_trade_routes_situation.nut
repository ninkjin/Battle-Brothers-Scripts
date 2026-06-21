this.ambushed_trade_routes_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.ambushed_trade_routes";
		this.m.Name = "商路被埋伏";
		this.m.Description = "最近通往这里的道路不安全，许多商队遭到了伏击和抢掠。由于成功的贸易太少，货物的种类变少并且价格更高。";
		this.m.Icon = "ui/settlement_status/settlement_effect_12.png";
		this.m.Rumors = [
			"强盗和掠夺者是我们旅行商人的祸根！我的一个老朋友就在%settlement%外面遭到了埋伏、抢劫和殴打！",
			"如果你身上有贵重物品，请远离%settlement%。那个地方被歹徒、强盗和响马给祸害了！",
			"卫兵们正在尽他们所能，但这些强盗们只是转移到下一个城镇，然后拦路抢劫商人。据说他们现在潜伏在%settlement%周围！"
		];
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
		_settlement.removeSituationByID("situation.safe_roads");
		_settlement.resetShop();
	}

	function onUpdate( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.2;
		_modifiers.SellPriceMult *= 1.1;
		_modifiers.RarityMult *= 0.75;
	}

});

