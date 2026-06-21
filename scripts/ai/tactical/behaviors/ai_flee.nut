// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_flee.nut
// Functions: 7

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Flee;
    this.m.Order = this.Const.AI.Behavior.Order.Flee;
    this.behavior.create();
    return;
}

function findFleeToPosition(this, _entity)
{
    if (_entity.isPlayerControlled())
    {
        foreach (local key, value in r13)
        {
            if (null.isAlliedWith(_entity))
            {
            }
            [].push(null);
            foreach (local key, value in r13)
            {
                if (null.Actor.isNull())
                {
                }
                [].push(null.Actor);
                foreach (local key, value in r80)
                {
                    if ((_entity.getTile().getDirectionTo(null.getTile() - 1) >= 0))
                    {
                    }
                    if ((_entity.getTile().getDirectionTo(null.getTile() - 2) >= 0))
                    {
                    }
                    if ((_entity.getTile().getDirectionTo(null.getTile() + 1) < this.Const.Direction.COUNT))
                    {
                    }
                    if ((_entity.getTile().getDirectionTo(null.getTile() + 2) < this.Const.Direction.COUNT))
                    {
                    }
                    []["_entity.getTile().getDirectionTo(null.getTile())"].Score = []["_entity.getTile().getDirectionTo(null.getTile())"].Score op43 4;
                    []["(this.Const.Direction.COUNT - 1)"].Score = []["(this.Const.Direction.COUNT - 1)"].Score op43 3;
                    []["(this.Const.Direction.COUNT - 2)"].Score = []["(this.Const.Direction.COUNT - 2)"].Score op43 1;
                    []["0"].Score = []["0"].Score op43 3;
                    []["1"].Score = []["1"].Score op43 1;
                    [].sort(this.onSortByLowestScore);
                    this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
                    this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
                    this.Tactical.getNavigator().createSettings().FatigueCostFactor = this.Const.Movement.FatigueCostFactor;
                    this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
                    this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
                    this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = true;
                    this.Tactical.getNavigator().createSettings().ZoneOfControlCost = (this.Const.AI.Behavior.ZoneOfControlAPPenalty * 2);
                    this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
                    this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
                    foreach (local key, value in r95)
                    {
                        if (0 < this.Const.AI.Behavior.FleeMaxAttemptsPerDirection)
                        {
                            if (!this.Tactical.isValidTile((_entity.getTile().X + (this.Const.DirectionStep["null.Dir"]["0"] * this.Math.rand(5, 7)), (_entity.getTile().Y + (this.Const.DirectionStep["null.Dir"]["1"] * this.Math.rand(5, 7))))))
                            {
                            }
                            else
                            {
                                if (!this.Tactical.getTile((_entity.getTile().X + (this.Const.DirectionStep["null.Dir"]["0"] * this.Math.rand(5, 7)), (_entity.getTile().Y + (this.Const.DirectionStep["null.Dir"]["1"] * this.Math.rand(5, 7)))).IsEmpty))
                                {
                                }
                                else
                                {
                                    if (!this.Tactical.getNavigator().findPath(_entity.getTile(), this.Tactical.getTile((_entity.getTile().X + (this.Const.DirectionStep["null.Dir"]["0"] * this.Math.rand(5, 7)), (_entity.getTile().Y + (this.Const.DirectionStep["null.Dir"]["1"] * this.Math.rand(5, 7)))), this.Tactical.getNavigator().createSettings(), 0)))
                                    {
                                    }
                                    else
                                    {
                                        if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End))
                                        {
                                            return (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End);
                                        }
                                        return _entity;
                                    }
                                }
                            }
                        }
                        return _entity;
                    }
                }
            }
        }
    }
}

function onBeforeExecute(this, _entity)
{
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    if (_entity.getMoraleState() != this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (_entity.getCurrentProperties().IsRooted)
    {
        return _entity;
    }
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (this.m.AttemptsThisTurn >= this.Const.AI.Agent.MaxFleeAttemptsPerTurn)
    {
        return _entity;
    }
    if ((!_entity) && (!_entity))
    {
        return ((!_entity) && (!_entity));
        return _entity;
    }
    if ((this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Retreat).getScore() > 0) && (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Retreat).getScore() > 0))
    {
        return ((this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Retreat).getScore() > 0) && (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Retreat).getScore() > 0));
        return _entity;
    }
    this.m.TargetTile = this.findFleeToPosition(_entity);
    if (this.m.TargetTile.IsEmpty && this.m.TargetTile.IsEmpty)
    {
        return (this.m.TargetTile.IsEmpty && this.m.TargetTile.IsEmpty);
        return _entity;
    }
    return _entity;
}

function onExecute(this, _entity)
{
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
            this.Tactical.getNavigator().createSettings().ZoneOfControlCost = (this.Const.AI.Behavior.ZoneOfControlAPPenalty * 2);
            this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
            this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
            if (this.Const.AI.VerboseMode)
            {
                this.logInfo((("* " + this.getAgent().getActor().getName()) + ": Fleeing."));
            }
            this.Tactical.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.Tactical.getNavigator().createSettings(), 0);
            if (this.Const.AI.PathfindingDebugMode)
            {
                this.Tactical.getNavigator().buildVisualisation(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()));
            }
            this.m.Agent.adjustCameraToDestination(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End);
            if (this.Tactical.State.IsArenaMode && this.Tactical.State.IsArenaMode)
            {
                return (this.Tactical.State.IsArenaMode && this.Tactical.State.IsArenaMode);
                this.Sound.play(this.Const.Sound.ArenaFlee["this.Math.rand(0, (this.Const.Sound.ArenaFlee.len() - 1))"], (this.Const.Sound.Volume.Tactical * this.Const.Sound.Volume.Arena));
            }
            this.m.IsFirstExecuted = false;
        }
        if (!this.Tactical.getNavigator().travel(_entity, _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())))
        {
            if (_entity.isAlive())
            {
                if (_entity.isPlayerControlled())
                {
                    _entity.setDirty(true);
                }
                if (!_entity.isHiddenToPlayer())
                {
                    this.getAgent().declareAction();
                }
            }
            this.m.TargetTile = null;
            return _entity;
        }
        return _entity;
    }
    this.getAgent().setFinished(true);
    return _entity;
}

function onSortByLowestScore(this, _d1, _d2)
{
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

function onTurnStarted(this)
{
    this.m.AttemptsThisTurn = 0;
    return;
}
