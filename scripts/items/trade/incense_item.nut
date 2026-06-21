this.incense_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.incense";
		this.m.Name = "熏香";
		this.m.Description = "这些干燥后的树液片能创造出充满神秘和奇特气味的浓浓烟雾。能够卖出个好价钱，尤其是在北方。";
		this.m.Icon = "trade/inventory_trade_12.png";
		this.m.Culture = this.Const.World.Culture.Southern;
		this.m.ProducingBuildings = [
			"attached_location.incense_dryer"
		];
		this.m.Value = 380;
	}

	function getSellPriceMult()
	{
		return this.World.State.getCurrentTown().getModifiers().IncensePriceMult;
	}

	function getBuyPriceMult()
	{
		return this.World.State.getCurrentTown().getModifiers().IncensePriceMult;
	}

});

