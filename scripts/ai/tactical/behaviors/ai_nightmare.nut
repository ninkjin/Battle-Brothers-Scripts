// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_nightmare.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Nightmare;
    this.m.Order = this.Const.AI.Behavior.Order.Nightmare;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function findBestTarget(this, _entity, _targets)
{
    foreach (local key, value in r216)
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
            if (null.Actor.getMoraleState() == this.Const.MoraleState.Fleeing)
            {
            }
            if ((_entity.getTile().getDistanceTo(null.Actor.getTile() <= null.Actor) && (_entity.getTile().getDistanceTo(null.Actor.getTile()) <= null.Actor)))
            {
                return ((_entity.getTile().getDistanceTo(null.Actor.getTile()) <= null.Actor) && (_entity.getTile().getDistanceTo(null.Actor.getTile()) <= null.Actor));
            }
            foreach (local key, value in r25)
            {
                if (null.getTile().getDistanceTo(null.Actor.getTile() < _entity.getTile().getDistanceTo(null.Actor.getTile())))
                {
                }
                if (null.Actor.getTile().getZoneOfOccupationCount(null.Actor.getFaction() == 0))
                {
                }
                foreach (local key, value in r52)
                {
                    if (null.Actor.getTile().getDistanceTo(null.Actor.getTile() >= 8))
                    {
                    }
                    if ((null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions() > 1) || (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) > 1)))
                    {
                        return ((null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) > 1) || (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) > 1));
                    }
                    if (this.queryActorTurnsNearTarget(null.Actor, null.Actor.getTile(), _entity).Turns <= 1.0)
                    {
                    }
                    if (null.Actor.getTile().hasZoneOfOccupationOtherThan(null.Actor.getAlliedFactions()))
                    {
                    }
                    if (_entity.getAttackers().find(null.Actor.getID() != null))
                    {
                    }
                    if ((((((((((30.0 + this.Const.AI.Behavior.NightmareDangerOfRangedTarget) - (_entity.getTile().getDistanceTo(null.Actor.getTile() * this.Const.AI.Behavior.NightmareDistanceMult)) + (this.Math.max(0, (7 - null.getTile().getDistanceTo(null.Actor.getTile()))) * this.Const.AI.Behavior.NightmareAllyDistanceMult)) + this.Const.AI.Behavior.NightmareIsolatedBonus) - this.Const.AI.Behavior.NightmareHelperPenalty) * this.Const.AI.Behavior.NightmareEngagedMult) * null.Actor.getCurrentProperties().TargetAttractionMult) * this.Const.AI.Behavior.NightmareAttackingMeMult) * this.queryTargetValue(_entity, null.Actor)) > 0.0))
                    {
                    }
                    if (null.Actor != null)
                    {
                        this.m.TargetTile = null.Actor.getTile();
                        this.m.ScoreBonus = ((((((((((30.0 + this.Const.AI.Behavior.NightmareDangerOfRangedTarget) - (_entity.getTile().getDistanceTo(null.Actor.getTile()) * this.Const.AI.Behavior.NightmareDistanceMult)) + (this.Math.max(0, (7 - null.getTile().getDistanceTo(null.Actor.getTile()))) * this.Const.AI.Behavior.NightmareAllyDistanceMult)) + this.Const.AI.Behavior.NightmareIsolatedBonus) - this.Const.AI.Behavior.NightmareHelperPenalty) * this.Const.AI.Behavior.NightmareEngagedMult) * null.Actor.getCurrentProperties().TargetAttractionMult) * this.Const.AI.Behavior.NightmareAttackingMeMult) * this.queryTargetValue(_entity, null.Actor)) * 0.10000000149011612);
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
    this.getAgent().declareEvaluationDelay(550);
    this.getAgent().declareAction();
    this.m.Skill = null;
    this.m.TargetTile = null;
    return _entity;
}
