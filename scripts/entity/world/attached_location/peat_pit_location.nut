this.peat_pit_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "泥炭坑";
		this.m.ID = "attached_location.peat_pit";
		this.m.Description = "在从这些泥炭坑中被挖出并干燥之后，泥炭就成为了一种宝贵的燃料来源。";
		this.m.Sprite = "world_peat_pit_01";
		this.m.SpriteDestroyed = "world_peat_pit_01_ruins";
		this.m.IsConnected = false;
	}

	function onUpdateProduce( _list )
	{
		_list.push("trade/peat_bricks_item");
	}

	function onUpdateDraftList( _list )
	{
		if (!this.isActive())
		{
			return;
		}

		_list.push("daytaler_background");
		_list.push("peddler_background");
	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/peat_bricks_item"
			});
		}

		if (_id == "building.specialized_trader")
		{
		}
	}

	function onInit()
	{
		this.attached_location.onInit();
		this.getSprite("body").Scale = 0.9;
	}

});

