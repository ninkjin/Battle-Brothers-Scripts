// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/actions/build_zombie_camp_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "build_zombie_camp_action";
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
    if (1 == 1)
    {
        if (this.World.FactionManager.isUndeadScourge())
        {
        }
        if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 5, 11, 1000, 7, 7, null, 0.0) != null)
        {
        }
    }
    else
    {
        if (1 == 2)
        {
            if (this.World.FactionManager.isUndeadScourge())
            {
            }
            if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 8, 16, 1000, 7, 7, null, 0.0) != null)
            {
            }
        }
        else
        {
            if (1 == 3)
            {
                if (this.World.FactionManager.isUndeadScourge())
                {
                }
                if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 7, 20, 1000, 7, 7, null, 0.0) != null)
                {
                }
            }
            else
            {
                if (1 == 4)
                {
                    if (this.World.FactionManager.isUndeadScourge())
                    {
                    }
                    if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 20, 1000, 7, 7, null, 0.0) != null)
                    {
                    }
                }
                else
                {
                    if (1 == 5)
                    {
                        if (this.World.FactionManager.isUndeadScourge())
                        {
                        }
                        if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 30, 1000, 7, 7, null, 0.0) != null)
                        {
                        }
                    }
                }
            }
        }
    }
    if (this.World.spawnLocation("scripts/entity/world/locations/undead_ruins_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 30, 1000, 7, 7, null, 0.0).Coords) != null)
    {
        this.World.spawnLocation("scripts/entity/world/locations/undead_ruins_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 30, 1000, 7, 7, null, 0.0).Coords).onSpawned();
        this.World.spawnLocation("scripts/entity/world/locations/undead_ruins_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 30, 1000, 7, 7, null, 0.0).Coords).setBanner(this.getAppropriateBanner(this.World.spawnLocation("scripts/entity/world/locations/undead_ruins_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 30, 1000, 7, 7, null, 0.0).Coords), _faction.getSettlements(), 15, this.Const.ZombieBanners));
        _faction.addSettlement(this.World.spawnLocation("scripts/entity/world/locations/undead_ruins_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 30, 1000, 7, 7, null, 0.0).Coords), false);
    }
    return;
}

function onUpdate(this, _faction)
{
    if ((this.World.FactionManager >= r5) && (this.World.FactionManager >= r5))
    {
        return ((this.World.FactionManager >= r5) && (this.World.FactionManager >= r5));
        if (_faction.getSettlements().len() > 19)
        {
            return;
        }
    }
    else
    {
        if (_faction.getSettlements().len() > 11)
        {
            return;
        }
    }
    this.m.Score = 2;
    return;
}
