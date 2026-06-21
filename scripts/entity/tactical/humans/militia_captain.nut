// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/militia_captain.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 7) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/billhook"));
    }
    else
    {
        if (this.Math.rand(1, 7) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
        }
        else
        {
            if (this.Math.rand(1, 7) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
            }
            else
            {
                if (this.Math.rand(1, 7) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/military_cleaver"));
                }
                else
                {
                    if (this.Math.rand(1, 7) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 7) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
                        }
                        else
                        {
                            if (this.Math.rand(1, 7) == 7)
                            {
                                this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
                            }
                        }
                    }
                }
            }
        }
        if (this.Math.rand(1, 100) <= 75)
        {
            if (this.Math.rand(1, 2) == 1)
            {
                this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
            }
            else
            {
                if (this.Math.rand(1, 2) == 2)
                {
                    this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
                }
            }
        }
    }
    if (this.Math.rand(1, 3) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
    }
    else
    {
        if (this.Math.rand(1, 3) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
        }
        else
        {
            if (this.Math.rand(1, 3) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
            }
        }
    }
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/mail_coif"));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/kettle_hat"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet_with_mail"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/helmets/feathered_hat"));
                }
            }
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.MilitiaCaptain;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.MilitiaCaptain.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.AllMale;
    this.m.HairColors = this.Const.HairColors.Old;
    this.m.Beards = this.Const.Beards.All;
    this.m.Flags.add("militia");
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/militia_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.MilitiaCaptain);
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.BaseProperties.IsSpecializedInAxes = true;
    this.m.BaseProperties.IsSpecializedInMaces = true;
    this.m.BaseProperties.IsSpecializedInFlails = true;
    this.m.BaseProperties.IsSpecializedInPolearms = true;
    this.m.BaseProperties.IsSpecializedInThrowing = true;
    this.m.BaseProperties.IsSpecializedInHammers = true;
    this.m.BaseProperties.IsSpecializedInSpears = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_militia");
    this.getSprite("accessory_special").setBrush("bust_militia_band_02");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
    this.m.Skills.add(this.new("scripts/skills/actives/rally_the_troops"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
