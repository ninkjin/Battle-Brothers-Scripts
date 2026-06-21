this.tundra_elk_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "在一个小湖边的树荫下，一只孤独的驼鹿正在啃食绿色的草场。";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.tundra_elk_location";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = false;
		this.m.VisibilityMult = 0.0;
		this.m.Resources = 0;
		this.m.OnEnter = "event.location.tundra_elk_enter";
		this.m.OnDestroyed = "event.location.tundra_elk_destroyed";
	}

	function onSpawned()
	{
		this.m.Name = "狩猎场";
		this.location.onSpawned();
		this.Const.World.Common.addTroop(this, {
			Type = this.Const.World.Spawn.Troops.TricksterGod
		}, true);
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
		body.setBrush("world_tundra_location");
	}

});

