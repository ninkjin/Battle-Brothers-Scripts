this.dies_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.dies";
		this.m.Name = "染料";
		this.m.Description = "由各种植物或矿物制成的贵重染料。商人会为此付个好价钱。";
		this.m.Icon = "trade/inventory_trade_02.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.dye_maker"
		];
		this.m.Value = 400;
	}

});

