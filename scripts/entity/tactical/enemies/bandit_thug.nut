// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/bandit_thug.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 11) == 1)
    {
        if (this.Const.DLC.Unhold)
        {
            if (this.Math.rand(1, 3) == 1)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
            }
            else
            {
                if (this.Math.rand(1, 3) == 2)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/goedendag"));
                }
                else
                {
                    if (this.Math.rand(1, 3) == 3)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
                    }
                }
            }
        }
        else
        {
            if (this.Math.rand(1, 2) == 1)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
            }
            else
            {
                if (this.Math.rand(1, 2) == 2)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
                }
            }
        }
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
        }
        else
        {
            if (this.Math.rand(1, 2) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
            }
            else
            {
                if (this.Math.rand(1, 2) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
                }
                else
                {
                    if (this.Math.rand(1, 2) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 2) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
                        }
                        else
                        {
                            if (this.Math.rand(1, 2) == 7)
                            {
                                this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
                            }
                            else
                            {
                                if (this.Math.rand(1, 2) == 8)
                                {
                                    this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
                                }
                                else
                                {
                                    if (this.Math.rand(1, 2) == 9)
                                    {
                                        this.m.Items.equip(this.new("scripts/items/weapons/wooden_flail"));
                                    }
                                    else
                                    {
                                        if (this.Math.rand(1, 2) == 10)
                                        {
                                            this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
                                        }
                                        else
                                        {
                                            if (this.Math.rand(1, 2) == 11)
                                            {
                                                this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        if (this.Math.rand(1, 100) <= 33)
        {
            if (this.Math.rand(1, 2) == 1)
            {
                this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
            }
            else
            {
                if (this.Math.rand(1, 2) == 2)
                {
                    this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
                }
            }
        }
    }
    if (this.Math.rand(0, 9) <= 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/leather_wraps"));
    }
    else
    {
        if (this.Math.rand(0, 9) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/thick_tunic"));
        }
        else
        {
            if (this.Math.rand(0, 9) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
            }
            else
            {
                if (this.Math.rand(0, 9) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
                }
                else
                {
                    if (this.Math.rand(0, 9) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/armor/ragged_surcoat"));
                    }
                    else
                    {
                        if (this.Math.rand(0, 9) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/armor/blotched_gambeson"));
                        }
                        else
                        {
                            if (this.Math.rand(0, 9) == 7)
                            {
                                this.m.Items.equip(this.new("scripts/items/armor/leather_tunic"));
                            }
                            else
                            {
                                if (this.Math.rand(0, 9) == 8)
                                {
                                    this.m.Items.equip(this.new("scripts/items/armor/monk_robe"));
                                }
                                else
                                {
                                    if (this.Math.rand(0, 9) == 9)
                                    {
                                        this.m.Items.equip(this.new("scripts/items/armor/gambeson"));
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 50)
    {
        if (this.Math.rand(1, 6) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/hood"));
        }
        else
        {
            if (this.Math.rand(1, 6) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/open_leather_cap"));
            }
            else
            {
                if (this.Math.rand(1, 6) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
                }
                else
                {
                    if (this.Math.rand(1, 6) == 4)
                    {
                        this.m.Items.equip(this.new("scripts/items/helmets/mouth_piece"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 6) == 5)
                        {
                            this.m.Items.equip(this.new("scripts/items/helmets/full_leather_cap"));
                        }
                        else
                        {
                            if (this.Math.rand(1, 6) == 6)
                            {
                                this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
                            }
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
    this.m.Type = this.Const.EntityType.BanditThug;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.BanditThug.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.UntidyMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.Raider;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onAppearanceChanged(this, _appearance, _setDirty)
{
    this.actor.onAppearanceChanged(_appearance, false);
    this.setDirty(true);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.BanditThug);
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_bandits");
    if (this.Math.rand(1, 100) <= 10)
    {
        this.getSprite("tattoo_head").Visible = true;
        this.getSprite("tattoo_head").setBrush("bust_head_pox_01");
    }
    if (this.Math.rand(1, 100) <= 15)
    {
        this.getSprite("tattoo_head").Visible = true;
        this.getSprite("tattoo_head").setBrush("bust_head_darkeyes_01");
    }
    this.getSprite("dirt").Visible = true;
    if (this.Math.rand(1, 100) <= 25)
    {
        this.getSprite("eye_rings").Visible = true;
    }
    this.getSprite("armor").Saturation = 0.800000011920929;
    this.getSprite("helmet").Saturation = 0.800000011920929;
    this.getSprite("helmet_damage").Saturation = 0.800000011920929;
    this.getSprite("shield_icon").Saturation = 0.800000011920929;
    this.getSprite("shield_icon").setBrightness(0.8999999761581421);
    return;
}
