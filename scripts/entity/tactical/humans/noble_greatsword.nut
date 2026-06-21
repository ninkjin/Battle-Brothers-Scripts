// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/noble_greatsword.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (!this.Tactical.State.isScenarioMode())
    {
    }
    this.m.Surcoat = this.getFaction();
    if (this.Math.rand(1, 100) <= 50)
    {
        if (this.getFaction() < 10)
        {
        }
        this.getSprite("surcoat").setBrush(("surcoat_" + this.getFaction()));
    }
    if (this.Math.rand(1, 1) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/greatsword"));
    }
    if (this.Const.DLC.Unhold)
    {
        if (this.Math.rand(1, 5) <= 2)
        {
            this.new("scripts/items/armor/mail_hauberk").setVariant(28);
            this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
        }
        else
        {
            if (this.Math.rand(1, 5) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/scale_armor"));
            }
            else
            {
                if (this.Math.rand(1, 5) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/reinforced_mail_hauberk"));
                }
                else
                {
                    if (this.Math.rand(1, 5) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/armor/footman_armor"));
                    }
                }
            }
        }
    }
    else
    {
        if (this.Math.rand(1, 4) <= 2)
        {
            this.new("scripts/items/armor/mail_hauberk").setVariant(28);
            this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/scale_armor"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/reinforced_mail_hauberk"));
                }
            }
        }
    }
    if (this.Math.rand(1, 2) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/greatsword_hat"));
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
            this.new("scripts/items/helmets/greatsword_faction_helm").setVariant(this.getFaction());
            this.m.Items.equip(this.new("scripts/items/helmets/greatsword_faction_helm"));
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Greatsword;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Greatsword.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.CommonMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.All;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Greatsword);
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
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
