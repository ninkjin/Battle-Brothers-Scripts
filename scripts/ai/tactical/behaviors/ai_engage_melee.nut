// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_engage_melee.nut
// Functions: 8

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.EngageMelee;
    this.m.Order = this.Const.AI.Behavior.Order.EngageMelee;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function isEngageRecommended(this, _entity, _tile)
{
    if (0 < 6)
    {
        if (!_tile.hasNextTile(0))
        {
        }
        else
        {
            if (!_tile.getNextTile(0).IsOccupiedByActor)
            {
            }
            else
            {
                if (_tile.getNextTile(0).getEntity() && _tile.getNextTile(0).getEntity())
                {
                    return (_tile.getNextTile(0).getEntity() && _tile.getNextTile(0).getEntity());
                }
                if ((_tile.getNextTile(0).getEntity().getActionPoints() <= 5) || (_tile.getNextTile(0).getEntity().getActionPoints() <= 5) || (_tile.getNextTile(0).getEntity().getActionPoints() <= 5))
                {
                    return ((_tile.getNextTile(0).getEntity().getActionPoints() <= 5) || (_tile.getNextTile(0).getEntity().getActionPoints() <= 5) || (_tile.getNextTile(0).getEntity().getActionPoints() <= 5));
                }
                if (_tile.getNextTile(0).getEntity().getIdealRange() >= 2)
                {
                }
                return _entity;
            }
        }
    }
    return _entity;
}

function onBeforeExecute(this, _entity)
{
    this.getAgent().getOrders().IsEngaging = true;
    this.getAgent().getOrders().IsDefending = false;
    this.getAgent().getIntentions().IsDefendingPosition = false;
    this.getAgent().getIntentions().IsEngaging = true;
    this.m.Inertia = this.m.Inertia op43 2;
    if (this.m.IsWaitingAfterMove)
    {
        this.m.IsDoneThisTurn = true;
    }
    return;
}

