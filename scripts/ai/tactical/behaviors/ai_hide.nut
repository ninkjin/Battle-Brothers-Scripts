// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_hide.nut
// Functions: 8

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Hide;
    this.m.Order = this.Const.AI.Behavior.Order.Hide;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function onBeforeExecute(this, _entity)
{
    this.getAgent().getOrders().IsEngaging = false;
    this.getAgent().getOrders().IsDefending = false;
    this.getAgent().getIntentions().IsDefendingPosition = false;
    this.getAgent().getIntentions().IsEngaging = false;
    this.getAgent().getIntentions().IsHiding = true;
    this.m.Inertia = this.m.Inertia op43 2;
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.TargetInfo = null;
    this.m.IsHoldingPosition = false;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (this.queryTargetsInMeleeRange(this.getProperties().EngageRangeMin, this.getProperties().EngageRangeMax).len() != 0)
    {
        return _entity;
    }
    if (this.getAgent().getIntentions().IsRecuperating)
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
    this.logWarning(("hide after inertia: " + (this.getProperties().BehaviorMult["this.m.ID"] * this.Math.maxf(1.0, this.Math.minf(this.Const.AI.Behavior.HideInertiaMaxMult, (this.m.Inertia * this.Const.AI.Behavior.HideInertiaMult))))));
    this.logWarning(("hide after distance?: " + ((this.getProperties().BehaviorMult["this.m.ID"] * this.Math.maxf(1.0, this.Math.minf(this.Const.AI.Behavior.HideInertiaMaxMult, (this.m.Inertia * this.Const.AI.Behavior.HideInertiaMult)))) * (1.0 - (_entity.getTile().getDistanceTo(this.m.TargetTile) / (this.Const.AI.Behavior.HideMaxSearchRange + 1.0))))));
    this.logWarning(("hide after tactical value?: " + (((this.getProperties().BehaviorMult["this.m.ID"] * this.Math.maxf(1.0, this.Math.minf(this.Const.AI.Behavior.HideInertiaMaxMult, (this.m.Inertia * this.Const.AI.Behavior.HideInertiaMult)))) * (1.0 - (_entity.getTile().getDistanceTo(this.m.TargetTile) / (this.Const.AI.Behavior.HideMaxSearchRange + 1.0)))) * ((1.0 - this.Const.AI.Behavior.HideTerrainValueMult) + (this.Math.maxf(0.0, (this.m.TargetTile.TVTotal / 14.0)) * this.Const.AI.Behavior.HideTerrainValueMult)))));
    if ((this.m.TargetInfo.Allies.Allies != 0) && (this.m.TargetInfo.Allies.Allies != 0))
    {
        return ((this.m.TargetInfo.Allies.Allies != 0) && (this.m.TargetInfo.Allies.Allies != 0));
    }
    this.logWarning(("hide after numbers advantage?: " + ((((this.getProperties().BehaviorMult["this.m.ID"] * this.Math.maxf(1.0, this.Math.minf(this.Const.AI.Behavior.HideInertiaMaxMult, (this.m.Inertia * this.Const.AI.Behavior.HideInertiaMult)))) * (1.0 - (_entity.getTile().getDistanceTo(this.m.TargetTile) / (this.Const.AI.Behavior.HideMaxSearchRange + 1.0)))) * ((1.0 - this.Const.AI.Behavior.HideTerrainValueMult) + (this.Math.maxf(0.0, (this.m.TargetTile.TVTotal / 14.0)) * this.Const.AI.Behavior.HideTerrainValueMult))) * this.Math.minf(2.0, ((this.queryOpponentMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).Opponents * this.queryOpponentMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).AverageDistanceScore) / (this.queryAllyMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).Allies * this.queryAllyMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).AverageDistanceScore))))));
    this.logWarning(("hide after opponent close enough?: " + (((((this.getProperties().BehaviorMult["this.m.ID"] * this.Math.maxf(1.0, this.Math.minf(this.Const.AI.Behavior.HideInertiaMaxMult, (this.m.Inertia * this.Const.AI.Behavior.HideInertiaMult)))) * (1.0 - (_entity.getTile().getDistanceTo(this.m.TargetTile) / (this.Const.AI.Behavior.HideMaxSearchRange + 1.0)))) * ((1.0 - this.Const.AI.Behavior.HideTerrainValueMult) + (this.Math.maxf(0.0, (this.m.TargetTile.TVTotal / 14.0)) * this.Const.AI.Behavior.HideTerrainValueMult))) * this.Math.minf(2.0, ((this.queryOpponentMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).Opponents * this.queryOpponentMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).AverageDistanceScore) / (this.queryAllyMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).Allies * this.queryAllyMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).AverageDistanceScore)))) * ((1.0 - this.Const.AI.Behavior.HideBreakBecauseOpponentCloseMult) + (this.queryOpponentMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).AverageDistanceScore * this.Const.AI.Behavior.HideBreakBecauseOpponentCloseMult)))));
    this.logWarning(("hide after everyone engaged?: " + ((((((this.getProperties().BehaviorMult["this.m.ID"] * this.Math.maxf(1.0, this.Math.minf(this.Const.AI.Behavior.HideInertiaMaxMult, (this.m.Inertia * this.Const.AI.Behavior.HideInertiaMult)))) * (1.0 - (_entity.getTile().getDistanceTo(this.m.TargetTile) / (this.Const.AI.Behavior.HideMaxSearchRange + 1.0)))) * ((1.0 - this.Const.AI.Behavior.HideTerrainValueMult) + (this.Math.maxf(0.0, (this.m.TargetTile.TVTotal / 14.0)) * this.Const.AI.Behavior.HideTerrainValueMult))) * this.Math.minf(2.0, ((this.queryOpponentMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).Opponents * this.queryOpponentMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).AverageDistanceScore) / (this.queryAllyMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).Allies * this.queryAllyMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).AverageDistanceScore)))) * ((1.0 - this.Const.AI.Behavior.HideBreakBecauseOpponentCloseMult) + (this.queryOpponentMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).AverageDistanceScore * this.Const.AI.Behavior.HideBreakBecauseOpponentCloseMult))) * (this.Math.pow((2 - this.Math.maxf(this.queryAllyMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).AverageEngaged, this.queryOpponentMagnitude(_entity.getTile(), this.Const.AI.Behavior.HideMaxOpponentToAllyDistance).AverageEngaged)), 5) / this.Math.pow(2, 5)))));
    this.m.IsHoldingPosition = _entity.getTile().isSameTileAs(this.m.TargetTile);
    if ("IsHoldingPosition".IsRecuperating && "IsHoldingPosition".IsRecuperating)
    {
        return ("IsHoldingPosition".IsRecuperating && "IsHoldingPosition".IsRecuperating);
        return _entity;
    }
    return _entity;
}

