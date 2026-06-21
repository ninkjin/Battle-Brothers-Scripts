this.move_troops_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Start = null,
		Dest = null
	},
	function create()
	{
		this.m.ID = "move_troops_action";
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

		local settlements = _faction.getSettlements();

		if (settlements.len() < 2)
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

			if (s.isMilitary())
			{
				sett.push(s);
			}
		}

		if (sett.len() <= 2)
		{
			return;
		}

		local settlements = this.getRandomConnectedSettlements(2, sett);

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
		this.m.Start.setLastSpawnTimeToNow();

		for( local i = 0; i < 1; i = ++i )
		{
			local party = this.getFaction().spawnEntity(this.m.Start.getTile(), this.m.Start.getName() + " Company", true, this.Const.World.Spawn.Noble, this.Math.rand(100, 300) * this.getReputationToDifficultyLightMult());
			party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + _faction.getBannerString());
			party.setDescription("为地方领主服务的专业士兵。");
			party.setFootprintType(this.Const.World.FootprintsType.Nobles);
			party.getFlags().set("IsRandomlySpawned", true);
			party.getLoot().Money = this.Math.rand(50, 200);
			party.getLoot().ArmorParts = this.Math.rand(0, 25);
			party.getLoot().Medicine = this.Math.rand(0, 5);
			party.getLoot().Ammo = this.Math.rand(0, 30);
			local r = this.Math.rand(1, 4);

			if (r == 1)
			{
				party.addToInventory("supplies/bread_item");
			}
			else if (r == 2)
			{
				party.addToInventory("supplies/roots_and_berries_item");
			}
			else if (r == 3)
			{
				party.addToInventory("supplies/dried_fruits_item");
			}
			else if (r == 4)
			{
				party.addToInventory("supplies/ground_grains_item");
			}

			local c = party.getController();
			local move = this.new("scripts/ai/world/orders/move_order");
			move.setRoadsOnly(true);
			move.setDestination(this.m.Dest.getTile());
			local wait = this.new("scripts/ai/world/orders/wait_order");
			wait.setTime(2.0);
			local despawn = this.new("scripts/ai/world/orders/despawn_order");
			c.addOrder(move);
			c.addOrder(wait);
			c.addOrder(despawn);
		}

		this.m.Cooldown = this.World.FactionManager.isCivilWar() ? 200.0 : 400.0;
		return true;
	}

});

