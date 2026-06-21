this.patrol_area_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "patrol_area_action";
		this.m.Cooldown = 400.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (!_faction.isReadyToSpawnUnit())
		{
			return;
		}

		this.m.Score = 10;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local settlements = _faction.getSettlements();
		local party = _faction.spawnEntity(settlements[0].getTile(), "Regiment of " + settlements[0].getName(), true, this.Const.World.Spawn.Southern, this.Math.rand(120, 250) * this.getReputationToDifficultyLightMult());
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + _faction.getBannerString());
		party.setDescription("忠于城邦的应征士兵。");
		party.setFootprintType(this.Const.World.FootprintsType.CityState);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().Money = this.Math.rand(50, 200);
		party.getLoot().ArmorParts = this.Math.rand(0, 25);
		party.getLoot().Medicine = this.Math.rand(0, 3);
		party.getLoot().Ammo = this.Math.rand(0, 30);
		local r = this.Math.rand(1, 4);

		if (r <= 2)
		{
			party.addToInventory("supplies/rice_item");
		}
		else if (r == 3)
		{
			party.addToInventory("supplies/dates_item");
		}
		else if (r == 4)
		{
			party.addToInventory("supplies/dried_lamb_item");
		}

		local c = party.getController();
		local roam = this.new("scripts/ai/world/orders/roam_order");
		roam.setAllTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
		roam.setTerrain(this.Const.World.TerrainType.Shore, false);
		roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
		roam.setPivot(settlements[0]);
		roam.setMinRange(1);
		roam.setMaxRange(10);
		roam.setTime(200.0);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(settlements[0].getTile());
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(roam);
		c.addOrder(move);
		c.addOrder(despawn);
		this.m.Cooldown = this.World.FactionManager.isGreaterEvil() ? 200.0 : 400.0;
		return true;
	}

});

