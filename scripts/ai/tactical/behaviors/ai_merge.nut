// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_merge.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Merge;
    this.m.Order = this.Const.AI.Behavior.Order.Merge;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    this.m.IsWaiting = false;
    if (_entity.getCurrentProperties().IsStunned)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (_entity.getSize() >= 3)
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        if (1 && 1)
        {
            return (1 && 1);
            if (0 < 6)
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
                        if ((!_entity.getTile().getNextTile(0).getEntity().getCurrentProperties().IsStunned) && (!_entity.getTile().getNextTile(0).getEntity().getCurrentProperties().IsStunned) && (!_entity.getTile().getNextTile(0).getEntity().getCurrentProperties().IsStunned) && (!_entity.getTile().getNextTile(0).getEntity().getCurrentProperties().IsStunned))
                        {
                            return ((!_entity.getTile().getNextTile(0).getEntity().getCurrentProperties().IsStunned) && (!_entity.getTile().getNextTile(0).getEntity().getCurrentProperties().IsStunned) && (!_entity.getTile().getNextTile(0).getEntity().getCurrentProperties().IsStunned) && (!_entity.getTile().getNextTile(0).getEntity().getCurrentProperties().IsStunned));
                            if (0 < 6)
                            {
                                if (!_entity.getTile().getNextTile(0).hasNextTile(0))
                                {
                                }
                                else
                                {
                                    if (!_entity.getTile().getNextTile(0).getNextTile(0).IsOccupiedByActor)
                                    {
                                    }
                                    else
                                    {
                                        if ((this.Const.EntityType.SandGolem == r14) && (this.Const.EntityType.SandGolem == r14))
                                        {
                                            return ((this.Const.EntityType.SandGolem == r14) && (this.Const.EntityType.SandGolem == r14));
                                        }
                                    }
                                }
                            }
                            if ((0 + 8) >= 2)
                            {
                                this.m.IsWaiting = true;
                                return _entity;
                            }
                        }
                    }
                }
            }
        }
        else
        {
            if ((_entity.getActionPoints() <= 2) && (_entity.getActionPoints() <= 2))
            {
                return ((_entity.getActionPoints() <= 2) && (_entity.getActionPoints() <= 2));
                if (0 < 6)
                {
                    if (!this.myTile.hasNextTile(0))
                    {
                    }
                    else
                    {
                        if ((this.myTile.getNextTile(0).getEntity().getSize() == _entity.getSize() && (this.myTile.getNextTile(0).getEntity().getSize() == _entity.getSize())))
                        {
                            return ((this.myTile.getNextTile(0).getEntity().getSize() == _entity.getSize()) && (this.myTile.getNextTile(0).getEntity().getSize() == _entity.getSize()));
                        }
                    }
                }
                if ((0 + 4) >= 2)
                {
                    this.m.IsWaiting = true;
                    return _entity;
                }
            }
        }
        return _entity;
    }
    return _entity;
}

function onExecute(this, _entity)
{
    if (this.m.IsWaiting)
    {
        if (this.Tactical.TurnSequenceBar.entityWaitTurn(_entity))
        {
            if (this.Const.AI.VerboseMode)
            {
                this.logInfo((("* " + _entity.getName()) + ": Waiting for others to act!"));
            }
            return _entity;
        }
        this.m.IsWaiting = false;
    }
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
