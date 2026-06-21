// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_puncture.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Puncture;
    this.m.Order = this.Const.AI.Behavior.Order.Puncture;
    this.behavior.create();
    return;
}

function getBestTarget(this, _entity, _skill, _targets)
{
    foreach (local key, value in r96)
    {
        if (!_skill.isUsableOn(null.getTile()))
        {
        }
        else
        {
            if ((25 <= 15) && (25 <= 15))
            {
                return ((25 <= 15) && (25 <= 15));
            }
            if (((_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0) > 100.0) && ((_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0) > 100.0))
            {
                return (((_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0) > 100.0) && ((_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0) > 100.0));
            }
            if ((this.queryTargetValue(_entity, null, _skill) * this.Math.pow((((null.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0) + (null.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) / 100.0), 1.100000023841858)) > 0.0))
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
            this.logInfo((((("* " + _entity.getName()) + ": Using Puncture against ") + this.m.TargetTile.getEntity().getName()) + "!"));
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
