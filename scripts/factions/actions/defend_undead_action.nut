this.defend_undead_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Settlement = null
	},
	function create()
	{
		this.m.ID = "defend_undead_action";
		this.m.Cooldown = 5.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local settlements = [];
		local playerAt;
		local beastFaction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID();

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

			local entities = this.World.getAllEntitiesAtPos(s.getPos(), 300.0);

			foreach( e in entities )
			{
				if (e.isParty() && e.isAttackable() && e.isAttackableByAI() && !s.isAlliedWith(e) && e.getStrength() < s.getResources() * 0.66)
				{
					if (e.getFaction() == beastFaction)
					{
						continue;
					}

					if (e.isPlayerControlled())
					{
						playerAt = s;
					}

					settlements.push(s);
					break;
				}
			}

			if (playerAt != null)
			{
				break;
			}
		}

		if (playerAt == null)
		{
			return;
		}

		if (playerAt != null && this.Math.rand(1, 100) > 10)
		{
			return;
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

		for( local i = 0; i != spawnpoints.len(); i = ++i )
		{
			local party = this.getFaction().spawnEntity(spawnpoints[i], "Undead", false, this.m.Settlement.getRoamerSpawnList(), this.m.Settlement.getResources() * 0.66);
			party.getSprite("banner").setBrush(this.m.Settlement.getBanner());
			party.setDescription("似乎不太对劲。");
			party.setFootprintType(this.Const.World.FootprintsType.Undead);
			party.setSlowerAtNight(false);
			party.setUsingGlobalVision(false);
			party.setLooting(false);
			party.getFlags().set("IsRandomlySpawned", true);
			party.getLoot().Money = this.Math.rand(0, 100);
			party.getLoot().ArmorParts = this.Math.rand(0, 10);
			local c = party.getController();
			local guard = this.new("scripts/ai/world/orders/guard_order");
			guard.setTarget(spawnpoints[i]);
			guard.setTime(20.0);
			local despawn = this.new("scripts/ai/world/orders/despawn_order");
			c.addOrder(guard);
			c.addOrder(despawn);
		}

		this.m.Settlement.setLastSpawnTimeToNow();
		return true;
	}

});

