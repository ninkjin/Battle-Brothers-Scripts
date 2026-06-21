// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_knock_out.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.KnockOut;
    this.m.Order = this.Const.AI.Behavior.Order.KnockOut;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function getBestTarget(this, _entity, _skill, _targets)
{
    if (_entity.getSkills().getAttackOfOpportunity() != null)
    {
    }
    foreach (local key, value in (_skill.getID() == "actives.golem_grapple"))
    {
        if (this.queryTargetValue(_entity, null, null) > _skill)
        {
        }
        foreach (local key, value in r642)
        {
            if (this.isAllottedTimeReached(this.Time.getExactTime()))
            {
                yield this;
            }
            if (_skill.onVerifyTarget(_entity.getTile(), null.getTile()))
            {
                if (null.getFatigue() >= (null.getFatigueMax() - 5))
                {
                }
                else
                {
                    if ((null == this.Const.MoraleState.Fleeing) && (null == this.Const.MoraleState.Fleeing))
                    {
                        return ((null == this.Const.MoraleState.Fleeing) && (null == this.Const.MoraleState.Fleeing));
                    }
                    else
                    {
                        if ((null == this.Const.MoraleState.Fleeing).IsImmuneToStun && (null == this.Const.MoraleState.Fleeing).IsImmuneToStun)
                        {
                            return ((null == this.Const.MoraleState.Fleeing).IsImmuneToStun && (null == this.Const.MoraleState.Fleeing).IsImmuneToStun);
                        }
                        else
                        {
                            if (_skill.getID() == "actives.golem_grapple")
                            {
                                foreach (local key, value in this.getAgent().getKnownAllies())
                                {
                                    if (null.getTile().getDistanceTo(null.getTile() <= null.getIdealRange()))
                                    {
                                    }
                                    if (!true)
                                    {
                                    }
                                    else
                                    {
                                        if ((null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions() <= 1) && (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) <= 1) && (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) <= 1)))
                                        {
                                            return ((null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) <= 1) && (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) <= 1) && (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) <= 1));
                                        }
                                        if (null.getHitpoints() <= (_entity.getSkills().getAttackOfOpportunity().getExpectedDamage(null).HitpointDamage + _entity.getSkills().getAttackOfOpportunity().getExpectedDamage(null).DirectDamage))
                                        {
                                        }
                                        if (null.getMoraleState() == this.Const.MoraleState.Fleeing)
                                        {
                                        }
                                        if (null.getSkills().hasSkill("effects.distracted"))
                                        {
                                        }
                                        if (null.getSkills().hasSkill("effects.dazed"))
                                        {
                                        }
                                        if (null && null)
                                        {
                                            return (null && null);
                                        }
                                        if (null.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.MeleeWeapon) && null.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.MeleeWeapon))
                                        {
                                            return (null.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.MeleeWeapon) && null.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.MeleeWeapon));
                                        }
                                        if (null && null)
                                        {
                                            return (null && null);
                                        }
                                        if (null && null)
                                        {
                                            return (null && null);
                                        }
                                        if ((!null.getTile().Properties.Effect.IsPositive) && (!null.getTile().Properties.Effect.IsPositive))
                                        {
                                            return ((!null.getTile().Properties.Effect.IsPositive) && (!null.getTile().Properties.Effect.IsPositive));
                                        }
                                        if (_skill.getID() == "actives.golem_grapple")
                                        {
                                        }
                                        if (0 < 6)
                                        {
                                            if (!null.getTile().hasNextTile(0))
                                            {
                                            }
                                            else
                                            {
                                                if (0 && 0)
                                                {
                                                    return (0 && 0);
                                                    if (null.getTile().getNextTile(0).getEntity().getCurrentProperties().TargetAttractionMult > 1.0)
                                                    {
                                                    }
                                                    if (null.getTile().getNextTile(0).getEntity().getSkills().hasSkill("actives.deathblow"))
                                                    {
                                                    }
                                                }
                                            }
                                        }
                                        if (null.getTile().getZoneOfControlCount(_entity.getFaction() == 0))
                                        {
                                        }
                                        foreach (local key, value in r34)
                                        {
                                            if ((!1.0) && (!1.0))
                                            {
                                                return ((!1.0) && (!1.0));
                                            }
                                            if (this.queryActorTurnsNearTarget(null, null.getTile(), null).Turns <= 1.0)
                                            {
                                            }
                                            if (((_entity.getActionPoints() - _skill.getActionPointCost() >= 2) && ((_entity.getActionPoints() - _skill.getActionPointCost()) >= 2) && ((_entity.getActionPoints() - _skill.getActionPointCost()) >= 2) && ((_entity.getActionPoints() - _skill.getActionPointCost()) >= 2)))
                                            {
                                                return (((_entity.getActionPoints() - _skill.getActionPointCost()) >= 2) && ((_entity.getActionPoints() - _skill.getActionPointCost()) >= 2) && ((_entity.getActionPoints() - _skill.getActionPointCost()) >= 2) && ((_entity.getActionPoints() - _skill.getActionPointCost()) >= 2));
                                                this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
                                                this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
                                                this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
                                                this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
                                                this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
                                                this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = false;
                                                this.Tactical.getNavigator().createSettings().ZoneOfControlCost = 0;
                                                this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
                                                this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
                                                foreach (local key, value in r92)
                                                {
                                                    if ((null.Actor == null) && (null.Actor == null))
                                                    {
                                                        return ((null.Actor == null) && (null.Actor == null));
                                                    }
                                                    if (null.Actor.getTile().getZoneOfOccupationCountOtherThan(null.Actor.getAlliedFactions() > 2))
                                                    {
                                                    }
                                                    if ((this.Math <= 1) && (this.Math <= 1))
                                                    {
                                                        return ((this.Math <= 1) && (this.Math <= 1));
                                                    }
                                                    if (this.queryTargetValue(_entity, null.Actor, null) > 0.0)
                                                    {
                                                        this.Tactical.getNavigator().createSettings().TileToConsiderEmpty = null.getTile();
                                                        if (this.Tactical.getNavigator().findPath(_entity.getTile(), null.Actor.getTile(), this.Tactical.getNavigator().createSettings(), 1))
                                                        {
                                                            if (this.Tactical.getNavigator().getTurnsRequiredForPath(_entity, this.Tactical.getNavigator().createSettings(), (_entity.getActionPoints() - _skill.getActionPointCost(), null.Actor.getTile(), _entity.getFaction()) > 1.0))
                                                            {
                                                            }
                                                        }
                                                    }
                                                    if (this.queryTargetValue(_entity, null.Actor, null) > (this.queryTargetValue(_entity, null, null) * this.Const.AI.Behavior.KnockBackBetterTargetPct))
                                                    {
                                                    }
                                                    if (((((((((((((((((null.getHitpoints() / null.getHitpointsMax() * (_skill.getHitchance(null) * 0.009999999776482582)) * null.getCurrentProperties().TargetAttractionMult) * this.Const.AI.Behavior.KnockoutFleeingMult) * this.Const.AI.Behavior.KnockoutDistractedMult) * this.Const.AI.Behavior.KnockoutDazedMult) * this.Const.AI.Behavior.KnockoutPriorityMult) * this.Const.AI.Behavior.KnockoutPriorityMult) * this.Const.AI.Behavior.KnockoutPriorityMult) * this.Const.AI.Behavior.KnockoutTargetWithQuickHandsMult) * this.Const.AI.Behavior.KnockoutPriorityMult) * this.Const.AI.Behavior.KnockoutPriorityMult) * this.Const.AI.Behavior.KnockoutPriorityMult) * this.Const.AI.Behavior.KnockoutSetupDeathblowMult) * this.Const.AI.Behavior.KnockoutProtectPriorityTargetMult) * this.Const.AI.Behavior.KnockBackEngageBetterTargetMult) > 0.0))
                                                    {
                                                    }
                                                    if (_skill.getID() == "actives.golem_grapple")
                                                    {
                                                    }
                                                    this.m.BestTarget = {Target = null, Score = (((((((((((((((((null.getHitpoints() / null.getHitpointsMax()) * (_skill.getHitchance(null) * 0.009999999776482582)) * null.getCurrentProperties().TargetAttractionMult) * this.Const.AI.Behavior.KnockoutFleeingMult) * this.Const.AI.Behavior.KnockoutDistractedMult) * this.Const.AI.Behavior.KnockoutDazedMult) * this.Const.AI.Behavior.KnockoutPriorityMult) * this.Const.AI.Behavior.KnockoutPriorityMult) * this.Const.AI.Behavior.KnockoutPriorityMult) * this.Const.AI.Behavior.KnockoutTargetWithQuickHandsMult) * this.Const.AI.Behavior.KnockoutPriorityMult) * this.Const.AI.Behavior.KnockoutPriorityMult) * this.Const.AI.Behavior.KnockoutPriorityMult) * this.Const.AI.Behavior.KnockoutSetupDeathblowMult) * this.Const.AI.Behavior.KnockoutProtectPriorityTargetMult) * this.Const.AI.Behavior.KnockBackEngageBetterTargetMult) * this.Const.AI.Behavior.KnockoutDisarmMult)};
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

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.Skill = null;
    this.m.BestTarget = null;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (!this.getAgent().hasVisibleOpponent())
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (this.m.Skill.isRanged())
    {
    }
    if (this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), (this.m.Skill.getMaxRange() + 0), this.m.Skill.getMaxLevelDifference().len() == 0))
    {
        return _entity;
    }
    if (resume this == null)
    {
        yield null;
    }
    if (this.m.BestTarget.Target == null)
    {
        return _entity;
    }
    this.m.TargetTile = this.m.BestTarget.Target.getTile();
    return _entity;
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        this.getAgent().adjustCameraToTarget(this.m.TargetTile);
        this.m.IsFirstExecuted = false;
        return _entity;
    }
    if (this.m.TargetTile.IsOccupiedByActor && this.m.TargetTile.IsOccupiedByActor)
    {
        return (this.m.TargetTile.IsOccupiedByActor && this.m.TargetTile.IsOccupiedByActor);
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((((((("* " + _entity.getName()) + ": Using ") + this.m.Skill.getName()) + " against ") + this.m.TargetTile.getEntity().getName()) + "!"));
        }
        this.m.Skill.use(this.m.TargetTile);
        if (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer)
        {
            return (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer);
            this.getAgent().declareAction();
            if (this.m.Skill.getDelay() != 0)
            {
                this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
            }
        }
        this.m.TargetTile = null;
    }
    return _entity;
}
