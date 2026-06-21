this.send_greenskin_army_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "send_greenskin_army_action";
		this.m.Cooldown = 190.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!this.World.FactionManager.isGreenskinInvasion() || this.World.FactionManager.getGreaterEvilStrength() < 15.0)
		{
			return;
		}

		if (_faction.getSettlements().len() < 6)
		{
			return;
		}

		if (_faction.getUnits().len() >= 9)
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
		local potential_origins = [];

		foreach( s in _faction.getSettlements() )
		{
			if (s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF())
			{
				continue;
			}

			potential_origins.push({
				D = s,
				P = s.getResources()
			});
		}

		if (potential_origins.len() == 0)
		{
			return;
		}

		local origin = this.pickWeightedRandom(potential_origins);
		local myTile = origin.getTile();
		local activeContract = this.World.Contracts.getActiveContract();
		local settlements = this.World.EntityManager.getSettlements();
		local lowest_distance = 99999;
		local best_settlement;

		foreach( s in settlements )
		{
			if (activeContract != null && (activeContract.getHome().getID() == s.getID() || activeContract.getOrigin().getID() == s.getID()))
			{
				continue;
			}

			local d = myTile.getDistanceTo(s.getTile());

			if (s.hasSituation("situation.razed"))
			{
				d = d + 20;
			}

			if (d <= lowest_distance && !s.isIsolatedFromLocation(origin))
			{
				if (s.isSouthern())
				{
					local skip = true;

					foreach( l in s.getAttachedLocations() )
					{
						if (l.isActive() && l.isUsable())
						{
							skip = false;
							break;
						}
					}

					if (skip)
					{
						continue;
					}
				}

				lowest_distance = d;
				best_settlement = s;
			}
		}

		if (best_settlement == null)
		{
			return;
		}

		local locations = best_settlement.getAttachedLocations();
		local targets = [];

		foreach( l in locations )
		{
			if (l.isActive() && l.isUsable())
			{
				targets.push(l);
			}
		}

		local nearestOrcs = this.getNearestLocationTo(origin, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getSettlements());
		local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).spawnEntity(myTile, "Greenskin Horde", false, this.Const.World.Spawn.GreenskinHorde, this.Math.rand(80, 120) * this.getScaledDifficultyMult());
		party.getSprite("banner").setBrush(nearestOrcs.getBanner());
		party.setDescription("一大群绿皮向战场进军。");
		party.setFootprintType(this.Const.World.FootprintsType.Orcs);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = this.Math.rand(0, 10);
		party.getLoot().Ammo = this.Math.rand(0, 10);
		local numFood = this.Math.rand(1, 2);

		for( local i = 0; i != numFood; i = ++i )
		{
			party.addToInventory("supplies/strange_meat_item");
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			local loot = [
				"loot/goblin_carved_ivory_iconographs_item",
				"loot/goblin_minted_coins_item",
				"loot/goblin_rank_insignia_item"
			];
			party.addToInventory(loot[this.Math.rand(0, loot.len() - 1)]);
		}

		local c = party.getController();

		if (targets.len() != 0)
		{
			local target = targets[this.Math.rand(0, targets.len() - 1)];
			local move = this.new("scripts/ai/world/orders/move_order");
			move.setDestination(target.getTile());
			c.addOrder(move);
			local raid = this.new("scripts/ai/world/orders/raid_order");
			raid.setTime(40.0);
			raid.setTargetTile(target.getTile());
			c.addOrder(raid);
			local back = this.new("scripts/ai/world/orders/move_order");
			back.setDestination(myTile);
			c.addOrder(back);
			local despawn = this.new("scripts/ai/world/orders/despawn_order");
			c.addOrder(despawn);
		}
		else
		{
			c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
			local target = best_settlement;
			local move = this.new("scripts/ai/world/orders/move_order");
			move.setDestination(target.getTile());
			c.addOrder(move);
			local destroy = this.new("scripts/ai/world/orders/destroy_order");
			destroy.setTime(60.0);
			destroy.setTargetTile(target.getTile());
			destroy.setTargetID(target.getID());
			c.addOrder(destroy);
			local back = this.new("scripts/ai/world/orders/move_order");
			back.setDestination(myTile);
			c.addOrder(back);
			local despawn = this.new("scripts/ai/world/orders/despawn_order");
			c.addOrder(despawn);
		}

		return true;
	}

});

