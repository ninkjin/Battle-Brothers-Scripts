// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/actions/build_nomad_camp_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "build_nomad_camp_action";
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
    if (0 < this.Const.World.TerrainType.COUNT)
    {
        if ((0 == this.Const.World.TerrainType.Hills) || (0 == this.Const.World.TerrainType.Hills) || (0 == this.Const.World.TerrainType.Hills))
        {
            return ((0 == this.Const.World.TerrainType.Hills) || (0 == this.Const.World.TerrainType.Hills) || (0 == this.Const.World.TerrainType.Hills));
        }
        [].push(0);
    }
    if (this.Math.rand(1, 4) == 1)
    {
        if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 7, 20, 1000, 7, 7, null, 0.0, 0.20000000298023224) != null)
        {
        }
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 9, 25, 1000, 7, 7, null, 0.0, 0.20000000298023224) != null)
            {
            }
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 13, 35, 1000, 7, 7, null, 0.0, 0.20000000298023224) != null)
                {
                }
            }
            else
            {
                if (this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 9, 25, 1000, 7, 7, null, 0.0, 0.20000000298023224) != null)
                {
                }
            }
        }
    }
    if (this.World.spawnLocation("scripts/entity/world/locations/nomad_ruins_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 9, 25, 1000, 7, 7, null, 0.0, 0.20000000298023224).Coords) != null)
    {
        this.World.spawnLocation("scripts/entity/world/locations/nomad_ruins_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 9, 25, 1000, 7, 7, null, 0.0, 0.20000000298023224).Coords).onSpawned();
        this.World.spawnLocation("scripts/entity/world/locations/nomad_ruins_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 9, 25, 1000, 7, 7, null, 0.0, 0.20000000298023224).Coords).setBanner(this.getAppropriateBanner(this.World.spawnLocation("scripts/entity/world/locations/nomad_ruins_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 9, 25, 1000, 7, 7, null, 0.0, 0.20000000298023224).Coords), _faction.getSettlements(), 10, this.Const.NomadBanners));
        _faction.addSettlement(this.World.spawnLocation("scripts/entity/world/locations/nomad_ruins_location", this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [], 9, 25, 1000, 7, 7, null, 0.0, 0.20000000298023224).Coords), false);
    }
    return;
}

function onUpdate(this, _faction)
{
    if (this.World.FactionManager.isGreaterEvil())
    {
        if (_faction.getSettlements().len() > 7)
        {
            return;
        }
    }
    else
    {
        if (_faction.getSettlements().len() > 9)
        {
            return;
        }
    }
    this.m.Score = 2;
    return;
}
