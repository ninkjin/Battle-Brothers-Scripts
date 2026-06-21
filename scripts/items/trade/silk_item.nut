this.silk_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.silk";
		this.m.Name = "丝绸";
		this.m.Description = "这些光滑的丝绸布料很难入手。只有最富有和最高贵的人才能负担的起用丝绸裁制的衣物，而且他们的价格很高，特别是在北方。";
		this.m.Icon = "trade/inventory_trade_11.png";
		this.m.Culture = this.Const.World.Culture.Southern;
		this.m.ProducingBuildings = [
			"attached_location.silk_farm"
		];
		this.m.Value = 460;
	}

});

