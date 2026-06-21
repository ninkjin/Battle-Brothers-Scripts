this.entity_manager <- {
	m = {
		Settlements = [],
		NextSituationID = 1,
		Locations = [],
		RoadAmbushTiles = [],
		Mercenaries = [],
		LastMercUpdateTime = 0,
		LastSnowSpawnTime = this.Time.getVirtualTimeF() + 5.0,
		LastWaveSpawnTime = this.Time.getVirtualTimeF() + 5.0
	},
	function addLocation( _l )
	{
		this.m.Locations.push(_l);
	}

	function removeLocation( _l )
	{
		foreach( i, r in this.m.Locations )
		{
			if (r.getID() == _l.getID())
			{
				this.m.Locations.remove(i);
				break;
			}
		}
	}

	function getLocations()
	{
		return this.m.Locations;
	}

	function addSettlement( _s )
	{
		this.m.Settlements.push(_s);
	}

	function removeSettlement( _s )
	{
		foreach( i, r in this.m.Settlements )
		{
			if (r.getID() == _s.getID())
			{
				this.m.Settlements.remove(i);
				break;
			}
		}
	}

	function getSettlements()
	{
		return this.m.Settlements;
	}

	function getNextSituationID()
	{
		return this.m.NextSituationID++;
	}

	function getAmbushSpots()
	{
		return this.m.RoadAmbushTiles;
	}

	function getMercenaries()
	{
		return this.m.Mercenaries;
	}

	function create()
	{
	}

	function update()
	{
		this.manageAIMercenaries();
	}

	function clear()
	{
		this.m.Settlements = [];
		this.m.Locations = [];
		this.m.RoadAmbushTiles = [];
		this.m.Mercenaries = [];
		this.m.LastMercUpdateTime = 0.0;
		this.m.LastSnowSpawnTime = 0.0;
	}

	function getUniqueLocationName( _names )
	{
		local vars = [
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomnoble",
				this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]
			]
		];
		local tries = 0;

		do
		{
			local name = _names[this.Math.rand(0, _names.len() - 1)];
			name = this.buildTextFromTemplate(name, vars);
			tries = ++tries;

			if (tries > 1000)
			{
				this.logError("找不到唯一名称：" + name);
				return name;
			}

			local tryAgain = false;

			foreach( v in this.m.Locations )
			{
				if (name == v.getName())
				{
					tryAgain = true;
					break;
				}
			}

			if (tryAgain)
			{
			}
			else
			{
				return name;
			}
		}
		while (true);
	}

	function buildRoadAmbushSpots()
	{
		this.m.RoadAmbushTiles = [];
		local sizeX = this.World.getMapSize().X;
		local sizeY = this.World.getMapSize().Y;

		for( local x = 0; x < sizeX; x = ++x )
		{
			for( local y = 0; y < sizeY; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.HasRoad)
				{
				}
				else if (this.Const.World.TerrainTypeVisibilityMult[tile.Type] >= 1.0)
				{
				}
				else if (this.Const.World.TerrainTypeVisionRadiusMult[tile.Type] < 1.0)
				{
				}
				else if (this.Const.World.TerrainTypeSpeedMult[tile.Type] < 0.5)
				{
				}
				else
				{
					local isNextToRoad = false;

					for( local i = 0; i != 6; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.HasRoad)
							{
								isNextToRoad = true;
								break;
							}

							for( local j = 0; j != 6; j = ++j )
							{
								if (!nextTile.hasNextTile(j))
								{
								}
								else
								{
									local veryNextTile = nextTile.getNextTile(j);

									if (veryNextTile.HasRoad && veryNextTile.ID != tile.ID)
									{
										isNextToRoad = true;
										break;
									}
								}
							}

							if (isNextToRoad)
							{
								break;
							}
						}
					}

					if (!isNextToRoad)
					{
					}
					else
					{
						local isTooClose = false;

						foreach( s in this.m.Settlements )
						{
							local d = tile.getDistanceTo(s.getTile());

							if (d <= this.Const.World.AI.Behavior.AmbushMinDistToSettlements)
							{
								isTooClose = true;
								break;
							}

							foreach( a in s.getAttachedLocations() )
							{
								if (d <= this.Const.World.AI.Behavior.AmbushMinDistToSettlements - 2)
								{
									isTooClose = true;
									break;
								}
							}

							if (isTooClose)
							{
								break;
							}
						}

						if (isTooClose)
						{
						}
						else
						{
							this.m.RoadAmbushTiles.push({
								Tile = tile,
								Distance = 0
							});
						}
					}
				}
			}
		}
	}

	function updateSettlementHeat()
	{
		local settlements = this.getSettlements();
		local sizeX = this.World.getMapSize().X;
		local sizeY = this.World.getMapSize().Y;

		for( local x = 0; x < sizeX; x = ++x )
		{
			for( local y = 0; y < sizeY; y = ++y )
			{
				this.World.getTileSquare(x, y).HeatFromSettlements = 0;
			}
		}

		for( local x = 0; x < sizeX; x = ++x )
		{
			for( local y = 0; y < sizeY; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				foreach( s in settlements )
				{
					if (!s.isAlive() || !s.isActive())
					{
						continue;
					}

					local d = s.getTile().getDistanceTo(tile);

					if (d > 6)
					{
						continue;
					}

					tile.HeatFromSettlements = tile.HeatFromSettlements + (6 - d);
				}
			}
		}
	}

	function spawnWaves()
	{
		local numWaves = (this.Time.getVirtualTimeF() - this.m.LastWaveSpawnTime) * 300;
		this.m.LastWaveSpawnTime = this.Time.getVirtualTimeF();

		while (numWaves-- >= 0)
		{
			local x = this.Math.rand(3, this.World.getMapSize().X - 3);
			local y = this.Math.rand(3, this.World.getMapSize().Y - 3);
			local tile = this.World.getTileSquare(x, y);

			if (tile.Type != this.Const.World.TerrainType.Ocean)
			{
				continue;
			}

			local other = false;

			for( local i = 0; i != 6; i = ++i )
			{
				if (tile.getNextTile(i).Type != this.Const.World.TerrainType.Ocean)
				{
					other = true;
					break;
				}
			}

			if (other)
			{
				continue;
			}

			this.World.spawnWaveSprite("waves_0" + this.Math.rand(1, 4), tile.Pos, this.createVec(-15, -15), 1.25);
		}
	}

	function onWorldEntityDestroyed( _entity, _isLocation )
	{
		if (!this.Tactical.isVisible())
		{
			return;
		}

		if (this.World.State.getPlayer().isAlliedWith(_entity))
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();

		if (playerTile.getDistanceTo(_entity.getTile()) > 2)
		{
			return;
		}

		if (_isLocation)
		{
			if (_entity.getTypeID() == "location.black_monolith")
			{
				this.updateAchievement("RestInPieces", 1, 1);
			}

			this.World.Statistics.getFlags().set("LastLocationDestroyedName", _entity.getName());
			this.World.Statistics.getFlags().set("LastLocationDestroyedFaction", _entity.getFaction());
			this.World.Statistics.getFlags().set("LastLocationDestroyedForContract", _entity.getSprite("selection").Visible);

			if (this.World.FactionManager.isGreaterEvil())
			{
				local f = this.World.FactionManager.getFaction(_entity.getFaction());

				if (this.World.FactionManager.isCivilWar() && f != null && f.getType() == this.Const.FactionType.NobleHouse)
				{
					this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnLocationDestroyed);
				}
				else if (this.World.FactionManager.isGreenskinInvasion() && f != null && (f.getType() == this.Const.FactionType.Orcs || f.getType() == this.Const.FactionType.Goblins))
				{
					this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnLocationDestroyed);
				}
				else if (this.World.FactionManager.isUndeadScourge() && f != null && (f.getType() == this.Const.FactionType.Undead || f.getType() == this.Const.FactionType.Zombies))
				{
					this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnLocationDestroyed);
				}
			}

			if (this.World.Flags.get("IsGoblinCityOutposts"))
			{
				if (_entity.getTypeID() == "location.goblin_camp" || _entity.getTypeID() == "location.goblin_hideout" || _entity.getTypeID() == "location.goblin_outpost" || _entity.getTypeID() == "location.goblin_ruins" || _entity.getTypeID() == "location.goblin_settlement")
				{
					this.World.Flags.increment("GoblinCityCount", 1);
				}
			}

			this.World.Contracts.onLocationDestroyed(_entity);
			this.World.Ambitions.onLocationDestroyed(_entity);
		}
		else
		{
			if (this.World.FactionManager.getFaction(_entity.getFaction()).getType() == this.Const.FactionType.NobleHouse)
			{
				this.updateAchievement("NotSoNoble", 1, 1);
			}

			if (_entity.getFlags().get("IsMercenaries"))
			{
				this.updateAchievement("KingOfTheHill", 1, 1);
			}

			if (this.World.FactionManager.isGreaterEvil())
			{
				local f = this.World.FactionManager.getFaction(_entity.getFaction());

				if (this.World.FactionManager.isCivilWar() && f != null && f.getType() == this.Const.FactionType.NobleHouse)
				{
					this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnPartyDestroyed);
				}
				else if (this.World.FactionManager.isGreenskinInvasion() && f != null && (f.getType() == this.Const.FactionType.Orcs || f.getType() == this.Const.FactionType.Goblins))
				{
					this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnPartyDestroyed);
				}
				else if (this.World.FactionManager.isUndeadScourge() && f != null && (f.getType() == this.Const.FactionType.Undead || f.getType() == this.Const.FactionType.Zombies))
				{
					this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnPartyDestroyed);
				}
				else if (this.World.FactionManager.isHolyWar() && f != null && (f.getType() == this.Const.FactionType.NobleHouse || f.getType() == this.Const.FactionType.OrientalCityState))
				{
					this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnPartyDestroyed);
				}
			}

			if (this.World.Flags.get("IsGoblinCityScouts"))
			{
				if (this.World.FactionManager.getFaction(_entity.getFaction()).getType() == this.Const.FactionType.Goblins)
				{
					this.World.Flags.increment("GoblinCityCount", 1);
				}
			}

			this.World.Contracts.onPartyDestroyed(_entity);
			this.World.Ambitions.onPartyDestroyed(_entity);
		}
	}

	function manageAIMercenaries()
	{
		local garbage = [];

		foreach( i, merc in this.m.Mercenaries )
		{
			if (merc.isNull() || !merc.isAlive())
			{
				garbage.push(i);
			}
		}

		garbage.reverse();

		foreach( g in garbage )
		{
			this.m.Mercenaries.remove(g);
		}

		if (this.m.LastMercUpdateTime + 3.0 > this.Time.getVirtualTimeF())
		{
			return;
		}

		this.m.LastMercUpdateTime = this.Time.getVirtualTimeF();

		if (this.m.Mercenaries.len() < 2 || this.World.FactionManager.isCivilWar() && this.m.Mercenaries.len() < 3)
		{
			local playerTile = this.World.State.getPlayer().getTile();
			local candidates = [];

			foreach( s in this.World.EntityManager.getSettlements() )
			{
				if (s.isIsolated())
				{
					continue;
				}

				if (s.getTile().getDistanceTo(playerTile) <= 10)
				{
					continue;
				}

				candidates.push(s);
			}

			local start = candidates[this.Math.rand(0, candidates.len() - 1)];
			local party = this.World.spawnEntity("scripts/entity/world/party", start.getTile().Coords);
			party.setPos(this.createVec(party.getPos().X - 50, party.getPos().Y - 50));
			party.setDescription("一个自由的雇佣兵战团在各地旅行，为出价最高的人挥出他们的剑。");
			party.setFootprintType(this.Const.World.FootprintsType.Mercenaries);
			party.getFlags().set("IsMercenaries", true);

			if (start.getFactions().len() == 1)
			{
				party.setFaction(start.getOwner().getID());
			}
			else
			{
				party.setFaction(start.getFactionOfType(this.Const.FactionType.Settlement).getID());
			}

			local r = this.Math.min(330, 150 + this.World.getTime().Days);
			this.Const.World.Common.assignTroops(party, this.Const.World.Spawn.Mercenaries, this.Math.rand(r * 0.8, r));
			party.getLoot().Money = this.Math.rand(300, 600);
			party.getLoot().ArmorParts = this.Math.rand(0, 25);
			party.getLoot().Medicine = this.Math.rand(0, 10);
			party.getLoot().Ammo = this.Math.rand(0, 50);

			for( local i = 0; i < 2; i = ++i )
			{
				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					party.addToInventory("supplies/bread_item");
				}
				else if (r == 2)
				{
					party.addToInventory("supplies/mead_item");
				}
				else if (r == 3)
				{
					party.addToInventory("supplies/dried_fruits_item");
				}
				else if (r == 4)
				{
					party.addToInventory("supplies/beer_item");
				}
			}

			party.getSprite("base").setBrush("world_base_07");
			party.getSprite("body").setBrush("figure_mercenary_0" + this.Math.rand(1, 2));

			while (true)
			{
				local name = this.Const.Strings.MercenaryCompanyNames[this.Math.rand(0, this.Const.Strings.MercenaryCompanyNames.len() - 1)];

				if (name == this.World.Assets.getName())
				{
					continue;
				}

				local abort = false;

				foreach( p in this.m.Mercenaries )
				{
					if (p.getName() == name)
					{
						abort = true;
						break;
					}
				}

				if (abort)
				{
					continue;
				}

				party.setName(name);
				break;
			}

			while (true)
			{
				local banner = this.Const.PlayerBanners[this.Math.rand(0, this.Const.PlayerBanners.len() - 1)];

				if (banner == this.World.Assets.getBanner())
				{
					continue;
				}

				local abort = false;

				foreach( p in this.m.Mercenaries )
				{
					if (p.getBanner() == banner)
					{
						abort = true;
						break;
					}
				}

				if (abort)
				{
					continue;
				}

				party.getSprite("banner").setBrush(banner);
				break;
			}

			this.m.Mercenaries.push(this.WeakTableRef(party));
		}

		foreach( merc in this.m.Mercenaries )
		{
			merc.updatePlayerRelation();

			if (!merc.getController().hasOrders())
			{
				local candidates = [];

				foreach( s in this.m.Settlements )
				{
					if (!s.isAlive() || s.isIsolated())
					{
						continue;
					}

					if (!s.isAlliedWith(merc))
					{
						continue;
					}

					if (s.getTile().ID == merc.getTile().ID)
					{
						continue;
					}

					candidates.push(s);
				}

				if (candidates.len() == 0)
				{
					continue;
				}

				local dest = candidates[this.Math.rand(0, candidates.len() - 1)];
				local c = merc.getController();
				local wait1 = this.new("scripts/ai/world/orders/wait_order");
				wait1.setTime(this.Math.rand(10, 60) * 1.0);
				c.addOrder(wait1);
				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(dest.getTile());
				move.setRoadsOnly(false);
				c.addOrder(move);
				local wait2 = this.new("scripts/ai/world/orders/wait_order");
				wait2.setTime(this.Math.rand(10, 60) * 1.0);
				c.addOrder(wait2);
				local mercenary = this.new("scripts/ai/world/orders/mercenary_order");
				mercenary.setSettlement(dest);
				c.addOrder(mercenary);
			}
		}
	}

	function onSerialize( _out )
	{
		_out.writeI32(this.m.NextSituationID);
		local numMercs = 0;

		foreach( merc in this.m.Mercenaries )
		{
			if (merc != null && !merc.isNull() && merc.isAlive())
			{
				numMercs = ++numMercs;
			}
		}

		_out.writeU8(numMercs);

		foreach( merc in this.m.Mercenaries )
		{
			if (merc != null && !merc.isNull() && merc.isAlive())
			{
				_out.writeU32(merc.getID());
			}
		}
	}

	function onDeserialize( _in )
	{
		this.m.NextSituationID = _in.readI32();
		local numMercs = _in.readU8();

		for( local i = 0; i != numMercs; i = ++i )
		{
			local merc = this.World.getEntityByID(_in.readU32());

			if (merc != null)
			{
				this.m.Mercenaries.push(this.WeakTableRef(merc));
			}
		}

		this.buildRoadAmbushSpots();
	}

};

