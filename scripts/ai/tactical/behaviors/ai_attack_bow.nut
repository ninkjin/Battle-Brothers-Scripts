// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_bow.nut
// Functions: 5

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.AttackBow;
    this.m.Order = this.Const.AI.Behavior.Order.AttackBow;
    this.behavior.create();
    return;
}

function onBeforeExecute(this, _entity)
{
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.SelectedSkill = null;
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
    foreach (local key, value in r24)
    {
        if (_entity.getSkills().getSkillByID(null).isAffordable() && _entity.getSkills().getSkillByID(null).isAffordable())
        {
            return (_entity.getSkills().getSkillByID(null).isAffordable() && _entity.getSkills().getSkillByID(null).isAffordable());
            [].push(_entity.getSkills().getSkillByID(null));
        }
        if ([].len() == 0)
        {
            return _entity;
        }
        if ((this.m.SelectedSkill == null) && (this.m.SelectedSkill == null))
        {
            return ((this.m.SelectedSkill == null) && (this.m.SelectedSkill == null));
            return _entity;
        }
        if (this.getAgent().getIntentions().IsChangingWeapons)
        {
        }
        return _entity;
    }
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        if (this.m.TargetTile.getEntity().isPlayerControlled && this.m.TargetTile.getEntity().isPlayerControlled)
        {
            return (this.m.TargetTile.getEntity().isPlayerControlled && this.m.TargetTile.getEntity().isPlayerControlled);
            _entity.setDiscovered(true);
            _entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
        }
        this.getAgent().adjustCameraToTarget(this.m.TargetTile, this.m.SelectedSkill.getDelay());
        this.m.IsFirstExecuted = false;
        return _entity;
    }
    if (this.m.TargetTile.IsOccupiedByActor && this.m.TargetTile.IsOccupiedByActor)
    {
        return (this.m.TargetTile.IsOccupiedByActor && this.m.TargetTile.IsOccupiedByActor);
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((((((("* " + _entity.getName()) + ": Using ") + this.m.SelectedSkill.getName()) + " against ") + this.m.TargetTile.getEntity().getName()) + "!"));
        }
        this.m.SelectedSkill.use(this.m.TargetTile);
        if (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer)
        {
            return (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer);
            this.getAgent().declareAction();
            this.getAgent().declareEvaluationDelay((this.m.SelectedSkill.getDelay() + 750));
        }
        this.m.TargetTile = null;
        this.m.SelectedSkill = null;
    }
    return _entity;
}

function selectBestTargetAndSkill(this, _entity, _targets, _skills)
{
    foreach (local key, value in r300)
    {
        if (null.Actor.isNull())
        {
        }
        else
        {
            if (!null.Actor.getTile().IsVisibleForEntity)
            {
            }
            foreach (local key, value in r23)
            {
                if (null && null)
                {
                    return (null && null);
                    [].push({});
                }
                if ([].len() == 0)
                {
                }
                foreach (local key, value in r60)
                {
                    foreach (local key, value in r50)
                    {
                        if (!null.IsOccupiedByActor)
                        {
                        }
                        if (_entity.isAlliedWith(null.getEntity()))
                        {
                            if (this.getProperties().TargetPriorityHittingAlliesMult < 1.0)
                            {
                                null.Score = null.Score op45 ((((1.0 / 6.0) * 4.0) * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) * null.getEntity().getCurrentProperties().TargetAttractionMult);
                            }
                        }
                        null.Score = null.Score op43 this.queryTargetValue(_entity, null.getEntity(), null.Skill);
                        foreach (local key, value in _entity.getFaction())
                        {
                            if (_entity && _entity)
                            {
                                return (_entity && _entity);
                            }
                            if (_entity.getTile().getDistanceTo(null.Actor.getTile() > 2))
                            {
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
                            }
                            if (null.Actor.getTile().getZoneOfControlCount(_entity.getFaction() < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones))
                            {
                            }
                            if (((0 + 14) <= this.Const.AI.Behavior.AttackRangedMaxAlliesAdjacent) && ((0 + 14) <= this.Const.AI.Behavior.AttackRangedMaxAlliesAdjacent))
                            {
                                return (((0 + 14) <= this.Const.AI.Behavior.AttackRangedMaxAlliesAdjacent) && ((0 + 14) <= this.Const.AI.Behavior.AttackRangedMaxAlliesAdjacent));
                            }
                            if (null != null)
                            {
                                this.m.TargetTile = null.Actor.getTile();
                                if (0 < [].len())
                                {
                                    if ([]["0"].Score > 0)
                                    {
                                    }
                                }
                                if (0 < [].len())
                                {
                                    if (this.Math.floor(this.Math.pow(([]["0"].Score * 100), this.Const.AI.Behavior.AttackRangedChancePOW) < (this.Math.floor(this.Math.pow(([]["0"].Score * 100), this.Const.AI.Behavior.AttackRangedChancePOW)) * this.Const.AI.Behavior.AttackRangedScoreCutoff)))
                                    {
                                    }
                                }
                                if ((0 + this.Math.floor(this.Math.pow(([]["0"].Score * 100), this.Const.AI.Behavior.AttackRangedChancePOW)) != 0))
                                {
                                    if (0 < [].len())
                                    {
                                        if (this.Math.floor(this.Math.pow(([]["0"].Score * 100), this.Const.AI.Behavior.AttackRangedChancePOW) < (this.Math.floor(this.Math.pow(([]["0"].Score * 100), this.Const.AI.Behavior.AttackRangedChancePOW)) * this.Const.AI.Behavior.AttackRangedScoreCutoff)))
                                        {
                                        }
                                        if (this.Math.rand(1, (0 + this.Math.floor(this.Math.pow(([]["0"].Score * 100), this.Const.AI.Behavior.AttackRangedChancePOW))) <= this.Math.floor(this.Math.pow(([]["0"].Score * 100), this.Const.AI.Behavior.AttackRangedChancePOW))))
                                        {
                                            this.m.SelectedSkill = []["0"].Skill;
                                            return this.Math.maxf(0.10000000149011612, ([]["0"].Score + this.Math.maxf(0.0, ((((0.0 * this.Const.AI.Behavior.AttackLineOfFireBlockedMult) - ((((1.0 / 6.0) * 4.0) * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) * null.Actor.getTile().getNextTile(0).getEntity().getCurrentProperties().TargetAttractionMult)) + (((1.0 / 6.0) * this.queryTargetValue(_entity, null.Actor.getTile().getNextTile(0).getEntity(), null)) * this.Const.AI.Behavior.AttackRangedHitBystandersMult)) * (1.0 + ((1.0 - this.Math.minf(1.0, this.queryActorTurnsNearTarget(null.Actor, _entity.getTile(), _entity).Turns)) * this.Const.AI.Behavior.AttackDangerMult))))));
                                            return _entity;
                                        }
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
