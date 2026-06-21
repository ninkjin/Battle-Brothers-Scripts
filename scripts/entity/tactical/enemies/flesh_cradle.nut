// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/flesh_cradle.nut
// Functions: 5

function create(this)
{
    this.m.IsActingEachTurn = false;
    this.m.IsNonCombatant = true;
    this.m.IsShakingOnHit = false;
    this.m.Type = this.Const.EntityType.FleshCradle;
    this.m.BloodType = this.Const.BloodType.None;
    this.m.MoraleState = this.Const.MoraleState.Ignore;
    this.m.XP = this.Const.Tactical.Actor.FleshCradle.XP;
    this.m.BloodSplatterOffset = this.createVec(0, 0);
    this.actor.create();
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/donkey_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function getIsDestroyed(this)
{
    return this.m.IsDestroyed;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_tile != null)
    {
        this.spawnTerrainDropdownEffect(_tile);
    }
    this.dropLoot(_tile, this.getLootForTile(_killer, []), (!this.m.Flip));
    this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.actor.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.FleshCradle);
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
    this.m.BaseProperties.TargetAttractionMult = 0.0;
    this.m.IsAttackable = false;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.m.Flip = (this.Math.rand(0, 1) == 1);
    this.addSprite("bottom").setBrush("flesh_cradle_01_bottom");
    this.addSprite("bottom").setHorizontalFlipping(this.m.Flip);
    this.addSprite("top").setBrush("flesh_cradle_01_top");
    this.addSprite("top").setHorizontalFlipping(this.m.Flip);
    this.addDefaultStatusSprites();
    this.m.Skills.update();
    return;
}

function setDestroyed(this, _destroyed)
{
    this.m.IsDestroyed = _destroyed;
    this.kill();
    return;
}
