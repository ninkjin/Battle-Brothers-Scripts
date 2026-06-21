// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_possess_undead.nut
// Functions: 5

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.PossessUndead;
    this.m.Order = this.Const.AI.Behavior.Order.PossessUndead;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function onBeforeExecute(this, _entity)
{
    if (this.m.IsTravelling)
    {
        this.getAgent().getOrders().IsEngaging = true;
        this.getAgent().getOrders().IsDefending = false;
        this.getAgent().getIntentions().IsDefendingPosition = false;
        this.getAgent().getIntentions().IsEngaging = true;
    }
    return;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    this.m.TargetTile = null;
    this.m.IsTravelling = false;
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
    yield this.m.PossibleSkills;
    foreach (local key, value in r16)
    {
        if (this.queryActorTurnsNearTarget(null, _entity.getTile(), _entity).Turns <= 1.0)
        {
        }
        yield null;
        foreach (local key, value in r172)
        {
            if (!null.getFlags().has("zombie_minion"))
            {
            }
            else
            {
                if (null.getCurrentProperties().IsStunned)
                {
                }
                else
                {
                    if (null.getAlliedFactions().IsRooted && null.getAlliedFactions().IsRooted)
                    {
                        return (null.getAlliedFactions().IsRooted && null.getAlliedFactions().IsRooted);
                    }
                    if (!null.isArmedWithMeleeWeapon())
                    {
                    }
                    if ((_entity.getTile().getDistanceTo(null.getTile() <= 2) && (_entity.getTile().getDistanceTo(null.getTile()) <= 2)))
                    {
                        return ((_entity.getTile().getDistanceTo(null.getTile()) <= 2) && (_entity.getTile().getDistanceTo(null.getTile()) <= 2));
                    }
                    else
                    {
                        if ((_entity.getTile().getDistanceTo(null.getTile() <= 2).IsRooted && (_entity.getTile().getDistanceTo(null.getTile()) <= 2).IsRooted))
                        {
                            return ((_entity.getTile().getDistanceTo(null.getTile()) <= 2).IsRooted && (_entity.getTile().getDistanceTo(null.getTile()) <= 2).IsRooted);
                        }
                    }
                    if (this.m.Skill.isInRange(null.getTile()))
                    {
                    }
                    if (!null.isTurnDone())
                    {
                    }
                    [].push({});
                    if ([].len() == 0)
                    {
                        return _entity;
                    }
                    [].sort(this.onSortByScore);
                    foreach (local key, value in r332)
                    {
                        if ((null != null) && (null != null))
                        {
                            return ((null != null) && (null != null));
                        }
                        if (this.isAllottedTimeReached(this.Time.getExactTime()))
                        {
                            yield this;
                        }
                        if (!this.m.Skill.isInRange(null.Tile))
                        {
                            this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
                            this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
                            this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
                            this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
                            this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
                            this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = false;
                            this.Tactical.getNavigator().createSettings().ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
                            this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
                            this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
                            if (_entity && _entity)
                            {
                                return (_entity && _entity);
                                if ((!this.m.Skill) && (!this.m.Skill))
                                {
                                    return ((!this.m.Skill) && (!this.m.Skill));
                                }
                                else
                                {
                                    if (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).IsComplete))
                                    {
                                    }
                                    if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.IsBadTerrain)
                                    {
                                    }
                                    if (this.getProperties().EngageOnBadTerrainPenaltyMult != 0.0)
                                    {
                                    }
                                    foreach (local key, value in r105)
                                    {
                                        if (this.isAllottedTimeReached(this.Time.getExactTime()))
                                        {
                                            yield this;
                                        }
                                        if (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).IsComplete))
                                        {
                                            if (this.queryActorTurnsNearTarget(null, null.Tile, _entity).Turns > this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End, _entity).Turns))
                                            {
                                            }
                                        }
                                        if (this.queryActorTurnsNearTarget(null, null.Tile, _entity).Turns <= 1.0)
                                        {
                                            if (null.getCurrentProperties().IsRooted || null.getCurrentProperties().IsRooted)
                                            {
                                                return (null.getCurrentProperties().IsRooted || null.getCurrentProperties().IsRooted);
                                            }
                                        }
                                        if (((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End, _entity).Turns))) >= this.Const.AI.Behavior.PossessUndeadMaxDanger) && ((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End, _entity).Turns))) >= this.Const.AI.Behavior.PossessUndeadMaxDanger)))
                                        {
                                            return (((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End, _entity).Turns))) >= this.Const.AI.Behavior.PossessUndeadMaxDanger) && ((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End, _entity).Turns))) >= this.Const.AI.Behavior.PossessUndeadMaxDanger));
                                        }
                                        if (((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End, _entity).Turns))) >= this.Const.AI.Behavior.PossessUndeadMaxDanger) && ((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End, _entity).Turns))) >= this.Const.AI.Behavior.PossessUndeadMaxDanger)))
                                        {
                                            return (((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End, _entity).Turns))) >= this.Const.AI.Behavior.PossessUndeadMaxDanger) && ((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End, _entity).Turns))) >= this.Const.AI.Behavior.PossessUndeadMaxDanger));
                                        }
                                        if ((0.0 + (1.0 - this.queryActorTurnsNearTarget(null, _entity.getTile(), _entity).Turns) >= this.Const.AI.Behavior.PossessUndeadMaxDanger))
                                        {
                                        }
                                        if (!this.m.Skill.onVerifyTarget(_entity.getTile(), null.Tile))
                                        {
                                        }
                                        if ((((((((null.Score - (this.Const.AI.Behavior.PossessUndeadMoveToBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult) - this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.TVLevelDisadvantage) - this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired) + this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.Level) - this.Const.AI.Behavior.PossessUndeadLowDangerPenalty) - this.Const.AI.Behavior.PossessUndeadHighDangerPenalty) + _entity.getTile().Level) > -9000))
                                        {
                                        }
                                        if (null.Tile == null)
                                        {
                                            return _entity;
                                        }
                                        this.m.TargetTile = null.Tile;
                                        this.m.IsTravelling = (!this.m.Skill.isInRange(this.m.TargetTile));
                                        if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End.ID == _entity.getTile().ID) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.ID == _entity.getTile().ID)))
                                        {
                                            return ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.ID == _entity.getTile().ID) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.ID == _entity.getTile().ID));
                                            return _entity;
                                        }
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

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        if (this.m.IsTravelling)
        {
            this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
            this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
            this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
            this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
            this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
            this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = false;
            this.Tactical.getNavigator().createSettings().ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
            this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
            this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
            this.Tactical.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.Tactical.getNavigator().createSettings(), this.m.Skill.getMaxRange());
            if (this.Const.AI.PathfindingDebugMode)
            {
                this.Tactical.getNavigator().buildVisualisation(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()));
            }
            this.getAgent().adjustCameraToDestination(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End);
            if (this.Const.AI.VerboseMode)
            {
                this.logInfo((("* " + _entity.getName()) + ": Moving into range to use Possess Undead"));
            }
            this.m.IsFirstExecuted = false;
            return _entity;
        }
        if (this.Tactical.getNavigator().createSettings() && this.Tactical.getNavigator().createSettings())
        {
            return (this.Tactical.getNavigator().createSettings() && this.Tactical.getNavigator().createSettings());
            _entity.setDiscovered(true);
            _entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
        }
        this.getAgent().adjustCameraToTarget(this.m.TargetTile);
        this.m.IsFirstExecuted = false;
        return _entity;
    }
    if (this.m.IsTravelling)
    {
        if (!this.Tactical.getNavigator().travel(_entity, _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())))
        {
            this.m.TargetTile = null;
            return _entity;
        }
    }
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Using Possess Undead!"));
    }
    if (this.m.Skill.use(this.m.TargetTile))
    {
        if (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer)
        {
            return (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer);
            this.getAgent().declareAction();
            this.getAgent().declareEvaluationDelay();
        }
    }
    this.m.Skill = null;
    this.m.TargetTile = null;
    return _entity;
}

function onSortByScore(this, _a, _b)
{
    if (_a.Score > _b.Score)
    {
        return _a;
    }
    else
    {
        if (_a.Score < _b.Score)
        {
            return _a;
        }
    }
    return _a;
}
