// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_split.nut
// Functions: 5

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Split;
    this.m.Order = this.Const.AI.Behavior.Order.Split;
    this.behavior.create();
    return;
}

function getBestTarget(this, _entity, _skill)
{
    this.Tactical.queryTilesInRange(_entity.getTile(), this.m.Skill.getMinRange(), this.m.Skill.getMaxRange(), false, [], this.onQueryTile, []);
    foreach (local key, value in r158)
    {
        if (!_skill.onVerifyTarget(_entity.getTile(), null))
        {
        }
        if ((this.Math <= this.m.Skill) && (this.Math <= this.m.Skill))
        {
            return ((this.Math <= this.m.Skill) && (this.Math <= this.m.Skill));
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
            this.logInfo((("* " + _entity.getName()) + ": Using Split!"));
        }
        this.m.Skill.use(this.m.TargetTile);
        if (_entity.isAlive())
        {
            this.getAgent().declareAction(this.m.Skill.getDelay());
            this.getAgent().declareEvaluationDelay(1000);
        }
        this.m.TargetTile = null;
    }
    return _entity;
}

function onQueryTile(this, _tile, _tag)
{
    _tag.push(_tile);
    return;
}
