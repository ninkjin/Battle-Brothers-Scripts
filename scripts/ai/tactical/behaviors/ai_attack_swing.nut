// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_swing.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Swing;
    this.m.Order = this.Const.AI.Behavior.Order.Swing;
    this.behavior.create();
    return;
}

function getBestTarget(this, _entity, _skill, _targets)
{
    foreach (local key, value in r180)
    {
        if (_skill.onVerifyTarget(_entity.getTile(), null.getTile()))
        {
            if ((_entity.getTile().getDirectionTo(null.getTile() - 1) >= 0))
            {
            }
            if (((this.Const.Direction.COUNT - 1) - 1) >= 0)
            {
            }
            if (_entity.getTile().hasNextTile((this.Const.Direction.COUNT - 1)))
            {
                if (_entity.getTile().getNextTile((this.Const.Direction.COUNT - 1).IsOccupiedByActor && _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).IsOccupiedByActor))
                {
                    return (_entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).IsOccupiedByActor && _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).IsOccupiedByActor);
                    if (_entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity().isAlliedWith(_entity))
                    {
                    }
                }
            }
            if (_entity.getTile().hasNextTile((this.Const.Direction.COUNT - 1)))
            {
                if (_entity.getTile().getNextTile((this.Const.Direction.COUNT - 1).IsOccupiedByActor && _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).IsOccupiedByActor))
                {
                    return (_entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).IsOccupiedByActor && _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).IsOccupiedByActor);
                    if (_entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity().isAlliedWith(_entity))
                    {
                    }
                }
            }
            if (((1.0 + 1.0) + 1.0) < this.m.MinTargets)
            {
            }
            if ((((((this.queryTargetValue(_entity, null, _skill) - ((1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1).getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) - ((1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) > 0.0) && (((((this.queryTargetValue(_entity, null, _skill) - ((1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) - ((1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) > 0.0)))
            {
                return ((((((this.queryTargetValue(_entity, null, _skill) - ((1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) - ((1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) > 0.0) && (((((this.queryTargetValue(_entity, null, _skill) - ((1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) - ((1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, _entity.getTile().getNextTile((this.Const.Direction.COUNT - 1)).getEntity(), _skill)) > 0.0));
            }
        }
        return _entity;
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
    if (this.queryTargetsInMeleeRange().len() < this.m.MinTargets)
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
        if ((!this.m.TargetTile.IsEmpty) && (!this.m.TargetTile.IsEmpty))
        {
            return ((!this.m.TargetTile.IsEmpty) && (!this.m.TargetTile.IsEmpty));
            this.logInfo((((("* " + _entity.getName()) + ": Using Swing against ") + this.m.TargetTile.getEntity().getName()) + "!"));
        }
        this.m.Skill.use(this.m.TargetTile);
        if ((this.m.Skill != 0) && (this.m.Skill != 0))
        {
            return ((this.m.Skill != 0) && (this.m.Skill != 0));
            this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
        }
        if (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer)
        {
            return (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer);
            this.getAgent().declareAction();
        }
        this.m.TargetTile = null;
    }
    return _entity;
}
