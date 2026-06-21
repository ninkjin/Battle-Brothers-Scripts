// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_recover.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Recover;
    this.m.Order = this.Const.AI.Behavior.Order.Recover;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (((_entity.getFatigueMax() / 2) <= (2.FatigueRecoveryRate + 5) && ((_entity.getFatigueMax() / 2) <= (2.FatigueRecoveryRate + 5))))
    {
        return (((_entity.getFatigueMax() / 2) <= (2.FatigueRecoveryRate + 5)) && ((_entity.getFatigueMax() / 2) <= (2.FatigueRecoveryRate + 5)));
        return _entity;
    }
    if ((null == (this.Time - 1) && (null == (this.Time - 1))))
    {
        return ((null == (this.Time - 1)) && (null == (this.Time - 1)));
        return _entity;
    }
    if (r8 && r8)
    {
        return (r8 && r8);
        return _entity;
    }
    if (_entity.getAttackedCount() > 1)
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    return _entity;
}

function onExecute(this, _entity)
{
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Using Recover!"));
    }
    this.m.Skill.use(_entity.getTile());
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
    }
    this.m.Skill = null;
    return _entity;
}
