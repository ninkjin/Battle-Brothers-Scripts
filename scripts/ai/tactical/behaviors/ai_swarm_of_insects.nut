// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_swarm_of_insects.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.SwarmOfInsects;
    this.m.Order = this.Const.AI.Behavior.Order.SwarmOfInsects;
    this.m.IsThreaded = false;
    this.behavior.create();
    return;
}

function findBestTarget(this, _entity, _targets)
{
    foreach (local key, value in r215)
    {
        if (!this.m.Skill.isUsableOn(null.Actor.getTile()))
        {
        }
        else
        {
            if ((this.queryActorTurnsNearTarget(null.Actor, _entity.getTile(), _entity).Turns <= 1.0) && (this.queryActorTurnsNearTarget(null.Actor, _entity.getTile(), _entity).Turns <= 1.0))
            {
                return ((this.queryActorTurnsNearTarget(null.Actor, _entity.getTile(), _entity).Turns <= 1.0) && (this.queryActorTurnsNearTarget(null.Actor, _entity.getTile(), _entity).Turns <= 1.0));
            }
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
                if ((_entity.getTile().getDistanceTo(null.Actor.getTile() > 4) && (_entity.getTile().getDistanceTo(null.Actor.getTile()) > 4)))
                {
                    return ((_entity.getTile().getDistanceTo(null.Actor.getTile()) > 4) && (_entity.getTile().getDistanceTo(null.Actor.getTile()) > 4));
                }
                if (null.Actor.getSkills().hasSkill("effects.insect_swarm"))
                {
                    if (null.Actor.getCurrentProperties().NegativeStatusEffectDuration < 0)
                    {
                    }
                }
                if (null.Actor.getTile().hasZoneOfOccupationOtherThan(null.Actor.getAlliedFactions()))
                {
                }
                if (_entity.getAttackers().find(null.Actor.getID() != null))
                {
                }
                if ((((((((((((1.0 + null.Actor.getCurrentProperties().getMeleeDefense() + null.Actor.getCurrentProperties().getRangedDefense()) + null.Actor.getCurrentProperties().getMeleeSkill()) + null.Actor.getCurrentProperties().getRangedSkill()) + this.Const.AI.Behavior.InsectSwarmDangerOfRangedTarget) - (_entity.getTile().getDistanceTo(null.Actor.getTile()) * this.Const.AI.Behavior.InsectSwarmDistanceMult)) + (this.Math.max(0, (7 - null.getTile().getDistanceTo(null.Actor.getTile()))) * this.Const.AI.Behavior.InsectSwarmAllyDistanceMult)) * this.Const.AI.Behavior.InsectSwarmAlreadyAppliedMult) * this.Const.AI.Behavior.InsectSwarmEngagedMult) * null.Actor.getCurrentProperties().TargetAttractionMult) * this.Const.AI.Behavior.InsectSwarmAttackingMeMult) > 30.0))
                {
                }
                return _entity;
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
    if ((this.Time.getRound() == 1) && (this.Time.getRound() == 1))
    {
        return ((this.Time.getRound() == 1) && (this.Time.getRound() == 1));
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
    if (this.findBestTarget(_entity, this.getAgent().getKnownOpponents().Target == null))
    {
        return _entity;
    }
    this.m.TargetTile = this.findBestTarget(_entity, this.getAgent().getKnownOpponents()).Target.getTile();
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
