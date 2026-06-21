// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_boost_morale.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.BoostMorale;
    this.m.Order = this.Const.AI.Behavior.Order.BoostMorale;
    this.m.IsThreaded = false;
    this.behavior.create();
    return;
}

function findBestTarget(this, _entity, _targets)
{
    foreach (local key, value in r70)
    {
        if (_entity.getTile().getDistanceTo(null.getTile() > this.m.Skill.getMaxRange()))
        {
        }
        if (!this.m.Skill.isUsableOn(null.getTile()))
        {
        }
        if (null.getMoraleState() == this.Const.MoraleState.Fleeing)
        {
            if (null.getTile().hasZoneOfOccupationOtherThan(null.getAlliedFactions()))
            {
            }
        }
        else
        {
            if (null.getTile().hasZoneOfOccupationOtherThan(null.getAlliedFactions()))
            {
            }
        }
        if ((((5.0 + this.Const.AI.Behavior.BoostMoraleFleeingBonus) + this.Const.AI.Behavior.BoostMoraleFleeingEngagedBonus) + this.Const.AI.Behavior.BoostMoraleEngagedBonus) > 0.0)
        {
        }
        return _entity;
    }
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    this.m.TargetTile = null;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (_entity.getTile().hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (this.findBestTarget(_entity, this.getAgent().getKnownAllies().Target == null))
    {
        return _entity;
    }
    this.m.TargetTile = this.findBestTarget(_entity, this.getAgent().getKnownAllies()).Target.getTile();
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
    this.m.Skill.use(this.m.TargetTile);
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
        this.getAgent().declareEvaluationDelay(350);
    }
    this.m.Skill = null;
    this.m.TargetTile = null;
    return _entity;
}
