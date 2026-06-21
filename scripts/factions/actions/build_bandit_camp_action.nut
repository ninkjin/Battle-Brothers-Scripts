// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/actions/build_bandit_camp_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "build_bandit_camp_action";
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
    if (this.Const.DLC.Wildmen)
    {
    }
    if (this.Math.rand(1, 3) == 1)
    {
        if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 7, 16, 1000, 7, 7, null, 0.0, 1.0) != null)
        {
        }
    }
    else
    {
        if (this.Math.rand(1, 3) == 2)
        {
            if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 6, 12, 1000, 7, 7, null, 0.0, 1.0) != null)
            {
            }
        }
        else
        {
            if (this.Math.rand(1, 3) == 3)
            {
                if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 20, 1000, 7, 7, null, 0.0, 1.0) != null)
                {
                }
            }
        }
    }
    if (this.World.spawnLocation("scripts/entity/world/locations/bandit_ruins_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 20, 1000, 7, 7, null, 0.0, 1.0).Coords) != null)
    {
        this.World.spawnLocation("scripts/entity/world/locations/bandit_ruins_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 20, 1000, 7, 7, null, 0.0, 1.0).Coords).onSpawned();
        this.World.spawnLocation("scripts/entity/world/locations/bandit_ruins_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 20, 1000, 7, 7, null, 0.0, 1.0).Coords).setBanner(this.getAppropriateBanner(this.World.spawnLocation("scripts/entity/world/locations/bandit_ruins_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 20, 1000, 7, 7, null, 0.0, 1.0).Coords), _faction.getSettlements(), 15, this.Const.BanditBanners));
        _faction.addSettlement(this.World.spawnLocation("scripts/entity/world/locations/bandit_ruins_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 10, 20, 1000, 7, 7, null, 0.0, 1.0).Coords), false);
    }
    return;
}

function onUpdate(this, _faction)
{
    if ((this.World.FactionManager >= r5) && (this.World.FactionManager >= r5))
    {
        return ((this.World.FactionManager >= r5) && (this.World.FactionManager >= r5));
        if (this.Const.DLC.Wildmen)
        {
        }
        if (_faction.getSettlements().len() > 16)
        {
            return;
        }
    }
    else
    {
        if (this.World.FactionManager.isGreaterEvil())
        {
            if (this.Const.DLC.Wildmen)
            {
            }
            if (_faction.getSettlements().len() > 8)
            {
                return;
            }
        }
        else
        {
            if (this.Const.DLC.Wildmen)
            {
            }
            if (_faction.getSettlements().len() > 12)
            {
                return;
            }
        }
    }
    this.m.Score = 2;
    return;
}
