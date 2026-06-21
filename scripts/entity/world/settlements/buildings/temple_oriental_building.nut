// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/world/settlements/buildings/temple_oriental_building.nut
// Functions: 2

function create(this)
{
    this.temple_building.create();
    this.m.UIImage = "ui/settlements/desert_building_03";
    this.m.UIImageNight = "ui/settlements/desert_building_03_night";
    this.m.Sounds = [];
    this.m.SoundsAtNight = [];
    return;
}

function onUpdateDraftList(this, _list)
{
    _list.push("cripple_southern_background");
    return;
}
