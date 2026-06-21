// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_protect.nut
// Functions: 10

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Protect;
    this.m.Order = this.Const.AI.Behavior.Order.Protect;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function isDoneThisTurn(this)
{
    return this.m.IsDoneThisTurn;
}

function onBeforeExecute(this, _entity)
{
    this.getAgent().getOrders().IsEngaging = false;
    this.getAgent().getOrders().IsDefending = true;
    this.getAgent().getIntentions().IsDefendingPosition = true;
    this.getAgent().getIntentions().IsEngaging = false;
    if (this.m.IsHoldingPosition && this.m.IsHoldingPosition)
    {
        return (this.m.IsHoldingPosition && this.m.IsHoldingPosition);
        this.m.IsDoneThisTurn = true;
    }
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.IsWaitingAfterMove = false;
    this.m.IsHoldingPosition = false;
    this.m.IsWaitingBeforeMove = false;
    if ((this.getProperties().BehaviorMult["this.m.ID"] == this.Const.Movement.AutoEndTurnBelowAP) && (this.getProperties().BehaviorMult["this.m.ID"] == this.Const.Movement.AutoEndTurnBelowAP))
    {
        return ((this.getProperties().BehaviorMult["this.m.ID"] == this.Const.Movement.AutoEndTurnBelowAP) && (this.getProperties().BehaviorMult["this.m.ID"] == this.Const.Movement.AutoEndTurnBelowAP));
        return _entity;
    }
    if (this.m.IsDoneThisTurn)
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
    if (this.getStrategy().isDefending && this.getStrategy().isDefending)
    {
        return (this.getStrategy().isDefending && this.getStrategy().isDefending);
        return _entity;
    }
    if (_entity.getTile().hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
    {
        return _entity;
    }
    foreach (local key, value in r62)
    {
        if ((1.0 == null) && (1.0 == null))
        {
            return ((1.0 == null) && (1.0 == null));
            if ((!null.getCurrentProperties().IsRooted) && (!null.getCurrentProperties().IsRooted) && (!null.getCurrentProperties().IsRooted))
            {
                return ((!null.getCurrentProperties().IsRooted) && (!null.getCurrentProperties().IsRooted) && (!null.getCurrentProperties().IsRooted));
                if (null.getTile().getDistanceTo(_entity.getTile() == 1))
                {
                }
            }
        }
        if ((0 + 5) == 0)
        {
            return _entity;
        }
        if (this.Tactical.TurnSequenceBar.canEntityWait(_entity) && this.Tactical.TurnSequenceBar.canEntityWait(_entity) && this.Tactical.TurnSequenceBar.canEntityWait(_entity))
        {
            return (this.Tactical.TurnSequenceBar.canEntityWait(_entity) && this.Tactical.TurnSequenceBar.canEntityWait(_entity) && this.Tactical.TurnSequenceBar.canEntityWait(_entity));
            this.m.IsWaitingBeforeMove = true;
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
        if (this.Const.AI.Behavior.Score.Zero && this.Const.AI.Behavior.Score.Zero)
        {
            return (this.Const.AI.Behavior.Score.Zero && this.Const.AI.Behavior.Score.Zero);
            if (this.m.IsHoldingPosition)
            {
                return _entity;
            }
            this.m.IsHoldingPosition = true;
        }
        return _entity;
    }
}

function onExecute(this, _entity)
{
    if (this.m.IsWaitingBeforeMove)
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
    }
    if (this.m.IsHoldingPosition)
    {
        return _entity;
    }
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
            this.logInfo((("* " + _entity.getName()) + ": Going for protective position."));
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

function onTurnResumed(this)
{
    this.m.IsDoneThisTurn = false;
    return;
}

function onTurnStarted(this)
{
    this.m.IsDoneThisTurn = false;
    return;
}

function selectBestTargetTile(this, _entity)
{
    foreach (local key, value in r420)
    {
        if (null.getMoraleState() == this.Const.MoraleState.Fleeing)
        {
        }
        else
        {
            if ((1.0.TargetAttractionMult <= r12.TargetAttractionMult) && (1.0.TargetAttractionMult <= r12.TargetAttractionMult))
            {
                return ((1.0.TargetAttractionMult <= r12.TargetAttractionMult) && (1.0.TargetAttractionMult <= r12.TargetAttractionMult));
            }
            if ((!2.ProtectFarAway) && (!2.ProtectFarAway))
            {
                return ((!2.ProtectFarAway) && (!2.ProtectFarAway));
            }
            if (this.isAllottedTimeReached(this.Time.getExactTime()))
            {
                yield this;
            }
            foreach (local key, value in r131)
            {
                if (r21 && r21)
                {
                    return (r21 && r21);
                }
                if (null.Actor.getTile().getDistanceTo(null.getTile() <= 6))
                {
                }
                if (null.getTile().getDirection8To(null.Actor.getTile() == this.Const.Direction8.W))
                {
                    []["this.Const.Direction.NW"] = []["this.Const.Direction.NW"] op43 (4 * this.Math.maxf(0.0, (1.0 - (null.Actor.getTile().getDistanceTo(null.getTile()) / 6.0))));
                    []["this.Const.Direction.SW"] = []["this.Const.Direction.SW"] op43 (4 * this.Math.maxf(0.0, (1.0 - (null.Actor.getTile().getDistanceTo(null.getTile()) / 6.0))));
                }
                if (null.getTile().getDirection8To(null.Actor.getTile() == this.Const.Direction8.E))
                {
                    []["this.Const.Direction.NE"] = []["this.Const.Direction.NE"] op43 (4 * this.Math.maxf(0.0, (1.0 - (null.Actor.getTile().getDistanceTo(null.getTile()) / 6.0))));
                    []["this.Const.Direction.SE"] = []["this.Const.Direction.SE"] op43 (4 * this.Math.maxf(0.0, (1.0 - (null.Actor.getTile().getDistanceTo(null.getTile()) / 6.0))));
                }
                if ((null.getTile().getDirectionTo(null.Actor.getTile() - 1) >= 0))
                {
                }
                if ((null.getTile().getDirectionTo(null.Actor.getTile() + 1) < 6))
                {
                }
                []["null.getTile().getDirectionTo(null.Actor.getTile())"] = []["null.getTile().getDirectionTo(null.Actor.getTile())"] op43 (4 * this.Math.maxf(0.0, (1.0 - (null.Actor.getTile().getDistanceTo(null.getTile()) / 6.0))));
                []["(6 - 1)"] = []["(6 - 1)"] op43 (3 * this.Math.maxf(0.0, (1.0 - (null.Actor.getTile().getDistanceTo(null.getTile()) / 6.0))));
                []["0"] = []["0"] op43 (3 * this.Math.maxf(0.0, (1.0 - (null.Actor.getTile().getDistanceTo(null.getTile()) / 6.0))));
                if (0 != 6)
                {
                    []["0"] = []["0"] op47 this.Math.maxf(1.0, (0 + 13));
                    if (!null.getTile().hasNextTile(0))
                    {
                    }
                    else
                    {
                        if ((null.getTile().getNextTile(0).ID != _entity.getTile().ID) && (null.getTile().getNextTile(0).ID != _entity.getTile().ID))
                        {
                            return ((null.getTile().getNextTile(0).ID != _entity.getTile().ID) && (null.getTile().getNextTile(0).ID != _entity.getTile().ID));
                        }
                        else
                        {
                            if (0 != 6)
                            {
                                if (!null.getTile().getNextTile(0).hasNextTile(0))
                                {
                                }
                                else
                                {
                                    if (!null.getTile().getNextTile(0).getNextTile(0).IsOccupiedByActor)
                                    {
                                    }
                                    else
                                    {
                                        if (this.Math.abs((null.getTile().getNextTile(0).Level - null.getTile().getNextTile(0).getNextTile(0).Level) > 1))
                                        {
                                        }
                                        else
                                        {
                                            if (!_entity.isAlliedWith(null.getTile().getNextTile(0).getNextTile(0).getEntity()))
                                            {
                                            }
                                            else
                                            {
                                                if ((1.0.TargetAttractionMult > null.getTile().getNextTile(0).getNextTile(0).getEntity().TargetAttractionMult) && (1.0.TargetAttractionMult > null.getTile().getNextTile(0).getNextTile(0).getEntity().TargetAttractionMult))
                                                {
                                                    return ((1.0.TargetAttractionMult > null.getTile().getNextTile(0).getNextTile(0).getEntity().TargetAttractionMult) && (1.0.TargetAttractionMult > null.getTile().getNextTile(0).getNextTile(0).getEntity().TargetAttractionMult));
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            if (this.hasNegativeTileEffect(null.getTile().getNextTile(0), _entity))
                            {
                            }
                            foreach (local key, value in r31)
                            {
                                if (null.Tile.ID == null.getTile().getNextTile(0).ID)
                                {
                                    null.AllyDefendBonus = null.AllyDefendBonus op43 (null.getCurrentProperties().TargetAttractionMult * this.Const.AI.Behavior.ProtectAllyAttractionBonus);
                                    null.TileBonus = null.TileBonus op43 ([]["0"] + ((0 + this.Const.AI.Behavior.ProtectAllyEngagedBonus) - this.Const.AI.Behavior.ProtectAllyTileEffectPenalty));
                                    null.Score = null.Score op43 ((((1 + (([]["0"] / this.Math.max(1, this.getAgent().getKnownOpponents().len())) * this.Const.AI.Behavior.ProtectAllyDirectionMult)) - _entity.getTile().getDistanceTo(null.getTile().getNextTile(0))) * null.getCurrentProperties().TargetAttractionMult) + ((0 + this.Const.AI.Behavior.ProtectAllyEngagedBonus) - this.Const.AI.Behavior.ProtectAllyTileEffectPenalty));
                                }
                                if (!true)
                                {
                                    [].push({});
                                }
                                if ([].len() == 0)
                                {
                                    return _entity;
                                }
                                [].sort(this.onSortByScore);
                                this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
                                this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
                                this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
                                this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
                                this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
                                this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = false;
                                this.Tactical.getNavigator().createSettings().ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
                                this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
                                this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
                                foreach (local key, value in r114)
                                {
                                    if (this.isAllottedTimeReached(this.Time.getExactTime()))
                                    {
                                        yield this;
                                    }
                                    if ((0 + 11) > this.Const.AI.Behavior.DefendMaxAttempts)
                                    {
                                    }
                                    if (!null.Tile.isSameTileAs(_entity.getTile()))
                                    {
                                        if (this.Tactical.getNavigator().findPath(_entity.getTile(), null.Tile, this.Tactical.getNavigator().createSettings(), 0))
                                        {
                                            if (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).IsComplete))
                                            {
                                                if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).Tiles == 0))
                                                {
                                                }
                                            }
                                        }
                                    }
                                    if (null.Score <= 0)
                                    {
                                    }
                                    if ((((null.TileBonus * this.Const.AI.Behavior.ProtectAllyDirectionMult) + null.AllyDefendBonus) - ((0 + this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).ActionPointsRequired) * this.Const.AI.Behavior.ProtectAllyAPCostMult)) > -9000))
                                    {
                                    }
                                    if ((true == true) && (true == true))
                                    {
                                        return ((true == true) && (true == true));
                                        if ((true == true) && (true == true))
                                        {
                                            return ((true == true) && (true == true));
                                            this.logInfo((("* " + _entity.getName()) + ": In fact, I would prefer to remain where I am"));
                                        }
                                        this.m.TargetTile = null.Tile;
                                        this.m.IsWaitingAfterMove = true;
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
