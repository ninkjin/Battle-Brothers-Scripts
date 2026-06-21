// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_engage_ranged.nut
// Functions: 12

function compileTargets(this, _entity, _targets, _maxRange)
{
    this.m.ValidTargets = [];
    this.m.PotentialDanger = [];
    this.m.CurrentDanger = 0.0;
    foreach (local key, value in r248)
    {
        if (null.Actor.isNull())
        {
        }
        if (this.isAllottedTimeReached(this.Time.getExactTime()))
        {
            yield this;
        }
        if ((null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions() < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones)))
        {
            return ((null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones));
            this.m.PotentialDanger.push(null.Actor);
            this.m.CurrentDanger = this.m.CurrentDanger op43 this.getDangerFromActor(null.Actor, _entity.getTile(), _entity);
        }
        if (0 < this.Const.Direction.COUNT)
        {
            if (!null.Actor.getTile().hasNextTile(0))
            {
            }
            else
            {
                if (null.Actor.getTile().getNextTile(0).IsEmpty)
                {
                }
                else
                {
                    if (null.Actor.getTile().getNextTile(0).IsOccupiedByActor)
                    {
                        if (null.Actor.getTile().getNextTile(0).getEntity().isAlliedWith(_entity))
                        {
                            if (this.getProperties().TargetPriorityHittingAlliesMult < 1.0)
                            {
                            }
                        }
                    }
                }
            }
        }
        if (null.Actor.getTile().getZoneOfControlCount(_entity.getFaction() < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones))
        {
        }
        this.m.ValidTargets.push({});
        return _entity;
    }
}

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.EngageRanged;
    this.m.Order = this.Const.AI.Behavior.Order.EngageRanged;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function getDangerFromActor(this, _actor, _target, _entity)
{
    if ((this.queryActorTurnsNearTarget(_actor, _target, _entity).InZonesOfControl < 2) && (this.queryActorTurnsNearTarget(_actor, _target, _entity).InZonesOfControl < 2))
    {
        return ((this.queryActorTurnsNearTarget(_actor, _target, _entity).InZonesOfControl < 2) && (this.queryActorTurnsNearTarget(_actor, _target, _entity).InZonesOfControl < 2));
        if (0.IsRooted && 0.IsRooted)
        {
            return (0.IsRooted && 0.IsRooted);
            return _actor;
        }
        return _actor;
    }
    return _actor;
}

function isUsedThisTurn(this)
{
    return this.m.IsUsedThisTurn;
}

