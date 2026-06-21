// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/assassin.nut
// Functions: 5

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 3) <= 2)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/oriental/qatal_dagger"));
    }
    else
    {
        if (this.Math.rand(1, 3) == 3)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/shamshir"));
        }
    }
    this.m.Items.equip(this.new("scripts/items/armor/oriental/assassin_robe"));
    if (this.Math.rand(1, 2) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/oriental/assassin_head_wrap"));
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/oriental/assassin_face_mask"));
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Assassin;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Assassin.XP;
    this.human.create();
    this.m.Bodies = this.Const.Bodies.SouthernMale;
    this.m.Faces = this.Const.Faces.SouthernMale;
    this.m.Hairs = this.Const.Hair.SouthernMale;
    this.m.HairColors = this.Const.HairColors.Southern;
    this.m.Beards = this.Const.Beards.Southern;
    this.m.BeardChance = 90;
    this.m.Ethnicity = 1;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/assassin_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Assassin);
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.BaseProperties.IsSpecializedInThrowing = true;
    this.m.BaseProperties.IsSpecializedInDaggers = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_southern");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
    this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
    return;
}

function onOtherActorDeath(this, _killer, _victim, _skill)
{
    if (this.Const.EntityType.Slave && this.Const.EntityType.Slave)
    {
        return (this.Const.EntityType.Slave && this.Const.EntityType.Slave);
    }
    this.actor.onOtherActorDeath(_killer, _victim, _skill);
    return;
}

function onOtherActorFleeing(this, _actor)
{
    if (this.Const.EntityType.Slave && this.Const.EntityType.Slave)
    {
        return (this.Const.EntityType.Slave && this.Const.EntityType.Slave);
    }
    this.actor.onOtherActorFleeing(_actor);
    return;
}
