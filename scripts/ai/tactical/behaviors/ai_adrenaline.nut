// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_adrenaline.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Adrenaline;
    this.m.Order = this.Const.AI.Behavior.Order.Adrenaline;
    this.behavior.create();
    return;
}

function getUsedLast(this)
{
    return this.m.UsedAdrenalineLast;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    this.m.IsWaiting = false;
    if (_entity.getCurrentProperties().IsStunned)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (_entity.getActionPoints() == _entity.getActionPointsMax())
    {
        return _entity;
    }
    if (_entity.getSkills().getAttackOfOpportunity() != null)
    {
    }
    if (_entity.getActionPoints() >= 4)
    {
        return _entity;
    }
    if (!this.getAgent().hasKnownOpponent())
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (((_entity.getFatigueMax() - (_entity.getFatigue() + this.m.Skill.getFatigueCost()) + _entity.getCurrentProperties().FatigueRecoveryRate) < 30))
    {
        return _entity;
    }
    if (37 && 37)
    {
        return (37 && 37);
        return _entity;
    }
    foreach (local key, value in 4)
    {
        if ((0 + null.getDamage() >= _entity.getHitpoints()))
        {
            return _entity;
        }
        if ((!this.getProperties().EngageRangeMax) && (!this.getProperties().EngageRangeMax))
        {
            return ((!this.getProperties().EngageRangeMax) && (!this.getProperties().EngageRangeMax));
        }
        if (this.queryTargetsInMeleeRange(this.Math.min(this.getProperties().EngageRangeMin, _entity.getCurrentProperties().Vision), this.Math.max(_entity.getIdealRange(), (this.Math.min(this.getProperties().EngageRangeMax, _entity.getCurrentProperties().Vision) + 0)).len() == 0))
        {
            return _entity;
        }
        foreach (local key, value in r109)
        {
            if (null.isNonCombatant())
            {
            }
            else
            {
                if ((!null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions()) && (!null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions())) && (!null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions()))))
                {
                    return ((!null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions())) && (!null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions())) && (!null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions())));
                }
                if (4 <= 4)
                {
                }
                if (null.getTile().getDistanceTo(_entity.getTile() <= (_entity.getIdealRange() + 1)))
                {
                }
                if ((null.getCurrentProperties().IsStunned == this.Const.MoraleState.Fleeing) && (null.getCurrentProperties().IsStunned == this.Const.MoraleState.Fleeing) && (null.getCurrentProperties().IsStunned == this.Const.MoraleState.Fleeing))
                {
                    return ((null.getCurrentProperties().IsStunned == this.Const.MoraleState.Fleeing) && (null.getCurrentProperties().IsStunned == this.Const.MoraleState.Fleeing) && (null.getCurrentProperties().IsStunned == this.Const.MoraleState.Fleeing));
                }
                if ((this.Time <= 2) && (this.Time <= 2))
                {
                    return ((this.Time <= 2) && (this.Time <= 2));
                }
                if (_entity.getTurnOrderInitiative() <= (null.getTurnOrderInitiative() + (null.getCurrentProperties().FatigueToInitiativeRate * -10)))
                {
                    if ((!null.IsStunned) && (!null.IsStunned))
                    {
                        return ((!null.IsStunned) && (!null.IsStunned));
                    }
                }
                if (((0 + 14) >= (0 + 13) || ((0 + 14) >= (0 + 13)) || ((0 + 14) >= (0 + 13))))
                {
                    return (((0 + 14) >= (0 + 13)) || ((0 + 14) >= (0 + 13)) || ((0 + 14) >= (0 + 13)));
                    return _entity;
                }
                if ((!2) && (!2))
                {
                    return ((!2) && (!2));
                }
                if (this.getStrategy().getStats().IsBeingKited)
                {
                }
                if (_entity.getFatiguePct() < 0.4000000059604645)
                {
                }
                if (_entity.getTile().IsBadTerrain && _entity.getTile().IsBadTerrain)
                {
                    return (_entity.getTile().IsBadTerrain && _entity.getTile().IsBadTerrain);
                }
                if (_entity.getAttackedCount() > 3)
                {
                }
                if ((((((((((this.getProperties().BehaviorMult["this.m.ID"] * this.getFatigueScoreMult(this.m.Skill) + (0.0 + this.queryTargetValue(_entity, null))) * this.Const.AI.Behavior.AdrenalineFirstRoundMult) * this.Const.AI.Behavior.AdrenalineBeingKitedMult) * (1.0 + (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) * this.Const.AI.Behavior.AdrenalineSurrounded))) * ((1.0 + 1.0) - _entity.getHitpointsPct())) * (1.0 + (this.Const.AI.Behavior.AdrenalineFresh - _entity.getFatiguePct()))) * this.Const.AI.Behavior.AdrenalineOnBadTerrainMult) * (_entity.getAttackedCount() / 3.0)) < this.Const.AI.Behavior.AdrenalineScoreCutoff))
                {
                    return _entity;
                }
                if (this.Tactical.TurnSequenceBar && this.Tactical.TurnSequenceBar)
                {
                    return (this.Tactical.TurnSequenceBar && this.Tactical.TurnSequenceBar);
                    this.m.IsWaiting = true;
                }
                return _entity;
            }
        }
    }
}

function onExecute(this, _entity)
{
    if (this.m.IsWaiting)
    {
        if (this.Tactical.TurnSequenceBar.entityWaitTurn(_entity))
        {
            if (this.Const.AI.VerboseMode)
            {
                this.logInfo((("* " + _entity.getName()) + ": Waiting until using Adrenaline!"));
            }
            return _entity;
        }
        this.m.IsWaiting = false;
    }
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Using Adrenaline!"));
    }
    this.m.Skill.use(_entity.getTile());
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
    }
    this.m.Skill = null;
    this.m.UsedAdrenalineLast = this.Time.getRound();
    return _entity;
}
