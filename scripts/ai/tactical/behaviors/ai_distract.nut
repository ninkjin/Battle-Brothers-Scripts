// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_distract.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Distract;
    this.m.Order = this.Const.AI.Behavior.Order.Distract;
    this.behavior.create();
    return;
}

function getBestTarget(this, _entity, _skill, _targets)
{
    if (_entity.getSkills().getAttackOfOpportunity() != null)
    {
    }
    foreach (local key, value in r526)
    {
        if (null.isNonCombatant())
        {
        }
        else
        {
            if (_skill.onVerifyTarget(_entity.getTile(), null.getTile()))
            {
                if (null.getMoraleState() == this.Const.MoraleState.Fleeing)
                {
                }
                else
                {
                    if (null.getFatigue() >= (null.getFatigueMax() - 5))
                    {
                    }
                    else
                    {
                        if (null.getSkills().hasSkill("effects.distracted") || null.getSkills().hasSkill("effects.distracted") || null.getSkills().hasSkill("effects.distracted"))
                        {
                            return (null.getSkills().hasSkill("effects.distracted") || null.getSkills().hasSkill("effects.distracted") || null.getSkills().hasSkill("effects.distracted"));
                        }
                        else
                        {
                            if ((null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions() > 0) && (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) > 0)))
                            {
                                return ((null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) > 0) && (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) > 0));
                            }
                            if ((_entity.getSkills().getAttackOfOpportunity().getHitchance(null) >= 20) && (_entity.getSkills().getAttackOfOpportunity().getHitchance(null) >= 20) && (_entity.getSkills().getAttackOfOpportunity().getHitchance(null) >= 20) && (_entity.getSkills().getAttackOfOpportunity().getHitchance(null) >= 20))
                            {
                                return ((_entity.getSkills().getAttackOfOpportunity().getHitchance(null) >= 20) && (_entity.getSkills().getAttackOfOpportunity().getHitchance(null) >= 20) && (_entity.getSkills().getAttackOfOpportunity().getHitchance(null) >= 20) && (_entity.getSkills().getAttackOfOpportunity().getHitchance(null) >= 20));
                            }
                            if (_entity.getSkills().getAttackOfOpportunity() != null)
                            {
                                if (null.getHitpoints() <= (_entity.getSkills().getAttackOfOpportunity().getExpectedDamage(null).HitpointDamage + _entity.getSkills().getAttackOfOpportunity().getExpectedDamage(null).DirectDamage))
                                {
                                }
                                if (_entity.getSkills().getAttackOfOpportunity().getExpectedDamage(null).HitpointDamage >= this.Const.Combat.InjuryMinDamage)
                                {
                                    if ((((_entity.getCurrentProperties().ThresholdToInflictInjuryMult * this.Const.Combat.InjuryThresholdMult) * null.getCurrentProperties().ThresholdToReceiveInjuryMult) * 0.25) <= (_entity.getSkills().getAttackOfOpportunity().getExpectedDamage(null).HitpointDamage / (null.getHitpointsMax() * 1.0)))
                                    {
                                    }
                                }
                            }
                            if (!null.isTurnDone())
                            {
                            }
                            if (null.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.MeleeWeapon) && null.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.MeleeWeapon))
                            {
                                return (null.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.MeleeWeapon) && null.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.MeleeWeapon));
                            }
                            if (null && null)
                            {
                                return (null && null);
                            }
                            if (null.getSkills().hasSkill("actives.lunge") || null.getSkills().hasSkill("actives.lunge"))
                            {
                                return (null.getSkills().hasSkill("actives.lunge") || null.getSkills().hasSkill("actives.lunge"));
                            }
                            if (null.getSkills().hasSkill && null.getSkills().hasSkill)
                            {
                                return (null.getSkills().hasSkill && null.getSkills().hasSkill);
                            }
                            if (null.getSkills().hasSkill("effects.shieldwall"))
                            {
                            }
                            if (null.getSkills().hasSkill("actives.taunt"))
                            {
                            }
                            if ((_entity >= 300) && (_entity >= 300))
                            {
                                return ((_entity >= 300) && (_entity >= 300));
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
                                    }
                                }
                            }
                            if ((null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions() > 1) && (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) > 1)))
                            {
                                return ((null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) > 1) && (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) > 1));
                            }
                            if (this.getStrategy().getStats().AlliesVSEnemiesRatio < 1.0)
                            {
                            }
                            if (((((((((((((((((((null.getHitpoints() / null.getHitpointsMax() * (_skill.getHitchance(null) * 0.009999999776482582)) * this.Const.AI.Behavior.DistractPreferInjuryMult) * (0.5 + ((null.getCurrentProperties().getMeleeSkill() * 0.009999999776482582) * 0.5))) * (0.5 + ((null.getCurrentProperties().getRegularDamageAverage() * 0.009999999776482582) * 0.5))) * this.Math.maxf(0.5, (1.5 - null.getCurrentProperties().TargetAttractionMult))) * this.Const.AI.Behavior.DistractYetToActMult) * this.Const.AI.Behavior.DistractPriorityMult) * this.Const.AI.Behavior.DistractPriorityMult) * this.Const.AI.Behavior.DistractInitiativeMult) * this.Const.AI.Behavior.DistractInitiativeMult) * this.Const.AI.Behavior.DistractVSShieldwallMult) * null.getCurrentProperties().DamageReceivedTotalMult) * this.Const.AI.Behavior.DistractVSTaunterMult) * this.Const.AI.Behavior.DistractAsEliteMult) * this.Const.AI.Behavior.DistractPriorityMult) * this.Math.pow(this.Const.AI.Behavior.DistractSurroundedTargetMult, (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) - 1))) * this.Math.maxf(0.5, this.getStrategy().getStats().AlliesVSEnemiesRatio)) > 0.0))
                            {
                            }
                            return _entity;
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
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getActionPoints() == _entity.getActionPointsMax())
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
    if (_entity.getActionPoints() == _entity.getActionPointsMax())
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
    if (this.getBestTarget(_entity, this.m.Skill, this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), (this.m.Skill.getMaxRange() + 0), this.m.Skill.getMaxLevelDifference()).Target == null))
    {
        return _entity;
    }
    this.m.TargetTile = this.getBestTarget(_entity, this.m.Skill, this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), (this.m.Skill.getMaxRange() + 0), this.m.Skill.getMaxLevelDifference())).Target.getTile();
    if (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions() > 1))
    {
    }
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
