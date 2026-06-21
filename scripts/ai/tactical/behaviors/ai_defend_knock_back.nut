// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_defend_knock_back.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.KnockBack;
    this.m.Order = this.Const.AI.Behavior.Order.KnockBack;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.DestinationTile = null;
    this.m.Skill = null;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if ((!this.Const.MoraleState.Fleeing) && (!this.Const.MoraleState.Fleeing))
    {
        return ((!this.Const.MoraleState.Fleeing) && (!this.Const.MoraleState.Fleeing));
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (!this.getStrategy().getStats().IsEngaged)
    {
    }
    if (this.m.Skill.getID() == "actives.flesh_pull")
    {
        foreach (local key, value in r31)
        {
            foreach (local key, value in r26)
            {
                if ((null == r14) && (null == r14))
                {
                    return ((null == r14) && (null == r14));
                }
                if (!null.isAlliedWith(_entity))
                {
                    [].push(null);
                }
                if (this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange(), this.m.Skill.getMaxLevelDifference().len() == 0))
                {
                    return _entity;
                }
                if (_entity.getSkills().hasSkill("perk.shield_bash"))
                {
                    if (_entity.getSkills().hasSkill("perk.shield_bash"))
                    {
                    }
                }
                if (0 != 6)
                {
                    if (!_entity.getTile().hasNextTile(0))
                    {
                    }
                    else
                    {
                        if ((!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity) && (!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity)) && (!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity)) && (!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity))))
                        {
                            return ((!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity)) && (!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity)) && (!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity)) && (!_entity.getTile().getNextTile(0).getEntity().isAlliedWith(_entity)));
                        }
                    }
                }
                foreach (local key, value in r1969)
                {
                    if ((null.getMoraleState() == this.Const.MoraleState.Fleeing) || (null.getMoraleState() == this.Const.MoraleState.Fleeing))
                    {
                        return ((null.getMoraleState() == this.Const.MoraleState.Fleeing) || (null.getMoraleState() == this.Const.MoraleState.Fleeing));
                    }
                    if (!this.m.Skill)
                    {
                    }
                    if ((this.m.Skill == r31) && (this.m.Skill == r31))
                    {
                        return ((this.m.Skill == r31) && (this.m.Skill == r31));
                    }
                    else
                    {
                        if (this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile() != null))
                        {
                            this.m.Skill.getPulledToTiles(_entity.getTile(), null.getTile()).push(this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()));
                        }
                    }
                    if (this.m.Skill.getPulledToTiles(_entity.getTile(), null.getTile().len() == 0))
                    {
                    }
                    if (0 != 6)
                    {
                        if (!null.getTile().hasNextTile(0))
                        {
                        }
                        else
                        {
                            if (null.getTile().getNextTile(0).getEntity().isAlliedWith(null) && null.getTile().getNextTile(0).getEntity().isAlliedWith(null) && null.getTile().getNextTile(0).getEntity().isAlliedWith(null))
                            {
                                return (null.getTile().getNextTile(0).getEntity().isAlliedWith(null) && null.getTile().getNextTile(0).getEntity().isAlliedWith(null) && null.getTile().getNextTile(0).getEntity().isAlliedWith(null));
                            }
                        }
                    }
                    if (0 != 6)
                    {
                        if (!null.getTile().hasNextTile(0))
                        {
                        }
                        else
                        {
                            if ((!null.getTile().getNextTile(0).getEntity().isAlliedWith(null) && (!null.getTile().getNextTile(0).getEntity().isAlliedWith(null)) && (!null.getTile().getNextTile(0).getEntity().isAlliedWith(null))))
                            {
                                return ((!null.getTile().getNextTile(0).getEntity().isAlliedWith(null)) && (!null.getTile().getNextTile(0).getEntity().isAlliedWith(null)) && (!null.getTile().getNextTile(0).getEntity().isAlliedWith(null)));
                                if ((null.getTile().getNextTile(0).getEntity().isTurnDone >= 4) && (null.getTile().getNextTile(0).getEntity().isTurnDone >= 4))
                                {
                                    return ((null.getTile().getNextTile(0).getEntity().isTurnDone >= 4) && (null.getTile().getNextTile(0).getEntity().isTurnDone >= 4));
                                }
                            }
                        }
                    }
                    foreach (local key, value in null)
                    {
                        if (null.Actor.getID() == null.getID())
                        {
                        }
                        if ((null.Actor.getTile().getDistanceTo(null.getTile() < 0) && (null.Actor.getTile().getDistanceTo(null.getTile()) < 0)))
                        {
                            return ((null.Actor.getTile().getDistanceTo(null.getTile()) < 0) && (null.Actor.getTile().getDistanceTo(null.getTile()) < 0));
                        }
                        if (null.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE())
                        {
                            if (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions() == 0))
                            {
                                if (84)
                                {
                                    yield _entity;
                                }
                            }
                            foreach (local key, value in r1635)
                            {
                                if (0 != 6)
                                {
                                    if (!null.hasNextTile(0))
                                    {
                                    }
                                    else
                                    {
                                        if ((this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0))
                                        {
                                            return ((this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0));
                                            if ((null.getNextTile(0).getEntity().isTurnDone >= 4) && (null.getNextTile(0).getEntity().isTurnDone >= 4))
                                            {
                                                return ((null.getNextTile(0).getEntity().isTurnDone >= 4) && (null.getNextTile(0).getEntity().isTurnDone >= 4));
                                            }
                                        }
                                    }
                                }
                                if (0 != 6)
                                {
                                    if (!null.hasNextTile(0))
                                    {
                                    }
                                    else
                                    {
                                        if (null.getNextTile(0).getEntity().isAlliedWith(null) && null.getNextTile(0).getEntity().isAlliedWith(null) && null.getNextTile(0).getEntity().isAlliedWith(null))
                                        {
                                            return (null.getNextTile(0).getEntity().isAlliedWith(null) && null.getNextTile(0).getEntity().isAlliedWith(null) && null.getNextTile(0).getEntity().isAlliedWith(null));
                                        }
                                    }
                                }
                                if (null.getCurrentProperties().IsStunned)
                                {
                                }
                                if ((null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions() == 0) || (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) == 0)))
                                {
                                    return ((null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) == 0) || (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) == 0));
                                }
                                if ((this.m.Skill == r70) && (this.m.Skill == r70))
                                {
                                    return ((this.m.Skill == r70) && (this.m.Skill == r70));
                                }
                                foreach (local key, value in null.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE())
                                {
                                    if (null.Actor.getID() == null.getID())
                                    {
                                    }
                                    if ((null.Actor.getTile().getDistanceTo(null) < 0) && (null.Actor.getTile().getDistanceTo(null) < 0))
                                    {
                                        return ((null.Actor.getTile().getDistanceTo(null) < 0) && (null.Actor.getTile().getDistanceTo(null) < 0));
                                    }
                                    if ((null.Actor.getTile().getDistanceTo(null) > null.Actor.getTile().getDistanceTo(null.getTile()) && (null.Actor.getTile().getDistanceTo(null) > null.Actor.getTile().getDistanceTo(null.getTile()))))
                                    {
                                        return ((null.Actor.getTile().getDistanceTo(null) > null.Actor.getTile().getDistanceTo(null.getTile())) && (null.Actor.getTile().getDistanceTo(null) > null.Actor.getTile().getDistanceTo(null.getTile())));
                                    }
                                    if ((0 <= 50) && (0 <= 50))
                                    {
                                        return ((0 <= 50) && (0 <= 50));
                                    }
                                    if (((this.Math.max(0, (this.Math.abs((null.Level - null.getTile().Level) - 1)) * this.Const.Combat.FallingDamage) + 0) >= null.getHitpoints()))
                                    {
                                    }
                                    else
                                    {
                                        if (((0 + 37) >= 2) && ((0 + 37) >= 2) && ((0 + 37) >= 2) && ((0 + 37) >= 2) && ((0 + 37) >= 2) && ((0 + 37) >= 2))
                                        {
                                            return (((0 + 37) >= 2) && ((0 + 37) >= 2) && ((0 + 37) >= 2) && ((0 + 37) >= 2) && ((0 + 37) >= 2) && ((0 + 37) >= 2));
                                        }
                                        if ((this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0))
                                        {
                                            return ((this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0));
                                        }
                                        if ((this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0))
                                        {
                                            return ((this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0) && (this.getProperties().BehaviorMult["this.m.ID"] > 1.0));
                                        }
                                        else
                                        {
                                            if ((null.getHitpointsPct() >= 0.5) && (null.getHitpointsPct() >= 0.5) && (null.getHitpointsPct() >= 0.5) && (null.getHitpointsPct() >= 0.5))
                                            {
                                                return ((null.getHitpointsPct() >= 0.5) && (null.getHitpointsPct() >= 0.5) && (null.getHitpointsPct() >= 0.5) && (null.getHitpointsPct() >= 0.5));
                                            }
                                        }
                                        if (((0 + 37) != 0) && ((0 + 37) != 0))
                                        {
                                            return (((0 + 37) != 0) && ((0 + 37) != 0));
                                        }
                                        if ((null.Properties.Effect.Timeout > (this.Time.getRound() + 1) && (null.Properties.Effect.Timeout > (this.Time.getRound() + 1)) && (null.Properties.Effect.Timeout > (this.Time.getRound() + 1))))
                                        {
                                            return ((null.Properties.Effect.Timeout > (this.Time.getRound() + 1)) && (null.Properties.Effect.Timeout > (this.Time.getRound() + 1)) && (null.Properties.Effect.Timeout > (this.Time.getRound() + 1)));
                                        }
                                        else
                                        {
                                            if ((!null.getTile().IsBadTerrain) && (!null.getTile().IsBadTerrain))
                                            {
                                                return ((!null.getTile().IsBadTerrain) && (!null.getTile().IsBadTerrain));
                                            }
                                        }
                                        if ((!(!null.IsBadTerrain) && (!(!null.IsBadTerrain)) && (!(!null.IsBadTerrain)) && (!(!null.IsBadTerrain)) && (!(!null.IsBadTerrain)) && (!(!null.IsBadTerrain))))
                                        {
                                            return ((!(!null.IsBadTerrain)) && (!(!null.IsBadTerrain)) && (!(!null.IsBadTerrain)) && (!(!null.IsBadTerrain)) && (!(!null.IsBadTerrain)) && (!(!null.IsBadTerrain)));
                                        }
                                        if (((!(!null.IsBadTerrain) != 0) && ((!(!null.IsBadTerrain)) != 0)))
                                        {
                                            return (((!(!null.IsBadTerrain)) != 0) && ((!(!null.IsBadTerrain)) != 0));
                                            if (0 < this.Const.Direction.COUNT)
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
                                                    else
                                                    {
                                                        if (null.getTile().getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall") && null.getTile().getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall") && null.getTile().getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall"))
                                                        {
                                                            return (null.getTile().getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall") && null.getTile().getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall") && null.getTile().getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall"));
                                                        }
                                                    }
                                                }
                                            }
                                            if ((0 + 44) > 0)
                                            {
                                            }
                                        }
                                        if (((this.Math.pow >= ((this.m.Skill.getActionPointCost() + this.Const.AI.Behavior.KnockBackSpearwallMult[null.getTile().Type]) + 0) > 1) && ((this.Math.pow >= ((this.m.Skill.getActionPointCost() + this.Const.AI.Behavior.KnockBackSpearwallMult[null.getTile().Type]) + 0)) > 1)))
                                        {
                                            return (((this.Math.pow >= ((this.m.Skill.getActionPointCost() + this.Const.AI.Behavior.KnockBackSpearwallMult[null.getTile().Type]) + 0)) > 1) && ((this.Math.pow >= ((this.m.Skill.getActionPointCost() + this.Const.AI.Behavior.KnockBackSpearwallMult[null.getTile().Type]) + 0)) > 1));
                                            if ((null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level))
                                            {
                                                return ((null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level));
                                            }
                                            if ((null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level))
                                            {
                                                return ((null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level));
                                            }
                                            if ((null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level))
                                            {
                                                return ((null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level) && (null.Level <= null.getTile().Level));
                                            }
                                            if ((null.Properties.Effect == null) && (null.Properties.Effect == null) && (null.Properties.Effect == null) && (null.Properties.Effect == null) && (null.Properties.Effect == null))
                                            {
                                                return ((null.Properties.Effect == null) && (null.Properties.Effect == null) && (null.Properties.Effect == null) && (null.Properties.Effect == null) && (null.Properties.Effect == null));
                                            }
                                        }
                                        if ((this.Math.abs((null.Level - _entity.getTile().Level) >= 2) && (this.Math.abs((null.Level - _entity.getTile().Level)) >= 2) && (this.Math.abs((null.Level - _entity.getTile().Level)) >= 2)))
                                        {
                                            return ((this.Math.abs((null.Level - _entity.getTile().Level)) >= 2) && (this.Math.abs((null.Level - _entity.getTile().Level)) >= 2) && (this.Math.abs((null.Level - _entity.getTile().Level)) >= 2));
                                            this.Tactical.getNavigator().createSettings().ActionPointCosts = _entity.getActionPointCosts();
                                            this.Tactical.getNavigator().createSettings().FatigueCosts = _entity.getFatigueCosts();
                                            this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
                                            this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _entity.getLevelActionPointCost();
                                            this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = _entity.getLevelFatigueCost();
                                            this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = false;
                                            this.Tactical.getNavigator().createSettings().ZoneOfControlCost = 0;
                                            this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
                                            this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
                                            foreach (local key, value in r100)
                                            {
                                                if ((null.Actor == null.getTile().getNextTile(0).getEntity().getAlliedFactions) && (null.Actor == null.getTile().getNextTile(0).getEntity().getAlliedFactions))
                                                {
                                                    return ((null.Actor == null.getTile().getNextTile(0).getEntity().getAlliedFactions) && (null.Actor == null.getTile().getNextTile(0).getEntity().getAlliedFactions));
                                                }
                                                if (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions() > 2))
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
                                                        if ((this.Tactical.getNavigator().getTurnsRequiredForPath(_entity, this.Tactical.getNavigator().createSettings(), (_entity.getActionPoints() - this.m.Skill.getActionPointCost(), null.Actor.getTile(), _entity.getFaction()) > (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) > 0)) && (this.Tactical.getNavigator().getTurnsRequiredForPath(_entity, this.Tactical.getNavigator().createSettings(), (_entity.getActionPoints() - this.m.Skill.getActionPointCost()), null.Actor.getTile(), _entity.getFaction()) > (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) > 0))))
                                                        {
                                                            return ((this.Tactical.getNavigator().getTurnsRequiredForPath(_entity, this.Tactical.getNavigator().createSettings(), (_entity.getActionPoints() - this.m.Skill.getActionPointCost()), null.Actor.getTile(), _entity.getFaction()) > (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) > 0)) && (this.Tactical.getNavigator().getTurnsRequiredForPath(_entity, this.Tactical.getNavigator().createSettings(), (_entity.getActionPoints() - this.m.Skill.getActionPointCost()), null.Actor.getTile(), _entity.getFaction()) > (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) > 0)));
                                                        }
                                                    }
                                                }
                                                if (this.queryTargetValue(_entity, null.Actor, null) > (this.queryTargetValue(_entity, null, null) * this.Const.AI.Behavior.KnockBackBetterTargetPct))
                                                {
                                                }
                                                if (0 != 6)
                                                {
                                                    if (!null.getTile().hasNextTile(0))
                                                    {
                                                    }
                                                    else
                                                    {
                                                        if ((this.Math <= 1) && (this.Math <= 1))
                                                        {
                                                            return ((this.Math <= 1) && (this.Math <= 1));
                                                            if (this.isRangedUnit(null.getTile().getNextTile(0).getEntity() && this.isRangedUnit(null.getTile().getNextTile(0).getEntity())))
                                                            {
                                                                return (this.isRangedUnit(null.getTile().getNextTile(0).getEntity()) && this.isRangedUnit(null.getTile().getNextTile(0).getEntity()));
                                                            }
                                                        }
                                                    }
                                                }
                                                if (0 != 6)
                                                {
                                                    if (!null.hasNextTile(0))
                                                    {
                                                    }
                                                    else
                                                    {
                                                        if ((this.Math <= 1) && (this.Math <= 1))
                                                        {
                                                            return ((this.Math <= 1) && (this.Math <= 1));
                                                            if ((null.getNextTile(0).getEntity().getCurrentProperties().TargetAttractionMult > 1.0) && (null.getNextTile(0).getEntity().getCurrentProperties().TargetAttractionMult > 1.0) && (null.getNextTile(0).getEntity().getCurrentProperties().TargetAttractionMult > 1.0))
                                                            {
                                                                return ((null.getNextTile(0).getEntity().getCurrentProperties().TargetAttractionMult > 1.0) && (null.getNextTile(0).getEntity().getCurrentProperties().TargetAttractionMult > 1.0) && (null.getNextTile(0).getEntity().getCurrentProperties().TargetAttractionMult > 1.0));
                                                            }
                                                        }
                                                    }
                                                }
                                                if (false && false)
                                                {
                                                    return (false && false);
                                                    if (null.getZoneOfControlCountOtherThan(null.getAlliedFactions() != 0))
                                                    {
                                                    }
                                                    else
                                                    {
                                                        if ((null.getTile().Level - _entity.getTile().Level) != 0)
                                                        {
                                                        }
                                                        if ((null.getTile().getNextTile(0).getEntity().getTile().getZoneOfControlCountOtherThan(null.getTile().getNextTile(0).getEntity().getAlliedFactions() <= 1) || (null.getTile().getNextTile(0).getEntity().getTile().getZoneOfControlCountOtherThan(null.getTile().getNextTile(0).getEntity().getAlliedFactions()) <= 1)))
                                                        {
                                                            return ((null.getTile().getNextTile(0).getEntity().getTile().getZoneOfControlCountOtherThan(null.getTile().getNextTile(0).getEntity().getAlliedFactions()) <= 1) || (null.getTile().getNextTile(0).getEntity().getTile().getZoneOfControlCountOtherThan(null.getTile().getNextTile(0).getEntity().getAlliedFactions()) <= 1));
                                                        }
                                                    }
                                                }
                                                if (((null.Level - null.getTile().Level) <= -2) && ((null.Level - null.getTile().Level) <= -2) && ((null.Level - null.getTile().Level) <= -2))
                                                {
                                                    return (((null.Level - null.getTile().Level) <= -2) && ((null.Level - null.getTile().Level) <= -2) && ((null.Level - null.getTile().Level) <= -2));
                                                    if (!(null.getZoneOfControlCountOtherThan(null.getAlliedFactions() != 0)))
                                                    {
                                                        this.Tactical.getNavigator().createSettings().ActionPointCosts = null.getActionPointCosts();
                                                        this.Tactical.getNavigator().createSettings().FatigueCosts = null.getFatigueCosts();
                                                        this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
                                                        this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = null.getLevelActionPointCost();
                                                        this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = null.getLevelFatigueCost();
                                                        this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = false;
                                                        this.Tactical.getNavigator().createSettings().ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
                                                        this.Tactical.getNavigator().createSettings().AlliedFactions = null.getAlliedFactions();
                                                        this.Tactical.getNavigator().createSettings().Faction = null.getFaction();
                                                        this.Tactical.getNavigator().createSettings().TileToConsiderEmpty = null.getTile();
                                                        if (this.Tactical.getNavigator().findPath(null, _entity.getTile(), this.Tactical.getNavigator().createSettings(), 1))
                                                        {
                                                            if (this.Tactical.getNavigator().getTurnsRequiredForPath(null, this.Tactical.getNavigator().createSettings(), null.getActionPointsMax(), null.getTile(), null.getFaction() <= this.Const.AI.Behavior.KnockBackKnockDownMinTurnsToGetBack))
                                                            {
                                                            }
                                                        }
                                                        if (this.m.Skill.m.IsTargetingCorpses)
                                                        {
                                                            if (null.getTile().IsCorpseSpawned)
                                                            {
                                                                if (!null.getTile().Properties.get("Corpse").IsConsumable)
                                                                {
                                                                }
                                                            }
                                                            else
                                                            {
                                                                if (null.IsCorpseSpawned)
                                                                {
                                                                    if (!null.Properties.get("Corpse").IsConsumable)
                                                                    {
                                                                    }
                                                                }
                                                                else
                                                                {
                                                                    if (0 != 6)
                                                                    {
                                                                        if (!null.getTile().hasNextTile(0))
                                                                        {
                                                                        }
                                                                        else
                                                                        {
                                                                            if (null.getTile().getNextTile(0).IsCorpseSpawned)
                                                                            {
                                                                            }
                                                                        }
                                                                    }
                                                                    if (!true)
                                                                    {
                                                                        if (0 != 6)
                                                                        {
                                                                            if (!null.hasNextTile(0))
                                                                            {
                                                                            }
                                                                            else
                                                                            {
                                                                                if (null.getNextTile(0).IsCorpseSpawned)
                                                                                {
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        if (this.m.Skill.m.IsTargetingDangerTiles)
                                                        {
                                                            foreach (local key, value in null)
                                                            {
                                                                if (null.getTile().ID == null.ID)
                                                                {
                                                                }
                                                                else
                                                                {
                                                                    if (null.ID == null.ID)
                                                                    {
                                                                    }
                                                                }
                                                                if (true)
                                                                {
                                                                }
                                                                else
                                                                {
                                                                    if ((!true) && (!true))
                                                                    {
                                                                        return ((!true) && (!true));
                                                                    }
                                                                }
                                                                if (!true)
                                                                {
                                                                }
                                                                if (null.getSkills().hasSkill("effects.staggered"))
                                                                {
                                                                }
                                                                if (((((((((((((((((((((((((((((((this.queryTargetValue(_entity, null, null) * (null.getHitpoints() / null.getHitpointsMax()) * this.Const.AI.Behavior.KnockBackStunnedTargetMult) * this.Const.AI.Behavior.KnockBackToRemoveCounterSkillMult) * this.Const.AI.Behavior.KnockBackStaggerMult) * this.Const.AI.Behavior.KnockBackIsolateMult) * ((this.m.Skill.getHitchance(null) / 100.0) * this.Const.AI.Behavior.KnockBackKnockDownToKillMult)) * (this.Const.AI.Behavior.KnockBackIntoAlliesMult * null.getCurrentProperties().TargetAttractionMult)) * this.Const.AI.Behavior.KnockBackDisruptMult) * this.Const.AI.Behavior.KnockBackChainAttacksMult) * this.Const.AI.Behavior.KnockBackIsolateMult) * this.Const.AI.Behavior.KnockBackIntoAlliesMult) * this.Const.AI.Behavior.KnockBackIntoTileEffectMult) * this.Const.AI.Behavior.KnockBackAvoidMistakeMult) * this.Const.AI.Behavior.KnockBackIntoTileEffectMult) * this.Math.pow(this.Const.AI.Behavior.KnockBackSpearwallMult, (0 + 44))) * this.Const.AI.Behavior.KnockBackForPositionMult) * this.Const.AI.Behavior.KnockBackAvoidTileEffectMult) * this.Const.AI.Behavior.KnockBackEngageBetterTargetMult) * this.Math.maxf(1.0, this.Const.AI.Behavior.KnockBackToProtectAllyMult)) * (this.Const.AI.Behavior.KnockBackProtectAllyLockedMult * null.getTile().getNextTile(0).getEntity().getCurrentProperties().TargetAttractionMult)) * (this.Const.AI.Behavior.KnockBackProtectAllyLockedMult * null.getTile().getNextTile(0).getEntity().getCurrentProperties().TargetAttractionMult)) * this.Const.AI.Behavior.KnockBackKnockDownCliffMult) * this.Const.AI.Behavior.KnockBackAlreadyOnCorpseMult) * this.Const.AI.Behavior.KnockBackCorpseNotConsumableMult) * this.Const.AI.Behavior.KnockBackCorpseDirectMult) * this.Const.AI.Behavior.KnockBackCorpseNotConsumableMult) * this.Const.AI.Behavior.KnockBackCorpseIndirectMult) * this.Const.AI.Behavior.KnockBackAlreadyOnDangerTileMult) * this.Const.AI.Behavior.KnockBackDangerTileMult) * this.getProperties().TargetPriorityStaggeredMult) > 0))
                                                                {
                                                                }
                                                                if (null != null)
                                                                {
                                                                    this.m.TargetTile = null.getTile();
                                                                    this.m.DestinationTile = null;
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

function onExecute(this, _entity)
{
    if (_entity.isHiddenToPlayer() && _entity.isHiddenToPlayer())
    {
        return (_entity.isHiddenToPlayer() && _entity.isHiddenToPlayer());
        _entity.setDiscovered(true);
        _entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
    }
    if (this.m.IsFirstExecuted)
    {
        this.getAgent().adjustCameraToTarget(this.m.TargetTile);
        this.m.IsFirstExecuted = false;
        return _entity;
    }
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Using Knock Back!"));
    }
    if ((this.m.Skill == this.m.Skill) && (this.m.Skill == this.m.Skill))
    {
        return ((this.m.Skill == this.m.Skill) && (this.m.Skill == this.m.Skill));
        this.m.Skill.setDestinationTile(this.m.DestinationTile);
    }
    this.m.Skill.use(this.m.TargetTile);
    this.getAgent().getIntentions().IsKnockingBack = true;
    if (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer)
    {
        return (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer);
        this.getAgent().declareEvaluationDelay();
        this.getAgent().declareAction();
    }
    this.m.TargetTile = null;
    this.m.DestinationTile = null;
    this.m.Skill = null;
    return _entity;
}
