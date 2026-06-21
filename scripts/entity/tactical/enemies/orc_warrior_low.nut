// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/orc_warrior_low.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 2) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_axe"));
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_cleaver"));
        }
    }
    if (this.Math.rand(1, 100) <= 66)
    {
        this.m.Items.equip(this.new("scripts/items/shields/greenskins/orc_heavy_shield"));
    }
    if (this.Math.rand(1, 2) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_warrior_light_armor"));
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_warrior_medium_armor"));
        }
    }
    if (this.Math.rand(1, 3) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_warrior_light_helmet"));
    }
    else
    {
        if (this.Math.rand(1, 3) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_warrior_medium_helmet"));
        }
    }
    return;
}

function create(this)
{
    this.orc_warrior.create();
    return;
}

function onFinish(this)
{
    this.actor.onFinish();
    return;
}

function onInit(this)
{
    this.orc_warrior.onInit();
    this.m.BaseProperties.DamageTotalMult = this.m.BaseProperties.DamageTotalMult op45 0.10000000149011612;
    this.m.Skills.update();
    return;
}
