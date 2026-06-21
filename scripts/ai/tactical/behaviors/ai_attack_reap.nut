// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_reap.nut
// Functions: 5

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Reap;
    this.m.Order = this.Const.AI.Behavior.Order.Reap;
    this.behavior.create();
    return;
}

function getBestTarget(this, _entity, _skill, _targets)
{
    foreach (local key, value in r200)
    {
        if (!_skill.onVerifyTarget(_entity.getTile(), null.getTile()))
        {
        }
        this.Tactical.queryTilesInRange(_entity.getTile(), _entity.getTile().getDistanceTo(null.getTile()), _entity.getTile().getDistanceTo(null.getTile()), false, [], this.onQueryTilesHittable, {});
        if (0 != {}.Tiles.len())
        {
            if ({}.Tiles["0"].ID == null.getTile().ID)
            {
                [].push({}.Tiles["0"]);
                if ((0 - 1) < 0)
                {
                }
                [].push({}.Tiles["((0 - 1) + {}.Tiles.len())"]);
                if ((0 - 2) < 0)
                {
                }
                [].push({}.Tiles["((0 - 2) + {}.Tiles.len())"]);
            }
        }
        foreach (local key, value in r72)
        {
            if (!null.IsVisibleForEntity)
            {
            }
            else
            {
                if ((this.Math > 1) && (this.Math > 1))
                {
                    return ((this.Math > 1) && (this.Math > 1));
                }
                if ((this.Math > 1) && (this.Math > 1))
                {
                    return ((this.Math > 1) && (this.Math > 1));
                    if (null.getEntity().isAlliedWith(_entity))
                    {
                    }
                }
                if ((0 + 1) < this.m.MinTargets)
                {
                }
                if ((((this.queryTargetValue(_entity, null, _skill) - ((1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * null.getEntity().getCurrentProperties().TargetAttractionMult) + this.queryTargetValue(_entity, null.getEntity(), _skill)) > 0) && (((this.queryTargetValue(_entity, null, _skill) - ((1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * null.getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, null.getEntity(), _skill)) > 0)))
                {
                    return ((((this.queryTargetValue(_entity, null, _skill) - ((1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * null.getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, null.getEntity(), _skill)) > 0) && (((this.queryTargetValue(_entity, null, _skill) - ((1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * null.getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, null.getEntity(), _skill)) > 0));
                }
                return _entity;
            }
        }
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
    if (this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange().len() < this.m.MinTargets))
    {
        return _entity;
    }
    if (this.getBestTarget(_entity, this.m.Skill, this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange()).Target == null))
    {
        return _entity;
    }
    this.m.TargetTile = this.getBestTarget(_entity, this.m.Skill, this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange())).Target.getTile();
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
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((((("* " + _entity.getName()) + ": Using Reap against ") + this.m.TargetTile.getEntity().getName()) + "!"));
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

function onQueryTilesHittable(this, _tile, _result)
{
    _result.Tiles.push(_tile);
    return;
}
