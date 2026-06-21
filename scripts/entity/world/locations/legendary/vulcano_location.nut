this.vulcano_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "曾经是一座繁荣的城市，现在不过是灰烬笼罩的废墟。这座失落的城市有着许多名字，现在它成为了南北共有的文化和宗教圣地。";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.holy_site.vulcano";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsAttackable = false;
		this.m.IsDestructible = false;
		this.m.VisibilityMult = 0.8;
		this.m.Resources = 0;
		this.m.OnEnter = "event.location.vulcano_enter";
	}

	function onSpawned()
	{
		this.m.Name = "古代城市";
		this.location.onSpawned();
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_holy_site_03");
		local banner = this.addSprite("banner");
		banner.setOffset(this.createVec(-20, 60));
	}

});

