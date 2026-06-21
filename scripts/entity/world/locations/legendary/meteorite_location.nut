this.meteorite_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "一块从天而降的陨石砸出来的大坑。很久之前一个陵墓曾环绕着它建造，而今天世界各地的人们都到此地朝圣。";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.holy_site.meteorite";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsAttackable = false;
		this.m.IsDestructible = false;
		this.m.VisibilityMult = 0.8;
		this.m.Resources = 0;
		this.m.OnEnter = "event.location.meteorite_enter";
	}

	function onSpawned()
	{
		this.m.Name = "陨落星辰";
		this.location.onSpawned();
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_holy_site_01");
		local banner = this.addSprite("banner");
		banner.setOffset(this.createVec(-60, 50));
	}

});

