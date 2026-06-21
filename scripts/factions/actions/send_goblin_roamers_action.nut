this.send_goblin_roamers_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "send_goblin_roamers_action";
		this.m.Cooldown = 30.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		local settlements = _faction.getSettlements();

		if (settlements.len() <= 6)
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
		local party = this.getFaction().spawnEntity(settlement.getTile(), "Goblin Hunters", false, this.Const.World.Spawn.GoblinRoamers, this.Math.min(settlement.getResources(), this.Math.rand(50, 100)) * this.getReputationToDifficultyLightMult());
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("一群淘气的哥布林，小而狡猾，不可低估。");
		party.setFootprintType(this.Const.World.FootprintsType.Goblins);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = this.Math.rand(0, 5);
		party.getLoot().Medicine = this.Math.rand(0, 3);
		party.getLoot().Ammo = this.Math.rand(10, 30);
		local numFood = this.Math.rand(1, 2);

		for( local i = 0; i != numFood; i = ++i )
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				party.addToInventory("supplies/strange_meat_item");
			}
			else
			{
				party.addToInventory("supplies/roots_and_berries_item");
			}
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

