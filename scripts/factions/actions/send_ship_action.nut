this.send_ship_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Settlement = null
	},
	function create()
	{
		this.m.ID = "send_ship_action";
		this.m.Cooldown = this.Math.rand(120, 240);
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (_faction.isEnemyNearby())
		{
			return;
		}

		local mySettlements = _faction.getSettlements();
		local settlements = [];

		foreach( s in mySettlements )
		{
			if (_faction.getType() == this.Const.FactionType.NobleHouse && !s.isMilitary())
			{
				continue;
			}

			if (s.isCoastal() && s.getDeepOceanTile() != null)
			{
				settlements.push(s);
			}
		}

		if (settlements.len() == 0)
		{
			return;
		}

		this.m.Settlement = settlements[this.Math.rand(0, settlements.len() - 1)];
		this.m.Score = 5;
	}

	function onClear()
	{
		this.m.Settlement = null;
	}

	function onExecute( _faction )
	{
		local spawnpoint;

		foreach( a in this.m.Settlement.getAttachedLocations() )
		{
			if (a.getTypeID() == "attached_location.harbor")
			{
				spawnpoint = a.getTile();
				break;
			}
		}

		if (spawnpoint == null)
		{
			local settlementTile = this.m.Settlement.getTile();

			for( local i = 0; i != 6; i = ++i )
			{
				if (!settlementTile.hasNextTile(i))
				{
				}
				else
				{
					local tile = settlementTile.getNextTile(i);

					if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore)
					{
						spawnpoint = tile;
						break;
					}
				}
			}
		}

		if (spawnpoint == null)
		{
			return;
		}

		local destination = this.m.Settlement.getDeepOceanTile();
		local party = _faction.spawnEntity(spawnpoint, "Ship", false, null, 0);
		party.getSprite("banner").Visible = false;
		party.getSprite("base").Visible = false;
		party.getSprite("body").setBrush("ship_03");
		party.getSprite("bodyUp").setBrush("ship_04");
		party.setShowName(false);
		party.setMirrored(true);
		party.setIgnoreCollision(true);
		party.setSlowerAtNight(false);
		party.setAttackable(false);
		party.setLeaveFootprints(false);
		party.setVisibilityMult(2.0);
		party.setDescription("运送货物和乘客的船。");
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local swim = this.new("scripts/ai/world/orders/swim_order");
		swim.setDestination(destination);
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(swim);
		c.addOrder(despawn);
	}

});

