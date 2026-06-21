// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_crush_armor.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.CrushArmor;
    this.m.Order = this.Const.AI.Behavior.Order.CrushArmor;
    this.behavior.create();
    return;
}

function getBestTarget(this, _entity, _skill, _targets)
{
    foreach (local key, value in r86)
    {
        if (_skill.onVerifyTarget(_entity.getTile(), null.getTile()))
        {
            if (null.getArmor(this.Const.BodyPart.Body) <= 40)
            {
            }
            if ((((null.getArmor(this.Const.BodyPart.Body) * _entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) * 0.009999999776482582) + ((null.getArmor(this.Const.BodyPart.Head) * _entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head)) * 0.009999999776482582)) <= _skill.getExpectedDamage(null).ArmorDamage))
            {
            }
            if ((((_skill.getExpectedDamage(null).ArmorDamage / _entity.getCurrentProperties().getArmorDamageAverage() * (null.getHitpoints() / null.getHitpointsMax())) * (_skill.getHitchance(null) * 0.009999999776482582)) > 0.0))
            {
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
    if (this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange(), this.m.Skill.getMaxLevelDifference().len() == 0))
    {
        return _entity;
    }
    if (this.getBestTarget(_entity, this.m.Skill, this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange(), this.m.Skill.getMaxLevelDifference()).Target == null))
    {
        return _entity;
    }
    this.m.TargetTile = this.getBestTarget(_entity, this.m.Skill, this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange(), this.m.Skill.getMaxLevelDifference())).Target.getTile();
    if (this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange(), this.m.Skill.getMaxLevelDifference().len() > 1))
    {
        foreach (local key, value in r19)
        {
            if (this.queryTargetValue(_entity, null, null) >= (this.queryTargetValue(_entity, this.getBestTarget(_entity, this.m.Skill, this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange(), this.m.Skill.getMaxLevelDifference()).Target, null) * this.Const.AI.Behavior.CrushArmorBetterTargetPct)))
            {
            }
            return _entity;
        }
    }
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
            this.logInfo((((("* " + _entity.getName()) + ": Using Crush Armor against ") + this.m.TargetTile.getEntity().getName()) + "!"));
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
