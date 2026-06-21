this.move_undead_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Start = null,
		Dest = null
	},
	function create()
	{
		this.m.ID = "move_undead_action";
		this.m.Cooldown = 180.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!this.World.FactionManager.isUndeadScourge())
		{
			return;
		}

		local settlements = _faction.getSettlements();

		if (settlements.len() < 6)
		{
			return;
		}

		if (_faction.getUnits().len() >= 10)
		{
			return;
		}

		local sett = [];

		foreach( s in settlements )
		{
			if (s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF())
			{
				continue;
			}

			if (!s.isLocationType(this.Const.World.LocationType.Passive))
			{
				sett.push(s);
			}
		}

		if (sett.len() <= 2)
		{
			return;
		}

		settlements = this.getRandomConnectedSettlements(2, sett);

		if (settlements.len() < 2)
		{
			return;
		}

		this.m.Start = settlements[0];
		this.m.Dest = settlements[1];
		this.m.Score = 10;
	}

	function onClear()
	{
		this.m.Start = null;
		this.m.Dest = null;
	}

	function onExecute( _faction )
	{
		local num = this.Math.rand(1, 2);
		this.m.Start.setLastSpawnTimeToNow();

		for( local i = 0; i < num; i = ++i )
		{
			local party = _faction.spawnEntity(this.m.Start.getTile(), "Undead", false, this.Const.World.Spawn.UndeadScourge, this.Math.rand(70, 130) * this.getReputationToDifficultyLightMult());
			party.getSprite("banner").setBrush(this.m.Start.getBanner());
			party.setDescription("一大群行尸，向活着的人索取曾经属于他们的东西。");
			party.setFootprintType(this.Const.World.FootprintsType.Undead);
			party.setSlowerAtNight(false);
			party.setUsingGlobalVision(false);
			party.setLooting(false);
			party.getFlags().set("IsRandomlySpawned", true);
			party.getLoot().ArmorParts = this.Math.rand(0, 15);
			local r = this.Math.rand(1, 3);

			if (r == 1)
			{
				party.addToInventory("loot/signet_ring_item");
			}

			local c = party.getController();
			c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);

			if (i != 0)
			{
				local waitUntilMove = this.new("scripts/ai/world/orders/wait_order");
				waitUntilMove.setTime(6.0);
				c.addOrder(waitUntilMove);
			}

			local move = this.new("scripts/ai/world/orders/move_order");
			move.setDestination(this.m.Dest.getTile());
			move.setAvoidSettlements(true);
			local wait = this.new("scripts/ai/world/orders/wait_order");
			wait.setTime(2.0);
			local despawn = this.new("scripts/ai/world/orders/despawn_order");
			c.addOrder(move);
			c.addOrder(wait);
			c.addOrder(despawn);
		}

		return true;
	}

});

