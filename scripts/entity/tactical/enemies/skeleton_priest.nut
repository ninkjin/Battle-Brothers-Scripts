// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/skeleton_priest.nut
// Functions: 4

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_priest_attire"));
    this.m.Items.equip(this.new("scripts/items/helmets/ancient/ancient_priest_diadem"));
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.SkeletonPriest;
    this.m.XP = this.Const.Tactical.Actor.SkeletonPriest.XP;
    this.m.ResurrectionValue = 10.0;
    this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/skeleton_priest";
    this.skeleton.create();
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_priest_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_killer.isPlayerControlled() && _killer.isPlayerControlled())
    {
        return (_killer.isPlayerControlled() && _killer.isPlayerControlled());
        this.updateAchievement("Atheist", 1, 1);
    }
    this.skeleton.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.skeleton.onInit();
    this.getSprite("body").setBrush("bust_skeleton_body_02");
    this.setDirty(true);
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.SkeletonPriest);
    this.m.BaseProperties.TargetAttractionMult = 3.0;
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToBleeding = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.m.Skills.add(this.new("scripts/skills/actives/horror_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/miasma_skill"));
    return;
}
