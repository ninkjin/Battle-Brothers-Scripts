// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_move_to_merge.nut
// Functions: 6

function <anonymous>(this, _a, _b)
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

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.MoveToMerge;
    this.m.Order = this.Const.AI.Behavior.Order.MoveToMerge;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function onBeforeExecute(this, _entity)
{
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
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
    if (_entity.getSize() >= 3)
    {
        return _entity;
    }
    if (_entity.getTile().hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
    {
        return _entity;
    }
    if (0 < 6)
    {
        if (!_entity.getTile().hasNextTile(0))
        {
        }
        else
        {
            if ((_entity.getTile().getNextTile(0).getEntity().getSize() == _entity.getSize() && (_entity.getTile().getNextTile(0).getEntity().getSize() == _entity.getSize())))
            {
                return ((_entity.getTile().getNextTile(0).getEntity().getSize() == _entity.getSize()) && (_entity.getTile().getNextTile(0).getEntity().getSize() == _entity.getSize()));
            }
        }
    }
    if ((0 + 5) >= 2)
    {
        if (6 && 6)
        {
            return (6 && 6);
            this.m.IsWaiting = true;
            return _entity;
        }
        return _entity;
    }
    foreach (local key, value in r21)
    {
        if ((this.Const.EntityType.SandGolem == r13) && (this.Const.EntityType.SandGolem == r13))
        {
            return ((this.Const.EntityType.SandGolem == r13) && (this.Const.EntityType.SandGolem == r13));
            [].push(null);
        }
        if ([].len() == 0)
        {
            return _entity;
        }
        foreach (local key, value in r118)
        {
            if (0 < 6)
            {
                if (!null.getTile().hasNextTile(0))
                {
                }
                else
                {
                    if (((_entity.getTile().getDistanceTo(null.getTile().getNextTile(0) * 2) > _entity.getActionPoints()) || ((_entity.getTile().getDistanceTo(null.getTile().getNextTile(0)) * 2) > _entity.getActionPoints())))
                    {
                        return (((_entity.getTile().getDistanceTo(null.getTile().getNextTile(0)) * 2) > _entity.getActionPoints()) || ((_entity.getTile().getDistanceTo(null.getTile().getNextTile(0)) * 2) > _entity.getActionPoints()));
                    }
                    else
                    {
                        if (0 < 6)
                        {
                            if (!null.getTile().getNextTile(0).hasNextTile(0))
                            {
                            }
                            else
                            {
                                if (null.getTile().getNextTile(0).getNextTile(0).ID == _entity.getTile().ID)
                                {
                                }
                                else
                                {
                                    if ((null.getTile().getNextTile(0).getNextTile(0).getEntity().getSize() == _entity.getSize() && (null.getTile().getNextTile(0).getNextTile(0).getEntity().getSize() == _entity.getSize())))
                                    {
                                        return ((null.getTile().getNextTile(0).getNextTile(0).getEntity().getSize() == _entity.getSize()) && (null.getTile().getNextTile(0).getNextTile(0).getEntity().getSize() == _entity.getSize()));
                                    }
                                }
                            }
                        }
                        if (((0 + 15) > (0 + 5) && ((0 + 15) > (0 + 5))))
                        {
                            return (((0 + 15) > (0 + 5)) && ((0 + 15) > (0 + 5)));
                            [].push({});
                        }
                    }
                }
            }
            if ([].len() == 0)
            {
                return _entity;
            }
            [].sort(function() /* closure #0 */);
            this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
            this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
            this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
            this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
            this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
            this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = false;
            this.Tactical.getNavigator().createSettings().ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
            this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
            this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
            foreach (local key, value in r58)
            {
                if ((0 + 11) > this.Const.AI.Behavior.MoveToMergeMaxAttempts)
                {
                    if (this.isAllottedTimeReached(this.Time.getExactTime()))
                    {
                        yield this;
                    }
                }
                if (this.Tactical.getNavigator().findPath(_entity.getTile(), null.Tile, this.Tactical.getNavigator().createSettings(), 0))
                {
                    if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).IsComplete)
                    {
                        if (((null.ScoreBonus * 2) - this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).ActionPointsRequired) > -9000))
                        {
                        }
                    }
                }
                if (null.Tile == null)
                {
                    return _entity;
                }
                this.m.TargetTile = null.Tile;
                return _entity;
            }
        }
    }
}

function onExecute(this, _entity)
{
    if (this.Tactical.TurnSequenceBar && this.Tactical.TurnSequenceBar)
    {
        return (this.Tactical.TurnSequenceBar && this.Tactical.TurnSequenceBar);
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((("* " + _entity.getName()) + ": Waiting until others have moved!"));
        }
        this.m.IsWaiting = false;
        return _entity;
    }
    if (this.m.TargetTile != null)
    {
        if (this.m.IsFirstExecuted)
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
            this.Tactical.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.Tactical.getNavigator().createSettings(), 0);
            if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).Tiles == 0))
            {
                return _entity;
            }
            this.m.Agent.adjustCameraToDestination(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End);
            this.m.IsFirstExecuted = false;
            return;
        }
        if (!this.Tactical.getNavigator().travel(_entity, _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())))
        {
            this.m.TargetTile = null;
            this.m.IsWaiting = false;
            return _entity;
        }
    }
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
