// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_rally.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Rally;
    this.m.Order = this.Const.AI.Behavior.Order.Rally;
    this.m.IsThreaded = false;
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
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    foreach (local key, value in r67)
    {
        if (null.getID() == _entity.getID())
        {
        }
        else
        {
            if (null.getTile().getDistanceTo(_entity.getTile() > 4))
            {
            }
            else
            {
                if ((this.Const.MoraleState.Ignore >= this.Const.MoraleState.Steady) && (this.Const.MoraleState.Ignore >= this.Const.MoraleState.Steady))
                {
                    return ((this.Const.MoraleState.Ignore >= this.Const.MoraleState.Steady) && (this.Const.MoraleState.Ignore >= this.Const.MoraleState.Steady));
                }
                if (null.getSkills().hasSkill("effects.rallied"))
                {
                }
                if ((0 + 6) == 0)
                {
                    return _entity;
                }
                return _entity;
            }
        }
    }
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        this.getAgent().adjustCameraToTarget(_entity.getTile());
        this.m.IsFirstExecuted = false;
        return _entity;
    }
    this.m.Skill.use(_entity.getTile());
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
        this.getAgent().declareEvaluationDelay(1500);
    }
    this.m.Skill = null;
    this.m.TargetTile = null;
    return _entity;
}
