// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_default.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.AttackDefault;
    this.m.Order = this.Const.AI.Behavior.Order.AttackDefault;
    this.behavior.create();
    return;
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
    if (this.m.Skill.isRanged())
    {
    }
    if (this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), (this.m.Skill.getMaxRange() + 0), this.m.Skill.getMaxLevelDifference().len() == 0))
    {
        return _entity;
    }
    if (this.m.Skill.isRanged())
    {
    }
    if (this.queryBestMeleeTarget(_entity, this.m.Skill, this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), (this.m.Skill.getMaxRange() + 0), this.m.Skill.getMaxLevelDifference()).Target == null))
    {
        return _entity;
    }
    if (this.getAgent().getIntentions().IsChangingWeapons)
    {
    }
    this.m.TargetTile = this.queryBestMeleeTarget(_entity, this.m.Skill, this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), (this.m.Skill.getMaxRange() + 0), this.m.Skill.getMaxLevelDifference())).Target.getTile();
    return this.Math.max(0, ((this.Const.AI.Behavior.Score.Attack * this.queryBestMeleeTarget(_entity, this.m.Skill, this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), (this.m.Skill.getMaxRange() + 0), this.m.Skill.getMaxLevelDifference())).Score) * ((this.getProperties().BehaviorMult["this.m.ID"] * this.getFatigueScoreMult(this.m.Skill)) * this.Const.AI.Behavior.AttackAfterSwitchWeaponMult)));
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
            this.logInfo((((((("* " + _entity.getName()) + ": Using ") + this.m.Skill.getName()) + " against ") + this.m.TargetTile.getEntity().getName()) + "!"));
        }
        this.m.Skill.use(this.m.TargetTile);
        if (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer)
        {
            return (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer);
            this.getAgent().declareAction();
            if (this.m.Skill && this.m.Skill)
            {
                return (this.m.Skill && this.m.Skill);
                this.getAgent().declareEvaluationDelay(750);
            }
            else
            {
                if (this.m.Skill.getDelay() != 0)
                {
                    this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
                }
            }
        }
        this.m.TargetTile = null;
    }
    return _entity;
}
