// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/actions/build_goblin_camp_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "build_goblin_camp_action";
    this.m.IsRunOnNewCampaign = true;
    this.faction_action.create();
    return;
}

function onClear(this)
{
    return;
}

function onExecute(this, _faction)
{
    if (this.Const.DLC.Desert)
    {
    }
    if (_faction.getSettlements().len() == 0)
    {
    }
    else
    {
        if (this.World.FactionManager.isGreenskinInvasion())
        {
        }
    }
    if ((this.Math.rand(1, 5) == 1) && (this.Math.rand(1, 5) == 1))
    {
        return ((this.Math.rand(1, 5) == 1) && (this.Math.rand(1, 5) == 1));
        if (this.World.FactionManager.isGreenskinInvasion())
        {
        }
        if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 15, 1000, 20, 7, 7, null, 0.0) != null)
        {
        }
    }
    else
    {
        if (this.Math.rand(1, 5) == 2)
        {
            if (this.World.FactionManager.isGreenskinInvasion())
            {
            }
            if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 20, 1000, 20, 7, 7, null, 0.0) != null)
            {
            }
        }
        else
        {
            if (this.Math.rand(1, 5) == 3)
            {
                if (this.World.FactionManager.isGreenskinInvasion())
                {
                }
                if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 14, 30, 20, 7, 7, null, 0.0) != null)
                {
                }
            }
            else
            {
                if (this.Math.rand(1, 5) == 4)
                {
                    if (this.World.FactionManager.isGreenskinInvasion())
                    {
                    }
                    if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 20, 30, 7, 7, null, 0.0) != null)
                    {
                    }
                }
                else
                {
                    if ((this.Math.rand(1, 5) == 6) && (this.Math.rand(1, 5) == 6))
                    {
                        return ((this.Math.rand(1, 5) == 6) && (this.Math.rand(1, 5) == 6));
                        if (0 != this.Const.World.TerrainType.COUNT)
                        {
                            if ((0 == this.Const.World.TerrainType.Hills) && (0 == this.Const.World.TerrainType.Hills))
                            {
                                return ((0 == this.Const.World.TerrainType.Hills) && (0 == this.Const.World.TerrainType.Hills));
                            }
                            [].push(0);
                        }
                        if (this.World.FactionManager.isGreenskinInvasion())
                        {
                            if (this.Math.rand(1, 5) == 6)
                            {
                            }
                        }
                        if (this.Math.rand(1, 5) == 6)
                        {
                        }
                        if ((this == 0) && (this == 0))
                        {
                            return ((this == 0) && (this == 0));
                            foreach (local key, value in 1000)
                            {
                                if (null.getTile().getDistanceTo(this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 25, 1000, 20, 0.0) <= 25))
                                {
                                    return;
                                }
                                if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 25, 1000, 20, 0.0) != null)
                                {
                                }
                                if (this.World.spawnLocation("scripts/entity/world/locations/goblin_settlement_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 25, 1000, 20, 0.0).Coords) != null)
                                {
                                    this.World.spawnLocation("scripts/entity/world/locations/goblin_settlement_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 25, 1000, 20, 0.0).Coords).onSpawned();
                                    this.World.spawnLocation("scripts/entity/world/locations/goblin_settlement_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 25, 1000, 20, 0.0).Coords).setBanner(this.getAppropriateBanner(this.World.spawnLocation("scripts/entity/world/locations/goblin_settlement_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 25, 1000, 20, 0.0).Coords), _faction.getSettlements(), 15, this.Const.GoblinBanners));
                                    _faction.addSettlement(this.World.spawnLocation("scripts/entity/world/locations/goblin_settlement_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 25, 1000, 20, 0.0).Coords), false);
                                }
                                return;
                            }
                        }
                    }
                }
            }
        }
    }
}

function onUpdate(this, _faction)
{
    if ((this.World.FactionManager >= r5) && (this.World.FactionManager >= r5))
    {
        return ((this.World.FactionManager >= r5) && (this.World.FactionManager >= r5));
        if (_faction.getSettlements().len() > 20)
        {
            return;
        }
    }
    else
    {
        if (_faction.getSettlements().len() > 12)
        {
            return;
        }
    }
    this.m.Score = 2;
    return;
}
