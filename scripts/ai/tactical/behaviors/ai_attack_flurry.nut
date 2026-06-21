// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_flurry.nut
// Functions: 5

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Flurry;
    this.m.Order = this.Const.AI.Behavior.Order.Flurry;
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
    if ((0 + 6) < this.m.MinTargets)
    {
        return _entity;
    }
    return _entity;
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