function onBeforeExecute(this, _entity)
{
    if (this.m.IsWaitingAfterMove)
    {
        this.m.IsDoneThisTurn = true;
    }
    this.m.IsUsedThisTurn = true;
    this.getAgent().getOrders().IsEngaging = true;
    this.getAgent().getOrders().IsDefending = false;
    this.getAgent().getIntentions().IsDefendingPosition = false;
    this.getAgent().getIntentions().IsEngaging = true;
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.TargetScore = 0.0;
    this.m.ValidTargets = [];
    this.m.TargetDist = 0;
    this.m.TargetAPCost = 0;
    this.m.TargetDanger = 0;
    this.m.Skill = null;
    this.m.IsTargetNextToUs = false;
    this.m.IsTargetForNextTurn = false;
    this.m.IsWaiting = false;
    this.m.IsWaitingAfterMove = false;
    this.m.IsTakingCover = false;
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
    if ((this.Const.AI.Behavior.ID.Retreat != 0) && (this.Const.AI.Behavior.ID.Retreat != 0))
    {
        return ((this.Const.AI.Behavior.ID.Retreat != 0) && (this.Const.AI.Behavior.ID.Retreat != 0));
        return _entity;
    }
    if (!this.getAgent().hasKnownOpponent())
    {
        return _entity;
    }
    if (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions() > 0))
    {
        return _entity;
    }
    foreach (local key, value in r33)
    {
        if ((null > 0) && (null > 0))
        {
            return ((null > 0) && (null > 0));
            this.m.Skill = _entity.getSkills().getSkillByID(null);
        }
        if (_entity.getSkills().getSkillByID(null).getMaxRange() == 0)
        {
        }
        if (_entity.getSkills().getSkillByID(null).isVisibleTileNeeded())
        {
        }
        if (resume this == null)
        {
            yield null;
        }
        if (this.m.ValidTargets.len() == 0)
        {
            return _entity;
        }
        this.m.IsInDangerThisRound = (this.m.CurrentDanger != 0);
        if ((!this.m.IsInDangerThisRound) && (!this.m.IsInDangerThisRound))
        {
            return ((!this.m.IsInDangerThisRound) && (!this.m.IsInDangerThisRound));
            return _entity;
        }
        yield (!this.m.IsInDangerThisRound);
        if (resume this == null)
        {
            yield null;
        }
        if (this.m.TargetTile.isSameTileAs(_entity.getTile() || this.m.TargetTile.isSameTileAs(_entity.getTile())))
        {
            return (this.m.TargetTile.isSameTileAs(_entity.getTile()) || this.m.TargetTile.isSameTileAs(_entity.getTile()));
            return _entity;
        }
        if ((this.m.TargetDanger > this.m.CurrentDanger) && (this.m.TargetDanger > this.m.CurrentDanger))
        {
            return ((this.m.TargetDanger > this.m.CurrentDanger) && (this.m.TargetDanger > this.m.CurrentDanger));
            return _entity;
        }
        if ((this.getProperties().OverallDefensivenessMult != 0) && (this.getProperties().OverallDefensivenessMult != 0))
        {
            return ((this.getProperties().OverallDefensivenessMult != 0) && (this.getProperties().OverallDefensivenessMult != 0));
            if (this.Const.AI.VerboseMode)
            {
                this.logInfo((("* " + _entity.getName()) + ": It's important that I get some distance from my opponents..."));
            }
        }
        if ((this.m.TargetTile.Level > 4.Level) && (this.m.TargetTile.Level > 4.Level) && (this.m.TargetTile.Level > 4.Level))
        {
            return ((this.m.TargetTile.Level > 4.Level) && (this.m.TargetTile.Level > 4.Level) && (this.m.TargetTile.Level > 4.Level));
            if (this.Const.AI.VerboseMode)
            {
                this.logInfo((("* " + _entity.getName()) + ": Considering improving position since a clearly better one is right next to me..."));
            }
        }
        if ((this.m.TargetAPCost > 9) && (this.m.TargetAPCost > 9) && (this.m.TargetAPCost > 9))
        {
            return ((this.m.TargetAPCost > 9) && (this.m.TargetAPCost > 9) && (this.m.TargetAPCost > 9));
            this.m.IsWaiting = true;
        }
        if (this.m.IsTakingCover)
        {
            if (this.Const.AI.VerboseMode)
            {
                this.logInfo((("* " + _entity.getName()) + ": Taking cover..."));
            }
        }
        return _entity;
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
        this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
        this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
        this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
        this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
        this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
        this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = false;
        this.Tactical.getNavigator().createSettings().ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
        this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
        this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
        this.Tactical.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.Tactical.getNavigator().createSettings(), this.m.TargetDist);
        if (this.Const.AI.PathfindingDebugMode)
        {
            this.Tactical.getNavigator().buildVisualisation(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()));
        }
        if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).Tiles == 0))
        {
            return _entity;
        }
        this.m.Agent.adjustCameraToDestination(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End);
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((((("* " + _entity.getName()) + ": Engaging into firing range over ") + this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).Tiles) + " tiles"));
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
    if ((_tile.SquareCoords.Y <= 0) || (_tile.SquareCoords.Y <= 0) || (_tile.SquareCoords.Y <= 0))
    {
        return ((_tile.SquareCoords.Y <= 0) || (_tile.SquareCoords.Y <= 0) || (_tile.SquareCoords.Y <= 0));
    }
    if (_tile.IsHidingEntity)
    {
    }
    if ((!_tile.IsVisibleForPlayer) && (!_tile.IsVisibleForPlayer))
    {
        return ((!_tile.IsVisibleForPlayer) && (!_tile.IsVisibleForPlayer));
    }
    if (_tile.Properties.Effect.Applicable(_tag.Actor) && _tile.Properties.Effect.Applicable(_tag.Actor))
    {
        return (_tile.Properties.Effect.Applicable(_tag.Actor) && _tile.Properties.Effect.Applicable(_tag.Actor));
    }
    if (_tile.Properties.IsMarkedForImpact)
    {
    }
    _tag.Tiles.push({});
    return;
}

function onSortByDistance(this, _a, _b)
{
    if (_a.Distance < _b.Distance)
    {
        return _a;
    }
    else
    {
        if (_a.Distance > _b.Distance)
        {
            return _a;
        }
    }
    return _a;
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
    this.m.IsInDangerThisRound = false;
    this.m.IsDoneThisTurn = false;
    this.m.IsUsedThisTurn = false;
    return;
}

