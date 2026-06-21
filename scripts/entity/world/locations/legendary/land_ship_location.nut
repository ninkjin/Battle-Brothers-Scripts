this.land_ship_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "在一些树的顶部有着一个大型木质建筑。虽然怎么说都很奇怪，但它看起来像一艘船。";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.land_ship";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = false;
		this.m.VisibilityMult = 0.9;
		this.m.Resources = 0;
		this.m.OnEnter = "event.location.golden_goose";
	}

	function onSpawned()
	{
		this.m.Name = "奇怪的沉船";
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
		body.setBrush("world_goose");
	}

});

