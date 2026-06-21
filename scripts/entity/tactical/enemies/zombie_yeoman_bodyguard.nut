// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/zombie_yeoman_bodyguard.nut
// Functions: 2

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 6) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
    }
    else
    {
        if (this.Math.rand(1, 6) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
        }
        else
        {
            if (this.Math.rand(1, 6) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
            }
            else
            {
                if (this.Math.rand(1, 6) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
                }
                else
                {
                    if (this.Math.rand(1, 6) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 6) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
                        }
                    }
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 50)
    {
        if (this.Math.rand(1, 2) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/shields/worn_heater_shield"));
        }
        else
        {
            if (this.Math.rand(1, 2) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/shields/wooden_shield_old"));
            }
        }
    }
    if (this.Math.rand(1, 5) == 1)
    {
    }
    else
    {
        if (this.Math.rand(1, 5) == 2)
        {
        }
        else
        {
            if (this.Math.rand(1, 5) == 3)
            {
            }
            else
            {
                if (this.Math.rand(1, 5) == 4)
                {
                }
                else
                {
                    if (this.Math.rand(1, 5) == 5)
                    {
                    }
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 66)
    {
        this.new("scripts/items/armor/basic_mail_shirt").setArmor((this.Math.round(((this.new("scripts/items/armor/basic_mail_shirt").getArmorMax() / 2) - 1)) / 1.0));
    }
    this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
    if (this.Math.rand(1, 100) <= 75)
    {
        if (this.Math.rand(1, 7) == 1)
        {
        }
        else
        {
            if (this.Math.rand(1, 7) == 2)
            {
            }
            else
            {
                if (this.Math.rand(1, 7) == 3)
                {
                }
                else
                {
                    if (this.Math.rand(1, 7) == 4)
                    {
                    }
                    else
                    {
                        if (this.Math.rand(1, 7) == 5)
                        {
                        }
                        else
                        {
                            if (this.Math.rand(1, 7) == 6)
                            {
                            }
                            else
                            {
                                if (this.Math.rand(1, 7) == 7)
                                {
                                }
                            }
                        }
                    }
                }
            }
        }
        if (this.Math.rand(1, 100) <= 66)
        {
            this.new("scripts/items/helmets/full_leather_cap").setArmor((this.Math.round(((this.new("scripts/items/helmets/full_leather_cap").getArmorMax() / 2) - 1)) / 1.0));
        }
        this.m.Items.equip(this.new("scripts/items/helmets/full_leather_cap"));
    }
    return;
}

function create(this)
{
    this.m.IsCreatingAgent = false;
    this.zombie_yeoman.create();
    this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/zombie_yeoman_bodyguard";
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/zombie_bodyguard_agent");
    this.m.AIAgent.setActor(this);
    return;
}
