// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_roam.nut
// Functions: 5

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Roam;
    this.m.Order = this.Const.AI.Behavior.Order.Roam;
    this.behavior.create();
    return;
}

function findRandomPosition(this, _entity)
{
    this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
    this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
    this.Tactical.getNavigator().createSettings().FatigueCostFactor = this.Const.Movement.FatigueCostFactor;
    this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
    this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
    this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
    if (this.getProperties().OverallHideMult >= 1)
    {
    }
    this.Tactical.getNavigator().createSettings().HiddenCost = 0;
    if ((1 + 5) < this.Const.AI.Behavior.RoamMaxAttempts)
    {
        if (!this.Tactical.isValidTile((_entity.getTile().X + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange), (((_entity.getTile().Y + (_entity.getTile().X / 2)) + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)) - ((_entity.getTile().X + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)) / 2)))))
        {
        }
        else
        {
            if ((this.Tactical.getTile((_entity.getTile().X + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange), (((_entity.getTile().Y + (_entity.getTile().X / 2)) + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)) - ((_entity.getTile().X + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)) / 2))).Type == this.Const.Tactical.TerrainType.Impassable) && (this.Tactical.getTile((_entity.getTile().X + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)), (((_entity.getTile().Y + (_entity.getTile().X / 2)) + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)) - ((_entity.getTile().X + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)) / 2))).Type == this.Const.Tactical.TerrainType.Impassable)))
            {
                return ((this.Tactical.getTile((_entity.getTile().X + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)), (((_entity.getTile().Y + (_entity.getTile().X / 2)) + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)) - ((_entity.getTile().X + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)) / 2))).Type == this.Const.Tactical.TerrainType.Impassable) && (this.Tactical.getTile((_entity.getTile().X + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)), (((_entity.getTile().Y + (_entity.getTile().X / 2)) + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)) - ((_entity.getTile().X + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)) / 2))).Type == this.Const.Tactical.TerrainType.Impassable));
            }
            if (this.Tactical.getNavigator().findPath(_entity.getTile(), this.Tactical.getTile((_entity.getTile().X + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)), (((_entity.getTile().Y + (_entity.getTile().X / 2)) + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)) - ((_entity.getTile().X + this.Math.rand((-this), this.Const.AI.Behavior.RoamMaxRange)) / 2))), this.Tactical.getNavigator().createSettings(), 0))
            {
                if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).Tiles == 0))
                {
                }
                return _entity;
            }
            return _entity;
        }
    }
}

function onBeforeExecute(this, _entity)
{
    this.getAgent().getOrders().IsEngaging = false;
    this.getAgent().getOrders().IsDefending = false;
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    if (!this.Tactical.State.isScenarioMode())
    {
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
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (this.getAgent().hasKnownOpponent())
    {
        return _entity;
    }
    if (_entity.getTile().hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
    {
        return _entity;
    }
    this.m.TargetTile = this.findRandomPosition(_entity);
    if ((this.Math <= this.Const.AI.Behavior.RoamChance) && (this.Math <= this.Const.AI.Behavior.RoamChance))
    {
        return ((this.Math <= this.Const.AI.Behavior.RoamChance) && (this.Math <= this.Const.AI.Behavior.RoamChance));
        return _entity;
    }
    return _entity;
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
        this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
        this.Tactical.getNavigator().createSettings().FatigueCostFactor = this.Const.Movement.FatigueCostFactor;
        this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
        this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
        this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((("* " + _entity.getName()) + ": Roaming."));
        }
        this.Tactical.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.Tactical.getNavigator().createSettings(), 0);
        if (this.Const.AI.PathfindingDebugMode)
        {
            this.Tactical.getNavigator().buildVisualisation(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()));
        }
        this.m.Agent.adjustCameraToDestination(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End);
        this.m.IsFirstExecuted = false;
        return;
    }
    if (!this.Tactical.getNavigator().travel(_entity, _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())))
    {
        this.m.TargetTile = null;
        return _entity;
    }
    return _entity;
}
