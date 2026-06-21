// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_always_use.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.AlwaysUse;
    this.m.Order = this.Const.AI.Behavior.Order.AlwaysUse;
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
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    return _entity;
}

function onExecute(this, _entity)
{
    this.m.Skill.use(_entity.getTile());
    if (_entity.isAlive())
    {
        this.getAgent().declareAction();
        if (this.m.Skill.getDelay() != 0)
        {
            this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
        }
    }
    this.m.Skill = null;
    return _entity;
}
