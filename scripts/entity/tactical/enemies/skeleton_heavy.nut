// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/skeleton_heavy.nut
// Functions: 5

function assignRandomEquipment(this)
{
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
    {
        if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
        {
            [].extend([]);
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
    {
        this.m.Items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
    }
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
    {
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
    {
        this.m.Items.equip(this.new("scripts/items/helmets/ancient/ancient_honorguard_helmet"));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.SkeletonHeavy;
    this.m.XP = this.Const.Tactical.Actor.SkeletonHeavy.XP;
    this.m.ResurrectionValue = 5.0;
    this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/skeleton_heavy";
    this.skeleton.create();
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function makeMiniboss(this)
{
    if (!this.actor.makeMiniboss())
    {
        return false;
    }
    this.getSprite("miniboss").setBrush("bust_miniboss");
    this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedUndeadWeapons["this.Math.rand(0, (this.Const.Items.NamedUndeadWeapons.len() - 1))"])));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_devastating_strikes"));
    return this.Const.Items.NamedUndeadWeapons;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_killer.isPlayerControlled() && _killer.isPlayerControlled())
    {
        return (_killer.isPlayerControlled() && _killer.isPlayerControlled());
        this.updateAchievement("WalkingStatue", 1, 1);
    }
    this.skeleton.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.skeleton.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.SkeletonHeavy);
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToBleeding = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    this.m.BaseProperties.IsSpecializedInAxes = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    if ((this.World.Days >= this.Const.World.Scaling.AncientDead.HonorGuardPolearmSpecDay) && (this.World.Days >= this.Const.World.Scaling.AncientDead.HonorGuardPolearmSpecDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.AncientDead.HonorGuardPolearmSpecDay) && (this.World.Days >= this.Const.World.Scaling.AncientDead.HonorGuardPolearmSpecDay));
        this.m.BaseProperties.IsSpecializedInPolearms = true;
    }
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
    return;
}
