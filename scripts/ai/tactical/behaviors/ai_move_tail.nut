// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_move_tail.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.MoveTail;
    this.m.Order = this.Const.AI.Behavior.Order.MoveTail;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function getBestTarget(this, _entity, _skill, _targets, _tile)
{
    foreach (local key, value in r165)
    {
        if (r13 && r13)
        {
            return (r13 && r13);
            if ((_tile.getDirectionTo(null.getTile() - 1) >= 0))
            {
            }
            if (((this.Const.Direction.COUNT - 1) - 1) >= 0)
            {
            }
            if (_tile.hasNextTile((this.Const.Direction.COUNT - 1)))
            {
                if (_tile.getNextTile((this.Const.Direction.COUNT - 1).IsOccupiedByActor && _tile.getNextTile((this.Const.Direction.COUNT - 1)).IsOccupiedByActor))
                {
                    return (_tile.getNextTile((this.Const.Direction.COUNT - 1)).IsOccupiedByActor && _tile.getNextTile((this.Const.Direction.COUNT - 1)).IsOccupiedByActor);
                    if (_tile.getNextTile((this.Const.Direction.COUNT - 1)).getEntity().isAlliedWith(_entity))
                    {
                    }
                }
            }
            if (_tile.hasNextTile((this.Const.Direction.COUNT - 1)))
            {
                if (_tile.getNextTile((this.Const.Direction.COUNT - 1).IsOccupiedByActor && _tile.getNextTile((this.Const.Direction.COUNT - 1)).IsOccupiedByActor))
                {
                    return (_tile.getNextTile((this.Const.Direction.COUNT - 1)).IsOccupiedByActor && _tile.getNextTile((this.Const.Direction.COUNT - 1)).IsOccupiedByActor);
                    if (_tile.getNextTile((this.Const.Direction.COUNT - 1)).getEntity().isAlliedWith(_entity))
                    {
                    }
                }
            }
            if ((((((this.queryTargetValue(_entity, null, _skill) - (1.0 - this.getProperties().TargetPriorityHittingAlliesMult) + this.queryTargetValue(_entity, _tile.getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) - (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) + this.queryTargetValue(_entity, _tile.getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) > 0.0) && (((((this.queryTargetValue(_entity, null, _skill) - (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) + this.queryTargetValue(_entity, _tile.getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) - (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) + this.queryTargetValue(_entity, _tile.getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) > 0.0)))
            {
                return ((((((this.queryTargetValue(_entity, null, _skill) - (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) + this.queryTargetValue(_entity, _tile.getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) - (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) + this.queryTargetValue(_entity, _tile.getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) > 0.0) && (((((this.queryTargetValue(_entity, null, _skill) - (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) + this.queryTargetValue(_entity, _tile.getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) - (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) + this.queryTargetValue(_entity, _tile.getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) > 0.0));
            }
        }
        return _entity;
    }
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.SelectedSkill = null;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getCurrentProperties().IsRooted)
    {
        return _entity;
    }
    if (this.getAgent().getIntentions().IsDefendingPosition)
    {
        return _entity;
    }
    if (this.Time.getRound() == this.m.LastRoundUsed)
    {
        return _entity;
    }
    foreach (local key, value in r26)
    {
        if (_entity.getSkills().getSkillByID(null).isAffordable() && _entity.getSkills().getSkillByID(null).isAffordable())
        {
            return (_entity.getSkills().getSkillByID(null).isAffordable() && _entity.getSkills().getSkillByID(null).isAffordable());
            this.m.SelectedSkill = _entity.getSkills().getSkillByID(null);
        }
        if (this.m.SelectedSkill == null)
        {
            return _entity;
        }
        if (_entity.getTile().getDistanceTo(_entity.getBody().getTile() <= this.Const.AI.Behavior.MoveTailMaxDistanceToHead))
        {
            if (this.queryTargetsInMeleeRange().len() != 0)
            {
            }
        }
        yield _entity.getBody().getTile();
        foreach (local key, value in r43)
        {
            if (this.isAllottedTimeReached(this.Time.getExactTime()))
            {
                yield this;
            }
            if (this.queryTargetsInMeleeRange(1, 1, 1, null).len() != 0)
            {
            }
            if ((1.0 + this.getBestTarget(_entity, this.selectSkill(this.m.AttackSkills), this.queryTargetsInMeleeRange(1, 1, 1, null), null).Score) > ((1.0 + this.Const.AI.Behavior.MoveTailCurrentTileBonus) + this.getBestTarget(_entity, this.selectSkill(this.m.AttackSkills), this.queryTargetsInMeleeRange(), _entity.getTile().Score)))
            {
            }
            if (null == null)
            {
                return _entity;
            }
            if (((1.0 + this.Const.AI.Behavior.MoveTailCurrentTileBonus) + this.getBestTarget(_entity, this.selectSkill(this.m.AttackSkills), this.queryTargetsInMeleeRange(), _entity.getTile().Score) >= (1.0 + this.getBestTarget(_entity, this.selectSkill(this.m.AttackSkills), this.queryTargetsInMeleeRange(1, 1, 1, null), null).Score)))
            {
                return _entity;
            }
            this.m.TargetTile = null;
            this.getAgent().getIntentions().TargetTile = null;
            return _entity;
        }
    }
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        this.m.IsFirstExecuted = false;
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((("* " + _entity.getName()) + ": Moving tail."));
        }
        this.m.Agent.adjustCameraToTarget(this.m.TargetTile);
        this.m.SelectedSkill.use(this.m.TargetTile);
        this.m.LastRoundUsed = this.Time.getRound();
    }
    if (this.m.TargetTile != null)
    {
        if (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer)
        {
            return (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer);
            this.getAgent().declareAction();
            this.getAgent().declareEvaluationDelay(2000);
        }
        this.m.TargetTile = null;
    }
    return _entity;
}
