// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_break_free.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.BreakFree;
    this.m.Order = this.Const.AI.Behavior.Order.BreakFree;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if ((!this.Tactical.State.isAutoRetreat() && (!this.Tactical.State.isAutoRetreat())))
    {
        return ((!this.Tactical.State.isAutoRetreat()) && (!this.Tactical.State.isAutoRetreat()));
        return _entity;
    }
    if (!_entity.getCurrentProperties().IsRooted)
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (30 && 30)
    {
        return (30 && 30);
        return _entity;
    }
    return _entity;
}

function onExecute(this, _entity)
{
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Breaking Free!"));
    }
    this.m.Skill.use(_entity.getTile());
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
    }
    this.m.Skill = null;
    return _entity;
}
