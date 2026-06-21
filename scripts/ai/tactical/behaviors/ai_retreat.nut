// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_retreat.nut
// Functions: 8

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Retreat;
    this.m.Order = this.Const.AI.Behavior.Order.Retreat;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function findRetreatToPosition(this, _entity)
{
    if (1 < this.Tactical.Entities.getAllInstances().len())
    {
        if (_entity.getAlliedFactions().find(1) != null)
        {
        }
        foreach (local key, value in r102)
        {
            if ((!20) && (!20))
            {
                return ((!20) && (!20));
                [].push(null);
            }
            if (_entity.getTile().getDirection8To(null.getTile() == this.Const.Direction8.W))
            {
                []["this.Const.Direction.NW"] = []["this.Const.Direction.NW"] op43 4;
                []["this.Const.Direction.SW"] = []["this.Const.Direction.SW"] op43 4;
            }
            if (_entity.getTile().getDirection8To(null.getTile() == this.Const.Direction8.E))
            {
                []["this.Const.Direction.NE"] = []["this.Const.Direction.NE"] op43 4;
                []["this.Const.Direction.SE"] = []["this.Const.Direction.SE"] op43 4;
            }
            if ((_entity.getTile().getDirectionTo(null.getTile() - 1) >= 0))
            {
            }
            if ((_entity.getTile().getDirectionTo(null.getTile() + 1) < 6))
            {
            }
            []["_entity.getTile().getDirectionTo(null.getTile())"] = []["_entity.getTile().getDirectionTo(null.getTile())"] op43 4;
            []["(6 - 1)"] = []["(6 - 1)"] op43 3;
            []["0"] = []["0"] op43 3;
            if (0 < this.Tactical.getMapSize().Y)
            {
                if (this.Tactical.getTileSquare((this.Tactical.getMapSize().X - 1), 0).IsEmpty)
                {
                    if ((_entity.getTile().getDistanceTo(this.Tactical.getTileSquare((this.Tactical.getMapSize().X - 1), 0) * 2) <= _entity.getActionPoints()))
                    {
                    }
                    if ((_entity.getTile().getDistanceTo(this.Tactical.getTileSquare((this.Tactical.getMapSize().X - 1), 0) * 2) <= _entity.getActionPoints()))
                    {
                    }
                    [].push({});
                }
            }
            if (0 < this.Tactical.getMapSize().Y)
            {
                if (this.Tactical.getTileSquare(0, 0).IsEmpty)
                {
                    if ((_entity.getTile().getDistanceTo(this.Tactical.getTileSquare(0, 0) * 2) <= _entity.getActionPoints()))
                    {
                    }
                    if ((_entity.getTile().getDistanceTo(this.Tactical.getTileSquare(0, 0) * 2) <= _entity.getActionPoints()))
                    {
                    }
                    [].push({});
                }
            }
            if (1 < (this.Tactical.getMapSize().X - 1))
            {
                if (this.Tactical.getTileSquare(1, (this.Tactical.getMapSize().Y - 1)).IsEmpty)
                {
                    if ((_entity.getTile().getDistanceTo(this.Tactical.getTileSquare(1, (this.Tactical.getMapSize().Y - 1)) * 2) <= _entity.getActionPoints()))
                    {
                    }
                    if ((_entity.getTile().getDistanceTo(this.Tactical.getTileSquare(1, (this.Tactical.getMapSize().Y - 1)) * 2) <= _entity.getActionPoints()))
                    {
                    }
                    [].push({});
                }
            }
            if (1 < (this.Tactical.getMapSize().X - 1))
            {
                if (this.Tactical.getTileSquare(1, 0).IsEmpty)
                {
                    if ((_entity.getTile().getDistanceTo(this.Tactical.getTileSquare(1, 0) * 2) <= _entity.getActionPoints()))
                    {
                    }
                    if ((_entity.getTile().getDistanceTo(this.Tactical.getTileSquare(1, 0) * 2) <= _entity.getActionPoints()))
                    {
                    }
                    [].push({});
                }
            }
            [].sort(this.onSortByLowestScore);
            foreach (local key, value in r244)
            {
                if (((0 + 12) > this.Const.AI.Behavior.RetreatHardMaxAttempts) && ((0 + 12) > this.Const.AI.Behavior.RetreatHardMaxAttempts))
                {
                    return (((0 + 12) > this.Const.AI.Behavior.RetreatHardMaxAttempts) && ((0 + 12) > this.Const.AI.Behavior.RetreatHardMaxAttempts));
                }
                if (this.isAllottedTimeReached(this.Time.getExactTime()))
                {
                    yield this;
                }
                this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
                this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
                this.Tactical.getNavigator().createSettings().FatigueCostFactor = this.Const.Movement.FatigueCostFactor;
                this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
                this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
                this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = true;
                this.Tactical.getNavigator().createSettings().ZoneOfControlCost = (this.Const.AI.Behavior.ZoneOfControlAPPenalty * 4);
                this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
                this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
                if (this.getAgent().isUsingHeat())
                {
                }
                this.Tactical.getNavigator().createSettings().HeatCost = 0;
                if (!this.Tactical.getNavigator().findPath(_entity.getTile(), null.Tile, this.Tactical.getNavigator().createSettings(), 0))
                {
                }
                else
                {
                    if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End))
                    {
                        return (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End);
                    }
                    if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End.Coords.Y == (this.Tactical.getMapSize().Y - 1)) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.Coords.Y == (this.Tactical.getMapSize().Y - 1))))
                    {
                        return ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.Coords.Y == (this.Tactical.getMapSize().Y - 1)) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.Coords.Y == (this.Tactical.getMapSize().Y - 1)));
                    }
                    if ((0 > 0) && (0 > 0))
                    {
                        return ((0 > 0) && (0 > 0));
                        if (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).IsComplete))
                        {
                            foreach (local key, value in null)
                            {
                                if (this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End, _entity).Turns <= 2.0))
                                {
                                }
                                if (this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End, _entity).Turns <= 1.0))
                                {
                                }
                                if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).ActionPointsRequired < this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired < this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired)))
                                {
                                    return ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired < this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired < this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired));
                                }
                                if (null.Tile != null)
                                {
                                    this.m.TargetTile = null.Tile;
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

function isAtMapBorder(this, _entity)
{
    if (0 < 6)
    {
        if (!_entity.getTile().hasNextTile(0))
        {
            return _entity;
        }
    }
    return _entity;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    if ((_entity.getFaction() != this.Const.Faction.Player) && (_entity.getFaction() != this.Const.Faction.Player) && (_entity.getFaction() != this.Const.Faction.Player))
    {
        return ((_entity.getFaction() != this.Const.Faction.Player) && (_entity.getFaction() != this.Const.Faction.Player) && (_entity.getFaction() != this.Const.Faction.Player));
        return _entity;
    }
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getCurrentProperties().IsRooted)
    {
        return _entity;
    }
    if (this.m.IsDone)
    {
        return _entity;
    }
    if ((_entity.getTile().hasZoneOfControlOtherThan != this.Const.Faction.Player) && (_entity.getTile().hasZoneOfControlOtherThan != this.Const.Faction.Player))
    {
        return ((_entity.getTile().hasZoneOfControlOtherThan != this.Const.Faction.Player) && (_entity.getTile().hasZoneOfControlOtherThan != this.Const.Faction.Player));
        return _entity;
    }
    if ((this.Const.EntityType.Lindwurm > 1) && (this.Const.EntityType.Lindwurm > 1))
    {
        return ((this.Const.EntityType.Lindwurm > 1) && (this.Const.EntityType.Lindwurm > 1));
        return _entity;
    }
    if (_entity.getFaction() != this.Const.Faction.Player)
    {
        foreach (local key, value in r40)
        {
            if (null.len() == 0)
            {
            }
            if (_entity && _entity)
            {
                return (_entity && _entity);
                foreach (local key, value in null)
                {
                    if (null.getXPValue() > 0)
                    {
                    }
                    foreach (local key, value in 0)
                    {
                        if (_entity && _entity)
                        {
                            return (_entity && _entity);
                        }
                        if ((((0.0 + 1.0) / (0.0 + null) >= this.Const.AI.Behavior.RetreatMinAllyRatio) && (((0.0 + 1.0) / (0.0 + null)) >= this.Const.AI.Behavior.RetreatMinAllyRatio)))
                        {
                            return ((((0.0 + 1.0) / (0.0 + null)) >= this.Const.AI.Behavior.RetreatMinAllyRatio) && (((0.0 + 1.0) / (0.0 + null)) >= this.Const.AI.Behavior.RetreatMinAllyRatio));
                            return _entity;
                        }
                        if (((0.0 + 1.0) >= (0.0 + (null.len() * 1.0)) && ((0.0 + 1.0) >= (0.0 + (null.len() * 1.0)))))
                        {
                            return (((0.0 + 1.0) >= (0.0 + (null.len() * 1.0))) && ((0.0 + 1.0) >= (0.0 + (null.len() * 1.0))));
                            return _entity;
                        }
                        if (this.isAtMapBorder(_entity))
                        {
                        }
                        else
                        {
                            if (resume this == null)
                            {
                                yield null;
                            }
                            if (this.m.TargetTile == null)
                            {
                                return _entity;
                            }
                        }
                        if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
                        {
                        }
                        if (_entity.getBaseProperties().Bravery == 0)
                        {
                        }
                        return _entity;
                    }
                }
            }
        }
    }
}

