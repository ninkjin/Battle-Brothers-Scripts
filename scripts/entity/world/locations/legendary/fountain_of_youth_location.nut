this.fountain_of_youth_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "在森林中的一小块空地，中间是一颗纤细且奇怪的树。这棵树看起来有点不对劲，但从远处很难弄清楚细节。";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.fountain_of_youth";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = false;
		this.m.VisibilityMult = 0.9;
		this.m.Resources = 0;
		this.m.OnEnter = "event.location.fountain_of_youth";
	}

	function onSpawned()
	{
		this.m.Name = "怪诞树";
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
		body.setBrush("world_fountain_of_youth");
	}

});