function onEvaluate(this, _entity)
{
    this.m.OriginTile = null;
    this.m.TargetTile = null;
    this.m.TargetActor = null;
    this.m.TargetDistance = 0;
    this.m.IsIgnoringZOC = _entity.getCurrentProperties().IsImmuneToZoneOfControl;
    this.m.IsWaitingBeforeMove = false;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if ((this.Const.Movement.AutoEndTurnBelowAP < _entity) && (this.Const.Movement.AutoEndTurnBelowAP < _entity))
    {
        return ((this.Const.Movement.AutoEndTurnBelowAP < _entity) && (this.Const.Movement.AutoEndTurnBelowAP < _entity));
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
    if (this.getAgent().getIntentions.IsRecuperating && this.getAgent().getIntentions.IsRecuperating)
    {
        return (this.getAgent().getIntentions.IsRecuperating && this.getAgent().getIntentions.IsRecuperating);
        return _entity;
    }
    if (this.Const.Faction.PlayerAnimals && this.Const.Faction.PlayerAnimals)
    {
        return (this.Const.Faction.PlayerAnimals && this.Const.Faction.PlayerAnimals);
        if ((this.getStrategy().getStats().ShortestDistanceToEnemy >= 5) || (this.getStrategy().getStats().ShortestDistanceToEnemy >= 5))
        {
            return ((this.getStrategy().getStats().ShortestDistanceToEnemy >= 5) || (this.getStrategy().getStats().ShortestDistanceToEnemy >= 5));
            return _entity;
        }
    }
    if (!this.getAgent().hasKnownOpponent())
    {
        return _entity;
    }
    if (_entity.isArmedWithMeleeWeapon() && _entity.isArmedWithMeleeWeapon() && _entity.isArmedWithMeleeWeapon() && _entity.isArmedWithMeleeWeapon() && _entity.isArmedWithMeleeWeapon())
    {
        return (_entity.isArmedWithMeleeWeapon() && _entity.isArmedWithMeleeWeapon() && _entity.isArmedWithMeleeWeapon() && _entity.isArmedWithMeleeWeapon() && _entity.isArmedWithMeleeWeapon());
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
            if (this.Tactical.TurnSequenceBar.isOpponentStillToAct(_entity) && this.Tactical.TurnSequenceBar.isOpponentStillToAct(_entity) && this.Tactical.TurnSequenceBar.isOpponentStillToAct(_entity))
            {
                return (this.Tactical.TurnSequenceBar.isOpponentStillToAct(_entity) && this.Tactical.TurnSequenceBar.isOpponentStillToAct(_entity) && this.Tactical.TurnSequenceBar.isOpponentStillToAct(_entity));
                this.m.IsWaitingBeforeMove = true;
                return _entity;
            }
            this.m.Skill = this.selectSkill(this.m.PossibleSkills);
            if ((null == this.Const.ImmobileMovementAPCost) && (null == this.Const.ImmobileMovementAPCost))
            {
                return ((null == this.Const.ImmobileMovementAPCost) && (null == this.Const.ImmobileMovementAPCost));
                return _entity;
            }
            if ((!this.m.Skill) && (!this.m.Skill))
            {
                return ((!this.m.Skill) && (!this.m.Skill));
                return _entity;
            }
            if ((!this.m.Skill) && (!this.m.Skill))
            {
                return ((!this.m.Skill) && (!this.m.Skill));
                return _entity;
            }
            if ((0.EngageWhenAlreadyEngagedMult == 0) && (0.EngageWhenAlreadyEngagedMult == 0))
            {
                return ((0.EngageWhenAlreadyEngagedMult == 0) && (0.EngageWhenAlreadyEngagedMult == 0));
                return _entity;
            }
            if (((0.EngageWhenAlreadyEngagedMult == 0) > 0) && ((0.EngageWhenAlreadyEngagedMult == 0) > 0))
            {
                return (((0.EngageWhenAlreadyEngagedMult == 0) > 0) && ((0.EngageWhenAlreadyEngagedMult == 0) > 0));
                if (this.m.Skill && this.m.Skill)
                {
                    return (this.m.Skill && this.m.Skill);
                }
                if (0 < 6)
                {
                    if (!_entity.getTile().hasNextTile(0))
                    {
                    }
                    else
                    {
                        if (!_entity.getTile().getNextTile(0).IsOccupiedByActor)
                        {
                        }
                        else
                        {
                            if ((!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity) && (!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity))))
                            {
                                return ((!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity)) && (!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity)));
                                if (_entity.getTile().getNextTile(0).getEntity().getSkills().getAttackOfOpportunity() != null)
                                {
                                }
                            }
                        }
                    }
                }
                if (_entity.getSkills().hasSkill("actives.knock_back"))
                {
                }
                if (_entity.getSkills().hasSkill("actives.footwork"))
                {
                }
                if (((1.0 * this.Math.pow(this.Const.AI.Behavior.EngageWithSkillToDisengagePOW, _entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions())) * this.Math.maxf(0.0, (1.0 - (((((0 + _entity.getTile().getNextTile(0).getEntity().getSkills().getAttackOfOpportunity().getHitchance(_entity)) * 0.009999999776482582) * (1.0 / this.getProperties().EngageWhenAlreadyEngagedMult)) * 1.0) * 1.0)))) <= 0))
                {
                    return _entity;
                }
            }
            else
            {
                if (this.queryTargetsInMeleeRange(this.getProperties().EngageRangeMin, this.Math.max(_entity.getIdealRange(), this.getProperties().EngageRangeMax).len() != 0))
                {
                }
            }
            foreach (local key, value in 0)
            {
                if (this.queryTargetValue(_entity, null) > 0)
                {
                }
                if ((null == null) && (null == null) && (null == null) && (null == null) && (null == null))
                {
                    return ((null == null) && (null == null) && (null == null) && (null == null) && (null == null));
                    foreach (local key, value in r501)
                    {
                        if ((null.getID() == _entity.getID() || (null.getID() == _entity.getID())))
                        {
                            return ((null.getID() == _entity.getID()) || (null.getID() == _entity.getID()));
                        }
                        if (this.isAllottedTimeReached(this.Time.getExactTime()))
                        {
                            yield this;
                        }
                        if (0 < 6)
                        {
                            if (!null.getTile().hasNextTile(0))
                            {
                            }
                            else
                            {
                                if ((this.Math > 1) && (this.Math > 1))
                                {
                                    return ((this.Math > 1) && (this.Math > 1));
                                }
                                [].push(null.getTile().getNextTile(0));
                            }
                        }
                        foreach (local key, value in r420)
                        {
                            foreach (local key, value in r123)
                            {
                                if ((null.Tile.getDistanceTo(null) > 8) || (null.Tile.getDistanceTo(null) > 8))
                                {
                                    return ((null.Tile.getDistanceTo(null) > 8) || (null.Tile.getDistanceTo(null) > 8));
                                }
                                if (null.getDirection8To(null.Tile) == this.Const.Direction8.W)
                                {
                                    []["this.Const.Direction.NW"] = []["this.Const.Direction.NW"] op43 (4 * (2.0 / null.getDistanceTo(null.Tile)));
                                    []["this.Const.Direction.SW"] = []["this.Const.Direction.SW"] op43 (4 * (2.0 / null.getDistanceTo(null.Tile)));
                                }
                                if (null.getDirection8To(null.Tile) == this.Const.Direction8.E)
                                {
                                    []["this.Const.Direction.NE"] = []["this.Const.Direction.NE"] op43 (4 * (2.0 / null.getDistanceTo(null.Tile)));
                                    []["this.Const.Direction.SE"] = []["this.Const.Direction.SE"] op43 (4 * (2.0 / null.getDistanceTo(null.Tile)));
                                }
                                if ((null.getDirectionTo(null.Tile) - 1) >= 0)
                                {
                                }
                                if ((null.getDirectionTo(null.Tile) + 1) < 6)
                                {
                                }
                                []["null.getDirectionTo(null.Tile)"] = []["null.getDirectionTo(null.Tile)"] op43 (4 * (2.0 / null.getDistanceTo(null.Tile)));
                                []["(6 - 1)"] = []["(6 - 1)"] op43 (3 * (2.0 / null.getDistanceTo(null.Tile)));
                                []["0"] = []["0"] op43 (3 * (2.0 / null.getDistanceTo(null.Tile)));
                                if ((0 + 27) != 0)
                                {
                                    if (0 < 6)
                                    {
                                        if (!null.hasNextTile(0))
                                        {
                                        }
                                        else
                                        {
                                            if (null.getNextTile(0).IsEmpty)
                                            {
                                            }
                                            else
                                            {
                                                if ((null.getNextTile(0).getEntity() > 1) && (null.getNextTile(0).getEntity() > 1))
                                                {
                                                    return ((null.getNextTile(0).getEntity() > 1) && (null.getNextTile(0).getEntity() > 1));
                                                }
                                                if ((null.getNextTile(0).getEntity().getIdealRange() == 1) && (null.getNextTile(0).getEntity().getIdealRange() == 1))
                                                {
                                                    return ((null.getNextTile(0).getEntity().getIdealRange() == 1) && (null.getNextTile(0).getEntity().getIdealRange() == 1));
                                                }
                                            }
                                        }
                                    }
                                }
                                if (null.IsBadTerrain)
                                {
                                }
                                if (null.Properties.IsMarkedForImpact && null.Properties.IsMarkedForImpact)
                                {
                                    return (null.Properties.IsMarkedForImpact && null.Properties.IsMarkedForImpact);
                                }
                                if (null.getZoneOfControlCountOtherThan(_entity.getAlliedFactions() > 0))
                                {
                                    if ((this.getProperties().EngageTargetMultipleOpponentsMult.EngageTargetMultipleOpponentsMult != this) && (this.getProperties().EngageTargetMultipleOpponentsMult.EngageTargetMultipleOpponentsMult != this))
                                    {
                                        return ((this.getProperties().EngageTargetMultipleOpponentsMult.EngageTargetMultipleOpponentsMult != this) && (this.getProperties().EngageTargetMultipleOpponentsMult.EngageTargetMultipleOpponentsMult != this));
                                    }
                                }
                                [].push({});
                                if ([].len() == 0)
                                {
                                }
                                foreach (local key, value in r1399)
                                {
                                    if (null.Actor.isNull())
                                    {
                                    }
                                    else
                                    {
                                        if ((null.Actor.getTile().getDistanceTo(_entity.getTile() > (this.m.Skill.getMaxRange() + 1)) && (null.Actor.getTile().getDistanceTo(_entity.getTile()) > (this.m.Skill.getMaxRange() + 1))))
                                        {
                                            return ((null.Actor.getTile().getDistanceTo(_entity.getTile()) > (this.m.Skill.getMaxRange() + 1)) && (null.Actor.getTile().getDistanceTo(_entity.getTile()) > (this.m.Skill.getMaxRange() + 1)));
                                        }
                                        if (this.isRangedUnit(null.Actor))
                                        {
                                            if (2.IgnoreTargetValueOnEngage)
                                            {
                                            }
                                        }
                                        if (((((null.Actor + (null.Actor * 2) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult.EngageTargetAlreadyBeingEngagedMult) == 0) && ((((null.Actor + (null.Actor * 2)) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult.EngageTargetAlreadyBeingEngagedMult) == 0) && ((((null.Actor + (null.Actor * 2)) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult.EngageTargetAlreadyBeingEngagedMult) == 0)))
                                        {
                                            return (((((null.Actor + (null.Actor * 2)) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult.EngageTargetAlreadyBeingEngagedMult) == 0) && ((((null.Actor + (null.Actor * 2)) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult.EngageTargetAlreadyBeingEngagedMult) == 0) && ((((null.Actor + (null.Actor * 2)) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult.EngageTargetAlreadyBeingEngagedMult) == 0));
                                            foreach (local key, value in r38)
                                            {
                                                if ((!1.0) && (!1.0))
                                                {
                                                    return ((!1.0) && (!1.0));
                                                }
                                                if (this.queryActorTurnsNearTarget(null.Actor, null.getTile(), null.Actor).Turns <= 1.0)
                                                {
                                                }
                                                if (this.getProperties().IgnoreTargetValueOnEngage)
                                                {
                                                    foreach (local key, value in r39)
                                                    {
                                                        if (null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions() || null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions())))
                                                        {
                                                            return (null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions()) || null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions()));
                                                        }
                                                        if (null.getTile().getDistanceTo(null.Actor.getTile() < _entity.getTile().getDistanceTo(null.Actor.getTile())))
                                                        {
                                                        }
                                                        foreach (local key, value in r39)
                                                        {
                                                            if (null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions() || null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions())))
                                                            {
                                                                return (null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions()) || null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions()));
                                                            }
                                                            if (null.getTile().getDistanceTo(null.Actor.getTile() < _entity.getTile().getDistanceTo(null.Actor.getTile())))
                                                            {
                                                            }
                                                            foreach (local key, value in r1095)
                                                            {
                                                                if (this.isAllottedTimeReached(this.Time.getExactTime()))
                                                                {
                                                                    yield this;
                                                                }
                                                                if ((null.Type == this.Const.Tactical.TerrainType.Impassable) && (null.Type == this.Const.Tactical.TerrainType.Impassable))
                                                                {
                                                                    return ((null.Type == this.Const.Tactical.TerrainType.Impassable) && (null.Type == this.Const.Tactical.TerrainType.Impassable));
                                                                }
                                                                else
                                                                {
                                                                    if ((!(null.Type == this.Const.Tactical.TerrainType.Impassable) && (!(null.Type == this.Const.Tactical.TerrainType.Impassable))))
                                                                    {
                                                                        return ((!(null.Type == this.Const.Tactical.TerrainType.Impassable)) && (!(null.Type == this.Const.Tactical.TerrainType.Impassable)));
                                                                    }
                                                                    else
                                                                    {
                                                                        if ((this.getStrategy().getStats().ShortestDistanceToEnemy >= 5) && (this.getStrategy().getStats().ShortestDistanceToEnemy >= 5))
                                                                        {
                                                                            return ((this.getStrategy().getStats().ShortestDistanceToEnemy >= 5) && (this.getStrategy().getStats().ShortestDistanceToEnemy >= 5));
                                                                            if ((null.Tile.getDistanceTo(this.centerTile) > (this.Const.Tactical.Settings.CampRadius + this.Tactical.State.LocationTemplate.AdditionalRadius) && (null.Tile.getDistanceTo(this.centerTile) > (this.Const.Tactical.Settings.CampRadius + this.Tactical.State.LocationTemplate.AdditionalRadius))))
                                                                            {
                                                                                return ((null.Tile.getDistanceTo(this.centerTile) > (this.Const.Tactical.Settings.CampRadius + this.Tactical.State.LocationTemplate.AdditionalRadius)) && (null.Tile.getDistanceTo(this.centerTile) > (this.Const.Tactical.Settings.CampRadius + this.Tactical.State.LocationTemplate.AdditionalRadius)));
                                                                            }
                                                                            else
                                                                            {
                                                                                if ((_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions() != 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) != 0)))
                                                                                {
                                                                                    return ((_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) != 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) != 0));
                                                                                    if ((!_entity.getTile().IsBadTerrain) && (!_entity.getTile().IsBadTerrain))
                                                                                    {
                                                                                        return ((!_entity.getTile().IsBadTerrain) && (!_entity.getTile().IsBadTerrain));
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        if (null.getDistanceTo(_entity.getTile() > 4))
                                                                                        {
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            if (null.getZoneOfControlCountOtherThan(_entity.getAlliedFactions() > _entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions())))
                                                                                            {
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                if ((!this.m.Skill.isDisengagement() && (!this.m.Skill.isDisengagement()) && (!this.m.Skill.isDisengagement()) && (!this.m.Skill.isDisengagement())))
                                                                                                {
                                                                                                    return ((!this.m.Skill.isDisengagement()) && (!this.m.Skill.isDisengagement()) && (!this.m.Skill.isDisengagement()) && (!this.m.Skill.isDisengagement()));
                                                                                                }
                                                                                                if ((this.queryTargetValue(_entity, null.Actor) < (this.queryTargetValue(_entity, null) * this.Const.AI.Behavior.EngageBestValueMult) && (this.queryTargetValue(_entity, null.Actor) < (this.queryTargetValue(_entity, null) * this.Const.AI.Behavior.EngageBestValueMult)) && (this.queryTargetValue(_entity, null.Actor) < (this.queryTargetValue(_entity, null) * this.Const.AI.Behavior.EngageBestValueMult)) && (this.queryTargetValue(_entity, null.Actor) < (this.queryTargetValue(_entity, null) * this.Const.AI.Behavior.EngageBestValueMult)) && (this.queryTargetValue(_entity, null.Actor) < (this.queryTargetValue(_entity, null) * this.Const.AI.Behavior.EngageBestValueMult))))
                                                                                                {
                                                                                                    return ((this.queryTargetValue(_entity, null.Actor) < (this.queryTargetValue(_entity, null) * this.Const.AI.Behavior.EngageBestValueMult)) && (this.queryTargetValue(_entity, null.Actor) < (this.queryTargetValue(_entity, null) * this.Const.AI.Behavior.EngageBestValueMult)) && (this.queryTargetValue(_entity, null.Actor) < (this.queryTargetValue(_entity, null) * this.Const.AI.Behavior.EngageBestValueMult)) && (this.queryTargetValue(_entity, null.Actor) < (this.queryTargetValue(_entity, null) * this.Const.AI.Behavior.EngageBestValueMult)) && (this.queryTargetValue(_entity, null.Actor) < (this.queryTargetValue(_entity, null) * this.Const.AI.Behavior.EngageBestValueMult)));
                                                                                                }
                                                                                                if (this.m.Skill.isUsableOn(null) && this.m.Skill.isUsableOn(null))
                                                                                                {
                                                                                                    return (this.m.Skill.isUsableOn(null) && this.m.Skill.isUsableOn(null));
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    if ((null == this.Const.ImmobileMovementAPCost) && (null == this.Const.ImmobileMovementAPCost))
                                                                                                    {
                                                                                                        return ((null == this.Const.ImmobileMovementAPCost) && (null == this.Const.ImmobileMovementAPCost));
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        if (this.m.Skill.isDisengagement() && this.m.Skill.isDisengagement())
                                                                                                        {
                                                                                                            return (this.m.Skill.isDisengagement() && this.m.Skill.isDisengagement());
                                                                                                        }
                                                                                                        else
                                                                                                        {
                                                                                                            if ((null.getDistanceTo(null.Actor.getTile() > 1) && (null.getDistanceTo(null.Actor.getTile()) > 1)))
                                                                                                            {
                                                                                                                return ((null.getDistanceTo(null.Actor.getTile()) > 1) && (null.getDistanceTo(null.Actor.getTile()) > 1));
                                                                                                                if (0 != 6)
                                                                                                                {
                                                                                                                    if (!null.hasNextTile(0))
                                                                                                                    {
                                                                                                                    }
                                                                                                                    else
                                                                                                                    {
                                                                                                                        if (this.m.Skill.isUsableOn(null.getNextTile(0), null))
                                                                                                                        {
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                                if (!true)
                                                                                                                {
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                                if ((null.getDistanceTo(null.Actor.getTile() != this.Const.AI.Behavior.EngageWithSkillBonus.EngageRangeIdeal) && (null.getDistanceTo(null.Actor.getTile()) != this.Const.AI.Behavior.EngageWithSkillBonus.EngageRangeIdeal)))
                                                                                                {
                                                                                                    return ((null.getDistanceTo(null.Actor.getTile()) != this.Const.AI.Behavior.EngageWithSkillBonus.EngageRangeIdeal) && (null.getDistanceTo(null.Actor.getTile()) != this.Const.AI.Behavior.EngageWithSkillBonus.EngageRangeIdeal));
                                                                                                }
                                                                                                if ((((null.Actor + (null.Actor * 2) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult.EngageTargetAlreadyBeingEngagedMult) != 0))
                                                                                                {
                                                                                                }
                                                                                                if ((!null.Actor.getTile().hasZoneOfControlOtherThan(null.Actor.getAlliedFactions()) && (!null.Actor.getTile().hasZoneOfControlOtherThan(null.Actor.getAlliedFactions())) && (!null.Actor.getTile().hasZoneOfControlOtherThan(null.Actor.getAlliedFactions()))))
                                                                                                {
                                                                                                    return ((!null.Actor.getTile().hasZoneOfControlOtherThan(null.Actor.getAlliedFactions())) && (!null.Actor.getTile().hasZoneOfControlOtherThan(null.Actor.getAlliedFactions())) && (!null.Actor.getTile().hasZoneOfControlOtherThan(null.Actor.getAlliedFactions())));
                                                                                                }
                                                                                                if (null.getZoneOfControlCountOtherThan(_entity.getAlliedFactions() > 0))
                                                                                                {
                                                                                                    if ((this.getProperties().EngageTargetMultipleOpponentsMult.EngageTargetMultipleOpponentsMult != this) && (this.getProperties().EngageTargetMultipleOpponentsMult.EngageTargetMultipleOpponentsMult != this))
                                                                                                    {
                                                                                                        return ((this.getProperties().EngageTargetMultipleOpponentsMult.EngageTargetMultipleOpponentsMult != this) && (this.getProperties().EngageTargetMultipleOpponentsMult.EngageTargetMultipleOpponentsMult != this));
                                                                                                    }
                                                                                                    if (_entity.getIdealRange() > 1)
                                                                                                    {
                                                                                                    }
                                                                                                }
                                                                                                if (this.m.Skill && this.m.Skill)
                                                                                                {
                                                                                                    return (this.m.Skill && this.m.Skill);
                                                                                                }
                                                                                                if (this.getProperties().EngageEnemiesInLinePreference > 1)
                                                                                                {
                                                                                                    if (0 < 6)
                                                                                                    {
                                                                                                        if (!null.hasNextTile(0))
                                                                                                        {
                                                                                                        }
                                                                                                        else
                                                                                                        {
                                                                                                            if (0 < (this.getProperties().EngageEnemiesInLinePreference - 1))
                                                                                                            {
                                                                                                                if (!null.getNextTile(0).hasNextTile(0))
                                                                                                                {
                                                                                                                }
                                                                                                                if ((!null.getNextTile(0).getNextTile(0).getEntity().isAlliedWith(_entity) && (!null.getNextTile(0).getNextTile(0).getEntity().isAlliedWith(_entity))))
                                                                                                                {
                                                                                                                    return ((!null.getNextTile(0).getNextTile(0).getEntity().isAlliedWith(_entity)) && (!null.getNextTile(0).getNextTile(0).getEntity().isAlliedWith(_entity)));
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                                if (null.IsBadTerrain)
                                                                                                {
                                                                                                    if (this.isRangedUnit(null.Actor))
                                                                                                    {
                                                                                                    }
                                                                                                }
                                                                                                if (null.Properties.IsMarkedForImpact && null.Properties.IsMarkedForImpact)
                                                                                                {
                                                                                                    return (null.Properties.IsMarkedForImpact && null.Properties.IsMarkedForImpact);
                                                                                                }
                                                                                                if (this.getProperties().OverallFormationMult != 0)
                                                                                                {
                                                                                                    if (this.queryAllyMagnitude(null, this.Const.AI.Behavior.EngageAllyFormationMaxDistance).Allies != 0)
                                                                                                    {
                                                                                                    }
                                                                                                }
                                                                                                if (1 && 1)
                                                                                                {
                                                                                                    return (1 && 1);
                                                                                                    foreach (local key, value in r123)
                                                                                                    {
                                                                                                        if ((null.Tile.getDistanceTo(null) > 8) || (null.Tile.getDistanceTo(null) > 8))
                                                                                                        {
                                                                                                            return ((null.Tile.getDistanceTo(null) > 8) || (null.Tile.getDistanceTo(null) > 8));
                                                                                                        }
                                                                                                        if (null.getDirection8To(null.Tile) == this.Const.Direction8.W)
                                                                                                        {
                                                                                                            []["this.Const.Direction.NW"] = []["this.Const.Direction.NW"] op43 (4 * (2.0 / null.getDistanceTo(null.Tile)));
                                                                                                            []["this.Const.Direction.SW"] = []["this.Const.Direction.SW"] op43 (4 * (2.0 / null.getDistanceTo(null.Tile)));
                                                                                                        }
                                                                                                        if (null.getDirection8To(null.Tile) == this.Const.Direction8.E)
                                                                                                        {
                                                                                                            []["this.Const.Direction.NE"] = []["this.Const.Direction.NE"] op43 (4 * (2.0 / null.getDistanceTo(null.Tile)));
                                                                                                            []["this.Const.Direction.SE"] = []["this.Const.Direction.SE"] op43 (4 * (2.0 / null.getDistanceTo(null.Tile)));
                                                                                                        }
                                                                                                        if ((null.getDirectionTo(null.Tile) - 1) >= 0)
                                                                                                        {
                                                                                                        }
                                                                                                        if ((null.getDirectionTo(null.Tile) + 1) < 6)
                                                                                                        {
                                                                                                        }
                                                                                                        []["null.getDirectionTo(null.Tile)"] = []["null.getDirectionTo(null.Tile)"] op43 (4 * (2.0 / null.getDistanceTo(null.Tile)));
                                                                                                        []["(6 - 1)"] = []["(6 - 1)"] op43 (3 * (2.0 / null.getDistanceTo(null.Tile)));
                                                                                                        []["0"] = []["0"] op43 (3 * (2.0 / null.getDistanceTo(null.Tile)));
                                                                                                        if ((0 + 39) != 0)
                                                                                                        {
                                                                                                            if (0 < 6)
                                                                                                            {
                                                                                                                if (!null.hasNextTile(0))
                                                                                                                {
                                                                                                                }
                                                                                                                else
                                                                                                                {
                                                                                                                    if (null.getNextTile(0).IsEmpty)
                                                                                                                    {
                                                                                                                    }
                                                                                                                    else
                                                                                                                    {
                                                                                                                        if ((null.getNextTile(0).getEntity().getIdealRange() == 1) && (null.getNextTile(0).getEntity().getIdealRange() == 1))
                                                                                                                        {
                                                                                                                            return ((null.getNextTile(0).getEntity().getIdealRange() == 1) && (null.getNextTile(0).getEntity().getIdealRange() == 1));
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                        if (null.getDistanceTo(null.Actor.getTile() == 1))
                                                                                                        {
                                                                                                        }
                                                                                                        [].push({});
                                                                                                        if ([].len() == 0)
                                                                                                        {
                                                                                                            return _entity;
                                                                                                        }
                                                                                                        [].sort(this.onSortByScore);
                                                                                                        if (this.isAllottedTimeReached(this.Time.getExactTime()))
                                                                                                        {
                                                                                                            yield this;
                                                                                                        }
                                                                                                        if (_entity.getSkills().hasSkill("actives.shieldwall"))
                                                                                                        {
                                                                                                            if (((((((((((((((((((((((-this) * this.Const.AI.Behavior.EngageDistancePenaltyMult) * (1.0 + this.Math.maxf(0.0, (1.0 - (_entity.getActionPointsMax() / 9.0)))) * (1.0 / this.getProperties().EngageFlankingMult)) - (((this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult.EngageTargetAlreadyBeingEngagedMult + (this.Math.abs((_entity.getTile().SquareCoords.Y - null.Actor.getTile().SquareCoords.Y)) * 20.0)) + 2.0) + 0.5)) + (this.queryTargetValue(_entity, null.Actor) * this.Const.AI.Behavior.EngageTargetValueMult)) + this.Const.AI.Behavior.EngageWithSkillBonus) + this.Const.AI.Behavior.EngageWithSkillBonus) + this.Const.AI.Behavior.EngageWithSkillNextTimeBonus) - this.Const.AI.Behavior.EngageWithSkillBonus) - (this.Math.abs((null.getDistanceTo(null.Actor.getTile()) - this.getProperties().EngageRangeIdeal)) * this.Const.AI.Behavior.EngageNotIdealRangePenalty)) - (((null.Actor + (null.Actor * 2)) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult.EngageTargetAlreadyBeingEngagedMult)) + (((null.Level - null.Actor.getTile().Level) * this.Const.AI.Behavior.EngageTerrainLevelBonus) * this.getProperties().EngageOnGoodTerrainBonusMult)) + ((null.TVTotal * this.Const.AI.Behavior.EngageTVValueMult) * this.getProperties().EngageOnGoodTerrainBonusMult)) - ((null.getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) * this.Const.AI.Behavior.EngageMultipleOpponentsPenalty) * this.getProperties().EngageTargetMultipleOpponentsMult)) - (null.getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) * this.Const.AI.Behavior.EngageIntoZocWithReachWeaponPenalty)) - (this.Const.AI.Behavior.EngageSpearwallTargetPenalty * this.querySpearwallValueForTile(_entity, null))) + ((this.queryTargetValue(_entity, null.getNextTile(0).getNextTile(0).getEntity()) * this.Const.AI.Behavior.EngageLineTargetValueMult) * this.getProperties().TargetPriorityAoEMult)) - ((this.Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult) * 1.0)) - (this.Const.AI.Behavior.EngageBadTerrainEffectPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult)) + (this.Math.pow(((((this.queryAllyMagnitude(null, this.Const.AI.Behavior.EngageAllyFormationMaxDistance).Allies * this.queryAllyMagnitude(null, this.Const.AI.Behavior.EngageAllyFormationMaxDistance).AverageDistanceScore) * (this.queryAllyMagnitude(null, this.Const.AI.Behavior.EngageAllyFormationMaxDistance).Magnetism / this.queryAllyMagnitude(null, this.Const.AI.Behavior.EngageAllyFormationMaxDistance).Allies)) * this.getProperties().OverallFormationMult) * 0.5), (this.getProperties().OverallFormationMult * 0.5)) * this.Const.AI.Behavior.EngageFormationBonus)) + (([]["0"] / (0 + 39)) * this.Const.AI.Behavior.EngageCoverWithReachWeaponMult)) != null))
                                                                                                            {
                                                                                                            }
                                                                                                        }
                                                                                                        if (([][0].Distance == 1) && ([][0].Distance == 1))
                                                                                                        {
                                                                                                            return (([][0].Distance == 1) && ([][0].Distance == 1));
                                                                                                        }
                                                                                                        foreach (local key, value in r1691)
                                                                                                        {
                                                                                                            if (([]["0"].Tile != null) && ([]["0"].Tile != null))
                                                                                                            {
                                                                                                                return (([]["0"].Tile != null) && ([]["0"].Tile != null));
                                                                                                            }
                                                                                                            if (this.isAllottedTimeReached(this.Time.getExactTime()))
                                                                                                            {
                                                                                                                yield this;
                                                                                                            }
                                                                                                            this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
                                                                                                            this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
                                                                                                            this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
                                                                                                            this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
                                                                                                            this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
                                                                                                            this.Tactical.getNavigator().createSettings().MaxLevelDifference = _entity.getMaxTraversibleLevels();
                                                                                                            this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = this.m.IsIgnoringZOC;
                                                                                                            this.Tactical.getNavigator().createSettings().ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
                                                                                                            this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
                                                                                                            this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
                                                                                                            if (this.getProperties().OverallHideMult >= 1)
                                                                                                            {
                                                                                                            }
                                                                                                            this.Tactical.getNavigator().createSettings().HiddenCost = 0;
                                                                                                            if ((this.getProperties().EngageFlankingMult > 1.0) && (this.getProperties().EngageFlankingMult > 1.0))
                                                                                                            {
                                                                                                                return ((this.getProperties().EngageFlankingMult > 1.0) && (this.getProperties().EngageFlankingMult > 1.0));
                                                                                                            }
                                                                                                            this.Tactical.getNavigator().createSettings().HeatCost = 0;
                                                                                                            if (this.Tactical.getNavigator().findPath(_entity.getTile(), null.Tile, this.Tactical.getNavigator().createSettings(), 0))
                                                                                                            {
                                                                                                                if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End.ID == _entity.getTile().ID) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.ID == _entity.getTile().ID)))
                                                                                                                {
                                                                                                                    return ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.ID == _entity.getTile().ID) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.ID == _entity.getTile().ID));
                                                                                                                }
                                                                                                                if ((!this.getStrategy().getStats().IsEngaged) && (!this.getStrategy().getStats().IsEngaged))
                                                                                                                {
                                                                                                                    return ((!this.getStrategy().getStats().IsEngaged) && (!this.getStrategy().getStats().IsEngaged));
                                                                                                                    if (!(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End.getNextTile(this.Const.Direction.N).getNextTile(this.Const.Direction.N).getEntity().getFaction() == _entity.getFaction())))
                                                                                                                    {
                                                                                                                        this.Tactical.getNavigator().clipPathToDistance(_entity.getTile(), this.getProperties().EngageTileLimit);
                                                                                                                        this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).IsComplete = false;
                                                                                                                    }
                                                                                                                }
                                                                                                                else
                                                                                                                {
                                                                                                                    if (this.getProperties().DontEngage && this.getProperties().DontEngage)
                                                                                                                    {
                                                                                                                        return (this.getProperties().DontEngage && this.getProperties().DontEngage);
                                                                                                                        this.Tactical.getNavigator().clipPathToDistance(_entity.getTile(), (this.getProperties().EngageTileLimit - 1));
                                                                                                                        this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).IsComplete = false;
                                                                                                                    }
                                                                                                                }
                                                                                                                if ((!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).IsComplete) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).IsComplete)))
                                                                                                                {
                                                                                                                    return ((!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).IsComplete) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).IsComplete));
                                                                                                                }
                                                                                                                if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty))
                                                                                                                {
                                                                                                                    return (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty);
                                                                                                                    this.Tactical.getNavigator().clipPathToDistance(_entity.getTile(), (_entity.getTile().getDistanceTo(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End) - 1));
                                                                                                                    this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).IsComplete = false;
                                                                                                                }
                                                                                                                if (null.Actor.getTile().IsBadTerrain && null.Actor.getTile().IsBadTerrain && null.Actor.getTile().IsBadTerrain && null.Actor.getTile().IsBadTerrain && null.Actor.getTile().IsBadTerrain && null.Actor.getTile().IsBadTerrain)
                                                                                                                {
                                                                                                                    return (null.Actor.getTile().IsBadTerrain && null.Actor.getTile().IsBadTerrain && null.Actor.getTile().IsBadTerrain && null.Actor.getTile().IsBadTerrain && null.Actor.getTile().IsBadTerrain && null.Actor.getTile().IsBadTerrain);
                                                                                                                }
                                                                                                                if ((_entity.getActionPoints() - this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).ActionPointsRequired) >= 4))
                                                                                                                {
                                                                                                                }
                                                                                                                if (this.m.Skill.isDisengagement() && this.m.Skill.isDisengagement() && this.m.Skill.isDisengagement())
                                                                                                                {
                                                                                                                    return (this.m.Skill.isDisengagement() && this.m.Skill.isDisengagement() && this.m.Skill.isDisengagement());
                                                                                                                    if (this.m.Skill.isUsableOn(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).First))
                                                                                                                    {
                                                                                                                    }
                                                                                                                    else
                                                                                                                    {
                                                                                                                        if (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions() > 1))
                                                                                                                        {
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                                else
                                                                                                                {
                                                                                                                    if ((4.EngageAgainstSpearwallMult != null.Actor.getTile) && (4.EngageAgainstSpearwallMult != null.Actor.getTile))
                                                                                                                    {
                                                                                                                        return ((4.EngageAgainstSpearwallMult != null.Actor.getTile) && (4.EngageAgainstSpearwallMult != null.Actor.getTile));
                                                                                                                        if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsEmpty)
                                                                                                                        {
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                            if (_entity.isAbleToWait())
                                                                                                                            {
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }
                                                                                                                    else
                                                                                                                    {
                                                                                                                        if ((_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions() == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0)))
                                                                                                                        {
                                                                                                                            return ((_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0) && (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0));
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                            if ((!this.isEngageRecommended(_entity, null.Tile) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile))))
                                                                                                                            {
                                                                                                                                return ((!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)) && (!this.isEngageRecommended(_entity, null.Tile)));
                                                                                                                                if (0 < 6)
                                                                                                                                {
                                                                                                                                    if (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.hasNextTile(0)))
                                                                                                                                    {
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                        if (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.getNextTile(0).IsEmpty))
                                                                                                                                        {
                                                                                                                                        }
                                                                                                                                        else
                                                                                                                                        {
                                                                                                                                            if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.getNextTile(0).getDistanceTo(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End) > this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.getDistanceTo(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd)))
                                                                                                                                            {
                                                                                                                                            }
                                                                                                                                            else
                                                                                                                                            {
                                                                                                                                                if (_entity.getActionPointCosts()["this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.getNextTile(0).Type"] > _entity.getActionPointCosts()["this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.Type"]))
                                                                                                                                                {
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                    if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.getNextTile(0).hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
                                                                                                                                                    {
                                                                                                                                                    }
                                                                                                                                                    else
                                                                                                                                                    {
                                                                                                                                                        if ((!this.hasNegativeTileEffect(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.getNextTile(0), _entity)) && (!this.hasNegativeTileEffect(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.getNextTile(0), _entity)) && (!this.hasNegativeTileEffect(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.getNextTile(0), _entity))))
                                                                                                                                                        {
                                                                                                                                                            return ((!this.hasNegativeTileEffect(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.getNextTile(0), _entity)) && (!this.hasNegativeTileEffect(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.getNextTile(0), _entity)) && (!this.hasNegativeTileEffect(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.getNextTile(0), _entity)));
                                                                                                                                                        }
                                                                                                                                                    }
                                                                                                                                                }
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                    }
                                                                                                                                }
                                                                                                                                if (((1 - this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).ActionPointsRequired) >= 4) && ((1 - this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired) >= 4)))
                                                                                                                                {
                                                                                                                                    return (((1 - this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired) >= 4) && ((1 - this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired) >= 4));
                                                                                                                                }
                                                                                                                                else
                                                                                                                                {
                                                                                                                                    if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.ID != this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.ID) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.ID != this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.ID)))
                                                                                                                                    {
                                                                                                                                        return ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.ID != this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.ID) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.ID != this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.ID));
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                        if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.getNextTile(0) != null))
                                                                                                                                        {
                                                                                                                                        }
                                                                                                                                        else
                                                                                                                                        {
                                                                                                                                            if (((_entity.getActionPointsMax() - this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).ActionPointsRequired) >= 4) && ((_entity.getActionPointsMax() - this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired) >= 4)))
                                                                                                                                            {
                                                                                                                                                return (((_entity.getActionPointsMax() - this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired) >= 4) && ((_entity.getActionPointsMax() - this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired) >= 4));
                                                                                                                                            }
                                                                                                                                            else
                                                                                                                                            {
                                                                                                                                                if (((_entity.getActionPointsMax() - (_entity.getActionPointCosts()["this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End.Type"] + _entity.getActionPointCosts()["this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.Type"])) >= 4) && ((_entity.getActionPointsMax() - (_entity.getActionPointCosts()["this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.Type"] + _entity.getActionPointCosts()["this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.Type"])) >= 4) && ((_entity.getActionPointsMax() - (_entity.getActionPointCosts()["this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.Type"] + _entity.getActionPointCosts()["this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.Type"])) >= 4)))
                                                                                                                                                {
                                                                                                                                                    return (((_entity.getActionPointsMax() - (_entity.getActionPointCosts()["this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.Type"] + _entity.getActionPointCosts()["this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.Type"])) >= 4) && ((_entity.getActionPointsMax() - (_entity.getActionPointCosts()["this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.Type"] + _entity.getActionPointCosts()["this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.Type"])) >= 4) && ((_entity.getActionPointsMax() - (_entity.getActionPointCosts()["this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.Type"] + _entity.getActionPointCosts()["this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.Type"])) >= 4));
                                                                                                                                                }
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                    }
                                                                                                                                }
                                                                                                                                if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).SecondLastBeforeEnd.ID == _entity.getTile().ID) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).SecondLastBeforeEnd.ID == _entity.getTile().ID)))
                                                                                                                                {
                                                                                                                                    return ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).SecondLastBeforeEnd.ID == _entity.getTile().ID) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).SecondLastBeforeEnd.ID == _entity.getTile().ID));
                                                                                                                                }
                                                                                                                                else
                                                                                                                                {
                                                                                                                                    if (this.hasNegativeTileEffect(null.Tile, _entity) && this.hasNegativeTileEffect(null.Tile, _entity) && this.hasNegativeTileEffect(null.Tile, _entity) && this.hasNegativeTileEffect(null.Tile, _entity))
                                                                                                                                    {
                                                                                                                                        return (this.hasNegativeTileEffect(null.Tile, _entity) && this.hasNegativeTileEffect(null.Tile, _entity) && this.hasNegativeTileEffect(null.Tile, _entity) && this.hasNegativeTileEffect(null.Tile, _entity));
                                                                                                                                        if (this.Tactical.getNavigator().findPath(_entity.getTile(), this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).SecondLastBeforeEnd, this.Tactical.getNavigator().createSettings(), 0))
                                                                                                                                        {
                                                                                                                                        }
                                                                                                                                    }
                                                                                                                                }
                                                                                                                            }
                                                                                                                            else
                                                                                                                            {
                                                                                                                                if ((!(this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End) != 0)) && (!(this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End) != 0)) && (!(this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End) != 0)) && (!(this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End) != 0)) && (!(this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End) != 0))))
                                                                                                                                {
                                                                                                                                    return ((!(this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End) != 0)) && (!(this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End) != 0)) && (!(this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End) != 0)) && (!(this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End) != 0)) && (!(this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End) != 0)));
                                                                                                                                    if ((!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.getEntity().getCurrentProperties().IsRooted) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.getEntity().getCurrentProperties().IsRooted) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.getEntity().getCurrentProperties().IsRooted) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.getEntity().getCurrentProperties().IsRooted)))
                                                                                                                                    {
                                                                                                                                        return ((!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.getEntity().getCurrentProperties().IsRooted) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.getEntity().getCurrentProperties().IsRooted) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.getEntity().getCurrentProperties().IsRooted) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.getEntity().getCurrentProperties().IsRooted));
                                                                                                                                    }
                                                                                                                                    if (this.hasNegativeTileEffect(null.Tile, _entity) && this.hasNegativeTileEffect(null.Tile, _entity) && this.hasNegativeTileEffect(null.Tile, _entity))
                                                                                                                                    {
                                                                                                                                        return (this.hasNegativeTileEffect(null.Tile, _entity) && this.hasNegativeTileEffect(null.Tile, _entity) && this.hasNegativeTileEffect(null.Tile, _entity));
                                                                                                                                    }
                                                                                                                                }
                                                                                                                                else
                                                                                                                                {
                                                                                                                                    if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.IsEmpty))
                                                                                                                                    {
                                                                                                                                        return (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.IsEmpty && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.IsEmpty);
                                                                                                                                        if ((!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.isSameTileAs(_entity.getTile())) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.isSameTileAs(_entity.getTile()))))
                                                                                                                                        {
                                                                                                                                            return ((!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.isSameTileAs(_entity.getTile())) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.isSameTileAs(_entity.getTile())));
                                                                                                                                            if (!this.hasNegativeTileEffect(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End, _entity)))
                                                                                                                                            {
                                                                                                                                                if (0 < 6)
                                                                                                                                                {
                                                                                                                                                    if (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End.hasNextTile(0)))
                                                                                                                                                    {
                                                                                                                                                    }
                                                                                                                                                    else
                                                                                                                                                    {
                                                                                                                                                        if ((!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).End.getNextTile(0).IsBadTerrain) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.getNextTile(0).IsBadTerrain)))
                                                                                                                                                        {
                                                                                                                                                            return ((!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.getNextTile(0).IsBadTerrain) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.getNextTile(0).IsBadTerrain));
                                                                                                                                                        }
                                                                                                                                                    }
                                                                                                                                                }
                                                                                                                                            }
                                                                                                                                            if (true)
                                                                                                                                            {
                                                                                                                                                if ((!this.hasNegativeTileEffect(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd, _entity)) && (!this.hasNegativeTileEffect(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd, _entity)) && (!this.hasNegativeTileEffect(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd, _entity))))
                                                                                                                                                {
                                                                                                                                                    return ((!this.hasNegativeTileEffect(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd, _entity)) && (!this.hasNegativeTileEffect(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd, _entity)) && (!this.hasNegativeTileEffect(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd, _entity)));
                                                                                                                                                }
                                                                                                                                                if (0 < 6)
                                                                                                                                                {
                                                                                                                                                    if (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.hasNextTile(0)))
                                                                                                                                                    {
                                                                                                                                                    }
                                                                                                                                                    else
                                                                                                                                                    {
                                                                                                                                                        if (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.getNextTile(0).IsEmpty))
                                                                                                                                                        {
                                                                                                                                                        }
                                                                                                                                                        else
                                                                                                                                                        {
                                                                                                                                                            if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.getNextTile(0).getDistanceTo(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End) > this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End.getDistanceTo(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd)))
                                                                                                                                                            {
                                                                                                                                                            }
                                                                                                                                                            else
                                                                                                                                                            {
                                                                                                                                                                if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.getNextTile(0).hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
                                                                                                                                                                {
                                                                                                                                                                }
                                                                                                                                                                else
                                                                                                                                                                {
                                                                                                                                                                    if ((!_entity) && (!_entity))
                                                                                                                                                                    {
                                                                                                                                                                        return ((!_entity) && (!_entity));
                                                                                                                                                                    }
                                                                                                                                                                }
                                                                                                                                                            }
                                                                                                                                                        }
                                                                                                                                                    }
                                                                                                                                                }
                                                                                                                                                if (this.Tactical.getNavigator().findPath(_entity.getTile(), this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.getNextTile(0), this.Tactical.getNavigator().createSettings(), 0))
                                                                                                                                                {
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                    if (true)
                                                                                                                                                    {
                                                                                                                                                    }
                                                                                                                                                }
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                        if (this.getProperties().EngageOnBadTerrainPenaltyMult != 0.0)
                                                                                                                                        {
                                                                                                                                            if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.TVLevelDisadvantage > 0))
                                                                                                                                            {
                                                                                                                                            }
                                                                                                                                            if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsBadTerrain)
                                                                                                                                            {
                                                                                                                                            }
                                                                                                                                            if (this.hasNegativeTileEffect(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd, _entity))
                                                                                                                                            {
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                    }
                                                                                                                                }
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            }
                                                                                                            if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsHidingEntity)
                                                                                                            {
                                                                                                            }
                                                                                                            if ((((((((((null.ScoreBonus - ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).ActionPointsRequired * (1.0 + this.Math.maxf(0.0, (1.0 - (_entity.getActionPointsMax() / 9.0))))) * (1.0 / this.getProperties().EngageFlankingMult))) + ((this.Const.AI.Behavior.EngageLockOpponentBonus * this.getProperties().EngageLockDownTargetMult) * null.LockDownMult)) + this.Const.AI.Behavior.EngageReachAndAttackBonus) + this.Const.AI.Behavior.EngageAvoidDisadvantageBonus) + this.Const.AI.Behavior.EngageAvoidDisadvantageBonus) - (this.Const.AI.Behavior.EngageLevelDisadvantagePenalty * this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.TVLevelDisadvantage)) - (this.Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult)) - (this.Const.AI.Behavior.EngageBadTerrainEffectPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult)) + (this.Const.AI.Behavior.EngageEndTurnHiddenBonus * this.getProperties().OverallHideMult)) > -9999))
                                                                                                            {
                                                                                                                if (null.Actor == null)
                                                                                                                {
                                                                                                                    if (null.Tile && null.Tile)
                                                                                                                    {
                                                                                                                        return (null.Tile && null.Tile);
                                                                                                                    }
                                                                                                                    if (this.isAllottedTimeReached(this.Time.getExactTime()))
                                                                                                                    {
                                                                                                                        yield this;
                                                                                                                    }
                                                                                                                    if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.ID != _entity.getTile().ID) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.ID != _entity.getTile().ID)))
                                                                                                                    {
                                                                                                                        return ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.ID != _entity.getTile().ID) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.ID != _entity.getTile().ID));
                                                                                                                        if ((!(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.ID == null.Tile.ID)) && (!(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.ID == null.Tile.ID))))
                                                                                                                        {
                                                                                                                            return ((!(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.ID == null.Tile.ID)) && (!(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.ID == null.Tile.ID)));
                                                                                                                            return _entity;
                                                                                                                        }
                                                                                                                        if ((this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd) != 0.0) && (this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd) != 0.0) && (this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd) != 0.0) && (this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd) != 0.0) && (this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd) != 0.0) && (this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd) != 0.0) && (this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd) != 0.0)))
                                                                                                                        {
                                                                                                                            return ((this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd) != 0.0) && (this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd) != 0.0) && (this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd) != 0.0) && (this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd) != 0.0) && (this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd) != 0.0) && (this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd) != 0.0) && (this.querySpearwallValueForTile(_entity, this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd) != 0.0));
                                                                                                                            foreach (local key, value in null.Tile.ID)
                                                                                                                            {
                                                                                                                                if (null.isTurnDone())
                                                                                                                                {
                                                                                                                                }
                                                                                                                                else
                                                                                                                                {
                                                                                                                                    if (null.getCurrentProperties().IsStunned || null.getCurrentProperties().IsStunned)
                                                                                                                                    {
                                                                                                                                        return (null.getCurrentProperties().IsStunned || null.getCurrentProperties().IsStunned);
                                                                                                                                    }
                                                                                                                                    if (null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions()))
                                                                                                                                    {
                                                                                                                                    }
                                                                                                                                    if (null.getTile().getDistanceTo(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd) > 5))
                                                                                                                                    {
                                                                                                                                    }
                                                                                                                                    if (null.isArmedWithShield())
                                                                                                                                    {
                                                                                                                                        return _entity;
                                                                                                                                    }
                                                                                                                                    if (this.isAllottedTimeReached(this.Time.getExactTime()))
                                                                                                                                    {
                                                                                                                                        yield this;
                                                                                                                                    }
                                                                                                                                    this.m.TargetTile = this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd;
                                                                                                                                    this.m.TargetActor = null.Actor;
                                                                                                                                    this.m.TargetDistance = 0;
                                                                                                                                    this.m.IsWaitingAfterMove = (null.Actor == null);
                                                                                                                                    this.m.IsWaitingBeforeMove = true;
                                                                                                                                    if ((null.Actor != null) && (null.Actor != null))
                                                                                                                                    {
                                                                                                                                        return ((null.Actor != null) && (null.Actor != null));
                                                                                                                                    }
                                                                                                                                    if (true)
                                                                                                                                    {
                                                                                                                                        this.logInfo("Waiting before move!");
                                                                                                                                    }
                                                                                                                                    this.getAgent().getIntentions().Target = null.Actor;
                                                                                                                                    this.getAgent().getIntentions().TargetTile = this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd;
                                                                                                                                    this.getAgent().getIntentions().IntermediateTargetTile = this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd;
                                                                                                                                    this.getAgent().getIntentions().APToReachTarget = this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).ActionPointsRequired;
                                                                                                                                    if (null.Actor != null)
                                                                                                                                    {
                                                                                                                                        if (true)
                                                                                                                                        {
                                                                                                                                        }
                                                                                                                                        this.m.Skill = null;
                                                                                                                                        if (true)
                                                                                                                                        {
                                                                                                                                        }
                                                                                                                                        if (this.getProperties().EngageOnGoodTerrainBonusMult != 0.0)
                                                                                                                                        {
                                                                                                                                            if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.Level - null.Actor.getTile().Level) > 0))
                                                                                                                                            {
                                                                                                                                            }
                                                                                                                                            else
                                                                                                                                            {
                                                                                                                                                if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.Level - null.Actor.getTile().Level) < 0))
                                                                                                                                                {
                                                                                                                                                }
                                                                                                                                            }
                                                                                                                                            if (((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.Level - _entity.getTile().Level) < 0) && ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.Level - _entity.getTile().Level) < 0)))
                                                                                                                                            {
                                                                                                                                                return (((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.Level - _entity.getTile().Level) < 0) && ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.Level - _entity.getTile().Level) < 0));
                                                                                                                                            }
                                                                                                                                            else
                                                                                                                                            {
                                                                                                                                                if (((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.Level - _entity.getTile().Level) > 0) && ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.Level - _entity.getTile().Level) > 0)))
                                                                                                                                                {
                                                                                                                                                    return (((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.Level - _entity.getTile().Level) > 0) && ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.Level - _entity.getTile().Level) > 0));
                                                                                                                                                }
                                                                                                                                            }
                                                                                                                                            if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd != null))
                                                                                                                                            {
                                                                                                                                                if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.Level - null.Actor.getTile().Level) > 0))
                                                                                                                                                {
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                    if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.Level - null.Actor.getTile().Level) < 0))
                                                                                                                                                    {
                                                                                                                                                    }
                                                                                                                                                }
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                        if (this.getProperties().EngageOnBadTerrainPenaltyMult != 0.0)
                                                                                                                                        {
                                                                                                                                            if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsBadTerrain)
                                                                                                                                            {
                                                                                                                                            }
                                                                                                                                            if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.IsBadTerrain && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsBadTerrain))
                                                                                                                                            {
                                                                                                                                                return (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsBadTerrain && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsBadTerrain);
                                                                                                                                            }
                                                                                                                                            if (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.IsBadTerrain && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsBadTerrain))
                                                                                                                                            {
                                                                                                                                                return (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsBadTerrain && this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsBadTerrain);
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                        if (this.getProperties().EngageOnGoodTerrainBonusMult != 0.0)
                                                                                                                                        {
                                                                                                                                            if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd == null) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd == null)))
                                                                                                                                            {
                                                                                                                                                return ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd == null) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd == null));
                                                                                                                                            }
                                                                                                                                            if ((!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd.IsBadTerrain) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsBadTerrain)))
                                                                                                                                            {
                                                                                                                                                return ((!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsBadTerrain) && (!this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd.IsBadTerrain));
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                        if (this.getProperties().EngageOnGoodTerrainBonusMult != 0.0)
                                                                                                                                        {
                                                                                                                                            if ((!this.m.TargetTile.Properties.IsMarkedForImpact) && (!this.m.TargetTile.Properties.IsMarkedForImpact))
                                                                                                                                            {
                                                                                                                                                return ((!this.m.TargetTile.Properties.IsMarkedForImpact) && (!this.m.TargetTile.Properties.IsMarkedForImpact));
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                        if (this.isAllottedTimeReached(this.Time.getExactTime()))
                                                                                                                                        {
                                                                                                                                            yield this;
                                                                                                                                        }
                                                                                                                                        if (this.m.Skill && this.m.Skill)
                                                                                                                                        {
                                                                                                                                            return (this.m.Skill && this.m.Skill);
                                                                                                                                            if ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd != null) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd != null)))
                                                                                                                                            {
                                                                                                                                                return ((this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd != null) && (this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).LastBeforeEnd != null));
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                    }
                                                                                                                                    if (this.queryTargetsInMeleeRange(this.getProperties().EngageRangeMin, this.Math.max(_entity.getIdealRange(), this.getProperties().EngageRangeMax).len() == 0))
                                                                                                                                    {
                                                                                                                                        if (this.queryAllyMagnitude(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()).LastBeforeEnd, this.Const.AI.Behavior.EngageAllyOpponentToAllyDistance).Allies != 0))
                                                                                                                                        {
                                                                                                                                        }
                                                                                                                                    }
                                                                                                                                    return _entity;
                                                                                                                                    if (this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity) && this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity) && this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity) && this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity) && this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity) && this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity))
                                                                                                                                    {
                                                                                                                                        return (this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity) && this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity) && this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity) && this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity) && this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity) && this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity));
                                                                                                                                        this.m.IsWaitingBeforeMove = true;
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

