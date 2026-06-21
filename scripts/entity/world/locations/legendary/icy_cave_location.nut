this.icy_cave_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "位于冰雪和乱石海洋之中的一个洞穴。一扇厚厚的冰柱大门阻挡了你的正常进入。";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.icy_cave_location";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = false;
		this.m.VisibilityMult = 0.8;
		this.m.Resources = 0;
		this.m.OnEnter = "event.location.icy_cave_enter";
	}

	function onSpawned()
	{
		this.m.Name = "冰洞";
		this.location.onSpawned();
	}

	function onDiscovered()
	{
		this.location.onDiscovered();
		this.World.Flags.increment("LegendaryLocationsDiscovered", 1);

		if (this.World.Flags.get("LegendaryLocationsDiscovered") >= 10)
		{
			this.updateAchievement("FamedExplorer", 1, 1);
		}
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_snow_cave");
	}

});

