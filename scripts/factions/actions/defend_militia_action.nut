this.defend_militia_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Settlement = null
	},
	function create()
	{
		this.m.ID = "defend_militia_action";
		this.m.Cooldown = 120.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!_faction.isReadyToSpawnUnit())
		{
			return;
		}

		if (!_faction.isActive())
		{
			return;
		}

		local settlements = [];
		local playerAt;

		foreach( s in _faction.getSettlements() )
		{
			if (s.isMilitary())
			{
				continue;
			}

			if (s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF())
			{
				continue;
			}

			if (playerAt != null)
			{
				break;
			}

			local isAdded = false;
			local entities = this.World.getAllEntitiesAtPos(s.getPos(), 400.0);

			foreach( e in entities )
			{
				if (e.isParty() && e.isAttackable() && e.isAttackableByAI() && !s.isAlliedWith(e) && e.getStrength() < s.getResources())
				{
					if (e.isPlayerControlled())
					{
						playerAt = s;
					}

					isAdded = true;
					settlements.push(s);
					break;
				}
			}

			if (isAdded)
			{
				continue;
			}

			foreach( a in s.getAttachedLocations() )
			{
				if (!a.isMilitary())
				{
					continue;
				}

				local entities = this.World.getAllEntitiesAtPos(a.getPos(), 300.0);

				foreach( e in entities )
				{
					if (e.isParty() && e.isAttackable() && e.isAttackableByAI() && !s.isAlliedWith(e) && e.getStrength() < s.getResources())
					{
						if (e.isPlayerControlled())
						{
							playerAt = s;
						}

						settlements.push(s);
						break;
					}
				}
			}
		}

		if (playerAt != null || settlements.len() != 0)
		{
			this.m.Settlement = playerAt == null ? settlements[this.Math.rand(0, settlements.len() - 1)] : playerAt;
			this.m.Score = 30;
		}
	}

	function onClear()
	{
		this.m.Settlement = null;
	}

	function onExecute( _faction )
	{
		local spawnpoints = [];
		spawnpoints.push(this.m.Settlement.getTile());

		foreach( a in this.m.Settlement.getAttachedLocations() )
		{
			if (a.isActive() && a.isMilitary())
			{
				spawnpoints.push(a.getTile());
			}
		}

		for( local i = 0; i != spawnpoints.len(); i = ++i )
		{
			if (!_faction.isReadyToSpawnUnit())
			{
				break;
			}

			local party = _faction.spawnEntity(spawnpoints[i], this.m.Settlement.getName() + " Militia", false, this.Const.World.Spawn.Militia, this.m.Settlement.getResources());
			party.getSprite("banner").setBrush(this.m.Settlement.getBanner());
			party.setDescription("勇敢的人用生命保卫家园。农夫、工匠、技工，但没有一个真正的士兵。");
			party.setFootprintType(this.Const.World.FootprintsType.Militia);
			party.getFlags().set("IsRandomlySpawned", true);
			local c = party.getController();
			local sleep = this.new("scripts/ai/world/orders/sleep_order");
			sleep.setTime(1.0);
			local guard = this.new("scripts/ai/world/orders/guard_order");
			guard.setTarget(spawnpoints[i]);
			guard.setTime(30.0);
			local despawn = this.new("scripts/ai/world/orders/despawn_order");
			c.addOrder(sleep);
			c.addOrder(guard);
			c.addOrder(despawn);
		}

		return true;
	}

});