function onExecute(this, _entity)
{
    if (!this.m.IsHoldingPosition)
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
            if (this.Const.AI.PathfindingDebugMode)
            {
                this.Tactical.getNavigator().buildVisualisation(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()));
            }
            if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).Tiles == 0))
            {
                this.getAgent().getIntentions().IsRecuperating = true;
                return _entity;
            }
            this.m.Agent.adjustCameraToDestination(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End);
            if (this.Const.AI.VerboseMode)
            {
                this.logInfo((("* " + _entity.getName()) + ": Hiding!"));
            }
            this.m.IsFirstExecuted = false;
            return;
        }
        if (!this.Tactical.getNavigator().travel(_entity, _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())))
        {
            this.m.TargetTile = null;
            this.m.TargetInfo = null;
            return _entity;
        }
    }
    this.getAgent().getIntentions().IsRecuperating = true;
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Holding hidden position."));
    }
    return _entity;
    return _entity;
}

function onQueryTargetTile(this, _tile, _tag)
{
    if ((!this.Const.AI.SecretSpectatorMode) && (!this.Const.AI.SecretSpectatorMode))
    {
        return ((!this.Const.AI.SecretSpectatorMode) && (!this.Const.AI.SecretSpectatorMode));
    }
    _tag.Tiles.push({});
    return;
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

function onTurnStarted(this)
{
    this.m.Inertia = this.Math.maxf(0, (this.m.Inertia - 1));
    return;
}

function selectBestTargetTile(this, _entity, _maxRange)
{
    this.onQueryTargetTile(_entity.getTile(), {});
    yield this;
    this.Tactical.queryTilesInRange(_entity.getTile(), 1, _maxRange, true, 0, _entity.getAlliedFactions(), this.onQueryTargetTile, {});
    yield this.Tactical.queryTilesInRange;
    {}.Tiles.sort(this.onSortByScore);
    foreach (local key, value in r123)
    {
        if (this.isAllottedTimeReached(this.Time.getExactTime()))
        {
            yield this;
        }
        if ((0 + 8) > this.Const.AI.Behavior.HideMaxAttempts)
        {
        }
        if (!null.Tile.isSameTileAs(_entity.getTile()))
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
            if (this.Tactical.getNavigator().findPath(_entity.getTile(), null.Tile, this.Tactical.getNavigator().createSettings(), 0))
            {
            }
        }
        if (((-this) + null.ScoreBonus) > -9000)
        {
        }
        if (null.Tile)
        {
            if (null && null)
            {
                return (null && null);
                this.logInfo((("* " + _entity.getName()) + ": In fact, I would prefer to remain where I am"));
            }
            this.m.TargetInfo = null;
            this.m.TargetTile = null.Tile;
            return _entity;
        }
        return _entity;
    }
}
