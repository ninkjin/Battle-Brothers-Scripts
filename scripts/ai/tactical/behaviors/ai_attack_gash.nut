// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_gash.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Gash;
    this.m.Order = this.Const.AI.Behavior.Order.Gash;
    this.behavior.create();
    return;
}

function getBestTarget(this, _entity, _skill, _targets)
{
    foreach (local key, value in r174)
    {
        if (!_skill.isUsableOn(null.getTile()))
        {
        }
        else
        {
            if ((null.getCurrentProperties().ThresholdToReceiveInjuryMult == 0) || (null.getCurrentProperties().ThresholdToReceiveInjuryMult == 0))
            {
                return ((null.getCurrentProperties().ThresholdToReceiveInjuryMult == 0) || (null.getCurrentProperties().ThresholdToReceiveInjuryMult == 0));
            }
            if (null.getHitpoints() <= (this.m.Skill.getExpectedDamage(null).HitpointDamage + this.m.Skill.getExpectedDamage(null).DirectDamage))
            {
            }
            if (null.getHitpointsPct() <= 0.4000000059604645)
            {
            }
            if ((this.m.Skill.getExpectedDamage(null).HitpointDamage + this.m.Skill.getExpectedDamage(null).DirectDamage) < this.Const.Combat.InjuryMinDamage)
            {
            }
            if (_entity.getCurrentProperties().IsSpecializedInSwords)
            {
            }
            if (((this.m.Skill.getExpectedDamage(null).HitpointDamage + this.m.Skill.getExpectedDamage(null).DirectDamage) / (null.getHitpointsMax() * 1.0) > ((((_entity.getCurrentProperties().ThresholdToInflictInjuryMult * this.Const.Combat.InjuryThresholdMult) * null.getCurrentProperties().ThresholdToReceiveInjuryMult) * 0.6600000262260437) * 0.5)))
            {
                if ((!(((this.m.Skill.getExpectedDamage(null).HitpointDamage + this.m.Skill.getExpectedDamage(null).DirectDamage) / (null.getHitpointsMax() * 1.0) > ((((_entity.getCurrentProperties().ThresholdToInflictInjuryMult * this.Const.Combat.InjuryThresholdMult) * null.getCurrentProperties().ThresholdToReceiveInjuryMult) * 0.6600000262260437) * 0.5))) && (((this.m.Skill.getExpectedDamage(null).HitpointDamage + this.m.Skill.getExpectedDamage(null).DirectDamage) / (null.getHitpointsMax() * 1.0)) > ((((_entity.getCurrentProperties().ThresholdToInflictInjuryMult * this.Const.Combat.InjuryThresholdMult) * null.getCurrentProperties().ThresholdToReceiveInjuryMult) * 0.6600000262260437) * 0.5))))
                {
                    return ((!(((this.m.Skill.getExpectedDamage(null).HitpointDamage + this.m.Skill.getExpectedDamage(null).DirectDamage) / (null.getHitpointsMax() * 1.0)) > ((((_entity.getCurrentProperties().ThresholdToInflictInjuryMult * this.Const.Combat.InjuryThresholdMult) * null.getCurrentProperties().ThresholdToReceiveInjuryMult) * 0.6600000262260437) * 0.5))) && (((this.m.Skill.getExpectedDamage(null).HitpointDamage + this.m.Skill.getExpectedDamage(null).DirectDamage) / (null.getHitpointsMax() * 1.0)) > ((((_entity.getCurrentProperties().ThresholdToInflictInjuryMult * this.Const.Combat.InjuryThresholdMult) * null.getCurrentProperties().ThresholdToReceiveInjuryMult) * 0.6600000262260437) * 0.5)));
                }
            }
            if ((((this.m.Skill.getExpectedDamage(null).HitpointDamage + this.m.Skill.getExpectedDamage(null).DirectDamage) / (null.getHitpointsMax() * 1.0) > ((((_entity.getCurrentProperties().ThresholdToInflictInjuryMult * this.Const.Combat.InjuryThresholdMult) * null.getCurrentProperties().ThresholdToReceiveInjuryMult) * 0.6600000262260437) * (((this.m.Skill.getExpectedDamage(null).HitpointDamage + this.m.Skill.getExpectedDamage(null).DirectDamage) / (null.getHitpointsMax() * 1.0)) > ((((_entity.getCurrentProperties().ThresholdToInflictInjuryMult * this.Const.Combat.InjuryThresholdMult) * null.getCurrentProperties().ThresholdToReceiveInjuryMult) * 0.6600000262260437) * 0.5)))) && (((this.m.Skill.getExpectedDamage(null).HitpointDamage + this.m.Skill.getExpectedDamage(null).DirectDamage) / (null.getHitpointsMax() * 1.0)) > ((((_entity.getCurrentProperties().ThresholdToInflictInjuryMult * this.Const.Combat.InjuryThresholdMult) * null.getCurrentProperties().ThresholdToReceiveInjuryMult) * 0.6600000262260437) * (((this.m.Skill.getExpectedDamage(null).HitpointDamage + this.m.Skill.getExpectedDamage(null).DirectDamage) / (null.getHitpointsMax() * 1.0)) > ((((_entity.getCurrentProperties().ThresholdToInflictInjuryMult * this.Const.Combat.InjuryThresholdMult) * null.getCurrentProperties().ThresholdToReceiveInjuryMult) * 0.6600000262260437) * 0.5))))))
            {
                return ((((this.m.Skill.getExpectedDamage(null).HitpointDamage + this.m.Skill.getExpectedDamage(null).DirectDamage) / (null.getHitpointsMax() * 1.0)) > ((((_entity.getCurrentProperties().ThresholdToInflictInjuryMult * this.Const.Combat.InjuryThresholdMult) * null.getCurrentProperties().ThresholdToReceiveInjuryMult) * 0.6600000262260437) * (((this.m.Skill.getExpectedDamage(null).HitpointDamage + this.m.Skill.getExpectedDamage(null).DirectDamage) / (null.getHitpointsMax() * 1.0)) > ((((_entity.getCurrentProperties().ThresholdToInflictInjuryMult * this.Const.Combat.InjuryThresholdMult) * null.getCurrentProperties().ThresholdToReceiveInjuryMult) * 0.6600000262260437) * 0.5)))) && (((this.m.Skill.getExpectedDamage(null).HitpointDamage + this.m.Skill.getExpectedDamage(null).DirectDamage) / (null.getHitpointsMax() * 1.0)) > ((((_entity.getCurrentProperties().ThresholdToInflictInjuryMult * this.Const.Combat.InjuryThresholdMult) * null.getCurrentProperties().ThresholdToReceiveInjuryMult) * 0.6600000262260437) * (((this.m.Skill.getExpectedDamage(null).HitpointDamage + this.m.Skill.getExpectedDamage(null).DirectDamage) / (null.getHitpointsMax() * 1.0)) > ((((_entity.getCurrentProperties().ThresholdToInflictInjuryMult * this.Const.Combat.InjuryThresholdMult) * null.getCurrentProperties().ThresholdToReceiveInjuryMult) * 0.6600000262260437) * 0.5)))));
            }
            if (null.getSkills().getAllSkillsOfType(this.Const.SkillType.Injury).len() >= this.Const.AI.Behavior.GashMaxInjuries)
            {
            }
            if (null.getSkills().getAllSkillsOfType(this.Const.SkillType.Injury).len() == 0)
            {
            }
            if (((this.queryTargetValue(_entity, null, _skill) * this.Const.AI.Behavior.GashHeavyInjuryInsteadOfNoneMult) * this.Const.AI.Behavior.GashTargetUninjuredMult) > 0.0)
            {
            }
            return _entity;
        }
    }
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.Skill = null;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (!this.getAgent().hasVisibleOpponent())
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (this.queryTargetsInMeleeRange().len() == 0)
    {
        return _entity;
    }
    if (this.getBestTarget(_entity, this.m.Skill, this.queryTargetsInMeleeRange().Target == null))
    {
        return _entity;
    }
    this.m.TargetTile = this.getBestTarget(_entity, this.m.Skill, this.queryTargetsInMeleeRange()).Target.getTile();
    return _entity;
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        this.getAgent().adjustCameraToTarget(this.m.TargetTile);
        this.m.IsFirstExecuted = false;
        return _entity;
    }
    if (this.m.TargetTile.IsOccupiedByActor && this.m.TargetTile.IsOccupiedByActor)
    {
        return (this.m.TargetTile.IsOccupiedByActor && this.m.TargetTile.IsOccupiedByActor);
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((((("* " + _entity.getName()) + ": Using Gash against ") + this.m.TargetTile.getEntity().getName()) + "!"));
        }
        this.m.Skill.use(this.m.TargetTile);
        if (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer)
        {
            return (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer);
            this.getAgent().declareAction();
        }
        this.m.TargetTile = null;
    }
    return _entity;
}
