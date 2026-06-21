// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_throw_net.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.ThrowNet;
    this.m.Order = this.Const.AI.Behavior.Order.ThrowNet;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function findBestTarget(this, _entity, _targets, _bestTarget)
{
    foreach (local key, value in r284)
    {
        if (null.IsImmuneToRoot && null.IsImmuneToRoot)
        {
            return (null.IsImmuneToRoot && null.IsImmuneToRoot);
        }
        if (null.getHitpoints() <= this.Const.AI.Behavior.ThrowNetMinHitpoints)
        {
        }
        if (null.getCurrentProperties().TargetAttractionMult < this.Const.AI.Behavior.ThrowNetMinAttaction)
        {
        }
        if (!this.m.Skill.isUsableOn(null.getTile()))
        {
        }
        if (this.isAllottedTimeReached(this.Time.getExactTime()))
        {
            yield this;
        }
        if (null.getTile().IsBadTerrain)
        {
        }
        if (this.hasNegativeTileEffect(null.getTile(), null))
        {
        }
        if (!null.hasRangedWeapon())
        {
        }
        foreach (local key, value in null)
        {
            if (null.getTile().getDistanceTo(null.getTile() <= null.getIdealRange()))
            {
            }
            if (!true)
            {
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
                if (null.getSkills().hasSkill("effects.adrenaline") && null.getSkills().hasSkill("effects.adrenaline"))
                {
                    return (null.getSkills().hasSkill("effects.adrenaline") && null.getSkills().hasSkill("effects.adrenaline"));
                }
                if ((this.Const.EntityType.Wardog == this.Const.EntityType.Warhound) && (this.Const.EntityType.Wardog == this.Const.EntityType.Warhound))
                {
                    return ((this.Const.EntityType.Wardog == this.Const.EntityType.Warhound) && (this.Const.EntityType.Wardog == this.Const.EntityType.Warhound));
                }
                if (null.isTurnDone())
                {
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
                                if (null.getTile().getNextTile(0).getEntity().getSkills().hasSkill("actives.deathblow"))
                                {
                                }
                            }
                        }
                    }
                }
                if ((((((((((((1.0 - (null.getTile().TVTotal * this.Const.AI.Behavior.ThrowNetTVMult) + this.Const.AI.Behavior.ThrowNetBadTerrainBonus) + this.Const.AI.Behavior.ThrowNetBadTerrainBonus) + (null.getCurrentProperties().getMeleeDefense() / 2)) + this.Const.AI.Behavior.ThrowNetNoRangedWeaponBonus) + this.Const.AI.Behavior.ThrowNetCantAttackAnyoneBonus) + this.Const.AI.Behavior.ThrowNetProtectPriorityTargetBonus) * null.getCurrentProperties().TargetAttractionMult) * this.Const.AI.Behavior.ThrowNetVSAdrenalineMult) * this.Const.AI.Behavior.ThrowNetVSWardogsMult) * this.Const.AI.Behavior.ThrowNetToSetupDeathblowMult) > -9000.0))
                {
                }
                _bestTarget.Target = null;
                _bestTarget.Score = ((((((((((((1.0 - (null.getTile().TVTotal * this.Const.AI.Behavior.ThrowNetTVMult)) + this.Const.AI.Behavior.ThrowNetBadTerrainBonus) + this.Const.AI.Behavior.ThrowNetBadTerrainBonus) + (null.getCurrentProperties().getMeleeDefense() / 2)) + this.Const.AI.Behavior.ThrowNetNoRangedWeaponBonus) + this.Const.AI.Behavior.ThrowNetCantAttackAnyoneBonus) + this.Const.AI.Behavior.ThrowNetProtectPriorityTargetBonus) * null.getCurrentProperties().TargetAttractionMult) * this.Const.AI.Behavior.ThrowNetVSAdrenalineMult) * this.Const.AI.Behavior.ThrowNetVSWardogsMult) * this.Const.AI.Behavior.ThrowNetToSetupDeathblowMult) * 0.10000000149011612);
                return _entity;
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
    if (this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange().len() == 0))
    {
        return _entity;
    }
    if (resume this == null)
    {
        yield null;
    }
    if ({}.Target == null)
    {
        return _entity;
    }
    this.m.TargetTile = {}.Target.getTile();
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
    if (this.m.TargetTile.IsOccupiedByActor && this.m.TargetTile.IsOccupiedByActor)
    {
        return (this.m.TargetTile.IsOccupiedByActor && this.m.TargetTile.IsOccupiedByActor);
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((((((("* " + _entity.getName()) + ": Using ") + this.m.Skill.getName()) + " against ") + this.m.TargetTile.getEntity().getName()) + "!"));
        }
        this.m.Skill.use(this.m.TargetTile);
        this.getAgent().declareEvaluationDelay(800);
        if (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer)
        {
            return (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer);
            this.getAgent().declareAction();
        }
        this.m.TargetTile = null;
    }
    return _entity;
}
