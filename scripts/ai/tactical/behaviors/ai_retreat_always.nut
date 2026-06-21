// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_retreat_always.nut
// Functions: 6

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.RetreatAlways;
    this.m.Order = this.Const.AI.Behavior.Order.RetreatAlways;
    this.behavior.create();
    return;
}

function findRetreatToPosition(this, _entity)
{
    if (_entity.getTile().SquareCoords.X > (this.Tactical.getMapSize().X / 2))
    {
        if (0 < this.Tactical.getMapSize().Y)
        {
            if (this.Tactical.getTileSquare((this.Tactical.getMapSize().X - 1), 0).IsEmpty)
            {
                [].push({});
            }
        }
    }
    else
    {
        if (0 < this.Tactical.getMapSize().Y)
        {
            if (this.Tactical.getTileSquare(0, 0).IsEmpty)
            {
                [].push({});
            }
        }
    }
    if (_entity.getTile().SquareCoords.Y > (this.Tactical.getMapSize().Y / 2))
    {
        if (0 < this.Tactical.getMapSize().X)
        {
            if (this.Tactical.getTileSquare(0, (this.Tactical.getMapSize().Y - 1)).IsEmpty)
            {
                [].push({});
            }
        }
    }
    else
    {
        if (0 < this.Tactical.getMapSize().X)
        {
            if (this.Tactical.getTileSquare(0, 0).IsEmpty)
            {
                [].push({});
            }
        }
    }
    [].sort(this.onSortByLowestScore);
    this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
    this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
    this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
    this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
    this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
    this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = false;
    this.Tactical.getNavigator().createSettings().ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
    this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
    this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
    foreach (local key, value in r56)
    {
        if ((0 + 7) > this.Const.AI.Behavior.RetreatSoftMaxAttempts)
        {
        }
        if (!this.Tactical.getNavigator().findPath(_entity.getTile(), null.Tile, this.Tactical.getNavigator().createSettings(), 0))
        {
        }
        else
        {
            if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End))
            {
                return (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End);
            }
            if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).ActionPointsRequired < 9000))
            {
            }
            if (null.Tile != null)
            {
                this.m.TargetTile = null.Tile;
            }
            return;
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
    if (_entity.getCurrentProperties().IsRooted)
    {
        return _entity;
    }
    if (!this.isAtMapBorder(_entity))
    {
        this.findRetreatToPosition(_entity);
        if (this.m.TargetTile == null)
        {
            return _entity;
        }
    }
    return _entity;
}

function onExecute(this, _entity)
{
    if (r4 && r4)
    {
        return (r4 && r4);
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((("* " + this.getAgent().getActor().getName()) + ": Retreated!"));
        }
        this.Tactical.EventLog.log((this.Const.UI.getColorizedEntityName(this.getAgent().getActor()) + " has retreated from battle"));
        this.getAgent().setFinished(true);
        _entity.retreat();
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
                if (this && this)
                {
                    return (this && this);
                    if (this.Const.AI.VerboseMode)
                    {
                        this.logInfo((("* " + this.getAgent().getActor().getName()) + ": Retreated!"));
                    }
                    this.Tactical.EventLog.log((this.Const.UI.getColorizedEntityName(this.getAgent().getActor()) + " has retreated from battle"));
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
