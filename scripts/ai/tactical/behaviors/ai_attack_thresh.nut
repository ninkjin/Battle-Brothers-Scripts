// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_thresh.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Thresh;
    this.m.Order = this.Const.AI.Behavior.Order.Thresh;
    this.behavior.create();
    return;
}

function getBestTarget(this, _entity, _skill)
{
    if (0 != 6)
    {
        if (!_entity.getTile().hasNextTile(0))
        {
        }
        else
        {
            if (!_entity.getTile().getNextTile(0).IsOccupiedByActor)
            {
            }
            else
            {
                if (this.Math.abs((_entity.getTile().getNextTile(0).Level - _entity.getTile().Level) > 1))
                {
                }
                else
                {
                    if (_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity))
                    {
                    }
                    else
                    {
                        if (this && this)
                        {
                            return (this && this);
                        }
                    }
                }
            }
        }
    }
    if (((0 + 7) >= 2) || ((0 + 7) >= 2))
    {
        return (((0 + 7) >= 2) || ((0 + 7) >= 2));
        return _entity;
    }
    return _entity;
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
    if (this.getBestTarget(_entity, this.m.Skill).Target == null)
    {
        return _entity;
    }
    this.m.TargetTile = this.getBestTarget(_entity, this.m.Skill).Target;
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
    if (this.m.TargetTile != null)
    {
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((("* " + _entity.getName()) + ": Using Round Swing / Thresh!"));
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
