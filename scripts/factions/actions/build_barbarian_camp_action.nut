// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/actions/build_barbarian_camp_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "build_barbarian_camp_action";
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
    if (this.Math.rand(1, 3) == 1)
    {
        if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 7, 20, 1000, 7, 7, null, 0.75) != null)
        {
        }
    }
    else
    {
        if (this.Math.rand(1, 3) == 2)
        {
            if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 9, 25, 1000, 7, 7, null, 0.75) != null)
            {
            }
        }
        else
        {
            if (this.Math.rand(1, 3) == 3)
            {
                if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 13, 35, 1000, 7, 7, null, 0.75) != null)
                {
                }
            }
        }
    }
    if (this.World.spawnLocation("scripts/entity/world/locations/barbarian_sanctuary_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 13, 35, 1000, 7, 7, null, 0.75).Coords) != null)
    {
        this.World.spawnLocation("scripts/entity/world/locations/barbarian_sanctuary_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 13, 35, 1000, 7, 7, null, 0.75).Coords).onSpawned();
        this.World.spawnLocation("scripts/entity/world/locations/barbarian_sanctuary_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 13, 35, 1000, 7, 7, null, 0.75).Coords).setBanner(this.getAppropriateBanner(this.World.spawnLocation("scripts/entity/world/locations/barbarian_sanctuary_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 13, 35, 1000, 7, 7, null, 0.75).Coords), _faction.getSettlements(), 15, this.Const.BarbarianBanners));
        _faction.addSettlement(this.World.spawnLocation("scripts/entity/world/locations/barbarian_sanctuary_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 13, 35, 1000, 7, 7, null, 0.75).Coords), false);
    }
    return;
}

function onUpdate(this, _faction)
{
    if (this.World.FactionManager.isGreaterEvil())
    {
        if (_faction.getSettlements().len() > 5)
        {
            return;
        }
    }
    else
    {
        if (_faction.getSettlements().len() > 7)
        {
            return;
        }
    }
    this.m.Score = 2;
    return;
}
