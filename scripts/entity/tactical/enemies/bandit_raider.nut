// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/bandit_raider.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 100) <= 20)
    {
        if (this.Const.DLC.Unhold)
        {
            if (this.Math.rand(0, 8) == 0)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
            }
            else
            {
                if (this.Math.rand(0, 8) == 1)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
                }
                else
                {
                    if (this.Math.rand(0, 8) == 2)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/pike"));
                    }
                    else
                    {
                        if (this.Math.rand(0, 8) == 3)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
                        }
                        else
                        {
                            if (this.Math.rand(0, 8) == 4)
                            {
                                this.m.Items.equip(this.new("scripts/items/weapons/longaxe"));
                            }
                            else
                            {
                                if (this.Math.rand(0, 8) == 5)
                                {
                                    this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
                                }
                                else
                                {
                                    if (this.Math.rand(0, 8) == 6)
                                    {
                                        this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_flail"));
                                    }
                                    else
                                    {
                                        if (this.Math.rand(0, 8) == 7)
                                        {
                                            this.m.Items.equip(this.new("scripts/items/weapons/two_handed_mace"));
                                        }
                                        else
                                        {
                                            if (this.Math.rand(0, 8) == 8)
                                            {
                                                this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
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
        else
        {
            if (this.Math.rand(0, 4) == 0)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
            }
            else
            {
                if (this.Math.rand(0, 4) == 1)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
                }
                else
                {
                    if (this.Math.rand(0, 4) == 2)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/pike"));
                    }
                    else
                    {
                        if (this.Math.rand(0, 4) == 3)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
                        }
                        else
                        {
                            if (this.Math.rand(0, 4) == 4)
                            {
                                this.m.Items.equip(this.new("scripts/items/weapons/longaxe"));
                            }
                        }
                    }
                }
            }
        }
    }
    else
    {
        if (this.Math.rand(2, 10) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
        }
        else
        {
            if (this.Math.rand(2, 10) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
            }
            else
            {
                if (this.Math.rand(2, 10) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
                }
                else
                {
                    if (this.Math.rand(2, 10) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
                    }
                    else
                    {
                        if (this.Math.rand(2, 10) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
                        }
                        else
                        {
                            if (this.Math.rand(2, 10) == 7)
                            {
                                this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
                            }
                            else
                            {
                                if (this.Math.rand(2, 10) == 8)
                                {
                                    this.m.Items.equip(this.new("scripts/items/weapons/flail"));
                                }
                                else
                                {
                                    if (this.Math.rand(2, 10) == 9)
                                    {
                                        this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
                                    }
                                    else
                                    {
                                        if (this.Math.rand(2, 10) == 10)
                                        {
                                            this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        if (this.Math.rand(1, 100) <= 75)
        {
            if (this.Math.rand(1, 100) <= 75)
            {
                this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
            }
            this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
        }
    }
    if ((this.Math <= 35) && (this.Math <= 35))
    {
        return ((this.Math <= 35) && (this.Math <= 35));
        if (this.Const.DLC.Unhold)
        {
            if (this.Math.rand(1, 3) == 1)
            {
                this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
            }
            else
            {
                if (this.Math.rand(1, 3) == 2)
                {
                    this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
                }
                else
                {
                    if (this.Math.rand(1, 3) == 3)
                    {
                        this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
                    }
                }
            }
        }
        else
        {
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
    }
    if (this.Math.rand(2, 7) == 2)
    {
    }
    else
    {
        if (this.Math.rand(2, 7) == 3)
        {
        }
        else
        {
            if (this.Math.rand(2, 7) == 4)
            {
            }
            else
            {
                if (this.Math.rand(2, 7) == 5)
                {
                }
                else
                {
                    if (this.Math.rand(2, 7) == 6)
                    {
                    }
                    else
                    {
                        if (this.Math.rand(2, 7) == 7)
                        {
                        }
                    }
                }
            }
        }
    }
    this.m.Items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
    if (this.Math.rand(1, 100) <= 85)
    {
        if (this.Math.rand(1, 5) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet"));
        }
        else
        {
            if (this.Math.rand(1, 5) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/dented_nasal_helmet"));
            }
            else
            {
                if (this.Math.rand(1, 5) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet_with_rusty_mail"));
                }
                else
                {
                    if (this.Math.rand(1, 5) == 4)
                    {
                        this.m.Items.equip(this.new("scripts/items/helmets/rusty_mail_coif"));
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
    this.m.Type = this.Const.EntityType.BanditRaider;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.BanditRaider.XP;
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
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.BanditRaider);
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_bandits");
    this.getSprite("dirt").Visible = true;
    this.getSprite("dirt").Alpha = this.Math.rand(150, 255);
    this.getSprite("armor").Saturation = 0.8500000238418579;
    this.getSprite("helmet").Saturation = 0.8500000238418579;
    this.getSprite("helmet_damage").Saturation = 0.8500000238418579;
    this.getSprite("shield_icon").Saturation = 0.8500000238418579;
    this.getSprite("shield_icon").setBrightness(0.8500000238418579);
    if (!this.m.IsLow)
    {
        this.m.BaseProperties.IsSpecializedInSwords = true;
        this.m.BaseProperties.IsSpecializedInAxes = true;
        this.m.BaseProperties.IsSpecializedInMaces = true;
        this.m.BaseProperties.IsSpecializedInFlails = true;
        this.m.BaseProperties.IsSpecializedInPolearms = true;
        this.m.BaseProperties.IsSpecializedInThrowing = true;
        this.m.BaseProperties.IsSpecializedInHammers = true;
        this.m.BaseProperties.IsSpecializedInSpears = true;
        this.m.BaseProperties.IsSpecializedInCleavers = true;
        if ((this.World.Days >= this.Const.World.Scaling.Brigands.RaiderStatIncreaseDay) && (this.World.Days >= this.Const.World.Scaling.Brigands.RaiderStatIncreaseDay))
        {
            return ((this.World.Days >= this.Const.World.Scaling.Brigands.RaiderStatIncreaseDay) && (this.World.Days >= this.Const.World.Scaling.Brigands.RaiderStatIncreaseDay));
            this.m.BaseProperties.MeleeSkill = this.m.BaseProperties.MeleeSkill op43 5;
            this.m.BaseProperties.RangedSkill = this.m.BaseProperties.RangedSkill op43 5;
        }
    }
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
