this.amber_shards_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.amber_shards";
		this.m.Name = "琥珀碎片";
		this.m.Description = "主要用于制作项链和戒指的琥珀碎片。商人会为此付个好价钱。";
		this.m.Icon = "trade/inventory_trade_04.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.amber_collector"
		];
		this.m.Value = 260;
	}

});

