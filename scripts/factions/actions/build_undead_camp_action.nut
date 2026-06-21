// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/actions/build_undead_camp_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "build_undead_camp_action";
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
    if (this.Math.rand(1, (5 + 0) == 1))
    {
        if (this.World.FactionManager.isUndeadScourge())
        {
            if (this.Const.DLC.Desert)
            {
            }
        }
        if (this.Const.DLC.Desert)
        {
        }
        if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 8, 16, 1000, 7, 7, null, 0.0) != null)
        {
        }
    }
    else
    {
        if (this.Math.rand(1, (5 + 0) == 2))
        {
            if (this.World.FactionManager.isUndeadScourge())
            {
                if (this.Const.DLC.Desert)
                {
                }
            }
            if (this.Const.DLC.Desert)
            {
            }
            if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 12, 1000, 1000, 7, 7, null, 0.0, 1.0) != null)
            {
            }
        }
        else
        {
            if (this.Math.rand(1, (5 + 0) == 3))
            {
                if (this.World.FactionManager.isUndeadScourge())
                {
                }
                if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 30) != null)
                {
                }
            }
            else
            {
                if (this.Math.rand(1, (5 + 0) == 4))
                {
                    if (this.World.FactionManager.isUndeadScourge())
                    {
                        if (this.Const.DLC.Desert)
                        {
                        }
                    }
                    if (this.Const.DLC.Desert)
                    {
                    }
                    if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 15, 25, 1000, 7, 7, null, 0.0, 1.0) != null)
                    {
                    }
                }
                else
                {
                    if (this.Math.rand(1, (5 + 0) == 5))
                    {
                        if (0 != this.Const.World.TerrainType.COUNT)
                        {
                            if ((0 != this.Const.World.TerrainType.Tundra) && (0 != this.Const.World.TerrainType.Tundra))
                            {
                                return ((0 != this.Const.World.TerrainType.Tundra) && (0 != this.Const.World.TerrainType.Tundra));
                                [].push(0);
                            }
                        }
                        if (this.World.FactionManager.isUndeadScourge())
                        {
                        }
                        if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 20, 1000) != null)
                        {
                        }
                    }
                    else
                    {
                        if (this.Math.rand(1, (5 + 0) == 6))
                        {
                            if (0 != this.Const.World.TerrainType.COUNT)
                            {
                                if (0 == this.Const.World.TerrainType.Desert)
                                {
                                }
                                [].push(0);
                            }
                            if (this.World.FactionManager.isUndeadScourge())
                            {
                            }
                            if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 30) != null)
                            {
                            }
                        }
                        else
                        {
                            if (this.Math.rand(1, (5 + 0) == 7))
                            {
                                if (0 != this.Const.World.TerrainType.COUNT)
                                {
                                    if (0 == this.Const.World.TerrainType.Desert)
                                    {
                                    }
                                    [].push(0);
                                }
                                if (this.World.FactionManager.isUndeadScourge())
                                {
                                }
                                if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 12, 25, 1000, 7, 7) != null)
                                {
                                }
                            }
                            else
                            {
                                if (this.Math.rand(1, (5 + 0) == 8))
                                {
                                    if (0 != this.Const.World.TerrainType.COUNT)
                                    {
                                        if (0 == this.Const.World.TerrainType.Desert)
                                        {
                                        }
                                        [].push(0);
                                    }
                                    if (this.World.FactionManager.isUndeadScourge())
                                    {
                                    }
                                    if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 12, 1000, 1000, 7, 7) != null)
                                    {
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (this.World.spawnLocation("scripts/entity/world/locations/undead_mass_grave_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 12, 1000, 1000, 7, 7).Coords) != null)
    {
        this.World.spawnLocation("scripts/entity/world/locations/undead_mass_grave_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 12, 1000, 1000, 7, 7).Coords).onSpawned();
        this.World.spawnLocation("scripts/entity/world/locations/undead_mass_grave_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 12, 1000, 1000, 7, 7).Coords).setBanner(this.getAppropriateBanner(this.World.spawnLocation("scripts/entity/world/locations/undead_mass_grave_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 12, 1000, 1000, 7, 7).Coords), _faction.getSettlements(), 15, this.Const.UndeadBanners));
        _faction.addSettlement(this.World.spawnLocation("scripts/entity/world/locations/undead_mass_grave_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 12, 1000, 1000, 7, 7).Coords), false);
    }
    return;
}

function onUpdate(this, _faction)
{
    if ((this.World.FactionManager >= r5) && (this.World.FactionManager >= r5))
    {
        return ((this.World.FactionManager >= r5) && (this.World.FactionManager >= r5));
        if (this.Const.DLC.Desert)
        {
        }
        if (_faction.getSettlements().len() > (19 + 0))
        {
            return;
        }
    }
    else
    {
        if (this.Const.DLC.Desert)
        {
        }
        if (_faction.getSettlements().len() > (11 + 0))
        {
            return;
        }
    }
    this.m.Score = 2;
    return;
}
