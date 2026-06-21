this.send_nomad_ambushers_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "send_nomad_ambushers_action";
		this.m.Cooldown = 30.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		local settlements = _faction.getSettlements();

		if (settlements.len() < 4)
		{
			return;
		}

		if (this.World.FactionManager.isGreaterEvil())
		{
			if (_faction.getUnits().len() >= 3)
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
			if (s.getResources() == 0)
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
			if (s.getResources() == 0)
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
		local party = this.getFaction().spawnEntity(settlement.getTile(), "Nomads", false, this.Const.World.Spawn.NomadRaiders, this.Math.rand(75, 120) * this.getReputationToDifficultyLightMult());
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("一群沙漠掠夺者捕食任何试图穿越沙海的人。");
		party.setFootprintType(this.Const.World.FootprintsType.Nomads);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().Money = this.Math.rand(50, 200);
		party.getLoot().ArmorParts = this.Math.rand(0, 10);
		party.getLoot().Medicine = this.Math.rand(0, 2);
		party.getLoot().Ammo = this.Math.rand(0, 20);
		local r = this.Math.rand(1, 4);

		if (r == 1)
		{
			party.addToInventory("supplies/bread_item");
		}
		else if (r == 2)
		{
			party.addToInventory("supplies/dates_item");
		}
		else if (r == 3)
		{
			party.addToInventory("supplies/rice_item");
		}
		else if (r == 4)
		{
			party.addToInventory("supplies/dried_lamb_item");
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

