// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/orc_young_low.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 100) <= 25)
    {
        this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/orc_javelin"));
    }
    if (this.Math.rand(1, 100) <= 75)
    {
        if (this.Math.rand(1, 2) == 1)
        {
        }
        else
        {
            if (this.Math.rand(1, 2) == 2)
            {
            }
        }
    }
    else
    {
        if (this.Math.rand(1, 3) == 1)
        {
        }
        else
        {
            if (this.Math.rand(1, 3) == 2)
            {
            }
            else
            {
                if (this.Math.rand(1, 3) == 3)
                {
                }
            }
        }
    }
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
    {
        this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
    }
    this.m.Items.addToBag(this.new("scripts/items/weapons/morning_star"));
    if (this.Math.rand(1, 100) <= 33)
    {
        this.m.Items.equip(this.new("scripts/items/shields/greenskins/orc_light_shield"));
    }
    if (this.Math.rand(1, 5) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_young_very_light_armor"));
    }
    else
    {
        if (this.Math.rand(1, 5) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_young_light_armor"));
        }
        else
        {
            if (this.Math.rand(1, 5) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_young_medium_armor"));
            }
        }
    }
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_young_light_helmet"));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_young_medium_helmet"));
        }
    }
    return;
}

function create(this)
{
    this.orc_young.create();
    return;
}

function onFinish(this)
{
    this.actor.onFinish();
    return;
}

function onInit(this)
{
    this.orc_young.onInit();
    return;
}