function onExecute(this, _entity)
{
    if (this.Tactical.TurnSequenceBar && this.Tactical.TurnSequenceBar && this.Tactical.TurnSequenceBar)
    {
        return (this.Tactical.TurnSequenceBar && this.Tactical.TurnSequenceBar && this.Tactical.TurnSequenceBar);
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((("* " + _entity.getName()) + ": Waiting until others have moved!"));
        }
        return _entity;
    }
    if (this.m.TargetTile != null)
    {
        if (this.m.IsFirstExecuted)
        {
            if (this.m.Skill != null)
            {
                this.m.Agent.adjustCameraToTarget(this.m.TargetTile);
                this.m.Skill.use(this.m.TargetTile);
            }
            this.m.OriginTile = _entity.getTile();
            this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
            this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
            this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
            this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
            this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
            this.Tactical.getNavigator().createSettings().MaxLevelDifference = _entity.getMaxTraversibleLevels();
            this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = this.m.IsIgnoringZOC;
            this.Tactical.getNavigator().createSettings().ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
            this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
            this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
            if (this.getProperties().OverallHideMult >= 1)
            {
            }
            this.Tactical.getNavigator().createSettings().HiddenCost = 0;
            if ((this.getProperties().EngageFlankingMult > 1.0) && (this.getProperties().EngageFlankingMult > 1.0))
            {
                return ((this.getProperties().EngageFlankingMult > 1.0) && (this.getProperties().EngageFlankingMult > 1.0));
            }
            this.Tactical.getNavigator().createSettings().HeatCost = 0;
            if ((this.m.TargetActor != null) && (this.m.TargetActor != null))
            {
                return ((this.m.TargetActor != null) && (this.m.TargetActor != null));
                if (this.m.TargetActor.getTile().IsVisibleForEntity)
                {
                }
                this.logInfo(((((((((("* " + _entity.getName()) + ": Engaging to melee range with ") + this.m.TargetActor.getName()) + " (") + "not visible") + "), accepted_distance=") + this.m.TargetDistance) + ", value=") + this.queryTargetValue(_entity, this.m.TargetActor)));
            }
            if (!this.Tactical.getNavigator().findPath(this.m.OriginTile, this.m.TargetTile, this.Tactical.getNavigator().createSettings(), this.m.TargetDistance))
            {
                this.logWarning((("* " + _entity.getName()) + ": Failed to execute path for Melee Engage - No path found"));
                return _entity;
            }
            if (this.Const.AI.PathfindingDebugMode)
            {
                this.Tactical.getNavigator().buildVisualisation(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue()));
            }
            this.m.Agent.adjustCameraToDestination(this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())).End);
            this.m.IsFirstExecuted = false;
            return _entity;
        }
        if (this.m.Skill != null)
        {
            if (!this.Tactical.getNavigator().isTravelling(_entity))
            {
                this.m.TargetTile = null;
                this.m.TargetActor = null;
                this.m.OriginTile = null;
                this.m.Skill = null;
                return _entity;
            }
        }
        if (!this.Tactical.getNavigator().travel(_entity, _entity.getActionPoints(), (_entity.getFatigueMax() - _entity.getFatigue())))
        {
            if (_entity.isAlive())
            {
                if ((_entity.getTile().getDistanceTo(this.m.TargetTile) < this.Const.AI.Behavior.EngageMaxDistance) && (_entity.getTile().getDistanceTo(this.m.TargetTile) < this.Const.AI.Behavior.EngageMaxDistance))
                {
                    return ((_entity.getTile().getDistanceTo(this.m.TargetTile) < this.Const.AI.Behavior.EngageMaxDistance) && (_entity.getTile().getDistanceTo(this.m.TargetTile) < this.Const.AI.Behavior.EngageMaxDistance));
                    this.m.TargetActor.getAIAgent().declareEngagement(_entity);
                }
                if (!_entity.getTile().hasZoneOfOccupationOtherThan(_entity.getAlliedFactions()))
                {
                    this.m.IsEngagedThisTurn = true;
                }
            }
            if ((_entity.getActionPoints() >= this.Const.Movement.AutoEndTurnBelowAP) && (_entity.getActionPoints() >= this.Const.Movement.AutoEndTurnBelowAP))
            {
                return ((_entity.getActionPoints() >= this.Const.Movement.AutoEndTurnBelowAP) && (_entity.getActionPoints() >= this.Const.Movement.AutoEndTurnBelowAP));
                this.getAgent().declareAction();
            }
            if (this.Const.AI.VerboseMode)
            {
                if (_entity.getTile().ID == this.m.TargetTile.ID)
                {
                    this.logInfo((("* " + _entity.getName()) + ": Reached engage destination"));
                }
                this.logInfo((("* " + _entity.getName()) + ": Stopped before reaching destination"));
            }
            this.m.TargetTile = null;
            this.m.TargetActor = null;
            this.m.OriginTile = null;
            this.m.TargetDistance = 0;
            return _entity;
        }
        return _entity;
    }
    return _entity;
}

function onSortByScore(this, _a, _b)
{
    if (_a.TileScore > _b.TileScore)
    {
        return _a;
    }
    else
    {
        if (_a.TileScore < _b.TileScore)
        {
            return _a;
        }
    }
    return _a;
}

function onTurnResumed(this)
{
    this.m.IsDoneThisTurn = false;
    this.m.IsEngagedThisTurn = false;
    return;
}

function onTurnStarted(this)
{
    this.m.Inertia = this.Math.maxf(0, (this.m.Inertia - 1));
    this.m.IsDoneThisTurn = false;
    this.m.IsEngagedThisTurn = false;
    return;
}
