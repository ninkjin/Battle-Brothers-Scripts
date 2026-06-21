// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_root.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Root;
    this.m.Order = this.Const.AI.Behavior.Order.Root;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function findBestTarget(this, _entity, _targets)
{
    foreach (local key, value in r295)
    {
        if (_entity.getTile().getDistanceTo(null.Actor.getTile() > this.m.Skill.getMaxRange()))
        {
        }
        if (!this.m.Skill.isUsableOn(null.Actor.getTile()))
        {
        }
        if (this.isAllottedTimeReached(this.Time.getExactTime()))
        {
            yield this;
        }
        if (0 < 6)
        {
            if (!null.Actor.getTile().hasNextTile(0))
            {
            }
            else
            {
                if (!null.Actor.getTile().getNextTile(0).IsOccupiedByActor)
                {
                }
                else
                {
                    if (null.Actor.getTile().getNextTile(0).getEntity().getCurrentProperties().IsRooted)
                    {
                    }
                    else
                    {
                        if (null.Actor.getTile().getNextTile(0).getEntity().isAlliedWith(_entity))
                        {
                        }
                        [].push(null.Actor.getTile().getNextTile(0).getEntity());
                    }
                }
            }
        }
        foreach (local key, value in r178)
        {
            if (null.IsImmuneToRoot && null.IsImmuneToRoot)
            {
                return (null.IsImmuneToRoot && null.IsImmuneToRoot);
            }
            if (null.getMoraleState() == this.Const.MoraleState.Fleeing)
            {
            }
            if (!null.hasRangedWeapon())
            {
            }
            if (!null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions()))
            {
                if (this.queryActorTurnsNearTarget(null, _entity.getTile(), _entity).Turns <= 1.0)
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
                    if (null.getSkills().hasSkill("effects.adrenaline") && null.getSkills().hasSkill("effects.adrenaline"))
                    {
                        return (null.getSkills().hasSkill("effects.adrenaline") && null.getSkills().hasSkill("effects.adrenaline"));
                    }
                    if (null.getTile().IsBadTerrain)
                    {
                    }
                    if (null.getTile().Properties.Effect.Applicable(null) && null.getTile().Properties.Effect.Applicable(null))
                    {
                        return (null.getTile().Properties.Effect.Applicable(null) && null.getTile().Properties.Effect.Applicable(null));
                    }
                    if ((0 + 14) > 1)
                    {
                    }
                    if (((0.0 + ((((((((((this.m.Skill.getMaxRange() - _entity.getTile().getDistanceTo(null.Actor.getTile()) + this.Const.AI.Behavior.RootFleeingBonus) + this.Const.AI.Behavior.RootNoRangedWeaponBonus) + this.Const.AI.Behavior.RootNotEngagedBonus) + this.Const.AI.Behavior.RootDangerBonus) + this.Const.AI.Behavior.RootCantAttackAnyoneBonus) + this.Const.AI.Behavior.RootAdrenalineBonus) + this.Const.AI.Behavior.RootBadTerrain) + this.Const.AI.Behavior.RootBadTerrain) * null.getCurrentProperties().TargetAttractionMult)) * this.Math.pow(this.Const.AI.Behavior.RootNumAffectedPOW, ((0 + 14) - 1))) > 0.0))
                    {
                    }
                    if (null.Actor != null)
                    {
                        this.m.TargetTile = null.Actor.getTile();
                        this.m.TargetScore = ((0.0 + ((((((((((this.m.Skill.getMaxRange() - _entity.getTile().getDistanceTo(null.Actor.getTile())) + this.Const.AI.Behavior.RootFleeingBonus) + this.Const.AI.Behavior.RootNoRangedWeaponBonus) + this.Const.AI.Behavior.RootNotEngagedBonus) + this.Const.AI.Behavior.RootDangerBonus) + this.Const.AI.Behavior.RootCantAttackAnyoneBonus) + this.Const.AI.Behavior.RootAdrenalineBonus) + this.Const.AI.Behavior.RootBadTerrain) + this.Const.AI.Behavior.RootBadTerrain) * null.getCurrentProperties().TargetAttractionMult)) * this.Math.pow(this.Const.AI.Behavior.RootNumAffectedPOW, ((0 + 14) - 1)));
                    }
                    return _entity;
                }
            }
        }
    }
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    this.m.TargetTile = null;
    this.m.TargetScore = 0;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if ((this.Time.getRound() == 1) && (this.Time.getRound() == 1))
    {
        return ((this.Time.getRound() == 1) && (this.Time.getRound() == 1));
        return _entity;
    }
    if (!this.getAgent().hasKnownOpponent())
    {
        return _entity;
    }
    if (_entity.getTile().hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
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
    if (this.m.TargetTile == null)
    {
        return _entity;
    }
    if (this.getStrategy().getStats().RangedAlliedVSEnemies > 1)
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
        if ("IsFirstExecuted" && "IsFirstExecuted")
        {
            return ("IsFirstExecuted" && "IsFirstExecuted");
            _entity.setDiscovered(true);
            _entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
        }
        return _entity;
    }
    this.m.Skill.use(this.m.TargetTile);
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
        this.getAgent().declareEvaluationDelay(500);
    }
    this.m.Skill = null;
    this.m.TargetTile = null;
    return _entity;
}
