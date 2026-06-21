// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_spike.nut
// Functions: 5

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Spike;
    this.m.Order = this.Const.AI.Behavior.Order.Spike;
    this.behavior.create();
    return;
}

function getBestTarget(this, _entity, _skill)
{
    this.Tactical.queryTilesInRange(_entity.getTile(), this.m.Skill.getMinRange(), this.m.Skill.getMaxRange(), false, [], this.onQueryTile, []);
    foreach (local key, value in r164)
    {
        if (!_skill.onVerifyTarget(_entity.getTile(), null))
        {
        }
        else
        {
            if (!null.IsOccupiedByActor)
            {
            }
            if (this.Math.abs((null.Level - _entity.getTile().Level) <= this.m.Skill.getMaxLevelDifference()))
            {
                if (null.getEntity().isAlliedWith(_entity))
                {
                }
            }
            if (0 < (this.m.Length - 1))
            {
                if (!null.hasNextTile(_entity.getTile().getDirectionTo(null)))
                {
                }
                if (null.getNextTile(_entity.getTile().getDirectionTo(null).IsOccupiedByActor && null.getNextTile(_entity.getTile().getDirectionTo(null)).IsOccupiedByActor))
                {
                    return (null.getNextTile(_entity.getTile().getDirectionTo(null)).IsOccupiedByActor && null.getNextTile(_entity.getTile().getDirectionTo(null)).IsOccupiedByActor);
                    if (null.getNextTile(_entity.getTile().getDirectionTo(null)).getEntity().isAlliedWith(_entity))
                    {
                    }
                }
            }
            if ((((((0.0 - ((3.0 * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * null.getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, null.getEntity(), _skill)) - ((3.0 * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) * null.getNextTile(_entity.getTile().getDirectionTo(null)).getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, null.getNextTile(_entity.getTile().getDirectionTo(null)).getEntity(), _skill)) > 0) && (((((0.0 - ((3.0 * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) * null.getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, null.getEntity(), _skill)) - ((3.0 * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) * null.getNextTile(_entity.getTile().getDirectionTo(null)).getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, null.getNextTile(_entity.getTile().getDirectionTo(null)).getEntity(), _skill)) > 0)))
            {
                return ((((((0.0 - ((3.0 * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) * null.getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, null.getEntity(), _skill)) - ((3.0 * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) * null.getNextTile(_entity.getTile().getDirectionTo(null)).getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, null.getNextTile(_entity.getTile().getDirectionTo(null)).getEntity(), _skill)) > 0) && (((((0.0 - ((3.0 * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) * null.getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, null.getEntity(), _skill)) - ((3.0 * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) * null.getNextTile(_entity.getTile().getDirectionTo(null)).getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, null.getNextTile(_entity.getTile().getDirectionTo(null)).getEntity(), _skill)) > 0));
            }
            if (((0 + 7) + 7) < this.m.MinTargets)
            {
                return _entity;
            }
            return _entity;
        }
    }
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
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
    this.m.TargetScore = this.getBestTarget(_entity, this.m.Skill).Score;
    return _entity;
}

function onExecute(this, _entity)
{
    this.m.Skill.use(this.m.TargetTile);
    if (_entity.isAlive())
    {
        this.getAgent().declareAction();
        if (this.m.Skill.getDelay() != 0)
        {
            this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
        }
    }
    this.m.Skill = null;
    this.m.TargetTile = null;
    return _entity;
}

function onQueryTile(this, _tile, _tag)
{
    _tag.push(_tile);
    return;
}
