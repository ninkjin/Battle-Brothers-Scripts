// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/bandit_raider_low.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (this.Math.rand(0, 7) <= 1)
    {
        if (this.Const.DLC.Unhold)
        {
            if (this.Math.rand(0, 3) == 0)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
            }
            else
            {
                if (this.Math.rand(0, 3) == 1)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
                }
                else
                {
                    if (this.Math.rand(0, 3) == 2)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/pike"));
                    }
                    else
                    {
                        if (this.Math.rand(0, 3) == 3)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
                        }
                    }
                }
            }
        }
        else
        {
            if (this.Math.rand(0, 2) == 0)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
            }
            else
            {
                if (this.Math.rand(0, 2) == 1)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
                }
                else
                {
                    if (this.Math.rand(0, 2) == 2)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/pike"));
                    }
                }
            }
        }
    }
    else
    {
        if (this.Math.rand(0, 2) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
        }
        else
        {
            if (this.Math.rand(0, 2) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
            }
            else
            {
                if (this.Math.rand(0, 2) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
                }
                else
                {
                    if (this.Math.rand(0, 2) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
                    }
                    else
                    {
                        if (this.Math.rand(0, 2) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
                        }
                        else
                        {
                            if (this.Math.rand(0, 2) == 7)
                            {
                                this.m.Items.equip(this.new("scripts/items/weapons/flail"));
                            }
                        }
                    }
                }
            }
        }
        if (this.Math.rand(1, 100) <= 66)
        {
            if (this.Math.rand(1, 100) <= 33)
            {
                this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
            }
            this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
        }
    }
    if ((this.Math <= 25) && (this.Math <= 25))
    {
        return ((this.Math <= 25) && (this.Math <= 25));
        if (this.Math.rand(1, 2) == 1)
        {
            this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
        }
        else
        {
            if (this.Math.rand(1, 2) == 2)
            {
                this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
            }
        }
    }
    if (this.Math.rand(2, 6) == 2)
    {
        this.m.Items.equip(this.new("scripts/items/armor/ragged_surcoat"));
    }
    else
    {
        if (this.Math.rand(2, 6) == 3)
        {
            this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
        }
        else
        {
            if (this.Math.rand(2, 6) == 4)
            {
                this.m.Items.equip(this.new("scripts/items/armor/worn_mail_shirt"));
            }
            else
            {
                if (this.Math.rand(2, 6) == 5)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
                }
                else
                {
                    if (this.Math.rand(2, 6) == 6)
                    {
                        this.m.Items.equip(this.new("scripts/items/armor/leather_lamellar"));
                    }
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 75)
    {
        if (this.Math.rand(1, 4) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/dented_nasal_helmet"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/helmets/rusty_mail_coif"));
                }
                else
                {
                    if (this.Math.rand(1, 4) == 4)
                    {
                        this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
                    }
                }
            }
        }
    }
    return;
}

function create(this)
{
    this.bandit_raider.create();
    this.m.IsLow = true;
    return;
}

function onInit(this)
{
    this.bandit_raider.onInit();
    this.m.BaseProperties.MeleeSkill = this.m.BaseProperties.MeleeSkill op45 5;
    this.m.BaseProperties.MeleeDefense = this.m.BaseProperties.MeleeDefense op45 5;
    this.m.BaseProperties.RangedDefense = this.m.BaseProperties.RangedDefense op45 5;
    this.m.BaseProperties.FatigueRecoveryRate = 15;
    this.m.Skills.update();
    return;
}
