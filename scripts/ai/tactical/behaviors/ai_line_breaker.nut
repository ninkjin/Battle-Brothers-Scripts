// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_line_breaker.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.LineBreaker;
    this.m.Order = this.Const.AI.Behavior.Order.LineBreaker;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.Skill = null;
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
    if (!this.getAgent().hasVisibleOpponent())
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    foreach (local key, value in null)
    {
        if (this.queryTargetValue(_entity, null) > 0)
        {
        }
        foreach (local key, value in r359)
        {
            if (null.getCurrentProperties().IsImmuneToKnockBackAndGrab)
            {
            }
            else
            {
                if (null.isArmedWithRangedWeapon())
                {
                }
                else
                {
                    if (null.IsRooted && null.IsRooted)
                    {
                        return (null.IsRooted && null.IsRooted);
                    }
                    else
                    {
                        if (!this.m.Skill.isUsableOn(null.getTile()))
                        {
                        }
                        else
                        {
                            if (this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile() == null))
                            {
                            }
                            if ((this.m.Skill == r34) && (this.m.Skill == r34))
                            {
                                return ((this.m.Skill == r34) && (this.m.Skill == r34));
                            }
                            if (null.getSkills().hasSkill("effects.riposte"))
                            {
                            }
                            if (((this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) - 1) > null) && ((this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).getZoneOfControlCountOtherThan(null.getAlliedFactions()) - 1) > null)))
                            {
                                return (((this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).getZoneOfControlCountOtherThan(null.getAlliedFactions()) - 1) > null) && ((this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).getZoneOfControlCountOtherThan(null.getAlliedFactions()) - 1) > null));
                            }
                            if (0 < 6)
                            {
                                if (!null.getTile().hasNextTile(0))
                                {
                                }
                                else
                                {
                                    if ((null.getTile().getNextTile(0).getDistanceTo(_entity.getTile() > 1) && (null.getTile().getNextTile(0).getDistanceTo(_entity.getTile()) > 1) && (null.getTile().getNextTile(0).getDistanceTo(_entity.getTile()) > 1)))
                                    {
                                        return ((null.getTile().getNextTile(0).getDistanceTo(_entity.getTile()) > 1) && (null.getTile().getNextTile(0).getDistanceTo(_entity.getTile()) > 1) && (null.getTile().getNextTile(0).getDistanceTo(_entity.getTile()) > 1));
                                        if (null.getTile().getNextTile(0).getEntity().getSkills().hasSkill("perks.rally_the_troops"))
                                        {
                                        }
                                        if ((this.queryTargetValue(_entity, null.getTile().getNextTile(0).getEntity() * this.Const.AI.Behavior.LineBreakerVSRallyMult) > (this.queryTargetValue(_entity, null) + this.Const.AI.Behavior.LineBreakerBetterTargetThreshold)))
                                        {
                                        }
                                    }
                                }
                            }
                            if (((0 + 16) > (this.queryTargetsInMeleeRange().len() + 1) && ((0 + 16) > (this.queryTargetsInMeleeRange().len() + 1))))
                            {
                                return (((0 + 16) > (this.queryTargetsInMeleeRange().len() + 1)) && ((0 + 16) > (this.queryTargetsInMeleeRange().len() + 1)));
                            }
                            if (!true)
                            {
                                if ((this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile().Level <= null.getTile().Level) && (this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level <= null.getTile().Level)))
                                {
                                    return ((this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level <= null.getTile().Level) && (this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level <= null.getTile().Level));
                                }
                                if ((this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile().Level <= null.getTile().Level) && (this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level <= null.getTile().Level) && (this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level <= null.getTile().Level)))
                                {
                                    return ((this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level <= null.getTile().Level) && (this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level <= null.getTile().Level) && (this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level <= null.getTile().Level));
                                }
                                if ((this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile().Level <= null.getTile().Level) && (this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level <= null.getTile().Level) && (this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level <= null.getTile().Level)))
                                {
                                    return ((this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level <= null.getTile().Level) && (this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level <= null.getTile().Level) && (this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level <= null.getTile().Level));
                                }
                            }
                            if (true)
                            {
                                if (null.getSkills().hasSkill("effects.shieldwall"))
                                {
                                }
                                if ((null.getTile().Level < this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile().Level) && (null.getTile().Level < this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level)))
                                {
                                    return ((null.getTile().Level < this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level) && (null.getTile().Level < this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).Level));
                                }
                                if ((!this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile().IsBadTerrain) && (!this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).IsBadTerrain)))
                                {
                                    return ((!this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).IsBadTerrain) && (!this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).IsBadTerrain));
                                }
                            }
                            if (((((((((((1.0 * this.Const.AI.Behavior.LineBreakerExecuteMult) * this.Const.AI.Behavior.LineBreakerVSRiposteMult) * (1.0 + ((this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) - 1) * this.Const.AI.Behavior.LineBreakerSetupAlliesBonus))) * (1.0 + ((this.queryTargetValue(_entity, null.getTile().getNextTile(0).getEntity()) * this.Const.AI.Behavior.LineBreakerVSRallyMult) - this.queryTargetValue(_entity, null)))) * (1.0 / this.getProperties().EngageTargetMultipleOpponentsMult)) * this.Const.AI.Behavior.LineBreakerForPositionMult) * this.Const.AI.Behavior.LineBreakerCounterSkillMult) * this.Const.AI.Behavior.LineBreakerWorsePositionMult) * this.Const.AI.Behavior.LineBreakerWorsePositionMult) > 0) && ((((((((((1.0 * this.Const.AI.Behavior.LineBreakerExecuteMult) * this.Const.AI.Behavior.LineBreakerVSRiposteMult) * (1.0 + ((this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).getZoneOfControlCountOtherThan(null.getAlliedFactions()) - 1) * this.Const.AI.Behavior.LineBreakerSetupAlliesBonus))) * (1.0 + ((this.queryTargetValue(_entity, null.getTile().getNextTile(0).getEntity()) * this.Const.AI.Behavior.LineBreakerVSRallyMult) - this.queryTargetValue(_entity, null)))) * (1.0 / this.getProperties().EngageTargetMultipleOpponentsMult)) * this.Const.AI.Behavior.LineBreakerForPositionMult) * this.Const.AI.Behavior.LineBreakerCounterSkillMult) * this.Const.AI.Behavior.LineBreakerWorsePositionMult) * this.Const.AI.Behavior.LineBreakerWorsePositionMult) > 0)))
                            {
                                return (((((((((((1.0 * this.Const.AI.Behavior.LineBreakerExecuteMult) * this.Const.AI.Behavior.LineBreakerVSRiposteMult) * (1.0 + ((this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).getZoneOfControlCountOtherThan(null.getAlliedFactions()) - 1) * this.Const.AI.Behavior.LineBreakerSetupAlliesBonus))) * (1.0 + ((this.queryTargetValue(_entity, null.getTile().getNextTile(0).getEntity()) * this.Const.AI.Behavior.LineBreakerVSRallyMult) - this.queryTargetValue(_entity, null)))) * (1.0 / this.getProperties().EngageTargetMultipleOpponentsMult)) * this.Const.AI.Behavior.LineBreakerForPositionMult) * this.Const.AI.Behavior.LineBreakerCounterSkillMult) * this.Const.AI.Behavior.LineBreakerWorsePositionMult) * this.Const.AI.Behavior.LineBreakerWorsePositionMult) > 0) && ((((((((((1.0 * this.Const.AI.Behavior.LineBreakerExecuteMult) * this.Const.AI.Behavior.LineBreakerVSRiposteMult) * (1.0 + ((this.m.Skill.findTileToKnockBackTo(_entity.getTile(), null.getTile()).getZoneOfControlCountOtherThan(null.getAlliedFactions()) - 1) * this.Const.AI.Behavior.LineBreakerSetupAlliesBonus))) * (1.0 + ((this.queryTargetValue(_entity, null.getTile().getNextTile(0).getEntity()) * this.Const.AI.Behavior.LineBreakerVSRallyMult) - this.queryTargetValue(_entity, null)))) * (1.0 / this.getProperties().EngageTargetMultipleOpponentsMult)) * this.Const.AI.Behavior.LineBreakerForPositionMult) * this.Const.AI.Behavior.LineBreakerCounterSkillMult) * this.Const.AI.Behavior.LineBreakerWorsePositionMult) * this.Const.AI.Behavior.LineBreakerWorsePositionMult) > 0));
                            }
                            if (null.getTile() != null)
                            {
                                this.m.TargetTile = null.getTile();
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

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        this.getAgent().adjustCameraToTarget(this.m.TargetTile);
        this.m.IsFirstExecuted = false;
        return _entity;
    }
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Using Line Breaker!"));
    }
    this.m.Skill.use(this.m.TargetTile);
    if (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer)
    {
        return (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer);
        this.getAgent().declareEvaluationDelay();
        this.getAgent().declareAction();
    }
    this.m.TargetTile = null;
    this.m.Skill = null;
    return _entity;
}
