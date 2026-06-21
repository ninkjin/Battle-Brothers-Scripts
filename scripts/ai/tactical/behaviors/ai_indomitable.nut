// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_indomitable.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Indomitable;
    this.m.Order = this.Const.AI.Behavior.Order.Indomitable;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    if (_entity.getCurrentProperties().IsStunned)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if ((_entity.getActionPointsMax() - _entity.getActionPoints() < 4))
    {
        return _entity;
    }
    if (!this.getAgent().hasKnownOpponent())
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    foreach (local key, value in null)
    {
        if ((0 + null.getDamage() >= _entity.getHitpoints()))
        {
            return _entity;
        }
        if (this.queryTargetsInMeleeRange(1, 1).len() <= 2)
        {
            return _entity;
        }
        foreach (local key, value in r29)
        {
            if (null.getSkills().hasSkill("actives.puncture"))
            {
            }
            if (null.getSkills().hasSkill && null.getSkills().hasSkill)
            {
                return (null.getSkills().hasSkill && null.getSkills().hasSkill);
            }
            if (_entity.getAttackedCount() > 3)
            {
            }
            if (((((((this.getProperties().BehaviorMult["this.m.ID"] * this.getFatigueScoreMult(this.m.Skill) + 1.0) + 1.0) * (1.0 + (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) * this.Const.AI.Behavior.IndomitableSurrounded))) * ((1.0 + 1.0) - _entity.getHitpointsPct())) * (_entity.getAttackedCount() / 3.0)) < this.Const.AI.Behavior.IndomitableScoreCutoff))
            {
                return _entity;
            }
            return _entity;
        }
    }
}

function onExecute(this, _entity)
{
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Using Indomitable!"));
    }
    this.m.Skill.use(_entity.getTile());
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
    }
    this.m.Skill = null;
    return _entity;
}
