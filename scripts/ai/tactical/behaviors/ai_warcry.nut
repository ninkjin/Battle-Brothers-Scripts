// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_warcry.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Warcry;
    this.m.Order = this.Const.AI.Behavior.Order.Warcry;
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
    if (!this.getAgent().hasKnownOpponent())
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    foreach (local key, value in r195)
    {
        foreach (local key, value in r190)
        {
            if ((null == r16) && (null == r16))
            {
                return ((null == r16) && (null == r16));
            }
            else
            {
                if (null.getFaction() == _entity.getFaction())
                {
                    if ((this.Const.MoraleState.Ignore == this.Const.MoraleState.Confident) && (this.Const.MoraleState.Ignore == this.Const.MoraleState.Confident))
                    {
                        return ((this.Const.MoraleState.Ignore == this.Const.MoraleState.Confident) && (this.Const.MoraleState.Ignore == this.Const.MoraleState.Confident));
                    }
                    else
                    {
                        if (!null.isAlliedWith(_entity))
                        {
                            if ((this.Const.MoraleState.Ignore == this.Const.MoraleState.Fleeing) && (this.Const.MoraleState.Ignore == this.Const.MoraleState.Fleeing))
                            {
                                return ((this.Const.MoraleState.Ignore == this.Const.MoraleState.Fleeing) && (this.Const.MoraleState.Ignore == this.Const.MoraleState.Fleeing));
                            }
                            if ((1.0 >= 80) && (1.0 >= 80))
                            {
                                return ((1.0 >= 80) && (1.0 >= 80));
                            }
                            if (null.getTile().getDistanceTo(_entity.getTile() == 1))
                            {
                            }
                        }
                        if (((0 + this.Math.max(0, ((this.Const.MoraleState.Confident - null.getMoraleState() - (null.getTile().getDistanceTo(_entity.getTile()) * this.Const.AI.Behavior.WarcryDistanceMult)))) + (this.Math.max(0, (null.getMoraleState() - (null.getTile().getDistanceTo(_entity.getTile()) * this.Const.AI.Behavior.WarcryDistanceMult))) * (1.0 - this.Math.minf(1.0, (null.getBravery() / 100.0))))) > 0))
                        {
                        }
                        if (true)
                        {
                        }
                        return _entity;
                    }
                }
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

function onSortByScore(this, _a, _b)
{
    if (_a.Score > _b.Score)
    {
        return _a;
    }
    else
    {
        if (_a.Score < _b.Score)
        {
            return _a;
        }
    }
    return _a;
}