function onExecute(this, _entity)
{
    if (null && null)
    {
        return (null && null);
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((("* " + this.getAgent().getActor().getName()) + ": Retreated!"));
        }
        this.getAgent().setFinished(true);
        _entity.retreat();
        return _entity;
    }
    if (this.m.TargetTile != null)
    {
        if (this.m.IsFirstExecuted)
        {
            this.getAgent().getOrders().IsRetreating = true;
            this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
            this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
            this.Tactical.getNavigator().createSettings().FatigueCostFactor = this.Const.Movement.FatigueCostFactor;
            this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
            this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
            this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = true;
            this.Tactical.getNavigator().createSettings().ZoneOfControlCost = (this.Const.AI.Behavior.ZoneOfControlAPPenalty * 4);
            this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
            this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
            if (this.Const.AI.VerboseMode)
            {
                this.logInfo((("* " + this.getAgent().getActor().getName()) + ": Retreating."));
            }
            this.Tactical.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.Tactical.getNavigator().createSettings(), 0);
            if (this.Const.AI.PathfindingDebugMode)
            {
                this.Tactical.getNavigator().buildVisualisation(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()));
            }
            this.m.Agent.adjustCameraToDestination(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End);
            this.m.IsFirstExecuted = false;
        }
        if (!this.Tactical.getNavigator().travel(_entity, _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())))
        {
            if (_entity.isAlive())
            {
                if (this.isAtMapBorder(_entity))
                {
                    if (this.Const.AI.VerboseMode)
                    {
                        this.logInfo((("* " + this.getAgent().getActor().getName()) + ": Retreated!"));
                    }
                    this.getAgent().setFinished(true);
                    _entity.retreat();
                }
                else
                {
                    if (!_entity.isHiddenToPlayer())
                    {
                        this.getAgent().declareAction();
                    }
                }
            }
            this.m.TargetTile = null;
            this.m.IsDone = true;
        }
        return _entity;
    }
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        this.getAgent().setFinished(true);
    }
    return _entity;
}

function onSortByLowestScore(this, _d1, _d2)
{
    if (_d1.Dir > _d2.Dir)
    {
        return _d1;
    }
    if (_d1.Dir < _d2.Dir)
    {
        return _d1;
    }
    if (_d1.Score > _d2.Score)
    {
        return _d1;
    }
    else
    {
        if (_d1.Score < _d2.Score)
        {
            return _d1;
        }
    }
    return _d1;
}

function onTurnResumed(this)
{
    this.m.IsDone = false;
    return;
}

function onTurnStarted(this)
{
    this.m.IsDone = false;
    return;
}
