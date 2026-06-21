// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/vampire_low.nut
// Functions: 3

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
    return;
}

function create(this)
{
    this.vampire.create();
    return;
}

function onInit(this)
{
    this.vampire.onInit();
    this.setHitpoints(((this.getHitpointsMax() * this.Math.rand(25, 65)) * 0.009999999776482582));
    this.getSkills().update();
    return;
}
