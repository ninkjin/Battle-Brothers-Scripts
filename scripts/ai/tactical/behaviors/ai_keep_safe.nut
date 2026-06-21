// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_keep_safe.nut
// Functions: 10

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.KeepSafe;
    this.m.Order = this.Const.AI.Behavior.Order.KeepSafe;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function getDangerFromActor(this, _actor, _target, _entity)
{
    if (this.queryActorTurnsNearTarget(_actor, _target, _entity).Turns <= this.Const.AI.Behavior.RangedEngageKeepMinTurnsAway)
    {
        if (0.IsStunned && 0.IsStunned)
        {
            return (0.IsStunned && 0.IsStunned);
            return _actor;
        }
        return _actor;
    }
    return _actor;
}

function onBeforeExecute(this, _entity)
{
    this.getAgent().getOrders().IsEngaging = false;
    this.getAgent().getOrders().IsDefending = true;
    this.getAgent().getIntentions().IsDefendingPosition = true;
    this.getAgent().getIntentions().IsEngaging = false;
    this.m.Inertia = this.m.Inertia op43 2;
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.TargetDanger = 0;
    this.m.IsTargetNextToUs = false;
    this.m.IsTargetForNextTurn = false;
    if (this.getProperties().BehaviorMult["this.m.ID"] == 0.0)
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
    if (!this.getAgent().hasKnownOpponent())
    {
        return _entity;
    }
    if (this.getAgent().getIntentions().IsEngaging)
    {
        return _entity;
    }
    if (this.queryTargetsInMeleeRange().len() != 0)
    {
        return _entity;
    }
    yield r8;
    foreach (local key, value in null)
    {
        yield null;
        if ((0.0 + this.getDangerFromActor(null, _entity.getTile(), _entity) != 0) && ((0.0 + this.getDangerFromActor(null, _entity.getTile(), _entity)) != 0))
        {
            this.m.IsInDangerThisRound = ((0.0 + this.getDangerFromActor(null, _entity.getTile(), _entity)) != 0);
            if ("IsInDangerThisRound" == null)
            {
                yield null;
            }
        }
        if ((this.m.TargetDanger >= (0.0 + this.getDangerFromActor(null, _entity.getTile(), _entity)) || (this.m.TargetDanger >= (0.0 + this.getDangerFromActor(null, _entity.getTile(), _entity))) || (this.m.TargetDanger >= (0.0 + this.getDangerFromActor(null, _entity.getTile(), _entity))) || (this.m.TargetDanger >= (0.0 + this.getDangerFromActor(null, _entity.getTile(), _entity)))))
        {
            return ((this.m.TargetDanger >= (0.0 + this.getDangerFromActor(null, _entity.getTile(), _entity))) || (this.m.TargetDanger >= (0.0 + this.getDangerFromActor(null, _entity.getTile(), _entity))) || (this.m.TargetDanger >= (0.0 + this.getDangerFromActor(null, _entity.getTile(), _entity))) || (this.m.TargetDanger >= (0.0 + this.getDangerFromActor(null, _entity.getTile(), _entity))));
            return _entity;
        }
        if (_entity.getAttackedCount() > 1)
        {
        }
        return _entity;
    }
}

function onExecute(this, _entity)
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
        this.m.Agent.adjustCameraToDestination(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End);
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((("* " + _entity.getName()) + ": Moving into safer position"));
        }
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

function onQueryTargetTile(this, _tile, _tag)
{
    if (_tile.IsHidingEntity)
    {
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

function onTurnStarted(this)
{
    this.m.IsInDangerThisRound = false;
    return;
}

function selectBestTargetTile(this, _entity, _maxRange, _potentialDanger, _currentDanger)
{
    this.onQueryTargetTile(_entity.getTile(), {});
    this.Tactical.queryTilesInRange(_entity.getTile(), 1, _maxRange, true, _entity.getAlliedFactions(), this.onQueryTargetTile, {});
    yield this.Tactical.queryTilesInRange;
    {}.Tiles.sort(this.onSortByScore);
    foreach (local key, value in r224)
    {
        if (this.isAllottedTimeReached(this.Time.getExactTime()))
        {
            yield this;
        }
        if ((!null.Tile.IsEmpty) && (!null.Tile.IsEmpty))
        {
            return ((!null.Tile.IsEmpty) && (!null.Tile.IsEmpty));
        }
        if ((0 + 10) > this.Const.AI.Behavior.KeepSafeMaxAttempts)
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
                if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).Tiles == 0) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).Tiles == 0)))
                {
                    return ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).Tiles == 0) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).Tiles == 0));
                }
                if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).Tiles <= 2) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).Tiles <= 2)))
                {
                    return ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).Tiles <= 2) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).Tiles <= 2));
                }
            }
            foreach (local key, value in 0)
            {
                if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.isSameTileAs(null.Tile))
                {
                }
                if (_currentDanger > _currentDanger)
                {
                }
                if (false)
                {
                }
                if ((_currentDanger < 0) && (_currentDanger < 0))
                {
                    return ((_currentDanger < 0) && (_currentDanger < 0));
                }
                if (null.Tile)
                {
                    if (null && null)
                    {
                        return (null && null);
                        this.logInfo((("* " + _entity.getName()) + ": In fact, I would prefer to remain where I am"));
                    }
                    this.m.TargetTile = null.Tile;
                    this.m.TargetDanger = _currentDanger;
                    this.m.IsTargetNextToUs = false;
                    this.m.IsTargetForNextTurn = true;
                    return _entity;
                }
                return _entity;
            }
        }
    }
}
