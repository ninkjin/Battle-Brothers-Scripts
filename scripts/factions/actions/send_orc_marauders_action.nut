this.send_orc_marauders_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "send_orc_marauders_action";
		this.m.Cooldown = 30.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (this.World.getTime().Days <= 5)
		{
			return;
		}

		local settlements = _faction.getSettlements();

		if (settlements.len() < 7)
		{
			return;
		}

		if (this.World.FactionManager.isGreenskinInvasion() && this.World.FactionManager.getGreaterEvilStrength() >= 10.0)
		{
			if (_faction.getUnits().len() >= 7)
			{
				return;
			}
		}
		else if (_faction.getUnits().len() >= 4)
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
		local mult = this.World.FactionManager.isGreenskinInvasion() ? 1.1 : 1.0;
		local party = this.getFaction().spawnEntity(settlement.getTile(), "Orc Marauders", false, this.Const.World.Spawn.OrcRaiders, this.Math.rand(75, 120) * this.getReputationToDifficultyLightMult() * mult);
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("一群凶残的兽人，绿皮肤，高耸于任何人之上。");
		party.setFootprintType(this.Const.World.FootprintsType.Orcs);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = this.Math.rand(0, 15);
		local numFood = this.Math.rand(1, 2);

		for( local i = 0; i != numFood; i = ++i )
		{
			party.addToInventory("supplies/strange_meat_item");
		}

		local c = party.getController();
		local ambush = this.new("scripts/ai/world/orders/ambush_order");
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(settlement.getTile());
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(ambush);
		c.addOrder(move);
		c.addOrder(despawn);
		return true;
	}

});

