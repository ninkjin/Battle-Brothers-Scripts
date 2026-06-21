// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_gruesome_feast.nut
// Functions: 6

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.GruesomeFeast;
    this.m.Order = this.Const.AI.Behavior.Order.GruesomeFeast;
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
    this.m.IsWaiting = false;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getCurrentProperties().IsRooted)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if ((3 >= r6) && (3 >= r6))
    {
        return ((3 >= r6) && (3 >= r6));
        return _entity;
    }
    foreach (local key, value in r24)
    {
        if (_entity.getSkills().getSkillByID(null).isAffordable() && _entity.getSkills().getSkillByID(null).isAffordable())
        {
            return (_entity.getSkills().getSkillByID(null).isAffordable() && _entity.getSkills().getSkillByID(null).isAffordable());
            [].push(_entity.getSkills().getSkillByID(null));
        }
        if ([].len() == 0)
        {
            return _entity;
        }
        this.m.Skill = []["this.Math.rand(0, ([].len() - 1))"];
        if (this.isAllottedTimeReached(this.Time.getExactTime()))
        {
            yield this;
        }
        if (this.Tactical.Entities.getCorpses().len() == 0)
        {
            return _entity;
        }
        if (_entity.getTile().Properties.IsConsumable && _entity.getTile().Properties.IsConsumable)
        {
            return (_entity.getTile().Properties.IsConsumable && _entity.getTile().Properties.IsConsumable);
            [].push({});
        }
        foreach (local key, value in r216)
        {
            if ((!null.Properties.IsConsumable) && (!null.Properties.IsConsumable))
            {
                return ((!null.Properties.IsConsumable) && (!null.Properties.IsConsumable));
            }
            else
            {
                if ((!(null.getDistanceTo(_entity.getTile() == 1)) && (!(null.getDistanceTo(_entity.getTile()) == 1)) && (null.getDistanceTo(_entity.getTile()) == 1) && (null.getDistanceTo(_entity.getTile()) == 1) && (null.getDistanceTo(_entity.getTile()) == 1) && (null.getDistanceTo(_entity.getTile()) == 1)))
                {
                    return ((!(null.getDistanceTo(_entity.getTile()) == 1)) && (!(null.getDistanceTo(_entity.getTile()) == 1)) && (null.getDistanceTo(_entity.getTile()) == 1) && (null.getDistanceTo(_entity.getTile()) == 1) && (null.getDistanceTo(_entity.getTile()) == 1) && (null.getDistanceTo(_entity.getTile()) == 1));
                }
                if (null.getDistanceTo(_entity.getTile() > this.Const.AI.Behavior.GruesomeFeastMaxDistance))
                {
                }
                if ((null.getDistanceTo(_entity.getTile() > this.m.Skill) && (null.getDistanceTo(_entity.getTile()) > this.m.Skill)))
                {
                    return ((null.getDistanceTo(_entity.getTile()) > this.m.Skill) && (null.getDistanceTo(_entity.getTile()) > this.m.Skill));
                }
                if ((!this.Const.AI.Behavior.GruesomeFeastOpponentValue) && (!this.Const.AI.Behavior.GruesomeFeastOpponentValue))
                {
                    return ((!this.Const.AI.Behavior.GruesomeFeastOpponentValue) && (!this.Const.AI.Behavior.GruesomeFeastOpponentValue));
                }
                if (null.getDistanceTo(_entity.getTile() > 1))
                {
                    foreach (local key, value in r34)
                    {
                        if ((_entity.getSize() < 3) && (_entity.getSize() < 3) && (_entity.getSize() < 3))
                        {
                            return ((_entity.getSize() < 3) && (_entity.getSize() < 3) && (_entity.getSize() < 3));
                        }
                        if (true)
                        {
                        }
                        [].push({});
                        if ([].len() == 0)
                        {
                            return _entity;
                        }
                        [].sort(this.onSortByScore);
                        foreach (local key, value in r308)
                        {
                            if ((null != null) && (null != null))
                            {
                                return ((null != null) && (null != null));
                            }
                            if (this.isAllottedTimeReached(this.Time.getExactTime()))
                            {
                                yield this;
                            }
                            if (null.Tile.IsEmpty && null.Tile.IsEmpty)
                            {
                                return (null.Tile.IsEmpty && null.Tile.IsEmpty);
                                this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
                                this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
                                this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
                                this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
                                this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
                                this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = false;
                                this.Tactical.getNavigator().createSettings().ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
                                this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
                                this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
                                if (this.Tactical.getNavigator().findPath(_entity.getTile(), null.Tile, this.Tactical.getNavigator().createSettings(), this.m.Skill.getMaxRange()))
                                {
                                    if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).Tiles == 0))
                                    {
                                    }
                                    if (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).IsComplete))
                                    {
                                    }
                                    if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.IsBadTerrain)
                                    {
                                    }
                                    if (this.getProperties().EngageOnBadTerrainPenaltyMult != 0.0)
                                    {
                                    }
                                    foreach (local key, value in r100)
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
                                            if (0.IsStunned && 0.IsStunned)
                                            {
                                                return (0.IsStunned && 0.IsStunned);
                                            }
                                        }
                                        if (((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End, _entity).Turns))) >= this.Const.AI.Behavior.GruesomeFeastMaxDanger) && ((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End, _entity).Turns))) >= this.Const.AI.Behavior.GruesomeFeastMaxDanger)))
                                        {
                                            return (((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End, _entity).Turns))) >= this.Const.AI.Behavior.GruesomeFeastMaxDanger) && ((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End, _entity).Turns))) >= this.Const.AI.Behavior.GruesomeFeastMaxDanger));
                                        }
                                        if (((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End, _entity).Turns))) >= this.Const.AI.Behavior.GruesomeFeastMaxDanger) && ((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End, _entity).Turns))) >= this.Const.AI.Behavior.GruesomeFeastMaxDanger)))
                                        {
                                            return (((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End, _entity).Turns))) >= this.Const.AI.Behavior.GruesomeFeastMaxDanger) && ((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End, _entity).Turns))) >= this.Const.AI.Behavior.GruesomeFeastMaxDanger));
                                        }
                                        if (((((((((0 + null.Score) - this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).ActionPointsRequired) - (this.Const.AI.Behavior.RaiseUndeadMoveToBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult)) - this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.TVLevelDisadvantage) + this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.Level) - this.Const.AI.Behavior.GruesomeFeastLowDangerPenalty) - this.Const.AI.Behavior.GruesomeFeastHighDangerPenalty) + _entity.getTile().Level) > -9999))
                                        {
                                        }
                                        if (null.Tile == null)
                                        {
                                            return _entity;
                                        }
                                        this.m.TargetTile = null.Tile;
                                        this.m.IsTravelling = (null.Tile.getDistanceTo(_entity.getTile()) > this.m.Skill.getMaxRange());
                                        if ((!"IsTravelling") && (!"IsTravelling"))
                                        {
                                            return ((!"IsTravelling") && (!"IsTravelling"));
                                            this.m.IsWaiting = true;
                                        }
                                        if (_entity.getHitpoints() < _entity.getHitpointsMax())
                                        {
                                        }
                                        if ((!(_entity.getHitpoints() / _entity.getHitpointsMax()) && (!(_entity.getHitpoints() / _entity.getHitpointsMax()))))
                                        {
                                            return ((!(_entity.getHitpoints() / _entity.getHitpointsMax())) && (!(_entity.getHitpoints() / _entity.getHitpointsMax())));
                                        }
                                        return this.Math.max(0, (this.Const.AI.Behavior.Score.GruesomeFeast * (((this.getProperties().BehaviorMult["this.m.ID"] + (1.0 - (_entity.getHitpoints() / _entity.getHitpointsMax()))) * (this.Const.AI.Behavior.GruesomeFeastLeaveZOCMult / _entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()))) - (this.Const.AI.Behavior.GruesomeFeastDangerPenaltyMult * this.Math.maxf((0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, null.Tile, _entity).Turns))), (0.0 + this.Math.maxf(0.0, (1.0 - this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End, _entity).Turns))))))));
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
        if (this.m.IsWaiting)
        {
            if (this.Tactical.TurnSequenceBar.entityWaitTurn(_entity))
            {
                if (this.Const.AI.VerboseMode)
                {
                    this.logInfo((("* " + _entity.getName()) + ": Waiting until others have moved!"));
                }
                this.m.TargetTile = null;
                return _entity;
            }
            this.m.IsWaiting = false;
        }
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
            if (!this.Tactical.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.Tactical.getNavigator().createSettings(), this.m.Skill.getMaxRange()))
            {
                this.logWarning((("* " + _entity.getName()) + ": Failed to execute path for Gruesome Feast - No path found!"));
                return _entity;
            }
            if (this.Const.AI.PathfindingDebugMode)
            {
                this.Tactical.getNavigator().buildVisualisation(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()));
            }
            this.getAgent().adjustCameraToDestination(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End);
            if (this.Const.AI.VerboseMode)
            {
                this.logInfo((("* " + _entity.getName()) + ": Moving into range to use Gruesome Feast"));
            }
            this.m.IsFirstExecuted = false;
            return _entity;
        }
    }
    if (this.m.IsTravelling)
    {
        if (!this.Tactical.getNavigator().travel(_entity, _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())))
        {
            this.m.IsTravelling = false;
            if ((!this.Tactical) && (!this.Tactical))
            {
                return ((!this.Tactical) && (!this.Tactical));
                if (_entity.getTile().Properties.IsConsumable && _entity.getTile().Properties.IsConsumable)
                {
                    return (_entity.getTile().Properties.IsConsumable && _entity.getTile().Properties.IsConsumable);
                    if (!this.m.Skill.isAffordable())
                    {
                        _entity.setActionPoints(0);
                    }
                    this.useSkill(_entity);
                }
                else
                {
                    if (_entity.getActionPoints() <= 2)
                    {
                        _entity.setActionPoints(0);
                    }
                }
            }
            this.m.TargetTile = null;
            return _entity;
        }
    }
    this.useSkill(_entity);
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

function useSkill(this, _entity)
{
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Using Gruesome Feast!"));
    }
    if (this.m.Skill.use(this.m.TargetTile))
    {
        if (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer)
        {
            return (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer);
            this.getAgent().declareAction();
            this.getAgent().declareEvaluationDelay(600);
        }
    }
    this.m.Skill = null;
    this.m.TargetTile = null;
    return;
}
