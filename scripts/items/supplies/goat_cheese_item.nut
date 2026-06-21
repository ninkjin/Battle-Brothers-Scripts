this.goat_cheese_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.goat_cheese";
		this.m.Name = "山羊奶酪";
		this.m.Description = "食物。山羊奶酪是一种美味且多油的食物，在北方的寒冷地区尤其常见和受欢迎。";
		this.m.Icon = "supplies/inventory_provisions_09.png";
		this.m.Value = 85;
		this.m.GoodForDays = 11;
	}

	function getBuyPrice()
	{
		if (this.m.IsSold)
		{
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			local isBuildingPresent = this.World.State.getCurrentTown().hasAttachedLocation("attached_location.goat_herd");
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getPriceMult() * this.World.State.getCurrentTown().getBuyPriceMult() * this.World.State.getCurrentTown().getFoodPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseBuyPrice : this.Const.World.Assets.BuyPriceNotProducedHere)));
		}

		return this.item.getBuyPrice();
	}

	function getSellPrice()
	{
		if (this.m.IsBought)
		{
			return this.getBuyPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			local isBuildingPresent = this.World.State.getCurrentTown().hasAttachedLocation("attached_location.goat_herd");
			return this.Math.floor(this.getValue() * this.World.State.getCurrentTown().getSellPriceMult() * this.World.State.getCurrentTown().getFoodPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseSellPrice : this.Const.World.Assets.SellPriceNotProducedHere));
		}

		return this.item.getSellPrice();
	}

});

