// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_darkflight.nut
// Functions: 5

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Darkflight;
    this.m.Order = this.Const.AI.Behavior.Order.Darkflight;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function onBeforeExecute(this, _entity)
{
    this.getAgent().getOrders().IsEngaging = true;
    this.getAgent().getOrders().IsDefending = false;
    this.getAgent().getIntentions().IsDefendingPosition = false;
    this.m.LastExecuteTime = this.Tactical.TurnSequenceBar.getCurrentRound();
    this.m.Inertia = this.m.Inertia op43 2;
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.SelectedSkill = null;
    this.m.UnlockTime = 0;
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
    if (this.getAgent().getIntentions().IsDefendingPosition)
    {
        return _entity;
    }
    foreach (local key, value in r26)
    {
        if (_entity.getSkills().getSkillByID(null).isAffordable() && _entity.getSkills().getSkillByID(null).isAffordable())
        {
            return (_entity.getSkills().getSkillByID(null).isAffordable() && _entity.getSkills().getSkillByID(null).isAffordable());
            this.m.SelectedSkill = _entity.getSkills().getSkillByID(null);
        }
        if (this.m.SelectedSkill == null)
        {
            return _entity;
        }
        if (this.m.LastEvaluateTime == this.m.LastExecuteTime)
        {
            this.m.Inertia = this.Math.maxf(0, (this.m.Inertia - 1));
        }
        this.m.Inertia = 0;
        this.m.LastEvaluateTime = this.Tactical.TurnSequenceBar.getCurrentRound();
        if (!this.getAgent().hasKnownOpponent())
        {
            return _entity;
        }
        if (this.queryTargetsInMeleeRange().len() != 0)
        {
        }
        foreach (local key, value in r118)
        {
            if (this.Const.MoraleState.Fleeing.IsStunned && this.Const.MoraleState.Fleeing.IsStunned)
            {
                return (this.Const.MoraleState.Fleeing.IsStunned && this.Const.MoraleState.Fleeing.IsStunned);
            }
            if (this.isRangedUnit(null))
            {
            }
            if ((null == null) && (null == null))
            {
                return ((null == null) && (null == null));
            }
            foreach (local key, value in r145)
            {
                if (null.Actor.isNull())
                {
                }
                if (_entity.getTile().getDistanceTo(null.Actor.getTile() > (this.m.SelectedSkill.getMaxRange() + 1)))
                {
                    if (_entity.getTile().getDistanceTo(_entity.getTile().getTileBetweenThisAnd(null.Actor.getTile()) > (this.m.SelectedSkill.getMaxRange() + 1)))
                    {
                    }
                }
                if (0 < this.Const.Direction.COUNT)
                {
                    if (!_entity.getTile().getTileBetweenThisAnd(null.Actor.getTile().hasNextTile(0)))
                    {
                    }
                    else
                    {
                        if ((_entity.getTile().getTileBetweenThisAnd(null.Actor.getTile().getNextTile(0).Type == this.Const.Tactical.TerrainType.Impassable) && (_entity.getTile().getTileBetweenThisAnd(null.Actor.getTile()).getNextTile(0).Type == this.Const.Tactical.TerrainType.Impassable) && (_entity.getTile().getTileBetweenThisAnd(null.Actor.getTile()).getNextTile(0).Type == this.Const.Tactical.TerrainType.Impassable)))
                        {
                            return ((_entity.getTile().getTileBetweenThisAnd(null.Actor.getTile()).getNextTile(0).Type == this.Const.Tactical.TerrainType.Impassable) && (_entity.getTile().getTileBetweenThisAnd(null.Actor.getTile()).getNextTile(0).Type == this.Const.Tactical.TerrainType.Impassable) && (_entity.getTile().getTileBetweenThisAnd(null.Actor.getTile()).getNextTile(0).Type == this.Const.Tactical.TerrainType.Impassable));
                        }
                        if (_entity.getTile().getDistanceTo(_entity.getTile().getTileBetweenThisAnd(null.Actor.getTile().getNextTile(0)) > this.m.SelectedSkill.getMaxRange()))
                        {
                        }
                        if (this.Math.abs((_entity.getTile().getTileBetweenThisAnd(null.Actor.getTile().getNextTile(0).Level - _entity.getTile().getTileBetweenThisAnd(null.Actor.getTile()).Level)) > 1))
                        {
                        }
                        if ([] == [])
                        {
                        }
                        [].push({});
                    }
                }
                if ([].len() == 0)
                {
                    if ([].len() == 0)
                    {
                        return _entity;
                    }
                }
                foreach (local key, value in r468)
                {
                    if (this.isAllottedTimeReached(this.Time.getExactTime()))
                    {
                        yield this;
                    }
                    if (0 < this.Const.Direction.COUNT)
                    {
                        if (!null.Tile.hasNextTile(0))
                        {
                        }
                        else
                        {
                            if (this.Math.abs((null.Tile.Level - null.Tile.getNextTile(0).Level) > 1))
                            {
                            }
                            else
                            {
                                if ((!1) && (!1))
                                {
                                    return ((!1) && (!1));
                                    if (this.isRangedUnit(null.Tile.getNextTile(0).getEntity()))
                                    {
                                        if (this.isRangedUnit(null.Tile.getNextTile(0).getEntity()))
                                        {
                                        }
                                    }
                                    if ((!this.Const.MoraleState.Fleeing.IsStunned) && (!this.Const.MoraleState.Fleeing.IsStunned))
                                    {
                                        return ((!this.Const.MoraleState.Fleeing.IsStunned) && (!this.Const.MoraleState.Fleeing.IsStunned));
                                        if (!this.isRangedUnit(null.Tile.getNextTile(0).getEntity()))
                                        {
                                        }
                                    }
                                    if ((null.Tile.Level - null.Tile.getNextTile(0).Level) > 0)
                                    {
                                    }
                                    else
                                    {
                                        if ((null.Tile.Level - null.Tile.getNextTile(0).Level) < 0)
                                        {
                                        }
                                    }
                                    if ((null == this) && (null == this))
                                    {
                                        return ((null == this) && (null == this));
                                    }
                                }
                                else
                                {
                                    if ((!null.Tile.getNextTile(0).IsOccupiedByActor) && (!null.Tile.getNextTile(0).IsOccupiedByActor))
                                    {
                                        return ((!null.Tile.getNextTile(0).IsOccupiedByActor) && (!null.Tile.getNextTile(0).IsOccupiedByActor));
                                    }
                                }
                            }
                        }
                    }
                    null.DebugTargets = (((((((((0.0 + (this.Const.AI.Behavior.DarkflightRangedTargetBonus * this.getProperties().EngageTargetArmedWithRangedWeaponMult)) - ((((null.Tile.getNextTile(0).getEntity().getHitpoints() + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Body)) + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Head)) / ((null.Tile.getNextTile(0).getEntity().getHitpointsMax() + null.Tile.getNextTile(0).getEntity().getArmorMax(this.Const.BodyPart.Body)) + null.Tile.getNextTile(0).getEntity().getArmorMax(this.Const.BodyPart.Head))) * this.Const.AI.Behavior.DarkflightHitpointsScoreMult)) + this.Const.AI.Behavior.DarkflightFleeingBonus) - (((null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Body) + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Head)) * this.Const.AI.Behavior.DarkflightHatredForArmorMult) * this.Const.AI.Behavior.DarkflightHatredForArmorMult)) - (null.Tile.getNextTile(0).getEntity().getCurrentProperties().getMeleeDefense() * this.Const.AI.Behavior.DarkflightHatredForMeleeDefenseMult)) + (((null.Tile.Level - null.Tile.getNextTile(0).Level) * this.Const.AI.Behavior.DarkflightTerrainLevelBonus) * this.getProperties().EngageOnGoodTerrainBonusMult)) + 100.0) + this.Const.AI.Behavior.DarkflightTileBlockedBonus) - 0);
                    foreach (local key, value in r55)
                    {
                        if (null.Actor.isNull())
                        {
                        }
                        else
                        {
                            if (this.isRangedUnit(null.Actor))
                            {
                            }
                            else
                            {
                                if (null.Actor.IsStunned && null.Actor.IsStunned)
                                {
                                    return (null.Actor.IsStunned && null.Actor.IsStunned);
                                }
                                if (this.queryActorTurnsNearTarget(null.Actor, null.Tile, _entity).Turns <= 1.0)
                                {
                                }
                                null.DebugDanger = ((((((((((0.0 + (this.Const.AI.Behavior.DarkflightRangedTargetBonus * this.getProperties().EngageTargetArmedWithRangedWeaponMult)) - ((((null.Tile.getNextTile(0).getEntity().getHitpoints() + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Body)) + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Head)) / ((null.Tile.getNextTile(0).getEntity().getHitpointsMax() + null.Tile.getNextTile(0).getEntity().getArmorMax(this.Const.BodyPart.Body)) + null.Tile.getNextTile(0).getEntity().getArmorMax(this.Const.BodyPart.Head))) * this.Const.AI.Behavior.DarkflightHitpointsScoreMult)) + this.Const.AI.Behavior.DarkflightFleeingBonus) - (((null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Body) + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Head)) * this.Const.AI.Behavior.DarkflightHatredForArmorMult) * this.Const.AI.Behavior.DarkflightHatredForArmorMult)) - (null.Tile.getNextTile(0).getEntity().getCurrentProperties().getMeleeDefense() * this.Const.AI.Behavior.DarkflightHatredForMeleeDefenseMult)) + (((null.Tile.Level - null.Tile.getNextTile(0).Level) * this.Const.AI.Behavior.DarkflightTerrainLevelBonus) * this.getProperties().EngageOnGoodTerrainBonusMult)) + 100.0) + this.Const.AI.Behavior.DarkflightTileBlockedBonus) - (this.Math.maxf(0.0, (0.0 + (1.0 - this.Math.minf(1.0, this.queryActorTurnsNearTarget(null.Actor, null.Tile, _entity).Turns)))) * this.Const.AI.Behavior.DarkflightDangerDestMult)) - ((((((((0.0 + (this.Const.AI.Behavior.DarkflightRangedTargetBonus * this.getProperties().EngageTargetArmedWithRangedWeaponMult)) - ((((null.Tile.getNextTile(0).getEntity().getHitpoints() + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Body)) + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Head)) / ((null.Tile.getNextTile(0).getEntity().getHitpointsMax() + null.Tile.getNextTile(0).getEntity().getArmorMax(this.Const.BodyPart.Body)) + null.Tile.getNextTile(0).getEntity().getArmorMax(this.Const.BodyPart.Head))) * this.Const.AI.Behavior.DarkflightHitpointsScoreMult)) + this.Const.AI.Behavior.DarkflightFleeingBonus) - (((null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Body) + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Head)) * this.Const.AI.Behavior.DarkflightHatredForArmorMult) * this.Const.AI.Behavior.DarkflightHatredForArmorMult)) - (null.Tile.getNextTile(0).getEntity().getCurrentProperties().getMeleeDefense() * this.Const.AI.Behavior.DarkflightHatredForMeleeDefenseMult)) + (((null.Tile.Level - null.Tile.getNextTile(0).Level) * this.Const.AI.Behavior.DarkflightTerrainLevelBonus) * this.getProperties().EngageOnGoodTerrainBonusMult)) + 100.0) + this.Const.AI.Behavior.DarkflightTileBlockedBonus));
                                if (null.Tile.IsBadTerrain)
                                {
                                }
                                if (this.hasNegativeTileEffect(null.Tile, _entity))
                                {
                                }
                                null.DebugTV = (((((((((((((0.0 + (this.Const.AI.Behavior.DarkflightRangedTargetBonus * this.getProperties().EngageTargetArmedWithRangedWeaponMult)) - ((((null.Tile.getNextTile(0).getEntity().getHitpoints() + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Body)) + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Head)) / ((null.Tile.getNextTile(0).getEntity().getHitpointsMax() + null.Tile.getNextTile(0).getEntity().getArmorMax(this.Const.BodyPart.Body)) + null.Tile.getNextTile(0).getEntity().getArmorMax(this.Const.BodyPart.Head))) * this.Const.AI.Behavior.DarkflightHitpointsScoreMult)) + this.Const.AI.Behavior.DarkflightFleeingBonus) - (((null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Body) + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Head)) * this.Const.AI.Behavior.DarkflightHatredForArmorMult) * this.Const.AI.Behavior.DarkflightHatredForArmorMult)) - (null.Tile.getNextTile(0).getEntity().getCurrentProperties().getMeleeDefense() * this.Const.AI.Behavior.DarkflightHatredForMeleeDefenseMult)) + (((null.Tile.Level - null.Tile.getNextTile(0).Level) * this.Const.AI.Behavior.DarkflightTerrainLevelBonus) * this.getProperties().EngageOnGoodTerrainBonusMult)) + 100.0) + this.Const.AI.Behavior.DarkflightTileBlockedBonus) - (this.Math.maxf(0.0, (0.0 + (1.0 - this.Math.minf(1.0, this.queryActorTurnsNearTarget(null.Actor, null.Tile, _entity).Turns)))) * this.Const.AI.Behavior.DarkflightDangerDestMult)) - (this.Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult)) - (this.Const.AI.Behavior.EngageBadTerrainEffectPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult)) + ((null.Tile.TVTotal * this.Const.AI.Behavior.DarkflightTacticalValueMult) * this.getProperties().EngageOnGoodTerrainBonusMult)) - (((((((((0.0 + (this.Const.AI.Behavior.DarkflightRangedTargetBonus * this.getProperties().EngageTargetArmedWithRangedWeaponMult)) - ((((null.Tile.getNextTile(0).getEntity().getHitpoints() + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Body)) + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Head)) / ((null.Tile.getNextTile(0).getEntity().getHitpointsMax() + null.Tile.getNextTile(0).getEntity().getArmorMax(this.Const.BodyPart.Body)) + null.Tile.getNextTile(0).getEntity().getArmorMax(this.Const.BodyPart.Head))) * this.Const.AI.Behavior.DarkflightHitpointsScoreMult)) + this.Const.AI.Behavior.DarkflightFleeingBonus) - (((null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Body) + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Head)) * this.Const.AI.Behavior.DarkflightHatredForArmorMult) * this.Const.AI.Behavior.DarkflightHatredForArmorMult)) - (null.Tile.getNextTile(0).getEntity().getCurrentProperties().getMeleeDefense() * this.Const.AI.Behavior.DarkflightHatredForMeleeDefenseMult)) + (((null.Tile.Level - null.Tile.getNextTile(0).Level) * this.Const.AI.Behavior.DarkflightTerrainLevelBonus) * this.getProperties().EngageOnGoodTerrainBonusMult)) + 100.0) + this.Const.AI.Behavior.DarkflightTileBlockedBonus) - (this.Math.maxf(0.0, (0.0 + (1.0 - this.Math.minf(1.0, this.queryActorTurnsNearTarget(null.Actor, null.Tile, _entity).Turns)))) * this.Const.AI.Behavior.DarkflightDangerDestMult)));
                                if (null.Tile.isSameTileAs(_entity.getTile()))
                                {
                                }
                                null.Score = (((((((((((((0.0 + (this.Const.AI.Behavior.DarkflightRangedTargetBonus * this.getProperties().EngageTargetArmedWithRangedWeaponMult)) - ((((null.Tile.getNextTile(0).getEntity().getHitpoints() + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Body)) + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Head)) / ((null.Tile.getNextTile(0).getEntity().getHitpointsMax() + null.Tile.getNextTile(0).getEntity().getArmorMax(this.Const.BodyPart.Body)) + null.Tile.getNextTile(0).getEntity().getArmorMax(this.Const.BodyPart.Head))) * this.Const.AI.Behavior.DarkflightHitpointsScoreMult)) + this.Const.AI.Behavior.DarkflightFleeingBonus) - (((null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Body) + null.Tile.getNextTile(0).getEntity().getArmor(this.Const.BodyPart.Head)) * this.Const.AI.Behavior.DarkflightHatredForArmorMult) * this.Const.AI.Behavior.DarkflightHatredForArmorMult)) - (null.Tile.getNextTile(0).getEntity().getCurrentProperties().getMeleeDefense() * this.Const.AI.Behavior.DarkflightHatredForMeleeDefenseMult)) + (((null.Tile.Level - null.Tile.getNextTile(0).Level) * this.Const.AI.Behavior.DarkflightTerrainLevelBonus) * this.getProperties().EngageOnGoodTerrainBonusMult)) + 100.0) + this.Const.AI.Behavior.DarkflightTileBlockedBonus) - (this.Math.maxf(0.0, (0.0 + (1.0 - this.Math.minf(1.0, this.queryActorTurnsNearTarget(null.Actor, null.Tile, _entity).Turns)))) * this.Const.AI.Behavior.DarkflightDangerDestMult)) - (this.Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult)) - (this.Const.AI.Behavior.EngageBadTerrainEffectPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult)) + ((null.Tile.TVTotal * this.Const.AI.Behavior.DarkflightTacticalValueMult) * this.getProperties().EngageOnGoodTerrainBonusMult)) + this.Const.AI.Behavior.DarkflightStayOnTileBonus);
                                null.ScoreMult = (((((((1.0 * this.Const.AI.Behavior.DarkflightRangedTargetMult) * this.Const.AI.Behavior.DarkflightMultipleOpponentsMult) * this.Const.AI.Behavior.DarkflightTerrainLevelMult) * this.Const.AI.Behavior.DarkflightBadTerrainMult) * this.Const.AI.Behavior.DarkflightBadTerrainMult) * this.Const.AI.Behavior.DarkflightBadTerrainMult) + ((null.Tile.TVTotal * this.Const.AI.Behavior.DarkflightTacticalValueMult) * this.Const.AI.Behavior.DarkflightTacticalValueMult));
                                [].sort(this.onSortByScore);
                                if (([][0].Score <= null.Score) && ([][0].Score <= null.Score))
                                {
                                    return (([][0].Score <= null.Score) && ([][0].Score <= null.Score));
                                    return _entity;
                                }
                                if ((this.getProperties().BehaviorMult["this.Const.AI.Behavior.ID.EngageMelee"] != 0) && (this.getProperties().BehaviorMult["this.Const.AI.Behavior.ID.EngageMelee"] != 0) && (this.getProperties().BehaviorMult["this.Const.AI.Behavior.ID.EngageMelee"] != 0))
                                {
                                    return ((this.getProperties().BehaviorMult["this.Const.AI.Behavior.ID.EngageMelee"] != 0) && (this.getProperties().BehaviorMult["this.Const.AI.Behavior.ID.EngageMelee"] != 0) && (this.getProperties().BehaviorMult["this.Const.AI.Behavior.ID.EngageMelee"] != 0));
                                    return _entity;
                                }
                                if (_entity.getTile().getDistanceTo([]["0"].UltimateTile) > 4)
                                {
                                }
                                else
                                {
                                    if (this.hasNegativeTileEffect(_entity.getTile(), _entity) && this.hasNegativeTileEffect(_entity.getTile(), _entity) && this.hasNegativeTileEffect(_entity.getTile(), _entity) && this.hasNegativeTileEffect(_entity.getTile(), _entity) && this.hasNegativeTileEffect(_entity.getTile(), _entity))
                                    {
                                        return (this.hasNegativeTileEffect(_entity.getTile(), _entity) && this.hasNegativeTileEffect(_entity.getTile(), _entity) && this.hasNegativeTileEffect(_entity.getTile(), _entity) && this.hasNegativeTileEffect(_entity.getTile(), _entity) && this.hasNegativeTileEffect(_entity.getTile(), _entity));
                                    }
                                    else
                                    {
                                        if (([]["0"].Score <= (null.Score + this.Const.AI.Behavior.DarkflightStayOnTileBonus) && ([]["0"].Score <= (null.Score + this.Const.AI.Behavior.DarkflightStayOnTileBonus))))
                                        {
                                            return (([]["0"].Score <= (null.Score + this.Const.AI.Behavior.DarkflightStayOnTileBonus)) && ([]["0"].Score <= (null.Score + this.Const.AI.Behavior.DarkflightStayOnTileBonus)));
                                            return _entity;
                                        }
                                    }
                                }
                                this.m.TargetTile = []["0"].Tile;
                                this.getAgent().getIntentions().TargetTile = this.m.TargetTile;
                                return _entity;
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
    if (this.m.IsFirstExecuted)
    {
        this.m.IsFirstExecuted = false;
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((("* " + _entity.getName()) + ": Using Darkflight to engage."));
        }
        this.m.Agent.adjustCameraToTarget(this.m.TargetTile);
        this.m.SelectedSkill.use(this.m.TargetTile);
    }
    else
    {
        if (!_entity.isStoringColor())
        {
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
