this.send_orc_roamers_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "send_orc_roamers_action";
		this.m.Cooldown = 30.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		local settlements = _faction.getSettlements();

		if (settlements.len() < 8)
		{
			return;
		}

		if (this.World.FactionManager.isGreenskinInvasion())
		{
			if (_faction.getUnits().len() >= 3)
			{
				return;
			}
		}
		else if (_faction.getUnits().len() >= 6)
		{
			return;
		}

		local allowed = false;

		foreach( s in _faction.getSettlements() )
		{
			if (s.getResources() < 100.0)
			{
				continue;
			}

			if (s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF())
			{
				continue;
			}

			allowed = true;
			break;
		}

		if (!allowed)
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
		local settlements = [];

		foreach( s in _faction.getSettlements() )
		{
			if (s.getResources() < 100.0)
			{
				continue;
			}

			if (s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF())
			{
				continue;
			}

			settlements.push({
				D = s,
				P = 10
			});
		}

		local settlement = this.pickWeightedRandom(settlements);
		settlement.setLastSpawnTimeToNow();
		local party = this.getFaction().spawnEntity(settlement.getTile(), "Orc Hunters", false, this.Const.World.Spawn.OrcRoamers, this.Math.min(settlement.getResources(), this.Math.rand(50, 100)) * this.getReputationToDifficultyLightMult());
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("一群凶残的兽人，绿皮肤，高耸于任何人之上。");
		party.setFootprintType(this.Const.World.FootprintsType.Orcs);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = this.Math.rand(0, 25);
		local numFood = this.Math.rand(2, 3);

		for( local i = 0; i != numFood; i = ++i )
		{
			party.addToInventory("supplies/strange_meat_item");
		}

		local c = party.getController();
		local roam = this.new("scripts/ai/world/orders/roam_order");
		roam.setAllTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
		roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
		roam.setPivot(settlement);
		roam.setAvoidHeat(true);
		roam.setTime(this.World.getTime().SecondsPerDay * 2);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(settlement.getTile());
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(roam);
		c.addOrder(move);
		c.addOrder(despawn);
	}

});

