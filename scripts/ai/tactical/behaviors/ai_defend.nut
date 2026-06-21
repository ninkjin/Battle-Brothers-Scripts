// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_defend.nut
// Functions: 9

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Defend;
    this.m.Order = this.Const.AI.Behavior.Order.Defend;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function onBeforeExecute(this, _entity)
{
    this.getAgent().getOrders().IsEngaging = false;
    this.getAgent().getOrders().IsDefending = true;
    this.getAgent().getIntentions().IsDefendingPosition = true;
    this.getAgent().getIntentions().IsEngaging = false;
    if (this.m.IsWaitingAfterMove)
    {
        this.m.IsDoneThisTurn = true;
    }
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.TargetInfo = null;
    this.m.IsHoldingPosition = false;
    this.m.IsWaitingAfterMove = false;
    this.m.IsWaitingBeforeMove = false;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if ((this.Const.Movement.AutoEndTurnBelowAP < r5) && (this.Const.Movement.AutoEndTurnBelowAP < r5))
    {
        return ((this.Const.Movement.AutoEndTurnBelowAP < r5) && (this.Const.Movement.AutoEndTurnBelowAP < r5));
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
    if ((this.Const.Faction.Player == this.Const.Faction.PlayerAnimals) && (this.Const.Faction.Player == this.Const.Faction.PlayerAnimals))
    {
        return ((this.Const.Faction.Player == this.Const.Faction.PlayerAnimals) && (this.Const.Faction.Player == this.Const.Faction.PlayerAnimals));
        return _entity;
    }
    if (!this.getStrategy().isDefending())
    {
        return _entity;
    }
    if ((!this) && (!this))
    {
        return ((!this) && (!this));
        return _entity;
    }
    if (0 && 0)
    {
        return (0 && 0);
        return _entity;
    }
    if (!this.getAgent().hasKnownOpponent())
    {
        return _entity;
    }
    if (this.queryTargetsInMeleeRange(this.getProperties().EngageRangeMin, this.getProperties().EngageRangeMax).len() != 0)
    {
        return _entity;
    }
    if ((!this.isKindOf(_entity.get(), "lindwurm") && (!this.isKindOf(_entity.get(), "lindwurm")) && (!this.isKindOf(_entity.get(), "lindwurm")) && (!this.isKindOf(_entity.get(), "lindwurm")) && (!this.isKindOf(_entity.get(), "lindwurm"))))
    {
        return ((!this.isKindOf(_entity.get(), "lindwurm")) && (!this.isKindOf(_entity.get(), "lindwurm")) && (!this.isKindOf(_entity.get(), "lindwurm")) && (!this.isKindOf(_entity.get(), "lindwurm")) && (!this.isKindOf(_entity.get(), "lindwurm")));
        foreach (local key, value in r27)
        {
            if ((null.getActionPoints() >= 4) && (null.getActionPoints() >= 4) && (null.getActionPoints() >= 4))
            {
                return ((null.getActionPoints() >= 4) && (null.getActionPoints() >= 4) && (null.getActionPoints() >= 4));
            }
            if (true)
            {
                this.m.IsWaitingBeforeMove = true;
                return _entity;
            }
            if (this.getAgent().getIntentions().IsDefendingPosition)
            {
            }
            if (this.getAgent().getIntentions().IntermediateTargetTile == null)
            {
            }
            if (this.getAgent().getIntentions().TargetTile.IsBadTerrain && this.getAgent().getIntentions().TargetTile.IsBadTerrain)
            {
                return (this.getAgent().getIntentions().TargetTile.IsBadTerrain && this.getAgent().getIntentions().TargetTile.IsBadTerrain);
            }
            if (this.getAgent().getIntentions().TargetTile.Properties.Effect.Applicable(_entity) && this.getAgent().getIntentions().TargetTile.Properties.Effect.Applicable(_entity) && this.getAgent().getIntentions().TargetTile.Properties.Effect.Applicable(_entity))
            {
                return (this.getAgent().getIntentions().TargetTile.Properties.Effect.Applicable(_entity) && this.getAgent().getIntentions().TargetTile.Properties.Effect.Applicable(_entity) && this.getAgent().getIntentions().TargetTile.Properties.Effect.Applicable(_entity));
            }
            if (resume this == null)
            {
                yield null;
            }
            if (this.m.TargetTile == null)
            {
                return _entity;
            }
            this.m.IsHoldingPosition = _entity.getTile().isSameTileAs(this.m.TargetTile);
            if ("IsHoldingPosition".IsRecuperating && "IsHoldingPosition".IsRecuperating)
            {
                return ("IsHoldingPosition".IsRecuperating && "IsHoldingPosition".IsRecuperating);
                return _entity;
            }
            else
            {
                if ("IsHoldingPosition".IsRecuperating && "IsHoldingPosition".IsRecuperating)
                {
                    return ("IsHoldingPosition".IsRecuperating && "IsHoldingPosition".IsRecuperating);
                    if ((0 > 0) && (0 > 0))
                    {
                        return ((0 > 0) && (0 > 0));
                    }
                }
            }
            return _entity;
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
        return _entity;
    }
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
            this.m.Agent.adjustCameraToDestination(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End);
            if (this.Const.AI.VerboseMode)
            {
                this.logInfo((("* " + _entity.getName()) + ": Going for defensive position."));
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
    if (this.Tactical.TurnSequenceBar && this.Tactical.TurnSequenceBar)
    {
        return (this.Tactical.TurnSequenceBar && this.Tactical.TurnSequenceBar);
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((("* " + _entity.getName()) + ": Waiting until others have moved!"));
        }
    }
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Holding defensive position."));
    }
    this.getAgent().getIntentions().IsRecuperating = true;
    this.m.TargetTile = null;
    this.m.TargetInfo = null;
    return _entity;
    return _entity;
}

function onQueryTargetTile(this, _tile, _tag)
{
    if (_tile.Properties.Effect.Applicable(_tag.Actor) && _tile.Properties.Effect.Applicable(_tag.Actor))
    {
        return (_tile.Properties.Effect.Applicable(_tag.Actor) && _tile.Properties.Effect.Applicable(_tag.Actor));
    }
    if (0 < 6)
    {
        if (!_tile.hasNextTile(0))
        {
        }
        else
        {
            if (!_tile.getNextTile(0).IsEmpty)
            {
            }
        }
    }
    _tag.Tiles.push({});
    return;
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

function onTurnStarted(this)
{
    this.m.IsDoneThisTurn = false;
    return;
}

function selectBestTargetTile(this, _entity, _targetTile, _maxRange, _potentialDanger)
{
    yield r10;
    this.onQueryTargetTile(_entity.getTile(), {});
    this.Tactical.queryTilesInRange(_entity.getTile(), 1, _maxRange, true, this.Const.AI.Behavior.DefendTerrainMinTV, _entity.getAlliedFactions(), this.onQueryTargetTile, {});
    yield this.Tactical.queryTilesInRange;
    {}.Tiles.sort(this.onSortByScore);
    foreach (local key, value in r27)
    {
        if (null.Actor.isNull())
        {
        }
        if ((this <= 8) && (this <= 8))
        {
            return ((this <= 8) && (this <= 8));
            [].push(null.Actor);
        }
        if ([].len() == 0)
        {
        }
        foreach (local key, value in null)
        {
            if (null.Actor.isNull())
            {
            }
            [].push(null.Actor);
            if ((this.Tactical.State.LocationTemplate != null) && (this.Tactical.State.LocationTemplate != null))
            {
                return ((this.Tactical.State.LocationTemplate != null) && (this.Tactical.State.LocationTemplate != null));
            }
            foreach (local key, value in r759)
            {
                if (this.isAllottedTimeReached(this.Time.getExactTime()))
                {
                    yield this;
                }
                if ((0 + 11) > this.Const.AI.Behavior.DefendMaxAttempts)
                {
                }
                if (this.getStrategy().isDefendingCamp())
                {
                    if (null.Tile.getDistanceTo(this.Tactical.getTileSquare((this.Tactical.getMapSize().X / 2), (this.Tactical.getMapSize().Y / 2)) > ((this.Const.Tactical.Settings.CampRadius + this.Tactical.State.getStrategicProperties().LocationTemplate.AdditionalRadius) + 1)))
                    {
                    }
                    else
                    {
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
                                if (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).IsComplete))
                                {
                                    if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).Tiles == 0))
                                    {
                                    }
                                }
                                if (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).IsComplete))
                                {
                                    foreach (local key, value in true)
                                    {
                                        if (this.isAllottedTimeReached(this.Time.getExactTime()))
                                        {
                                            yield this;
                                        }
                                        if (this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End, _entity).Turns <= 1.0))
                                        {
                                        }
                                        if (true)
                                        {
                                            null.ScoreBonus = (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.TVTotal * this.Const.AI.Behavior.DefendTerrainValueMult);
                                        }
                                        if (this.isRangedUnit(_entity))
                                        {
                                            foreach (local key, value in [])
                                            {
                                                if (this.queryActorTurnsNearTarget(null, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End, _entity).Turns <= 1.0))
                                                {
                                                    null.ScoreBonus = null.ScoreBonus op45 this.Const.AI.Behavior.DefendRangedWeaponDanger;
                                                }
                                                foreach (local key, value in r109)
                                                {
                                                    if (this.isRangedUnit(null))
                                                    {
                                                    }
                                                    if (null.Tile.getDirection8To(null.getTile() == this.Const.Direction8.W))
                                                    {
                                                        []["this.Const.Direction.NW"] = []["this.Const.Direction.NW"] op43 (4 * (1 * (7.0 / null.Tile.getDistanceTo(null.getTile()))));
                                                        []["this.Const.Direction.SW"] = []["this.Const.Direction.SW"] op43 (4 * (1 * (7.0 / null.Tile.getDistanceTo(null.getTile()))));
                                                    }
                                                    if (null.Tile.getDirection8To(null.getTile() == this.Const.Direction8.E))
                                                    {
                                                        []["this.Const.Direction.NE"] = []["this.Const.Direction.NE"] op43 (4 * (1 * (7.0 / null.Tile.getDistanceTo(null.getTile()))));
                                                        []["this.Const.Direction.SE"] = []["this.Const.Direction.SE"] op43 (4 * (1 * (7.0 / null.Tile.getDistanceTo(null.getTile()))));
                                                    }
                                                    if ((null.Tile.getDirectionTo(null.getTile() - 1) >= 0))
                                                    {
                                                    }
                                                    if ((null.Tile.getDirectionTo(null.getTile() + 1) < 6))
                                                    {
                                                    }
                                                    []["null.Tile.getDirectionTo(null.getTile())"] = []["null.Tile.getDirectionTo(null.getTile())"] op43 (4 * (1 * (7.0 / null.Tile.getDistanceTo(null.getTile()))));
                                                    []["(6 - 1)"] = []["(6 - 1)"] op43 (3 * (1 * (7.0 / null.Tile.getDistanceTo(null.getTile()))));
                                                    []["0"] = []["0"] op43 (3 * (1 * (7.0 / null.Tile.getDistanceTo(null.getTile()))));
                                                    if ((!null.Tile.getDirection8To(null.getTile()) && (!null.Tile.getDirection8To(null.getTile()))))
                                                    {
                                                        return ((!null.Tile.getDirection8To(null.getTile())) && (!null.Tile.getDirection8To(null.getTile())));
                                                        if (0 < 6)
                                                        {
                                                            if (!null.Tile.hasNextTile(0))
                                                            {
                                                            }
                                                            else
                                                            {
                                                                if ((!this.isRangedUnit(null.Tile.getNextTile(0).getEntity()) && (!this.isRangedUnit(null.Tile.getNextTile(0).getEntity())) && (!this.isRangedUnit(null.Tile.getNextTile(0).getEntity()))))
                                                                {
                                                                    return ((!this.isRangedUnit(null.Tile.getNextTile(0).getEntity())) && (!this.isRangedUnit(null.Tile.getNextTile(0).getEntity())) && (!this.isRangedUnit(null.Tile.getNextTile(0).getEntity())));
                                                                }
                                                            }
                                                        }
                                                    }
                                                    if (((([]["0"] / [].len() * this.Const.AI.Behavior.DefendSeekCoverMult).TargetAttractionMult <= this.Const.AI.Behavior.DefendSeekCoverMult) && ((([]["0"] / [].len()) * this.Const.AI.Behavior.DefendSeekCoverMult).TargetAttractionMult <= this.Const.AI.Behavior.DefendSeekCoverMult)))
                                                    {
                                                        return (((([]["0"] / [].len()) * this.Const.AI.Behavior.DefendSeekCoverMult).TargetAttractionMult <= this.Const.AI.Behavior.DefendSeekCoverMult) && ((([]["0"] / [].len()) * this.Const.AI.Behavior.DefendSeekCoverMult).TargetAttractionMult <= this.Const.AI.Behavior.DefendSeekCoverMult));
                                                        if (0 < 6)
                                                        {
                                                            if (!null.Tile.hasNextTile(0))
                                                            {
                                                            }
                                                            else
                                                            {
                                                                if (!null.Tile.getNextTile(0).IsOccupiedByActor)
                                                                {
                                                                }
                                                                else
                                                                {
                                                                    if (null.Tile.getNextTile(0).getEntity().getFaction() == _entity.getFaction())
                                                                    {
                                                                        if (1.0 && 1.0)
                                                                        {
                                                                            return (1.0 && 1.0);
                                                                            [].push(null.Tile.getNextTile(0).getEntity());
                                                                        }
                                                                        else
                                                                        {
                                                                            if ((!_entity) && (!_entity))
                                                                            {
                                                                                return ((!_entity) && (!_entity));
                                                                                [].push(null.Tile.getNextTile(0).getEntity());
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        if ([].len() == 0)
                                                        {
                                                        }
                                                        foreach (local key, value in r134)
                                                        {
                                                            [].push(null.getTile().getDirectionTo(null.Tile));
                                                            if (([]["0"] - 1) >= 0)
                                                            {
                                                            }
                                                            [].push((this.Const.Direction.COUNT - 1));
                                                            if (([]["0"] + 1) < this.Const.Direction.COUNT)
                                                            {
                                                            }
                                                            [].push(0);
                                                            foreach (local key, value in r53)
                                                            {
                                                                if (!null.getTile().hasNextTile(null))
                                                                {
                                                                }
                                                                else
                                                                {
                                                                    if (null && null)
                                                                    {
                                                                        return (null && null);
                                                                    }
                                                                    else
                                                                    {
                                                                        if (null.getTile().getNextTile(null).IsOccupiedByActor)
                                                                        {
                                                                            if (_entity && _entity)
                                                                            {
                                                                                return (_entity && _entity);
                                                                            }
                                                                        }
                                                                        else
                                                                        {
                                                                            if (!true)
                                                                            {
                                                                            }
                                                                            if (this.getStrategy().isDefendingCamp())
                                                                            {
                                                                                if ((!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).IsComplete) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).IsComplete)))
                                                                                {
                                                                                    return ((!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).IsComplete) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).IsComplete));
                                                                                    if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End.getDistanceTo(this.Tactical.getTileSquare((this.Tactical.getMapSize().X / 2), (this.Tactical.getMapSize().Y / 2))) > ((this.Const.Tactical.Settings.CampRadius + this.Tactical.State.getStrategicProperties().LocationTemplate.AdditionalRadius) + 1)))
                                                                                    {
                                                                                        null.ScoreBonus = null.ScoreBonus op45 this.Const.AI.Behavior.DefendAtPalisadeBonus;
                                                                                    }
                                                                                }
                                                                                if ((null.Tile.getDistanceTo(this.Tactical.getTileSquare((this.Tactical.getMapSize().X / 2), (this.Tactical.getMapSize().Y / 2)) == ((this.Const.Tactical.Settings.CampRadius + this.Tactical.State.LocationTemplate.AdditionalRadius) - 1)) && (null.Tile.getDistanceTo(this.Tactical.getTileSquare((this.Tactical.getMapSize().X / 2), (this.Tactical.getMapSize().Y / 2))) == ((this.Const.Tactical.Settings.CampRadius + this.Tactical.State.LocationTemplate.AdditionalRadius) - 1))))
                                                                                {
                                                                                    return ((null.Tile.getDistanceTo(this.Tactical.getTileSquare((this.Tactical.getMapSize().X / 2), (this.Tactical.getMapSize().Y / 2))) == ((this.Const.Tactical.Settings.CampRadius + this.Tactical.State.LocationTemplate.AdditionalRadius) - 1)) && (null.Tile.getDistanceTo(this.Tactical.getTileSquare((this.Tactical.getMapSize().X / 2), (this.Tactical.getMapSize().Y / 2))) == ((this.Const.Tactical.Settings.CampRadius + this.Tactical.State.LocationTemplate.AdditionalRadius) - 1)));
                                                                                    null.ScoreBonus = null.ScoreBonus op43 this.Const.AI.Behavior.DefendAtPalisadeBonus;
                                                                                }
                                                                            }
                                                                            if (((((0 + this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).ActionPointsRequired) - null.ScoreBonus) - (0.0 + (((([]["[]["0"]"] / [].len()) * this.Const.AI.Behavior.DefendImportantAllyPosMult) * 1.0) * null.getCurrentProperties().TargetAttractionMult))) - (0.0 + (([]["0"] / [].len()) * this.Const.AI.Behavior.DefendSeekCoverMult))) < 9000))
                                                                            {
                                                                            }
                                                                            if ((true == true) && (true == true))
                                                                            {
                                                                                return ((true == true) && (true == true));
                                                                                this.m.TargetInfo = null;
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
