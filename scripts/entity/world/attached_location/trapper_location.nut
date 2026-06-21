this.trapper_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "陷猎者";
		this.m.ID = "attached_location.trapper";
		this.m.Description = "这些小屋为陷猎者提供了住所，他们设置陷阱猎捕有着珍贵毛皮的动物。";
		this.m.Sprite = "world_trapper_01";
		this.m.SpriteDestroyed = "world_trapper_01_ruins";
	}

	function onUpdateProduce( _list )
	{
		_list.push("trade/furs_item");
	}

	function onUpdateDraftList( _list )
	{
		if (!this.isActive())
		{
			return;
		}

		_list.push("peddler_background");
		_list.push("caravan_hand_background");
		_list.push("poacher_background");
	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/furs_item"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/hunting_bow"
			});
		}
		else if (_id == "building.specialized_trader")
		{
		}
	}

});

