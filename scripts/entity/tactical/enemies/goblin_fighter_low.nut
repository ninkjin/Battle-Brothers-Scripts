// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/goblin_fighter_low.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 3) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_falchion"));
    }
    else
    {
        if (this.Math.rand(1, 3) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_spear"));
        }
        else
        {
            if (this.Math.rand(1, 3) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_notched_blade"));
            }
        }
    }
    if ((this.m.Items != r14) && (this.m.Items != r14))
    {
        return ((this.m.Items != r14) && (this.m.Items != r14));
        this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_spiked_balls"));
    }
    if (this.m.Items && this.m.Items)
    {
        return (this.m.Items && this.m.Items);
        if (this.Math.rand(1, 100) <= 50)
        {
            this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
        }
        this.m.Items.equip(this.new("scripts/items/shields/greenskins/goblin_light_shield"));
    }
    if (this.Math.rand(1, 2) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/greenskins/goblin_light_armor"));
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/greenskins/goblin_medium_armor"));
        }
    }
    if (this.Math.rand(1, 100) <= 50)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/greenskins/goblin_light_helmet"));
    }
    return;
}

function create(this)
{
    this.goblin_fighter.create();
    this.m.IsLow = true;
    return;
}

function onInit(this)
{
    this.goblin_fighter.onInit();
    this.m.BaseProperties.MeleeSkill = this.m.BaseProperties.MeleeSkill op45 5;
    this.m.BaseProperties.RangedSkill = this.m.BaseProperties.RangedSkill op45 5;
    this.m.BaseProperties.RangedDefense = this.m.BaseProperties.RangedDefense op45 5;
    this.m.BaseProperties.MeleeDefense = this.m.BaseProperties.MeleeDefense op45 5;
    this.m.BaseProperties.DamageDirectMult = 1.0;
    this.m.Skills.update();
    return;
}
