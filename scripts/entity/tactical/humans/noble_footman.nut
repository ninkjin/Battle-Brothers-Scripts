// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/noble_footman.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (!this.Tactical.State.isScenarioMode())
    {
    }
    this.m.Surcoat = this.getFaction();
    if (this.Math.rand(1, 100) <= 90)
    {
        if (this.getFaction() < 10)
        {
        }
        this.getSprite("surcoat").setBrush(("surcoat_" + this.getFaction()));
    }
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
                }
            }
        }
    }
    if (this.Math.rand(1, 2) == 1)
    {
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
        }
    }
    this.new("scripts/items/shields/faction_heater_shield").setFaction(this.getFaction());
    this.m.Items.equip(this.new("scripts/items/shields/faction_heater_shield"));
    if ((this.getFaction() == 10) && (this.getFaction() == 10))
    {
        return ((this.getFaction() == 10) && (this.getFaction() == 10));
        if (this.Math.rand(1, 4) == 1)
        {
            this.new("scripts/items/armor/mail_hauberk").setVariant(28);
            this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/leather_scale_armor"));
                }
                this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
            }
        }
    }
    else
    {
        if (this.Math.rand(1, 3) == 1)
        {
            this.new("scripts/items/armor/mail_hauberk").setVariant(28);
            this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
        }
        else
        {
            if (this.Math.rand(1, 3) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
            }
            this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
        }
    }
    if (this.getFaction() <= 4)
    {
        if (this.Math.rand(1, 4) == 1)
        {
        }
        else
        {
            if (this.Math.rand(1, 4) == 2)
            {
            }
            else
            {
                if (this.Math.rand(1, 4) == 3)
                {
                }
            }
        }
    }
    else
    {
        if (this.getFaction() <= 7)
        {
            if (this.Math.rand(1, 4) == 1)
            {
            }
            else
            {
                if (this.Math.rand(1, 4) == 2)
                {
                }
                else
                {
                    if (this.Math.rand(1, 4) == 3)
                    {
                    }
                }
            }
        }
        else
        {
            if (this.Math.rand(1, 4) == 1)
            {
            }
            else
            {
                if (this.Math.rand(1, 4) == 2)
                {
                }
                else
                {
                    if (this.Math.rand(1, 4) == 3)
                    {
                    }
                }
            }
        }
    }
    if (this.new("scripts/items/helmets/mail_coif") != null)
    {
        this.new("scripts/items/helmets/mail_coif").setPlainVariant();
        this.m.Items.equip(this.new("scripts/items/helmets/mail_coif"));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Footman;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Footman.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.CommonMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.Tidy;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Footman);
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
    this.getSprite("socket").setBrush("bust_base_military");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
