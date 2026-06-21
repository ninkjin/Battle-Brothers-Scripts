this.uncut_gems_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.uncut_gems";
		this.m.Name = "宝石毛料";
		this.m.Description = "正等着被切割并抛光的粗糙宝石毛料。商人会为此付个好价钱。";
		this.m.Icon = "trade/inventory_trade_06.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.gem_mine"
		];
		this.m.Value = 520;
	}

});

