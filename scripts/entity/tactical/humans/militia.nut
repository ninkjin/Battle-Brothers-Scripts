// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/militia.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (this.Math.rand(0, 10) <= 1)
    {
        if (this.Const.DLC.Unhold)
        {
            if (this.Math.rand(1, 6) == 1)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
            }
            else
            {
                if (this.Math.rand(1, 6) == 2)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/knife"));
                }
                else
                {
                    if (this.Math.rand(1, 6) == 3)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 6) == 4)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
                        }
                        else
                        {
                            if (this.Math.rand(1, 6) == 5)
                            {
                                this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
                            }
                            else
                            {
                                if (this.Math.rand(1, 6) == 6)
                                {
                                    this.m.Items.equip(this.new("scripts/items/weapons/goedendag"));
                                }
                            }
                        }
                    }
                }
            }
        }
        else
        {
            if (this.Math.rand(1, 5) == 1)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
            }
            else
            {
                if (this.Math.rand(1, 5) == 2)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/knife"));
                }
                else
                {
                    if (this.Math.rand(1, 5) == 3)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 5) == 4)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
                        }
                        else
                        {
                            if (this.Math.rand(1, 5) == 5)
                            {
                                this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
                            }
                        }
                    }
                }
            }
        }
    }
    else
    {
        if (this.Math.rand(0, 10) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
        }
        else
        {
            if (this.Math.rand(0, 10) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
            }
            else
            {
                if (this.Math.rand(0, 10) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
                }
                else
                {
                    if (this.Math.rand(0, 10) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
                    }
                    else
                    {
                        if (this.Math.rand(0, 10) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
                        }
                        else
                        {
                            if (this.Math.rand(0, 10) == 7)
                            {
                                this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
                            }
                            else
                            {
                                if (this.Math.rand(0, 10) == 8)
                                {
                                    this.m.Items.equip(this.new("scripts/items/weapons/wooden_flail"));
                                }
                                else
                                {
                                    if (this.Math.rand(0, 10) == 9)
                                    {
                                        this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
                                    }
                                    else
                                    {
                                        if (this.Math.rand(0, 10) == 10)
                                        {
                                            this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        if (this.Math.rand(1, 100) <= 25)
        {
            this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
        }
    }
    if (this.Math.rand(1, 6) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/leather_tunic"));
    }
    else
    {
        if (this.Math.rand(1, 6) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/linen_tunic"));
        }
        else
        {
            if (this.Math.rand(1, 6) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
            }
            else
            {
                if (this.Math.rand(1, 6) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/sackcloth"));
                }
                else
                {
                    if (this.Math.rand(1, 6) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 6) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/armor/thick_tunic"));
                        }
                        else
                        {
                            if (this.Math.rand(1, 6) == 7)
                            {
                                this.m.Items.equip(this.new("scripts/items/armor/apron"));
                            }
                        }
                    }
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 50)
    {
        if (this.Math.rand(1, 5) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/hood"));
        }
        else
        {
            if (this.Math.rand(1, 5) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
            }
            else
            {
                if (this.Math.rand(1, 5) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/helmets/open_leather_cap"));
                }
                else
                {
                    if (this.Math.rand(1, 5) == 4)
                    {
                        this.m.Items.equip(this.new("scripts/items/helmets/full_leather_cap"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 5) == 5)
                        {
                            this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
                        }
                    }
                }
            }
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Militia;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Militia.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.AllMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.All;
    this.m.Flags.add("militia");
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/militia_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Militia);
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_militia");
    this.getSprite("accessory_special").setBrush("bust_militia_band_01");
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
