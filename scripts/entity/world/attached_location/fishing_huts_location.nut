this.fishing_huts_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "捕鱼小屋";
		this.m.ID = "attached_location.fishing_huts";
		this.m.Description = "由网、矛、钩和其他捕鱼装备包围的一堆小棚屋。篮子里的鱼肠子气味传得很远。";
		this.m.Sprite = "world_fishing_huts_01";
		this.m.SpriteDestroyed = "world_fishing_huts_01_ruins";
	}

	function onUpdateProduce( _list )
	{
		_list.push("supplies/dried_fish_item");
	}

	function onUpdateDraftList( _list )
	{
		if (!this.isActive())
		{
			return;
		}

		_list.push("fisherman_background");
		_list.push("fisherman_background");
		_list.push("fisherman_background");
	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/dried_fish_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/militia_spear"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "tools/throwing_net"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "tools/throwing_net"
			});
		}
	}

	function onInit()
	{
		this.attached_location.onInit();
		this.getSprite("body").Scale = 0.9;
	}

});

