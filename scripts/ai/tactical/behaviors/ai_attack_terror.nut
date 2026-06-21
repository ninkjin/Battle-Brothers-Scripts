// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_terror.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Terror;
    this.m.Order = this.Const.AI.Behavior.Order.Terror;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function getBestTarget(this, _entity, _skill, _targets)
{
    this.m.TargetTile = null;
    this.m.TargetScore = 0.0;
    foreach (local key, value in r205)
    {
        if ((this.Const.MoraleState.Fleeing == this.Const.MoraleState.Ignore) && (this.Const.MoraleState.Fleeing == this.Const.MoraleState.Ignore))
        {
            return ((this.Const.MoraleState.Fleeing == this.Const.MoraleState.Ignore) && (this.Const.MoraleState.Fleeing == this.Const.MoraleState.Ignore));
        }
        if (this.isAllottedTimeReached(this.Time.getExactTime()))
        {
            yield this;
        }
        if (null.getCurrentProperties().IsStunned)
        {
        }
        if (_skill.onVerifyTarget(_entity.getTile(), null.getTile()))
        {
            if (null.getSkills().hasSkill("effects.spearwall"))
            {
            }
            if (null.getSkills().hasSkill("effects.shieldwall"))
            {
            }
            if (null.getSkills().hasSkill("effects.riposte"))
            {
            }
            if (null.getTile().getDistanceTo(_entity.getTile() == 1))
            {
            }
            if (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions() > 0))
            {
            }
            if ((null.getTile().getDistanceTo(_entity.getTile() <= _entity.getTile()) && (null.getTile().getDistanceTo(_entity.getTile()) <= _entity.getTile())))
            {
                return ((null.getTile().getDistanceTo(_entity.getTile()) <= _entity.getTile()) && (null.getTile().getDistanceTo(_entity.getTile()) <= _entity.getTile()));
            }
            else
            {
                if (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions() == 0))
                {
                    if (this.queryActorTurnsNearTarget(null, _entity.getTile(), null).Turns <= 1.0)
                    {
                    }
                }
            }
            if (((((((((((this.Math.max(1, (120 - null.getBravery()) * (null.getHitpoints() / (null.getHitpointsMax() * 1.0))) * (null.getMoraleState() / (this.Const.MoraleState.Confident * 1.0))) * (1.0 / null.getCurrentProperties().MoraleCheckBraveryMult["this.Const.MoraleCheckType.MentalAttack"])) * this.Const.AI.Behavior.TerrorSpearwallMult) * this.Const.AI.Behavior.TerrorShieldwallMult) * this.Const.AI.Behavior.TerrorRiposteMult) * this.Const.AI.Behavior.TerrorMeleeBonus) * (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) * this.Const.AI.Behavior.TerrorZoCMult)) * this.Const.AI.Behavior.TerrorInMeleeWithMe) * this.Const.AI.Behavior.TerrorCanReachMe) > 0.0))
            {
            }
        }
        this.m.TargetScore = (((((((((((this.Math.max(1, (120 - null.getBravery())) * (null.getHitpoints() / (null.getHitpointsMax() * 1.0))) * (null.getMoraleState() / (this.Const.MoraleState.Confident * 1.0))) * (1.0 / null.getCurrentProperties().MoraleCheckBraveryMult["this.Const.MoraleCheckType.MentalAttack"])) * this.Const.AI.Behavior.TerrorSpearwallMult) * this.Const.AI.Behavior.TerrorShieldwallMult) * this.Const.AI.Behavior.TerrorRiposteMult) * this.Const.AI.Behavior.TerrorMeleeBonus) * (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) * this.Const.AI.Behavior.TerrorZoCMult)) * this.Const.AI.Behavior.TerrorInMeleeWithMe) * this.Const.AI.Behavior.TerrorCanReachMe) * 0.05000000074505806);
        if (null != null)
        {
            this.m.TargetTile = null.getTile();
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
    foreach (local key, value in r35)
    {
        if (null.Actor.isNull())
        {
        }
        else
        {
            if ((_entity.getTile().getDistanceTo(null.Actor.getTile() < this.m.Skill) && (_entity.getTile().getDistanceTo(null.Actor.getTile()) < this.m.Skill)))
            {
                return ((_entity.getTile().getDistanceTo(null.Actor.getTile()) < this.m.Skill) && (_entity.getTile().getDistanceTo(null.Actor.getTile()) < this.m.Skill));
            }
            [].push(null.Actor);
            if ([].len() == 0)
            {
                return _entity;
            }
            if (resume this == null)
            {
                yield null;
            }
            if (this.m.TargetTile == null)
            {
                return _entity;
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
        if ("IsFirstExecuted" && "IsFirstExecuted")
        {
            return ("IsFirstExecuted" && "IsFirstExecuted");
            _entity.setDiscovered(true);
            _entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
        }
        return _entity;
    }
    if (this.m.TargetTile != null)
    {
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((((("* " + _entity.getName()) + ": Using Horrific Scream against ") + this.m.TargetTile.getEntity().getName()) + "!"));
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
