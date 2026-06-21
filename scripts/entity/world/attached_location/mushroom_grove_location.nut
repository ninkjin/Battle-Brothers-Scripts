this.mushroom_grove_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "蘑菇林";
		this.m.ID = "attached_location.mushroom_grove";
		this.m.Description = "在泥泞和芦苇中，专业的采集者可以找到长满珍贵蘑菇的小树林和洞穴。";
		this.m.Sprite = "world_mushroom_grove_01";
		this.m.SpriteDestroyed = "world_mushroom_grove_01_ruins";
	}

	function onUpdateProduce( _list )
	{
		_list.push("supplies/pickled_mushrooms_item");
	}

	function onUpdateDraftList( _list )
	{
		if (!this.isActive())
		{
			return;
		}

		_list.push("cultist_background");
		_list.push("cultist_background");
		_list.push("flagellant_background");
		_list.push("wildman_background");
	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/pickled_mushrooms_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "armor/apron"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/medicine_item"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "accessory/berserker_mushrooms_item"
			});
		}
	}

});

