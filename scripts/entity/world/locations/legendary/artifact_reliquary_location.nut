// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/world/locations/legendary/artifact_reliquary_location.nut
// Functions: 6

function create(this)
{
    this.location.create();
    this.m.TypeID = "location.artifact_reliquary";
    this.m.LocationType = this.Const.World.LocationType.Unique;
    this.m.IsShowingDefenders = false;
    this.m.IsShowingBanner = false;
    this.m.IsAttackable = true;
    this.m.VisibilityMult = 0.0;
    this.m.Resources = 500;
    this.m.OnEnter = "event.location.artifact_reliquary_enter";
    return;
}

function getDescription(this)
{
    return "A collapsed ruin from days long past. The occasional flicker of torchlight betrays the presence of current inhabitants, as do the strange sounds eminating from deep within.";
}

function onDiscovered(this)
{
    this.location.onDiscovered();
    this.World.Flags.increment("LegendaryLocationsDiscovered", 1);
    if (this.World.Flags.get("LegendaryLocationsDiscovered") >= 10)
    {
        this.updateAchievement("FamedExplorer", 1, 1);
    }
    return;
}

function onDropLootForPlayer(this, _lootTable)
{
    this.location.onDropLootForPlayer(_lootTable);
    this.dropTreasure(2, [], _lootTable);
    _lootTable.push(this.new("scripts/items/helmets/golems/grand_diviner_headdress"));
    _lootTable.push(this.new("scripts/items/armor/golems/grand_diviner_robes"));
    return;
}

function onInit(this)
{
    this.location.onInit();
    this.addSprite("body").setBrush("world_artifact_reliquary");
    return;
}

function onSpawned(this)
{
    this.m.Name = "Artifact Reliquary";
    this.location.onSpawned();
    return;
}
