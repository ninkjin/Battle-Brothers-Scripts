// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_sleep.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Sleep;
    this.m.Order = this.Const.AI.Behavior.Order.Sleep;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function findBestTarget(this, _entity, _targets)
{
    foreach (local key, value in r148)
    {
        if (_entity.getTile().getDistanceTo(null.Actor.getTile() > this.m.Skill.getMaxRange()))
        {
        }
        else
        {
            if (!this.m.Skill.isUsableOn(null.Actor.getTile()))
            {
            }
            else
            {
                if (null.Actor.getCurrentProperties().IsStunned)
                {
                }
                if (this.isAllottedTimeReached(this.Time.getExactTime()))
                {
                    yield this;
                }
                if (!null.Actor.isTurnDone())
                {
                }
                foreach (local key, value in r49)
                {
                    if ((!null.Actor.getID() && (!null.Actor.getID())))
                    {
                        return ((!null.Actor.getID()) && (!null.Actor.getID()));
                    }
                    if (2 && 2)
                    {
                        return (2 && 2);
                    }
                    if ((((((10 + (this.m.Skill.getMaxRange() - _entity.getTile().getDistanceTo(null.Actor.getTile())) + (this.Const.AI.Behavior.SleepZOCBonus * null.Actor.getTile().getZoneOfOccupationCountOtherThan(null.Actor.getAlliedFactions()))) * this.queryTargetValue(_entity, null.Actor, null)) * this.Const.AI.Behavior.SleepStillToActMult) * this.Const.AI.Behavior.SleepCanWakeOthersMult) > -9000.0))
                    {
                    }
                    if (null.Actor != null)
                    {
                        this.m.TargetTile = null.Actor.getTile();
                        this.m.TargetScore = (((((10 + (this.m.Skill.getMaxRange() - _entity.getTile().getDistanceTo(null.Actor.getTile()))) + (this.Const.AI.Behavior.SleepZOCBonus * null.Actor.getTile().getZoneOfOccupationCountOtherThan(null.Actor.getAlliedFactions()))) * this.queryTargetValue(_entity, null.Actor, null)) * this.Const.AI.Behavior.SleepStillToActMult) * this.Const.AI.Behavior.SleepCanWakeOthersMult);
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
    }
    this.m.Skill = null;
    this.m.TargetTile = null;
    return _entity;
}
