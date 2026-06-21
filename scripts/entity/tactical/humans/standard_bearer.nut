// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/standard_bearer.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if ((!this.Tactical.State.isScenarioMode() && (!this.Tactical.State.isScenarioMode())))
    {
        return ((!this.Tactical.State.isScenarioMode()) && (!this.Tactical.State.isScenarioMode()));
    }
    this.m.Surcoat = this.getFaction();
    if (this.getFaction() < 10)
    {
    }
    this.getSprite("surcoat").setBrush(("surcoat_" + this.getFaction()));
    this.new("scripts/items/tools/faction_banner").setVariant(this.getFaction());
    this.m.Items.equip(this.new("scripts/items/tools/faction_banner"));
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
        this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
    }
    if (this.Math.rand(1, 100) <= 90)
    {
        if (this.getFaction() <= 4)
        {
            if (this.Math.rand(1, 3) == 1)
            {
            }
            else
            {
                if (this.Math.rand(1, 3) == 2)
                {
                }
            }
        }
        else
        {
            if (this.getFaction() <= 7)
            {
                if (this.Math.rand(1, 3) == 1)
                {
                }
                else
                {
                    if (this.Math.rand(1, 3) == 2)
                    {
                    }
                }
            }
            else
            {
                if (this.Math.rand(1, 3) == 1)
                {
                }
                else
                {
                    if (this.Math.rand(1, 3) == 2)
                    {
                    }
                }
            }
        }
        this.new("scripts/items/helmets/nasal_helmet_with_mail").setPlainVariant();
        this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet_with_mail"));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.StandardBearer;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.StandardBearer.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.Military;
    this.m.HairColors = this.Const.HairColors.Old;
    this.m.Beards = this.Const.Beards.Tidy;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_standard_bearer_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.StandardBearer);
    this.m.BaseProperties.TargetAttractionMult = 1.5;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_military");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_inspiring_presence"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/rally_the_troops"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
