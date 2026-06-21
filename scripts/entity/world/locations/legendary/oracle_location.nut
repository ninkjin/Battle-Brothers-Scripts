this.oracle_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "一个旧远时代的神喻所的遗迹。尽管现在成了废墟，人们仍从各地来到这里并看到未来之事的幻象。";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.holy_site.oracle";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsAttackable = false;
		this.m.IsDestructible = false;
		this.m.VisibilityMult = 0.8;
		this.m.Resources = 0;
		this.m.OnEnter = "event.location.oracle_enter";
	}

	function onSpawned()
	{
		this.m.Name = "神谕之所";
		this.location.onSpawned();
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_holy_site_02");
		local banner = this.addSprite("banner");
		banner.setOffset(this.createVec(90, 80));
	}

});

