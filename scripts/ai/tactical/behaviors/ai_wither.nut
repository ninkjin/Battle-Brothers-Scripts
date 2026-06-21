// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_wither.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Wither;
    this.m.Order = this.Const.AI.Behavior.Order.Wither;
    this.m.IsThreaded = false;
    this.behavior.create();
    return;
}

function findBestTarget(this, _entity, _targets)
{
    foreach (local key, value in r16)
    {
        if (null.getType() == this.Const.EntityType.SkeletonLich)
        {
        }
        foreach (local key, value in r159)
        {
            if (!this.m.Skill.isUsableOn(null.Actor.getTile()))
            {
            }
            else
            {
                if (null.Actor.getMoraleState() == this.Const.MoraleState.Fleeing)
                {
                }
                else
                {
                    foreach (local key, value in r21)
                    {
                        if ((null.Actor.getSkills().getSkillByID("effects.withered").m.TurnsLeft >= 2) && (null.Actor.getSkills().getSkillByID("effects.withered").m.TurnsLeft >= 2))
                        {
                            return ((null.Actor.getSkills().getSkillByID("effects.withered").m.TurnsLeft >= 2) && (null.Actor.getSkills().getSkillByID("effects.withered").m.TurnsLeft >= 2));
                        }
                        if ((null.Actor.getSkills().getSkillByID("effects.withered").m.TurnsLeft == 1) && (null.Actor.getSkills().getSkillByID("effects.withered").m.TurnsLeft == 1))
                        {
                            return ((null.Actor.getSkills().getSkillByID("effects.withered").m.TurnsLeft == 1) && (null.Actor.getSkills().getSkillByID("effects.withered").m.TurnsLeft == 1));
                        }
                        if (null.Actor.getTile().hasZoneOfOccupationOtherThan(null.Actor.getAlliedFactions()))
                        {
                        }
                        if ((this.Math.pow <= 2) && (this.Math.pow <= 2))
                        {
                            return ((this.Math.pow <= 2) && (this.Math.pow <= 2));
                        }
                        if ((((((((((0.0 + null.Actor.getCurrentProperties().getMeleeDefense() + null.Actor.getCurrentProperties().getRangedDefense()) + null.Actor.getCurrentProperties().getMeleeSkill()) + null.Actor.getCurrentProperties().getRangedSkill()) + (this.Math.max(0, (5 - null.getTile().getDistanceTo(null.Actor.getTile()))) * this.Const.AI.Behavior.WitherAllyDistanceMult)) * this.Const.AI.Behavior.WitherAlreadyAppliedMult) * this.Math.pow(this.Const.AI.Behavior.WitherEngagedPOW, null.Actor.getTile().getZoneOfOccupationCountOtherThan(null.Actor.getAlliedFactions()))) * this.Const.AI.Behavior.WitherNearMasterMult) * null.Actor.getCurrentProperties().TargetAttractionMult) > 0.0))
                        {
                        }
                        return _entity;
                    }
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
