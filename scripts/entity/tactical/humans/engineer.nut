// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/engineer.nut
// Functions: 5

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 100) <= 50)
    {
        if (this.Math.rand(1, 2) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/knife"));
        }
        else
        {
            if (this.Math.rand(1, 2) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
            }
        }
    }
    this.m.Items.equip(this.new("scripts/items/armor/oriental/padded_vest"));
    this.m.Items.equip(this.new("scripts/items/helmets/oriental/engineer_hat"));
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Engineer;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Engineer.XP;
    this.human.create();
    this.m.Bodies = this.Const.Bodies.SouthernMale;
    this.m.Faces = this.Const.Faces.SouthernMale;
    this.m.Hairs = this.Const.Hair.SouthernMale;
    this.m.HairColors = this.Const.HairColors.Southern;
    this.m.Beards = this.Const.Beards.Southern;
    this.m.BeardChance = 90;
    this.m.Ethnicity = 1;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_engineer_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Engineer);
    this.m.BaseProperties.TargetAttractionMult = 1.100000023841858;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_southern");
    this.m.Skills.add(this.new("scripts/skills/actives/load_mortar_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
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
