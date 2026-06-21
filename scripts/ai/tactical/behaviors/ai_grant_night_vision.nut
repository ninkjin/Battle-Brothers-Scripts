// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_grant_night_vision.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.GrantNightVision;
    this.m.Order = this.Const.AI.Behavior.Order.GrantNightVision;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function findBestTarget(this, _entity, _targets)
{
    foreach (local key, value in r166)
    {
        if (_entity.getTile().getDistanceTo(null.getTile() > this.m.Skill.getMaxRange()))
        {
        }
        if (!this.m.Skill.isUsableOn(null.getTile()))
        {
        }
        if (this.isAllottedTimeReached(this.Time.getExactTime()))
        {
            yield this;
        }
        if (this.m.Skill.isViableTarget(_entity, null))
        {
            [].push(null);
        }
        if (0 < 6)
        {
            if (!null.getTile().hasNextTile(0))
            {
            }
            else
            {
                if (!null.getTile().getNextTile(0).IsOccupiedByActor)
                {
                }
                else
                {
                    if (!this.m.Skill.isViableTarget(_entity, null.getTile().getNextTile(0).getEntity()))
                    {
                    }
                    [].push(null.getTile().getNextTile(0).getEntity());
                }
            }
        }
        foreach (local key, value in r46)
        {
            if (!null.isTurnDone())
            {
            }
            if (this.isRangedUnit(null))
            {
            }
            if ((0 + 13) > 1)
            {
            }
            if (((0.0 + (((((1.0 * null.getHitpointsPct() * null.getCurrentProperties().TargetAttractionMult) * this.Const.AI.Behavior.GrantNightVisionStillToActMult) * this.Const.AI.Behavior.GrantNightVisionRangedMult) * this.Const.AI.Behavior.GrantNightVisionMeleeMult)) * this.Math.pow(this.Const.AI.Behavior.RootNumAffectedPOW, ((0 + 13) - 1))) > -9000.0))
            {
            }
            if (null != null)
            {
                this.m.TargetTile = null.getTile();
                this.m.TargetScore = ((0.0 + (((((1.0 * null.getHitpointsPct()) * null.getCurrentProperties().TargetAttractionMult) * this.Const.AI.Behavior.GrantNightVisionStillToActMult) * this.Const.AI.Behavior.GrantNightVisionRangedMult) * this.Const.AI.Behavior.GrantNightVisionMeleeMult)) * this.Math.pow(this.Const.AI.Behavior.RootNumAffectedPOW, ((0 + 13) - 1)));
            }
            return _entity;
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
    if (this.World.IsDaytime && this.World.IsDaytime)
    {
        return (this.World.IsDaytime && this.World.IsDaytime);
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
    return _entity;
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        this.getAgent().adjustCameraToTarget(this.m.TargetTile);
        this.m.IsFirstExecuted = false;
        _entity.setDiscovered(true);
        _entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
        return _entity;
    }
    this.m.Skill.use(this.m.TargetTile);
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
    }
    this.m.Skill = null;
    this.m.TargetTile = null;
    return _entity;
}
