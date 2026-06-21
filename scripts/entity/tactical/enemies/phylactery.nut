// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/phylactery.nut
// Functions: 4

function create(this)
{
    this.m.IsActingEachTurn = false;
    this.m.IsNonCombatant = true;
    this.m.IsShakingOnHit = false;
    this.m.Type = this.Const.EntityType.SkeletonPhylactery;
    this.m.BloodType = this.Const.BloodType.None;
    this.m.MoraleState = this.Const.MoraleState.Ignore;
    this.m.XP = this.Const.Tactical.Actor.SkeletonPhylactery.XP;
    this.m.BloodSplatterOffset = this.createVec(0, 0);
    this.actor.create();
    this.m.Sound["this.Const.Sound.ActorEvent.Death"] = ["sounds/enemies/dlc6/phylactery_death_01.wav", "sounds/enemies/dlc6/phylactery_death_02.wav", "sounds/enemies/dlc6/phylactery_death_03.wav", "sounds/enemies/dlc6/phylactery_death_04.wav"];
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/donkey_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onDamageReceived(this, _attacker, _skill, _hitInfo)
{
    _hitInfo.BodyPart = this.Const.BodyPart.Body;
    return this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
    return _attacker;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_tile != null)
    {
        {}.Stages <- [];
        if (_tile.IsVisibleForPlayer)
        {
            this.Tactical.spawnParticleEffect(false, {}.Brushes, _tile, {}.Delay, {}.Quantity, {}.LifeTimeQuantity, {}.SpawnRate, {}.Stages, this.createVec(0, 40));
        }
        _tile.spawnDetail("phylactery_destroyed", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50));
        this.spawnTerrainDropdownEffect(_tile);
    }
    this.dropLoot(_tile, this.getLootForTile(_killer, []), (!(this.Math.rand(0, 100) < 50)));
    this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.actor.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.SkeletonPhylactery);
    this.m.BaseProperties.IsImmuneToKnockBackAndGrab = true;
    this.m.BaseProperties.IsImmuneToStun = true;
    this.m.BaseProperties.IsImmuneToRoot = true;
    this.m.BaseProperties.IsImmuneToBleeding = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    this.m.BaseProperties.IsImmuneToHeadshots = true;
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsMovable = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToDisarm = true;
    this.m.BaseProperties.TargetAttractionMult = 1.0;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.addSprite("body").setBrush("phylactery");
    this.addSprite("body").setHorizontalFlipping((this.Math.rand(0, 1) == 1));
    this.addDefaultStatusSprites();
    this.m.Skills.add(this.new("scripts/skills/racial/skeleton_racial"));
    this.m.Skills.update();
    return;
}
