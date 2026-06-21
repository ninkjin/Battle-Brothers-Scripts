// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/caravan_guard.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 5) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
    }
    else
    {
        if (this.Math.rand(1, 5) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
        }
        else
        {
            if (this.Math.rand(1, 5) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
            }
            else
            {
                if (this.Math.rand(1, 5) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
                }
                else
                {
                    if (this.Math.rand(1, 5) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
                    }
                }
            }
        }
    }
    this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
    if (this.Math.rand(1, 100) <= 35)
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
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/leather_tunic"));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/leather_lamellar"));
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 75)
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
                    this.m.Items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
                }
                else
                {
                    if (this.Math.rand(1, 5) == 4)
                    {
                        this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 5) == 5)
                        {
                            this.m.Items.equip(this.new("scripts/items/helmets/padded_nasal_helmet"));
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
    this.m.Type = this.Const.EntityType.CaravanGuard;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.CaravanGuard.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.CommonMale;
    this.m.HairColors = this.Const.HairColors.Young;
    this.m.Beards = this.Const.Beards.All;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/caravan_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.CaravanGuard);
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.BaseProperties.IsSpecializedInAxes = true;
    this.m.BaseProperties.IsSpecializedInMaces = true;
    this.m.BaseProperties.IsSpecializedInFlails = true;
    this.m.BaseProperties.IsSpecializedInPolearms = true;
    this.m.BaseProperties.IsSpecializedInThrowing = true;
    this.m.BaseProperties.IsSpecializedInHammers = true;
    this.m.BaseProperties.IsSpecializedInSpears = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    this.m.BaseProperties.IsSpecializedInSpears = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_caravan");
    this.getSprite("dirt").Visible = true;
    this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
