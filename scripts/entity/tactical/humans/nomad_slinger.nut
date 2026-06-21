// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/nomad_slinger.nut
// Functions: 5

function assignRandomEquipment(this)
{
    [].push([]);
    foreach (local key, value in r11)
    {
        this.m.Items.equip(this.new(("scripts/items/" + null)));
        this.m.Items.addToBag(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
        return;
    }
}

function create(this)
{
    this.m.Type = this.Const.EntityType.NomadSlinger;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.NomadSlinger.XP;
    this.human.create();
    this.m.Bodies = this.Const.Bodies.SouthernMale;
    this.m.Faces = this.Const.Faces.SouthernMale;
    this.m.Hairs = this.Const.Hair.SouthernMale;
    this.m.HairColors = this.Const.HairColors.Southern;
    this.m.Beards = this.Const.Beards.SouthernUntidy;
    this.m.BeardChance = 90;
    this.m.Ethnicity = 1;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_ranged_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.NomadSlinger);
    this.m.BaseProperties.TargetAttractionMult = 1.100000023841858;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_nomads");
    if (this.Math.rand(1, 100) <= 20)
    {
        this.getSprite("tattoo_head").Visible = true;
        this.getSprite("tattoo_head").setBrush("bust_head_darkeyes_01");
    }
    this.getSprite("dirt").Visible = true;
    this.getSprite("dirt").Alpha = this.Math.rand(150, 255);
    this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    if ((this.World.Days >= this.Const.World.Scaling.Nomads.SlingerHeadHunterDay) && (this.World.Days >= this.Const.World.Scaling.Nomads.SlingerHeadHunterDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.Nomads.SlingerHeadHunterDay) && (this.World.Days >= this.Const.World.Scaling.Nomads.SlingerHeadHunterDay));
        this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
    }
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
