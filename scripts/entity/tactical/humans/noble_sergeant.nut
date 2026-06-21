// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/noble_sergeant.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (!this.Tactical.State.isScenarioMode())
    {
    }
    this.m.Surcoat = this.getFaction();
    if (this.Math.rand(1, 100) <= 80)
    {
        if (this.getFaction() < 10)
        {
        }
        this.getSprite("surcoat").setBrush(("surcoat_" + this.getFaction()));
    }
    if (this.Math.rand(1, 5) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/warhammer"));
    }
    else
    {
        if (this.Math.rand(1, 5) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/fighting_axe"));
        }
        else
        {
            if (this.Math.rand(1, 5) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
            }
            else
            {
                if (this.Math.rand(1, 5) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/winged_mace"));
                }
                else
                {
                    if (this.Math.rand(1, 5) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/military_cleaver"));
                    }
                }
            }
        }
    }
    if (this.Math.rand(1, 2) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/reinforced_mail_hauberk"));
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
            this.new("scripts/items/armor/mail_hauberk").setVariant(30);
            this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Sergeant;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Sergeant.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.Military;
    this.m.HairColors = this.Const.HairColors.Old;
    this.m.Beards = this.Const.Beards.Tidy;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Sergeant);
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
    this.getSprite("accessory_special").setBrush("sergeant_trophy");
    if (this.Math.rand(1, 100) <= 33)
    {
        if (this.Math.rand(1, 3) == 1)
        {
            this.getSprite("permanent_injury_4").setBrush("permanent_injury_04");
            this.getSprite("permanent_injury_4").Visible = true;
        }
        else
        {
            if (this.Math.rand(1, 3) == 2)
            {
                this.getSprite("permanent_injury_2").setBrush("permanent_injury_02");
                this.getSprite("permanent_injury_2").Visible = true;
            }
            else
            {
                if (this.Math.rand(1, 3) == 3)
                {
                    this.getSprite("permanent_injury_1").setBrush("permanent_injury_01");
                    this.getSprite("permanent_injury_1").Visible = true;
                }
            }
        }
    }
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
