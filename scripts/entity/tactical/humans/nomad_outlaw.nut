// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/nomad_outlaw.nut
// Functions: 5

function assignRandomEquipment(this)
{
    if (this.Const.DLC.Unhold)
    {
        if ((this.World.Days >= this.Const.World.Scaling.Nomads.OutlawThreeHeadedFlailDay) && (this.World.Days >= this.Const.World.Scaling.Nomads.OutlawThreeHeadedFlailDay))
        {
            return ((this.World.Days >= this.Const.World.Scaling.Nomads.OutlawThreeHeadedFlailDay) && (this.World.Days >= this.Const.World.Scaling.Nomads.OutlawThreeHeadedFlailDay));
            [].push("weapons/three_headed_flail");
        }
    }
    this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    if ((this.Math <= 66) && (this.Math <= 66))
    {
        return ((this.Math <= 66) && (this.Math <= 66));
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.NomadOutlaw;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.NomadOutlaw.XP;
    this.human.create();
    this.m.Bodies = this.Const.Bodies.SouthernMale;
    this.m.Faces = this.Const.Faces.SouthernMale;
    this.m.Hairs = this.Const.Hair.SouthernMale;
    this.m.HairColors = this.Const.HairColors.Southern;
    this.m.Beards = this.Const.Beards.SouthernUntidy;
    this.m.BeardChance = 90;
    this.m.Ethnicity = 1;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.NomadOutlaw);
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_nomads");
    if (this.Math.rand(1, 100) <= 15)
    {
        this.getSprite("tattoo_head").Visible = true;
        this.getSprite("tattoo_head").setBrush("bust_head_darkeyes_01");
    }
    this.getSprite("dirt").Visible = true;
    if (this.Math.rand(1, 100) <= 25)
    {
        this.getSprite("eye_rings").Visible = true;
    }
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.BaseProperties.IsSpecializedInAxes = true;
    this.m.BaseProperties.IsSpecializedInMaces = true;
    this.m.BaseProperties.IsSpecializedInFlails = true;
    this.m.BaseProperties.IsSpecializedInPolearms = true;
    this.m.BaseProperties.IsSpecializedInThrowing = true;
    this.m.BaseProperties.IsSpecializedInHammers = true;
    this.m.BaseProperties.IsSpecializedInSpears = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    if ((this.World.Days >= this.Const.World.Scaling.Nomads.OutlawStatIncreaseDay) && (this.World.Days >= this.Const.World.Scaling.Nomads.OutlawStatIncreaseDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.Nomads.OutlawStatIncreaseDay) && (this.World.Days >= this.Const.World.Scaling.Nomads.OutlawStatIncreaseDay));
        this.m.BaseProperties.MeleeSkill = this.m.BaseProperties.MeleeSkill op43 5;
        this.m.BaseProperties.RangedSkill = this.m.BaseProperties.RangedSkill op43 5;
    }
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
    this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    if ((this.World.Days >= this.Const.World.Scaling.Nomads.OutlawDodgeDay) && (this.World.Days >= this.Const.World.Scaling.Nomads.OutlawDodgeDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.Nomads.OutlawDodgeDay) && (this.World.Days >= this.Const.World.Scaling.Nomads.OutlawDodgeDay));
        this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
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
