this.cloth_rolls_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.cloth_rolls";
		this.m.Name = "布匹卷";
		this.m.Description = "用羊毛纺织而成的布匹卷。商人会为此付个好价钱。";
		this.m.Icon = "trade/inventory_trade_09.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.ProducingBuildings = [
			"attached_location.wool_spinner"
		];
		this.m.Value = 140;
	}

});

