// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_swallow_whole.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.SwallowWhole;
    this.m.Order = this.Const.AI.Behavior.Order.SwallowWhole;
    this.behavior.create();
    return;
}

function getBestTarget(this, _entity, _skill, _targets)
{
    foreach (local key, value in r81)
    {
        if (!_skill.onVerifyTarget(_entity.getTile(), null.getTile()))
        {
        }
        if (null.getHitpoints() <= 10)
        {
        }
        if ((((((0.0 + null.getCurrentProperties().getMeleeDefense() + (null.getCurrentProperties().getMeleeSkill() * 0.25)) + (null.getHitpoints() * 0.25)) + (((null.getArmor(this.Const.BodyPart.Body) * (null.getCurrentProperties().HitChance["this.Const.BodyPart.Body"] / 100.0)) + (null.getArmor(this.Const.BodyPart.Head) * (null.getCurrentProperties().HitChance["this.Const.BodyPart.Head"] / 100.0))) * 0.10000000149011612)) * null.getCurrentProperties().TargetAttractionMult) > 0.0))
        {
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
    if (this.getAgent().getKnownOpponents().len() <= 1)
    {
        return _entity;
    }
    foreach (local key, value in r24)
    {
        if (null.Actor.isNull())
        {
        }
        if (null.Actor.getFaction() == this.Const.Faction.Player)
        {
            if ((0 + 4) > 1)
            {
            }
        }
        if ((0 + 4) < 2)
        {
            return _entity;
        }
        if ((0.15000000596046448 > 1) && (0.15000000596046448 > 1))
        {
            return ((0.15000000596046448 > 1) && (0.15000000596046448 > 1));
            return _entity;
        }
        this.m.Skill = this.selectSkill(this.m.PossibleSkills);
        if (this.m.Skill == null)
        {
            return _entity;
        }
        if (this.queryTargetsInMeleeRange().len() == 0)
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
            this.logInfo((((("* " + _entity.getName()) + ": Using Swallow Whole against ") + this.m.TargetTile.getEntity().getName()) + "!"));
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
