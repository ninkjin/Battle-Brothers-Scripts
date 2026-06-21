// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_defend_shieldwall.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Shieldwall;
    this.m.Order = this.Const.AI.Behavior.Order.Shieldwall;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
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
    if (this.Tactical.State.isAutoRetreat())
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (_entity.getSkills().hasSkill("effects.adrenaline"))
    {
        return _entity;
    }
    foreach (local key, value in null)
    {
        if ((0 + null.getDamage() >= _entity.getHitpoints()))
        {
            return _entity;
        }
        if (_entity.getAttackedCount() >= this.Const.AI.Behavior.ShieldwallMinOverwhelmCount)
        {
        }
        if (this.getAgent().getIntentions().IsDefendingPosition)
        {
        }
        if (this.queryTargetsInMeleeRange().len() != 0)
        {
            if (r10 != 0)
            {
                foreach (local key, value in r153)
                {
                    if (null.isNonCombatant())
                    {
                    }
                    if (null.isFatigued() || null.isFatigued() || null.isFatigued() || null.isFatigued() || null.isFatigued() || null.isFatigued())
                    {
                        return (null.isFatigued() || null.isFatigued() || null.isFatigued() || null.isFatigued() || null.isFatigued() || null.isFatigued());
                    }
                    else
                    {
                        if (0 < 6)
                        {
                            if (!null.getTile().hasNextTile(0))
                            {
                            }
                            else
                            {
                                if ((null.getTile().getNextTile(0).getEntity().getCurrentProperties().TargetAttractionMult > 1.0) && (null.getTile().getNextTile(0).getEntity().getCurrentProperties().TargetAttractionMult > 1.0))
                                {
                                    return ((null.getTile().getNextTile(0).getEntity().getCurrentProperties().TargetAttractionMult > 1.0) && (null.getTile().getNextTile(0).getEntity().getCurrentProperties().TargetAttractionMult > 1.0));
                                }
                            }
                        }
                    }
                    if (this.Const.ItemSlot.Mainhand && this.Const.ItemSlot.Mainhand)
                    {
                        return (this.Const.ItemSlot.Mainhand && this.Const.ItemSlot.Mainhand);
                    }
                    if ((0 + 10) > 1)
                    {
                    }
                    if (((0 + 9) + 9) > 0)
                    {
                    }
                    if (null.getSkills().hasSkill("effects.riposte"))
                    {
                    }
                    if ((this.queryTargetsInMeleeRange().len() != 0) && (this.queryTargetsInMeleeRange().len() != 0))
                    {
                        return ((this.queryTargetsInMeleeRange().len() != 0) && (this.queryTargetsInMeleeRange().len() != 0));
                        if (0 != 6)
                        {
                            if (!(this.queryTargetsInMeleeRange().len() != 0).hasNextTile(0))
                            {
                            }
                            else
                            {
                                if (!(this.queryTargetsInMeleeRange().len() != 0).getNextTile(0).IsOccupiedByActor)
                                {
                                }
                                else
                                {
                                    if (!(this.queryTargetsInMeleeRange().len() != 0).getNextTile(0).getEntity().isAlliedWith(_entity))
                                    {
                                    }
                                    else
                                    {
                                        if (this.queryTargetsInMeleeRange().len() != 0).getNextTile(0).getEntity().isArmedWithShield()
                                        {
                                            if (this.queryTargetsInMeleeRange().len() != 0).getNextTile(0).getEntity().getSkills().hasSkill("effects.shieldwall")
                                            {
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if ((this.getAgent().getIntentions().TargetTile != null) && (this.getAgent().getIntentions().TargetTile != null))
                    {
                        return ((this.getAgent().getIntentions().TargetTile != null) && (this.getAgent().getIntentions().TargetTile != null));
                        if (0 < this.Const.Direction.COUNT)
                        {
                            if (!this.getAgent().getIntentions().TargetTile.hasNextTile(0))
                            {
                            }
                            else
                            {
                                if ((this.Math > 1) && (this.Math > 1))
                                {
                                    return ((this.Math > 1) && (this.Math > 1));
                                }
                                else
                                {
                                    if (this.getAgent().getIntentions().TargetTile.getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall") && this.getAgent().getIntentions().TargetTile.getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall") && this.getAgent().getIntentions().TargetTile.getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall"))
                                    {
                                        return (this.getAgent().getIntentions().TargetTile.getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall") && this.getAgent().getIntentions().TargetTile.getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall") && this.getAgent().getIntentions().TargetTile.getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall"));
                                    }
                                }
                            }
                        }
                        if ((0 + 13) != 0)
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
                            if (this.Tactical.getNavigator().findPath(_entity.getTile(), this.getAgent().getIntentions().TargetTile, this.Tactical.getNavigator().createSettings(), 0))
                            {
                                if ((this.m.Skill.getActionPointCost() <= this.m.Skill.getActionPointCost) && (this.m.Skill.getActionPointCost() <= this.m.Skill.getActionPointCost))
                                {
                                    return ((this.m.Skill.getActionPointCost() <= this.m.Skill.getActionPointCost) && (this.m.Skill.getActionPointCost() <= this.m.Skill.getActionPointCost));
                                }
                            }
                        }
                        else
                        {
                            if ((!this.getStrategy().getStats().IsEngaged) && (!this.getStrategy().getStats().IsEngaged))
                            {
                                return ((!this.getStrategy().getStats().IsEngaged) && (!this.getStrategy().getStats().IsEngaged));
                                return _entity;
                            }
                            if (_entity.getActionPoints() >= (this.m.Skill.getActionPointCost() * 2))
                            {
                            }
                            if ((this.queryTargetsInMeleeRange().len() != 0).IsBadTerrain || (this.queryTargetsInMeleeRange().len() != 0).IsBadTerrain)
                            {
                                return ((this.queryTargetsInMeleeRange().len() != 0).IsBadTerrain || (this.queryTargetsInMeleeRange().len() != 0).IsBadTerrain);
                            }
                            if (this.getAgent().getIntentions().Target != null)
                            {
                                if (this.queryTargetValue(_entity, this.getAgent().getIntentions().Target, null) >= this.Const.AI.Behavior.ShieldwallMinTargetPrefValue)
                                {
                                    if (_entity.getActionPoints() < (this.m.Skill.getActionPointCost() + this.getAgent().getIntentions().APToReachTarget))
                                    {
                                    }
                                }
                            }
                        }
                    }
                    if (this.queryTargetsInMeleeRange().len() != 0)
                    {
                    }
                    foreach (local key, value in r160)
                    {
                        if (null.Actor.isNull())
                        {
                        }
                        else
                        {
                            if (null.Actor.isNonCombatant() || null.Actor.isNonCombatant())
                            {
                                return (null.Actor.isNonCombatant() || null.Actor.isNonCombatant());
                            }
                            else
                            {
                                if (0 && 0)
                                {
                                    return (0 && 0);
                                    if (null.Actor.getTile().getDistanceTo((this.queryTargetsInMeleeRange().len() != 0) <= null.Actor.getRangedWeaponInfo().RangeWithLevel))
                                    {
                                    }
                                }
                                else
                                {
                                    if ((null.Actor.getHitpointsPct() > 0.25) && (null.Actor.getHitpointsPct() > 0.25) && (null.Actor.getHitpointsPct() > 0.25))
                                    {
                                        return ((null.Actor.getHitpointsPct() > 0.25) && (null.Actor.getHitpointsPct() > 0.25) && (null.Actor.getHitpointsPct() > 0.25));
                                        if (this.Const.ItemSlot.Mainhand && this.Const.ItemSlot.Mainhand)
                                        {
                                            return (this.Const.ItemSlot.Mainhand && this.Const.ItemSlot.Mainhand);
                                        }
                                        if ((null.Actor.getTile().getDistanceTo((this.queryTargetsInMeleeRange().len() != 0) > null.Actor) && (null.Actor.getTile().getDistanceTo((this.queryTargetsInMeleeRange().len() != 0)) > null.Actor)))
                                        {
                                            return ((null.Actor.getTile().getDistanceTo((this.queryTargetsInMeleeRange().len() != 0)) > null.Actor) && (null.Actor.getTile().getDistanceTo((this.queryTargetsInMeleeRange().len() != 0)) > null.Actor));
                                        }
                                        if ((this.queryActorTurnsNearTarget(null.Actor, (this.queryTargetsInMeleeRange().len() != 0), _entity).InZonesOfControl <= 1) && (this.queryActorTurnsNearTarget(null.Actor, (this.queryTargetsInMeleeRange().len() != 0), _entity).InZonesOfControl <= 1))
                                        {
                                            return ((this.queryActorTurnsNearTarget(null.Actor, (this.queryTargetsInMeleeRange().len() != 0), _entity).InZonesOfControl <= 1) && (this.queryActorTurnsNearTarget(null.Actor, (this.queryTargetsInMeleeRange().len() != 0), _entity).InZonesOfControl <= 1));
                                        }
                                    }
                                }
                                if (((0 + 14) == 0) && ((0 + 14) == 0))
                                {
                                    return (((0 + 14) == 0) && ((0 + 14) == 0));
                                    return _entity;
                                }
                                if ((0 + 13) > 0)
                                {
                                }
                                if (((0 + 14) > ((0 + 9) + 9) && ((0 + 14) > ((0 + 9) + 9))))
                                {
                                    return (((0 + 14) > ((0 + 9) + 9)) && ((0 + 14) > ((0 + 9) + 9)));
                                }
                                if ((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeIdeal() <= 4) && (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeIdeal() <= 4) && (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeIdeal() <= 4))
                                {
                                    return ((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeIdeal() <= 4) && (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeIdeal() <= 4) && (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeIdeal() <= 4));
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

function onExecute(this, _entity)
{
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Using Shieldwall!"));
    }
    this.m.Skill.use(_entity.getTile());
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
    }
    this.m.Skill = null;
    return _entity;
}
