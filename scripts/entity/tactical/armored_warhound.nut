// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/armored_warhound.nut
// Functions: 2

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new("scripts/items/armor/special/wardog_armor"));
    return;
}

function create(this)
{
    this.warhound.create();
    return;
}
