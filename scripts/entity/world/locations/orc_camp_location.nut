this.orc_camp_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "兽人建立的一个小营地，要么是附近一个大部落的一部分，要么是单独的一个小部落。他们最终会转移到其他地方去打猎和劫掠。";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.orc_camp";
		this.m.LocationType = this.Const.World.LocationType.Lair | this.Const.World.LocationType.Mobile;
		this.m.CombatLocation.Template[0] = "tactical.orc_camp";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = true;
		this.setDefenderSpawnList(this.Const.World.Spawn.OrcDefenders);
		this.m.Resources = 140;
		this.m.NamedWeaponsList = this.Const.Items.NamedOrcWeapons;
		this.m.NamedShieldsList = this.Const.Items.NamedOrcShields;
	}

	function onSpawned()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(this.Const.World.LocationNames.GreenskinCamp);
		this.location.onSpawned();
	}

	function onDropLootForPlayer( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(this.Math.rand(10, 25), _lootTable);
		this.dropMedicine(this.Math.rand(0, 2), _lootTable);
		this.dropFood(this.Math.rand(2, 4), [
			"strange_meat_item"
		], _lootTable);
		this.dropTreasure(this.Math.rand(0, 1), [
			"trade/furs_item",
			"trade/copper_ingots_item"
		], _lootTable);

		if (this.Const.DLC.Unhold && this.Math.rand(1, 100) <= 10)
		{
			local treasure = [];
			treasure.push("misc/paint_black_item");
			treasure.push("misc/paint_red_item");
			this.dropTreasure(1, treasure, _lootTable);
		}
	}

	function onInit()
	{
		this.location.onInit();
		this.setVisibleInFogOfWar(true);
		local body = this.addSprite("body");
		body.setBrush("world_orc_camp_01");
	}

});