function selectBestTargetTile(this, _entity, _maxRange, _considerLineOfFire, _visibleTileNeeded)
{
    foreach (local key, value in _entity.getTile())
    {
        if (null.Tile.getDistanceTo(_entity.getTile() < 9000))
        {
        }
        if ((null.Tile.getDistanceTo(_entity.getTile() >= _maxRange) && (null.Tile.getDistanceTo(_entity.getTile()) >= _maxRange)))
        {
            return ((null.Tile.getDistanceTo(_entity.getTile()) >= _maxRange) && (null.Tile.getDistanceTo(_entity.getTile()) >= _maxRange));
            foreach (local key, value in null.Tile.getDistanceTo(_entity.getTile()))
            {
                if (!this.Tactical.isValidTile(this.Math.round(((_entity.getTile().SquareCoords.X * 0.75) + (((0 + null.Tile.SquareCoords.X) / this.m.ValidTargets.len() * 0.25))), this.Math.round(((_entity.getTile().SquareCoords.Y * 0.75) + (((0 + null.Tile.SquareCoords.Y) / this.m.ValidTargets.len()) * 0.25))))))
                {
                }
                if (this.Tactical.getTileSquare(_entity.getTile().SquareCoords.X, _entity.getTile().SquareCoords.Y).getDistanceTo(_entity.getTile() > (this.Math.min(12, this.Math.max(this.Const.AI.Behavior.RangedEngageMinQueryRadius, _maxRange)) / 2)))
                {
                }
                foreach (local key, value in _entity.getTile())
                {
                    if (null.Tile.getDistanceTo(_entity.getTile() < 9000))
                    {
                    }
                    if (null.Tile.getDistanceTo(_entity.getTile() > this.Math.min(12, this.Math.max(this.Const.AI.Behavior.RangedEngageMinQueryRadius, _maxRange))))
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
                        this.m.ValidTargets.sort(this.onSortByDistance);
                        foreach (local key, value in r70)
                        {
                            if (this.Tactical.getNavigator().findPath(_entity.getTile(), null.Tile, this.Tactical.getNavigator().createSettings(), this.Math.min(12, this.Math.max(this.Const.AI.Behavior.RangedEngageMinQueryRadius, _maxRange))))
                            {
                                if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).Tiles != 0))
                                {
                                    this.m.TargetDist = this.Math.min(12, this.Math.max(this.Const.AI.Behavior.RangedEngageMinQueryRadius, _maxRange));
                                    this.m.TargetTile = null.Tile;
                                    this.m.TargetDanger = 0;
                                    this.logDebug("No good tile in range, engaging in the general direction of the enemy!");
                                    return _entity;
                                }
                            }
                            if ((this.Tactical.State.LocationTemplate != null) && (this.Tactical.State.LocationTemplate != null))
                            {
                                return ((this.Tactical.State.LocationTemplate != null) && (this.Tactical.State.LocationTemplate != null));
                            }
                            yield (this.Tactical.getMapSize().X / 2);
                            this.onQueryTargetTile(_entity.getTile(), {});
                            this.Tactical.queryTilesInRange(_entity.getTile(), 1, this.Math.min(12, this.Math.max(this.Const.AI.Behavior.RangedEngageMinQueryRadius, _maxRange)), true, _entity.getAlliedFactions(), this.onQueryTargetTile, {});
                            if (this.isAllottedTimeReached(this.Time.getExactTime()))
                            {
                                yield this;
                            }
                            {}.Tiles.sort(this.onSortByScore);
                            foreach (local key, value in r693)
                            {
                                if (this.isAllottedTimeReached(this.Time.getExactTime()))
                                {
                                    yield this;
                                }
                                if ((this.getStrategy().getStats().EnemyRangedFiring < this.getStrategy().getStats().AllyRangedFiring) && (this.getStrategy().getStats().EnemyRangedFiring < this.getStrategy().getStats().AllyRangedFiring) && (this.getStrategy().getStats().EnemyRangedFiring < this.getStrategy().getStats().AllyRangedFiring))
                                {
                                    return ((this.getStrategy().getStats().EnemyRangedFiring < this.getStrategy().getStats().AllyRangedFiring) && (this.getStrategy().getStats().EnemyRangedFiring < this.getStrategy().getStats().AllyRangedFiring) && (this.getStrategy().getStats().EnemyRangedFiring < this.getStrategy().getStats().AllyRangedFiring));
                                    if (null.Tile.getDistanceTo(this.Tactical.getTileSquare((this.Tactical.getMapSize().X / 2), (this.Tactical.getMapSize().Y / 2)) > (this.Const.Tactical.Settings.CampRadius + this.Tactical.State.getStrategicProperties().LocationTemplate.AdditionalRadius)))
                                    {
                                    }
                                }
                                if ((null.Tile.getDistanceTo(this.Tactical.getTileSquare((this.Tactical.getMapSize().X / 2), (this.Tactical.getMapSize().Y / 2)) != 0) && (null.Tile.getDistanceTo(this.Tactical.getTileSquare((this.Tactical.getMapSize().X / 2), (this.Tactical.getMapSize().Y / 2))) != 0)))
                                {
                                    return ((null.Tile.getDistanceTo(this.Tactical.getTileSquare((this.Tactical.getMapSize().X / 2), (this.Tactical.getMapSize().Y / 2))) != 0) && (null.Tile.getDistanceTo(this.Tactical.getTileSquare((this.Tactical.getMapSize().X / 2), (this.Tactical.getMapSize().Y / 2))) != 0));
                                }
                                foreach (local key, value in r39)
                                {
                                    if (null.Tile.getDistanceTo(null.Tile) <= 1)
                                    {
                                    }
                                    else
                                    {
                                        if (null.Actor.isArmedWithMeleeWeapon() && null.Actor.isArmedWithMeleeWeapon())
                                        {
                                            return (null.Actor.isArmedWithMeleeWeapon() && null.Actor.isArmedWithMeleeWeapon());
                                        }
                                    }
                                    if (true)
                                    {
                                    }
                                    if ((this.m.Skill == r95) && (this.m.Skill == r95))
                                    {
                                        return ((this.m.Skill == r95) && (this.m.Skill == r95));
                                    }
                                    else
                                    {
                                        if ((this.m.Skill == r98) && (this.m.Skill == r98))
                                        {
                                            return ((this.m.Skill == r98) && (this.m.Skill == r98));
                                        }
                                        else
                                        {
                                            if ((this.m.Skill == r99) && (this.m.Skill == r99))
                                            {
                                                return ((this.m.Skill == r99) && (this.m.Skill == r99));
                                            }
                                            else
                                            {
                                                foreach (local key, value in r115)
                                                {
                                                    if (this.m.Skill.onVerifyTarget(null.Tile, null.Tile) && this.m.Skill.onVerifyTarget(null.Tile, null.Tile))
                                                    {
                                                        return (this.m.Skill.onVerifyTarget(null.Tile, null.Tile) && this.m.Skill.onVerifyTarget(null.Tile, null.Tile));
                                                    }
                                                    if (null.Tile.hasLineOfSightTo(null.Tile, _entity.getCurrentProperties().getVision()))
                                                    {
                                                        if (null.Tile.hasLineOfSightTo(null.Tile, _entity.getCurrentProperties().getVision()))
                                                        {
                                                            if (this.Const.Tactical.Common.getBlockedTiles(null.Tile, null.Tile, _entity.getFaction().len() != 0))
                                                            {
                                                            }
                                                            foreach (local key, value in ((((0.0 + this.Const.AI.Behavior.RangedEngageInRangeOfPolearmBonus) + (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.AttackHandgonne).selectBestTarget(null.Tile, _entity, this.m.Skill) * this.Const.AI.Behavior.RangedEngageTargetScoreMult)) + (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Miasma).selectBestTarget(null.Tile, _entity, this.m.Skill) * this.Const.AI.Behavior.RangedEngageTargetScoreMult)) + (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Horror).selectBestTarget(null.Tile, _entity, this.m.Skill) * this.Const.AI.Behavior.RangedEngageTargetScoreMult)))
                                                            {
                                                                if (_entity.getCurrentProperties().getVision() && _entity.getCurrentProperties().getVision())
                                                                {
                                                                    return (_entity.getCurrentProperties().getVision() && _entity.getCurrentProperties().getVision());
                                                                }
                                                                if ((0 + 30) > 0)
                                                                {
                                                                    if (null.Tile.Level > ((0 + null.Tile.Level) / (0 + 30)))
                                                                    {
                                                                    }
                                                                }
                                                                if (((((((0.0 + this.Const.AI.Behavior.RangedEngageInRangeOfPolearmBonus) + (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.AttackHandgonne).selectBestTarget(null.Tile, _entity, this.m.Skill) * this.Const.AI.Behavior.RangedEngageTargetScoreMult) + (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Miasma).selectBestTarget(null.Tile, _entity, this.m.Skill) * this.Const.AI.Behavior.RangedEngageTargetScoreMult)) + (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Horror).selectBestTarget(null.Tile, _entity, this.m.Skill) * this.Const.AI.Behavior.RangedEngageTargetScoreMult)) + (((null.Score * this.Const.AI.Behavior.RangedEngageBlockedMult) * (this.Const.AI.Behavior.RangedEngageBlockedByAllyMult * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult))) * this.Const.AI.Behavior.RangedEngageTargetScoreMult)) + ((null.Tile.Level - ((0 + null.Tile.Level) / (0 + 30))) * this.Const.AI.Behavior.RangedEngageLevelAdvantageMult)) <= 0))
                                                                {
                                                                }
                                                                if (this.getStrategy().getStats().RangedAlliedVSEnemies <= 3.0)
                                                                {
                                                                    foreach (local key, value in r113)
                                                                    {
                                                                        if ((null.Tile > 10) && (null.Tile > 10))
                                                                        {
                                                                            return ((null.Tile > 10) && (null.Tile > 10));
                                                                        }
                                                                        if (null.Tile.getDirection8To(null.Tile) == this.Const.Direction8.W)
                                                                        {
                                                                            []["this.Const.Direction.NW"] = []["this.Const.Direction.NW"] op43 (4 * (7.0 / null.Tile.getDistanceTo(null.Tile)));
                                                                            []["this.Const.Direction.SW"] = []["this.Const.Direction.SW"] op43 (4 * (7.0 / null.Tile.getDistanceTo(null.Tile)));
                                                                        }
                                                                        if (null.Tile.getDirection8To(null.Tile) == this.Const.Direction8.E)
                                                                        {
                                                                            []["this.Const.Direction.NE"] = []["this.Const.Direction.NE"] op43 (4 * (7.0 / null.Tile.getDistanceTo(null.Tile)));
                                                                            []["this.Const.Direction.SE"] = []["this.Const.Direction.SE"] op43 (4 * (7.0 / null.Tile.getDistanceTo(null.Tile)));
                                                                        }
                                                                        if ((null.Tile.getDirectionTo(null.Tile) - 1) >= 0)
                                                                        {
                                                                        }
                                                                        if ((null.Tile.getDirectionTo(null.Tile) + 1) < 6)
                                                                        {
                                                                        }
                                                                        []["null.Tile.getDirectionTo(null.Tile)"] = []["null.Tile.getDirectionTo(null.Tile)"] op43 (4 * (7.0 / null.Tile.getDistanceTo(null.Tile)));
                                                                        []["(6 - 1)"] = []["(6 - 1)"] op43 (3 * (7.0 / null.Tile.getDistanceTo(null.Tile)));
                                                                        []["0"] = []["0"] op43 (3 * (7.0 / null.Tile.getDistanceTo(null.Tile)));
                                                                        if ((0 + 30) != 0)
                                                                        {
                                                                            if (0 < 6)
                                                                            {
                                                                                if ([]["0"] <= 1)
                                                                                {
                                                                                }
                                                                                else
                                                                                {
                                                                                    if (!null.Tile.hasNextTile(0))
                                                                                    {
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        if ((null.Tile.getNextTile(0).ID == _entity.getTile().ID) && (null.Tile.getNextTile(0).ID == _entity.getTile().ID))
                                                                                        {
                                                                                            return ((null.Tile.getNextTile(0).ID == _entity.getTile().ID) && (null.Tile.getNextTile(0).ID == _entity.getTile().ID));
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            if ((!null.Tile.getDirectionTo(null.Tile) && (!null.Tile.getDirectionTo(null.Tile))))
                                                                                            {
                                                                                                return ((!null.Tile.getDirectionTo(null.Tile)) && (!null.Tile.getDirectionTo(null.Tile)));
                                                                                                if ((null.Tile == ((this.Const.Tactical.Settings.CampRadius + this.Tactical.State.LocationTemplate.AdditionalRadius) - 1) && (null.Tile == ((this.Const.Tactical.Settings.CampRadius + this.Tactical.State.LocationTemplate.AdditionalRadius) - 1))))
                                                                                                {
                                                                                                    return ((null.Tile == ((this.Const.Tactical.Settings.CampRadius + this.Tactical.State.LocationTemplate.AdditionalRadius) - 1)) && (null.Tile == ((this.Const.Tactical.Settings.CampRadius + this.Tactical.State.LocationTemplate.AdditionalRadius) - 1)));
                                                                                                }
                                                                                                if ((null.Tile.getNextTile(0).getEntity().getAIAgent().getBehavior(this.Const.AI.Behavior.ID.Protect) != null) && (null.Tile.getNextTile(0).getEntity().getAIAgent().getBehavior(this.Const.AI.Behavior.ID.Protect) != null) && (null.Tile.getNextTile(0).getEntity().getAIAgent().getBehavior(this.Const.AI.Behavior.ID.Protect) != null))
                                                                                                {
                                                                                                    return ((null.Tile.getNextTile(0).getEntity().getAIAgent().getBehavior(this.Const.AI.Behavior.ID.Protect) != null) && (null.Tile.getNextTile(0).getEntity().getAIAgent().getBehavior(this.Const.AI.Behavior.ID.Protect) != null) && (null.Tile.getNextTile(0).getEntity().getAIAgent().getBehavior(this.Const.AI.Behavior.ID.Protect) != null));
                                                                                                }
                                                                                                if (this.getStrategy().isDefending())
                                                                                                {
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                        if (_entity.getTile().ID == null.Tile.ID)
                                                                        {
                                                                        }
                                                                        [].push({});
                                                                        if ([].len() == 0)
                                                                        {
                                                                            return _entity;
                                                                        }
                                                                        [].sort(this.onSortByScore);
                                                                        foreach (local key, value in r271)
                                                                        {
                                                                            if (this.isAllottedTimeReached(this.Time.getExactTime()))
                                                                            {
                                                                                yield this;
                                                                            }
                                                                            if ((null != null) && (null != null))
                                                                            {
                                                                                return ((null != null) && (null != null));
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
                                                                                    if (_entity && _entity)
                                                                                    {
                                                                                        return (_entity && _entity);
                                                                                    }
                                                                                    if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).Tiles == 0) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).Tiles == 0)))
                                                                                    {
                                                                                        return ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).Tiles == 0) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).Tiles == 0));
                                                                                    }
                                                                                    if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).Tiles <= 2) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).Tiles <= 2)))
                                                                                    {
                                                                                        return ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).Tiles <= 2) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).Tiles <= 2));
                                                                                    }
                                                                                }
                                                                                foreach (local key, value in null)
                                                                                {
                                                                                    if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.isSameTileAs(null.Tile))
                                                                                    {
                                                                                    }
                                                                                    if (this.m.CurrentDanger > ((this.m.CurrentDanger + 2) + this.getProperties().EngageDangerTolerance))
                                                                                    {
                                                                                    }
                                                                                    if (null.Tile.isSameTileAs(_entity.getTile()))
                                                                                    {
                                                                                    }
                                                                                    if ((this.m.CurrentDanger < 0) && (this.m.CurrentDanger < 0))
                                                                                    {
                                                                                        return ((this.m.CurrentDanger < 0) && (this.m.CurrentDanger < 0));
                                                                                    }
                                                                                    if (null && null)
                                                                                    {
                                                                                        return (null && null);
                                                                                        if (this.Const.AI.VerboseMode)
                                                                                        {
                                                                                            this.logInfo((("* " + _entity.getName()) + ": In fact, I would prefer to remain where I am (new)"));
                                                                                        }
                                                                                        this.m.TargetDist = 0;
                                                                                        this.m.TargetTile = _entity.getTile();
                                                                                        this.m.TargetDanger = this.m.CurrentDanger;
                                                                                        this.m.TargetAPCost = 0;
                                                                                        this.m.IsTargetNextToUs = false;
                                                                                        this.m.IsTargetForNextTurn = false;
                                                                                        return _entity;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        if (null.Tile != null)
                                                                                        {
                                                                                            this.m.TargetScore = (((0 - ((0 + this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired) + this.Const.AI.Behavior.RangedEngageNegativeEffecAtStop)) + null.TileScore) - (this.m.CurrentDanger * this.Const.AI.Behavior.RangedEngageDangerMult));
                                                                                            this.m.TargetDist = 0;
                                                                                            this.m.TargetTile = null.Tile;
                                                                                            this.m.TargetDanger = this.m.CurrentDanger;
                                                                                            this.m.TargetAPCost = ((0 + this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired) + this.Const.AI.Behavior.RangedEngageNegativeEffecAtStop);
                                                                                            this.m.IsTargetNextToUs = false;
                                                                                            this.m.IsTargetForNextTurn = true;
                                                                                            this.m.IsTakingCover = null.IsTakingCover;
                                                                                            return _entity;
                                                                                        }
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
    }
}
