// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_disengage.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Disengage;
    this.m.Order = this.Const.AI.Behavior.Order.Disengage;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.Target = null;
    this.m.Skill = null;
    this.m.JustMove = false;
    this.m.IsMoving = false;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions() == 0))
    {
        return _entity;
    }
    if (_entity.isArmedWithMeleeWeapon() && _entity.isArmedWithMeleeWeapon())
    {
        return (_entity.isArmedWithMeleeWeapon() && _entity.isArmedWithMeleeWeapon());
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (!this.isRangedUnit(_entity))
    {
        foreach (local key, value in this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1))
        {
            if (this.isRangedUnit(null))
            {
            }
            foreach (local key, value in r22)
            {
                if ((null <= 1) && (null <= 1))
                {
                    return ((null <= 1) && (null <= 1));
                }
                this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
                this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
                this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
                this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
                this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
                this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = false;
                this.Tactical.getNavigator().createSettings().ZoneOfControlCost = 0;
                this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
                this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
                if (0 < 6)
                {
                    if (!_entity.getTile().hasNextTile(0))
                    {
                    }
                    else
                    {
                        if (_entity.getTile().getNextTile(0).IsOccupiedByActor)
                        {
                            if ((!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity) && (!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity))))
                            {
                                return ((!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity)) && (!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity)));
                                if (_entity.getTile().getNextTile(0).getEntity().getSkills().getAttackOfOpportunity() != null)
                                {
                                }
                            }
                        }
                        if (!_entity.getTile().getNextTile(0).IsEmpty)
                        {
                        }
                        else
                        {
                            if (!this.m.Skill.isUsableOn(_entity.getTile().getNextTile(0)))
                            {
                            }
                            else
                            {
                                if (_entity.getTile().getNextTile(0).getZoneOfControlCountOtherThan(_entity.getAlliedFactions() > _entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions())))
                                {
                                }
                                else
                                {
                                    if (this.isRangedUnit(_entity))
                                    {
                                        if (false && false)
                                        {
                                            return (false && false);
                                        }
                                    }
                                    else
                                    {
                                        if ((!true) && (!true))
                                        {
                                            return ((!true) && (!true));
                                        }
                                        if ((this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1).Score >= this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score) && (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1)).Score >= this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score) && (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1)).Score >= this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score)))
                                        {
                                            return ((this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1)).Score >= this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score) && (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1)).Score >= this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score) && (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1)).Score >= this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score));
                                        }
                                        if ((_entity.getTile().getNextTile(0).getZoneOfControlCountOtherThan(_entity.getAlliedFactions() <= _entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions())) && (_entity.getTile().getNextTile(0).getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) <= _entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()))))
                                        {
                                            return ((_entity.getTile().getNextTile(0).getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) <= _entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions())) && (_entity.getTile().getNextTile(0).getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) <= _entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions())));
                                        }
                                        if ((_entity.getActionPoints() >= (this.m.Skill.getActionPointCost() + 2) && (_entity.getActionPoints() >= (this.m.Skill.getActionPointCost() + 2))))
                                        {
                                            return ((_entity.getActionPoints() >= (this.m.Skill.getActionPointCost() + 2)) && (_entity.getActionPoints() >= (this.m.Skill.getActionPointCost() + 2)));
                                            foreach (local key, value in r116)
                                            {
                                                if ((null.Actor.getTile().getDistanceTo(_entity.getTile().getNextTile(0) >= 4) && (null.Actor.getTile().getDistanceTo(_entity.getTile().getNextTile(0)) >= 4)))
                                                {
                                                    return ((null.Actor.getTile().getDistanceTo(_entity.getTile().getNextTile(0)) >= 4) && (null.Actor.getTile().getDistanceTo(_entity.getTile().getNextTile(0)) >= 4));
                                                }
                                                if (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions() > 2))
                                                {
                                                }
                                                if (!(this.queryTargetValue(_entity, null.Actor, null) >= (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1).Score * this.Const.AI.Behavior.DisengageMinBetterTargetPct))))
                                                {
                                                }
                                                if (this.Tactical.getNavigator().findPath(_entity.getTile().getNextTile(0), null.Actor.getTile(), this.Tactical.getNavigator().createSettings(), 1))
                                                {
                                                    if (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), (_entity.getActionPoints() - this.m.Skill.getActionPointCost(), ((_entity.getFatigueMax() - _entity.getFatigue()) - this.m.Skill.getFatigueCost())).IsComplete))
                                                    {
                                                    }
                                                    if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), (_entity.getActionPoints() - this.m.Skill.getActionPointCost(), ((_entity.getFatigueMax() - _entity.getFatigue()) - this.m.Skill.getFatigueCost())).End.getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) > _entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions())))
                                                    {
                                                    }
                                                }
                                                if ((this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1).Score >= this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score) && (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1)).Score >= this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score)))
                                                {
                                                    return ((this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1)).Score >= this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score) && (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1)).Score >= this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score));
                                                }
                                                if ((((((((1.0 * this.Const.AI.Behavior.DisengageWithRangedWeaponMult) * (this.Const.AI.Behavior.DisengageWrongRangeMult * (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions() - _entity.getTile().getNextTile(0).getZoneOfControlCountOtherThan(_entity.getAlliedFactions())))) * (this.Math.pow(this.Const.AI.Behavior.DisengageLessOpponentsMult, (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) - _entity.getTile().getNextTile(0).getZoneOfControlCountOtherThan(_entity.getAlliedFactions()))) + (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score * this.Const.AI.Behavior.DisengageTargetMult))) * (1.0 + (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score * this.Const.AI.Behavior.DisengageBetterTargetMult))) * ((this.Const.AI.Behavior.DisengageBetterTargetMult - (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), (_entity.getActionPoints() - this.m.Skill.getActionPointCost()), ((_entity.getFatigueMax() - _entity.getFatigue()) - this.m.Skill.getFatigueCost())).Tiles * 0.10000000149011612)) + (this.queryTargetValue(_entity, null.Actor, null) * this.Const.AI.Behavior.DisengageTargetMult))) * (this.Const.AI.Behavior.DisengageBetterTileMult + (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score * this.Const.AI.Behavior.DisengageTargetMult))) > -9000.0) && (((((((1.0 * this.Const.AI.Behavior.DisengageWithRangedWeaponMult) * (this.Const.AI.Behavior.DisengageWrongRangeMult * (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) - _entity.getTile().getNextTile(0).getZoneOfControlCountOtherThan(_entity.getAlliedFactions())))) * (this.Math.pow(this.Const.AI.Behavior.DisengageLessOpponentsMult, (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) - _entity.getTile().getNextTile(0).getZoneOfControlCountOtherThan(_entity.getAlliedFactions()))) + (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score * this.Const.AI.Behavior.DisengageTargetMult))) * (1.0 + (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score * this.Const.AI.Behavior.DisengageBetterTargetMult))) * ((this.Const.AI.Behavior.DisengageBetterTargetMult - (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), (_entity.getActionPoints() - this.m.Skill.getActionPointCost()), ((_entity.getFatigueMax() - _entity.getFatigue()) - this.m.Skill.getFatigueCost())).Tiles * 0.10000000149011612)) + (this.queryTargetValue(_entity, null.Actor, null) * this.Const.AI.Behavior.DisengageTargetMult))) * (this.Const.AI.Behavior.DisengageBetterTileMult + (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score * this.Const.AI.Behavior.DisengageTargetMult))) > -9000.0)))
                                                {
                                                    return ((((((((1.0 * this.Const.AI.Behavior.DisengageWithRangedWeaponMult) * (this.Const.AI.Behavior.DisengageWrongRangeMult * (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) - _entity.getTile().getNextTile(0).getZoneOfControlCountOtherThan(_entity.getAlliedFactions())))) * (this.Math.pow(this.Const.AI.Behavior.DisengageLessOpponentsMult, (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) - _entity.getTile().getNextTile(0).getZoneOfControlCountOtherThan(_entity.getAlliedFactions()))) + (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score * this.Const.AI.Behavior.DisengageTargetMult))) * (1.0 + (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score * this.Const.AI.Behavior.DisengageBetterTargetMult))) * ((this.Const.AI.Behavior.DisengageBetterTargetMult - (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), (_entity.getActionPoints() - this.m.Skill.getActionPointCost()), ((_entity.getFatigueMax() - _entity.getFatigue()) - this.m.Skill.getFatigueCost())).Tiles * 0.10000000149011612)) + (this.queryTargetValue(_entity, null.Actor, null) * this.Const.AI.Behavior.DisengageTargetMult))) * (this.Const.AI.Behavior.DisengageBetterTileMult + (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score * this.Const.AI.Behavior.DisengageTargetMult))) > -9000.0) && (((((((1.0 * this.Const.AI.Behavior.DisengageWithRangedWeaponMult) * (this.Const.AI.Behavior.DisengageWrongRangeMult * (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) - _entity.getTile().getNextTile(0).getZoneOfControlCountOtherThan(_entity.getAlliedFactions())))) * (this.Math.pow(this.Const.AI.Behavior.DisengageLessOpponentsMult, (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) - _entity.getTile().getNextTile(0).getZoneOfControlCountOtherThan(_entity.getAlliedFactions()))) + (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score * this.Const.AI.Behavior.DisengageTargetMult))) * (1.0 + (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score * this.Const.AI.Behavior.DisengageBetterTargetMult))) * ((this.Const.AI.Behavior.DisengageBetterTargetMult - (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), (_entity.getActionPoints() - this.m.Skill.getActionPointCost()), ((_entity.getFatigueMax() - _entity.getFatigue()) - this.m.Skill.getFatigueCost())).Tiles * 0.10000000149011612)) + (this.queryTargetValue(_entity, null.Actor, null) * this.Const.AI.Behavior.DisengageTargetMult))) * (this.Const.AI.Behavior.DisengageBetterTileMult + (this.queryBestMeleeTarget(_entity, null, this.queryTargetsInMeleeRange(1, _entity.getIdealRange(), 1, _entity.getTile().getNextTile(0))).Score * this.Const.AI.Behavior.DisengageTargetMult))) > -9000.0));
                                                }
                                                if (_entity.getTile().getNextTile(0) == null)
                                                {
                                                    return _entity;
                                                }
                                                if ((0 + _entity.getTile().getNextTile(0).getEntity().getSkills().getAttackOfOpportunity().getHitchance(_entity) <= 15))
                                                {
                                                    this.m.JustMove = true;
                                                }
                                                this.m.TargetTile = _entity.getTile().getNextTile(0);
                                                this.m.Target = null.Actor;
                                                return _entity;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((("* " + _entity.getName()) + ": Disengaging!"));
        }
        this.getAgent().adjustCameraToTarget(this.m.TargetTile);
        this.m.IsFirstExecuted = false;
        return _entity;
    }
    if (this.m.IsMoving)
    {
        if (!this.Tactical.getNavigator().travel(_entity, _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())))
        {
            this.m.Target = null;
            this.m.TargetTile = null;
            this.m.Skill = null;
            return _entity;
        }
    }
    if (this.m.JustMove)
    {
        this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
        this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
        this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
        this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
        this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
        this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = true;
        this.Tactical.getNavigator().createSettings().ZoneOfControlCost = 0;
        this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
        this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
        this.Tactical.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.Tactical.getNavigator().createSettings(), 0);
        if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).Tiles == 0))
        {
            this.m.JustMove = false;
            this.m.IsMoving = false;
            return _entity;
        }
        this.m.IsMoving = true;
        this.m.JustMove = false;
        return _entity;
    }
    this.m.Skill.use(this.m.TargetTile);
    if (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer)
    {
        return (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer);
        this.getAgent().declareEvaluationDelay(1000);
        this.getAgent().declareAction();
    }
    if ((null == null) && (null == null))
    {
        return ((null == null) && (null == null));
        this.getAgent().setForcedOpponent(this.m.Target);
    }
    this.m.Target = null;
    this.m.TargetTile = null;
    this.m.Skill = null;
    return _entity;
    return _entity;
}
