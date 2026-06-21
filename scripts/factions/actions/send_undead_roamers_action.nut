this.send_undead_roamers_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "send_undead_roamers_action";
		this.m.Cooldown = 30.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (this.World.getTime().Days < 20)
		{
			return;
		}

		local settlements = _faction.getSettlements();

		if (settlements.len() < 6)
		{
			return;
		}

		if (_faction.getUnits().len() >= 3)
		{
			return;
		}

		local allowed = false;

		foreach( s in _faction.getSettlements() )
		{
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
			if (s.getRoamerSpawnList() == null)
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

		if (settlements.len() == 0)
		{
			return;
		}

		local settlement = this.pickWeightedRandom(settlements);
		settlement.setLastSpawnTimeToNow();
		local party = this.getFaction().spawnEntity(settlement.getTile(), "Undead", false, settlement.getRoamerSpawnList(), this.Math.max(settlement.getResources() * 0.75, this.Math.rand(60, 100) * this.getReputationToDifficultyLightMult()));
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("似乎不太对劲。");
		party.setFootprintType(this.Const.World.FootprintsType.Undead);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().Money = this.Math.rand(0, 100);
		party.getLoot().ArmorParts = this.Math.rand(0, 10);
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			party.addToInventory("loot/signet_ring_item");
		}

		local c = party.getController();
		local roam = this.new("scripts/ai/world/orders/roam_order");
		roam.setAllTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
		roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
		roam.setPivot(settlement);
		roam.setAvoidHeat(true);
		roam.setTime(this.World.getTime().SecondsPerDay * 2);
		roam.setMinRange(1);
		roam.setMaxRange(5);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(settlement.getTile());
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(roam);
		c.addOrder(move);
		c.addOrder(despawn);
	}

});

