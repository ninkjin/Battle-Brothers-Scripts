// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objective/greenskin_catapult.nut
// Functions: 5

function create(this)
{
    this.m.IsActingEachTurn = false;
    this.m.IsNonCombatant = true;
    this.m.IsShakingOnHit = false;
    this.m.Type = this.Const.EntityType.GreenskinCatapult;
    this.m.BloodType = this.Const.BloodType.None;
    this.m.MoraleState = this.Const.MoraleState.Ignore;
    this.m.XP = this.Const.Tactical.Actor.Donkey.XP;
    this.m.BloodSplatterOffset = this.createVec(0, 0);
    this.actor.create();
    this.m.Sound["this.Const.Sound.ActorEvent.DamageReceived"] = ["sounds/enemies/catapult_hurt_01.wav", "sounds/enemies/catapult_hurt_02.wav", "sounds/enemies/catapult_hurt_03.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Death"] = ["sounds/enemies/catapult_death_02.wav"];
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/donkey_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onAfterDeath(this, _tile)
{
    _tile.spawnObject("entity/tactical/objects/destroyed_greenskin_catapult");
    if (0 < this.Const.Tactical.BurnParticles.len())
    {
        this.Tactical.spawnParticleEffect(false, this.Const.Tactical.BurnParticles["0"].Brushes, _tile, this.Const.Tactical.BurnParticles["0"].Delay, this.Math.max(1, this.Const.Tactical.BurnParticles["0"].Quantity), this.Math.max(1, this.Const.Tactical.BurnParticles["0"].LifeTimeQuantity), this.Const.Tactical.BurnParticles["0"].SpawnRate, this.Const.Tactical.BurnParticles["0"].Stages, this.createVec(0, -10));
    }
    return;
}

function onDamageReceived(this, _attacker, _skill, _hitInfo)
{
    _hitInfo.BodyPart = this.Const.BodyPart.Body;
    return this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
    return _attacker;
}

function onInit(this)
{
    this.actor.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.GreenskinCatapult);
    this.m.BaseProperties.IsImmuneToKnockBackAndGrab = true;
    this.m.BaseProperties.IsImmuneToStun = true;
    this.m.BaseProperties.IsImmuneToRoot = true;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToBleeding = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    this.m.BaseProperties.IsImmuneToDisarm = true;
    this.m.BaseProperties.IsImmuneToHeadshots = true;
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsMovable = false;
    this.m.BaseProperties.TargetAttractionMult = 1.5;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.addSprite("body").setBrush("greenskin_catapult_bottom");
    this.addSprite("body").varySaturation(0.10000000149011612);
    this.addSprite("top").setBrush("greenskin_catapult_top");
    this.setSpriteOcclusion("top", 1, 2, -3);
    this.addDefaultStatusSprites();
    this.m.Skills.update();
    return;
}

function setFlipped(this, _f)
{
    this.getSprite("body").setHorizontalFlipping(_f);
    return;
}
