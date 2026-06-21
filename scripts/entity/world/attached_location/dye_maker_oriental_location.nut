// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/world/attached_location/dye_maker_oriental_location.nut
// Functions: 1

function create(this)
{
    this.dye_maker_location.create();
    this.m.Sprite = "world_southern_dye";
    this.m.SpriteDestroyed = "world_southern_dye_ruins";
    return;
}
