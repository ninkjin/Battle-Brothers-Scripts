// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/conscript_polearm.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (!this.Tactical.State.isScenarioMode())
    {
    }
    if (this.Math.rand(1, 2) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/oriental/polemace"));
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/oriental/swordlance"));
        }
    }
    if (this.Math.rand(1, 3) <= 2)
    {
        if (13 == 12)
        {
            this.new("scripts/items/armor/oriental/linothorax").setVariant(9);
        }
        else
        {
            if (13 == 13)
            {
                this.new("scripts/items/armor/oriental/linothorax").setVariant(10);
            }
            else
            {
                if (13 == 14)
                {
                    this.new("scripts/items/armor/oriental/linothorax").setVariant(8);
                }
            }
        }
        this.m.Items.equip(this.new("scripts/items/armor/oriental/linothorax"));
    }
    else
    {
        if (this.Math.rand(1, 3) == 3)
        {
            this.m.Items.equip(this.new("scripts/items/armor/oriental/southern_mail_shirt"));
        }
    }
    if (13 == 12)
    {
        this.new("scripts/items/helmets/oriental/southern_head_wrap").setVariant(12);
    }
    else
    {
        if (13 == 13)
        {
            this.new("scripts/items/helmets/oriental/southern_head_wrap").setVariant(8);
        }
        else
        {
            if (13 == 14)
            {
                this.new("scripts/items/helmets/oriental/southern_head_wrap").setVariant(7);
            }
        }
    }
    this.m.Items.equip(this.new("scripts/items/helmets/oriental/southern_head_wrap"));
    return;
}

function create(this)
{
    this.conscript.create();
    return;
}

function onInit(this)
{
    this.conscript.onInit();
    return;
}
