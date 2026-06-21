// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_charm.nut
// Functions: 6

function calculateDanger(this, _entity, _targets)
{
    foreach (local key, value in r90)
    {
        if (this.isAllottedTimeReached(this.Time.getExactTime()))
        {
            yield this;
        }
        if ((null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions() < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones)))
        {
            return ((null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones));
            [].push(null.Actor.getID());
        }
        this.m.Danger = {Danger = (0.0 + this.getDangerFromActor(null.Actor, _entity.getTile(), _entity)), PotentialDanger = []};
        return _entity;
    }
}

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Charm;
    this.m.Order = this.Const.AI.Behavior.Order.Charm;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function findBestTarget(this, _entity, _targets)
{
    foreach (local key, value in r567)
    {
        if (this.isAllottedTimeReached(this.Time.getExactTime()))
        {
            yield this;
        }
        if (!this.m.Skill.isUsableOn(null.Actor.getTile()))
        {
        }
        else
        {
            if ((!null.Actor.getCurrentProperties().IsAbleToUseWeaponSkills) || (!null.Actor.getCurrentProperties().IsAbleToUseWeaponSkills))
            {
                return ((!null.Actor.getCurrentProperties().IsAbleToUseWeaponSkills) || (!null.Actor.getCurrentProperties().IsAbleToUseWeaponSkills));
            }
            if (null.Actor.getSkills().hasSkill("effects.charmed"))
            {
            }
            if (this.isRangedUnit(null.Actor))
            {
            }
            foreach (local key, value in null)
            {
                if ((_entity.getID().TargetAttractionMult > _entity) && (_entity.getID().TargetAttractionMult > _entity))
                {
                    return ((_entity.getID().TargetAttractionMult > _entity) && (_entity.getID().TargetAttractionMult > _entity));
                }
                if ((!null.Actor.isArmedWithRangedWeapon() && (!null.Actor.isArmedWithRangedWeapon())))
                {
                    return ((!null.Actor.isArmedWithRangedWeapon()) && (!null.Actor.isArmedWithRangedWeapon()));
                }
                if ((null.Actor != 0) && (null.Actor != 0))
                {
                    return ((null.Actor != 0) && (null.Actor != 0));
                }
                if (_entity.getTile().getDistanceTo(null.Actor.getTile() <= null.Actor.getIdealRange()))
                {
                }
                if ((this.m.Danger.PotentialDanger != 0) && (this.m.Danger.PotentialDanger != 0))
                {
                    return ((this.m.Danger.PotentialDanger != 0) && (this.m.Danger.PotentialDanger != 0));
                }
                if ((this.Const.EntityType.Wardog == this.Const.EntityType.Warhound) && (this.Const.EntityType.Wardog == this.Const.EntityType.Warhound))
                {
                    return ((this.Const.EntityType.Wardog == this.Const.EntityType.Warhound) && (this.Const.EntityType.Wardog == this.Const.EntityType.Warhound));
                }
                if (null.Actor.getCurrentProperties().MoraleCheckBraveryMult["this.Const.MoraleCheckType.MentalAttack"] >= 1000.0)
                {
                }
                if (!this.isRangedUnit(null.Actor))
                {
                    foreach (local key, value in null)
                    {
                        if (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions() == 0))
                        {
                        }
                        if (null.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE() && null.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE())
                        {
                            return (null.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE() && null.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE());
                        }
                        if ((null.Actor <= this.Const.AI.Behavior.CharmAoEMult) && (null.Actor <= this.Const.AI.Behavior.CharmAoEMult))
                        {
                            return ((null.Actor <= this.Const.AI.Behavior.CharmAoEMult) && (null.Actor <= this.Const.AI.Behavior.CharmAoEMult));
                        }
                        if ((!null.Actor) && (!null.Actor))
                        {
                            return ((!null.Actor) && (!null.Actor));
                        }
                        else
                        {
                            if ((null.Actor < (null.Actor <= this.Const.AI.Behavior.CharmAoEMult) && (null.Actor < (null.Actor <= this.Const.AI.Behavior.CharmAoEMult))))
                            {
                                return ((null.Actor < (null.Actor <= this.Const.AI.Behavior.CharmAoEMult)) && (null.Actor < (null.Actor <= this.Const.AI.Behavior.CharmAoEMult)));
                            }
                        }
                        if ((null.Actor.Items == 0) && (null.Actor.Items == 0))
                        {
                            return ((null.Actor.Items == 0) && (null.Actor.Items == 0));
                        }
                        if ((null == r87) && (null == r87))
                        {
                            return ((null == r87) && (null == r87));
                            if (!null.Actor.getSkills().hasSkill("perk.quick_hands"))
                            {
                            }
                            foreach (local key, value in null.Actor.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag))
                            {
                                if ((null != r87) && (null != r87))
                                {
                                    return ((null != r87) && (null != r87));
                                }
                                if (!true)
                                {
                                }
                                if (null.Actor.getCurrentProperties().NegativeStatusEffectDuration < 0)
                                {
                                }
                                if (((((((((((((((((((((((((100.0 + (null.Actor.getLevel() * this.Const.AI.Behavior.CharmLevelMult) + (null.Actor.getCurrentProperties().getRangedSkill() * this.Const.AI.Behavior.CharmSkillMult)) + (null.Actor.getCurrentProperties().getMeleeSkill() * this.Const.AI.Behavior.CharmSkillMult)) + (null.Actor.getCurrentProperties().getMeleeDefense() * this.Const.AI.Behavior.CharmDefenseSkillMult)) - (_entity.getTile().getDistanceTo(null.Actor.getTile()) * this.Const.AI.Behavior.CharmDistanceMult)) + ((0 + 16) * this.Const.AI.Behavior.CharmHelpOther)) * this.Math.maxf(0.20000000298023224, (1.0 - (((this.Const.AI.Behavior.CharmBraveryMult * null.Actor.getBravery()) * null.Actor.getCurrentProperties().MoraleCheckBraveryMult["this.Const.MoraleCheckType.MentalAttack"]) * 0.009999999776482582)))) * this.Const.AI.Behavior.CharmRootedMult) * this.Const.AI.Behavior.CharmRangedWouldBeInZOCMult) * this.Const.AI.Behavior.CharmMeleeDangerMult) * this.Const.AI.Behavior.CharmRemoveDangerMult) * this.Const.AI.Behavior.CharmWardogMult) * this.Const.AI.Behavior.CharmImmuneMult) * (1.0 + (((1.0 + this.queryTargetValue(null.Actor, null)) + ((0 + 20) * this.Const.AI.Behavior.CharmTargetLockdownMult)) * this.Const.AI.Behavior.CharmTargetsMult))) * this.Const.AI.Behavior.CharmAoEMult) * this.Const.AI.Behavior.CharmRangedTargetMult) * this.Const.AI.Behavior.CharmEasierToKillMult) * this.Const.AI.Behavior.CharmStillToActMult) * this.Const.AI.Behavior.CharmAlreadyWaitedMult) * this.Const.AI.Behavior.CharmTargetUnarmedMult) * this.Const.AI.Behavior.CharmTargetWoodenClubRightNowMult) * this.Const.AI.Behavior.CharmTargetWoodenClubOnlyMult) * null.Actor.getCurrentProperties().TargetAttractionMult) * this.Const.AI.Behavior.CharmLowerDurationMult) > 0.0))
                                {
                                }
                                if (null.Actor != null)
                                {
                                    this.m.TargetTile = null.Actor.getTile();
                                    this.m.ScoreBonus = (((((((((((((((((((((((((100.0 + (null.Actor.getLevel() * this.Const.AI.Behavior.CharmLevelMult)) + (null.Actor.getCurrentProperties().getRangedSkill() * this.Const.AI.Behavior.CharmSkillMult)) + (null.Actor.getCurrentProperties().getMeleeSkill() * this.Const.AI.Behavior.CharmSkillMult)) + (null.Actor.getCurrentProperties().getMeleeDefense() * this.Const.AI.Behavior.CharmDefenseSkillMult)) - (_entity.getTile().getDistanceTo(null.Actor.getTile()) * this.Const.AI.Behavior.CharmDistanceMult)) + ((0 + 16) * this.Const.AI.Behavior.CharmHelpOther)) * this.Math.maxf(0.20000000298023224, (1.0 - (((this.Const.AI.Behavior.CharmBraveryMult * null.Actor.getBravery()) * null.Actor.getCurrentProperties().MoraleCheckBraveryMult["this.Const.MoraleCheckType.MentalAttack"]) * 0.009999999776482582)))) * this.Const.AI.Behavior.CharmRootedMult) * this.Const.AI.Behavior.CharmRangedWouldBeInZOCMult) * this.Const.AI.Behavior.CharmMeleeDangerMult) * this.Const.AI.Behavior.CharmRemoveDangerMult) * this.Const.AI.Behavior.CharmWardogMult) * this.Const.AI.Behavior.CharmImmuneMult) * (1.0 + (((1.0 + this.queryTargetValue(null.Actor, null)) + ((0 + 20) * this.Const.AI.Behavior.CharmTargetLockdownMult)) * this.Const.AI.Behavior.CharmTargetsMult))) * this.Const.AI.Behavior.CharmAoEMult) * this.Const.AI.Behavior.CharmRangedTargetMult) * this.Const.AI.Behavior.CharmEasierToKillMult) * this.Const.AI.Behavior.CharmStillToActMult) * this.Const.AI.Behavior.CharmAlreadyWaitedMult) * this.Const.AI.Behavior.CharmTargetUnarmedMult) * this.Const.AI.Behavior.CharmTargetWoodenClubRightNowMult) * this.Const.AI.Behavior.CharmTargetWoodenClubOnlyMult) * null.Actor.getCurrentProperties().TargetAttractionMult) * this.Const.AI.Behavior.CharmLowerDurationMult) * 0.10000000149011612);
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

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    this.m.TargetTile = null;
    this.m.Danger = null;
    this.m.ScoreBonus = 0.0;
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
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (resume this == null)
    {
        yield null;
    }
    if (resume this == null)
    {
        yield null;
    }
    if (this.m.TargetTile == null)
    {
        return _entity;
    }
    this.m.Danger = null;
    return _entity;
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        this.getAgent().adjustCameraToTarget(this.m.TargetTile);
        this.m.IsFirstExecuted = false;
        if ("IsFirstExecuted" && "IsFirstExecuted")
        {
            return ("IsFirstExecuted" && "IsFirstExecuted");
            _entity.setDiscovered(true);
            _entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
        }
        return _entity;
    }
    this.m.Skill.use(this.m.TargetTile);
    this.getAgent().declareEvaluationDelay(2000);
    if (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer)
    {
        return (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer);
        this.getAgent().declareAction(2000);
    }
    this.m.Skill = null;
    this.m.TargetTile = null;
    return _entity;
}
