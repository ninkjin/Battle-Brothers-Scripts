// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/goblin_ambusher_low.nut
// Functions: 3

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    if (this.Math.rand(1, 1) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_bow"));
    }
    this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_notched_blade"));
    this.m.Items.equip(this.new("scripts/items/armor/greenskins/goblin_skirmisher_armor"));
    this.m.Items.equip(this.new("scripts/items/helmets/greenskins/goblin_skirmisher_helmet"));
    return;
}

function create(this)
{
    this.goblin_ambusher.create();
    this.m.IsLow = true;
    return;
}

function onInit(this)
{
    this.goblin_ambusher.onInit();
    this.m.BaseProperties.MeleeSkill = this.m.BaseProperties.MeleeSkill op45 5;
    this.m.BaseProperties.RangedSkill = this.m.BaseProperties.RangedSkill op45 5;
    this.m.BaseProperties.RangedDefense = this.m.BaseProperties.RangedDefense op45 5;
    this.m.BaseProperties.MeleeDefense = this.m.BaseProperties.MeleeDefense op45 5;
    this.m.BaseProperties.DamageDirectMult = 1.0;
    this.m.Skills.update();
    return;
}
