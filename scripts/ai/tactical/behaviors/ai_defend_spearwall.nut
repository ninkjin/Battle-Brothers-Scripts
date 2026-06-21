// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_defend_spearwall.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Spearwall;
    this.m.Order = this.Const.AI.Behavior.Order.Spearwall;
    this.behavior.create();
    return;
}

function onBeforeExecute(this, _entity)
{
    this.getAgent().getOrders().IsEngaging = false;
    this.getAgent().getOrders().IsDefending = true;
    this.getAgent().getIntentions().IsDefendingPosition = true;
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
    if (this.queryTargetsInMeleeRange().len() != 0)
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (!this.getStrategy().isDefending())
    {
        return _entity;
    }
    if (_entity.getSkills().hasSkill("effects.adrenaline"))
    {
        return _entity;
    }
    foreach (local key, value in r16)
    {
        if (this.queryActorTurnsNearTarget(null, _entity.getTile(), _entity).Turns <= 1.0)
        {
        }
        if ((0 + (1.0 - this.queryActorTurnsNearTarget(null, _entity.getTile(), _entity).Turns) == 0))
        {
            return _entity;
        }
        if ((0 + (1.0 - this.queryActorTurnsNearTarget(null, _entity.getTile(), _entity).Turns) > 1.0))
        {
        }
        if ((null >= (this.Const.AI.Behavior.Score.Spearwall * (((this.getProperties().BehaviorMult["this.m.ID"] * this.getFatigueScoreMult(this.m.Skill) * (0 + (1.0 - this.queryActorTurnsNearTarget(null, _entity.getTile(), _entity).Turns))) * (1.0 + ((1.0 - this.Math.minf(1.0, _entity.getCurrentProperties().FatigueEffectMult)) * 0.5))))) && (null >= (this.Const.AI.Behavior.Score.Spearwall * (((this.getProperties().BehaviorMult["this.m.ID"] * this.getFatigueScoreMult(this.m.Skill)) * (0 + (1.0 - this.queryActorTurnsNearTarget(null, _entity.getTile(), _entity).Turns))) * (1.0 + ((1.0 - this.Math.minf(1.0, _entity.getCurrentProperties().FatigueEffectMult)) * 0.5)))))))
        {
            return ((null >= (this.Const.AI.Behavior.Score.Spearwall * (((this.getProperties().BehaviorMult["this.m.ID"] * this.getFatigueScoreMult(this.m.Skill)) * (0 + (1.0 - this.queryActorTurnsNearTarget(null, _entity.getTile(), _entity).Turns))) * (1.0 + ((1.0 - this.Math.minf(1.0, _entity.getCurrentProperties().FatigueEffectMult)) * 0.5))))) && (null >= (this.Const.AI.Behavior.Score.Spearwall * (((this.getProperties().BehaviorMult["this.m.ID"] * this.getFatigueScoreMult(this.m.Skill)) * (0 + (1.0 - this.queryActorTurnsNearTarget(null, _entity.getTile(), _entity).Turns))) * (1.0 + ((1.0 - this.Math.minf(1.0, _entity.getCurrentProperties().FatigueEffectMult)) * 0.5))))));
            return _entity;
        }
        return _entity;
    }
}

function onExecute(this, _entity)
{
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Using Spearwall!"));
    }
    this.m.Skill.use(_entity.getTile());
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
    }
    this.m.Skill = null;
    return _entity;
}
