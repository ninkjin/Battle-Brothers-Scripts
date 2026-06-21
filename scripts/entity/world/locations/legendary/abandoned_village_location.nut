// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/world/locations/legendary/abandoned_village_location.nut
// Functions: 6

function create(this)
{
    this.location.create();
    this.m.TypeID = "location.abandoned_village";
    this.m.LocationType = this.Const.World.LocationType.Unique;
    this.m.IsShowingDefenders = false;
    this.m.IsShowingBanner = false;
    this.m.IsAttackable = true;
    this.m.VisibilityMult = 1.0;
    this.m.Resources = 500;
    this.m.OnEnter = "event.location.abandoned_village_enter";
    return;
}

function getDescription(this)
{
    return "A seemingly abandoned village, with a towering statue dominating the square.";
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
    return;
}

function onInit(this)
{
    this.location.onInit();
    this.addSprite("body").setBrush("world_abandoned_village");
    return;
}

function onSpawned(this)
{
    this.m.Name = "Abandoned Village";
    this.location.onSpawned();
    return;
}
