this.peat_bricks_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.peat_bricks";
		this.m.Name = "泥炭砖";
		this.m.Description = "由干燥后的泥炭制成的砖，通常用作燃料。商人会为此付个好价钱。";
		this.m.Icon = "trade/inventory_trade_08.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.peat_pit"
		];
		this.m.Value = 100;
	}

});

