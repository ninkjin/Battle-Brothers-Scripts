// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_lightning_storm.nut
// Functions: 5

function <anonymous>(this, _a, _b)
{
    if (_a.Score > _b.Score)
    {
        return _a;
    }
    else
    {
        if (_a.Score < _b.Score)
        {
            return _a;
        }
    }
    return _a;
}

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.LightningStorm;
    this.m.Order = this.Const.AI.Behavior.Order.LightningStorm;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    this.m.Target = null;
    if (this.Time.getRound() == 1)
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (this.m.Skill.isWaitingOnImpact())
    {
        return _entity;
    }
    this.m.Target = this.selectBestTarget(_entity, this.getAgent().getKnownOpponents());
    if (this.m.Target == null)
    {
        return _entity;
    }
    return _entity;
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        if (this.m.Target == null)
        {
            this.getAgent().adjustCameraToDestination(this.m.Skill.getTiles()["15"]);
        }
        this.getAgent().adjustCameraToDestination(this.m.Target);
        this.m.IsFirstExecuted = false;
        return _entity;
    }
    if (this.m.Target == null)
    {
        this.m.Skill.updateImpact();
    }
    this.m.Skill.use(this.m.Target);
    if (_entity.isAlive())
    {
        this.getAgent().declareAction();
        if (this.m.Skill.getDelay() != 0)
        {
            this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
        }
    }
    this.m.Skill = null;
    this.m.Target = null;
    return _entity;
    return _entity;
}

function selectBestTarget(this, _entity, _targets)
{
    [].resize(this.Tactical.getMapSize().X);
    if (0 < [].len())
    {
        []["0"] = {Score = 0.0, X = 0};
    }
    foreach (local key, value in r47)
    {
        if ((this.Const.EntityType.SkeletonLichMirrorImage == this.Const.EntityType.SkeletonLich) && (this.Const.EntityType.SkeletonLichMirrorImage == this.Const.EntityType.SkeletonLich))
        {
            return ((this.Const.EntityType.SkeletonLichMirrorImage == this.Const.EntityType.SkeletonLich) && (this.Const.EntityType.SkeletonLichMirrorImage == this.Const.EntityType.SkeletonLich));
            if (("actives.lightning_storm" != 0) && ("actives.lightning_storm" != 0))
            {
                return (("actives.lightning_storm" != 0) && ("actives.lightning_storm" != 0));
                []["null.getSkills().getSkillByID("actives.lightning_storm").getTiles()["0"].SquareCoords.X"].Score = -999999.0;
            }
        }
        foreach (local key, value in r82)
        {
            if ((null.Actor.getType() == this.Const.EntityType.Warhound) || (null.Actor.getType() == this.Const.EntityType.Warhound))
            {
                return ((null.Actor.getType() == this.Const.EntityType.Warhound) || (null.Actor.getType() == this.Const.EntityType.Warhound));
            }
            if (null.Actor.IsRooted && null.Actor.IsRooted)
            {
                return (null.Actor.IsRooted && null.Actor.IsRooted);
            }
            if (null.Actor.getTile().hasZoneOfControlOtherThan(null.Actor.getAlliedFactions()))
            {
            }
            []["null.Actor.getTile().SquareCoords.X"].Score = []["null.Actor.getTile().SquareCoords.X"].Score op43 ((this.queryTargetValue(_entity, null.Actor, this.m.Skill) * this.Const.AI.Behavior.LightningStormStunnedTargetMult) * this.Const.AI.Behavior.LightningStormTargetInZOCMult);
            [].sort(function() /* closure #0 */);
            if ([]["0"].Score > 0)
            {
                return this.Tactical.getTileSquare([]["0"].X, 15);
                return _entity;
            }
            return _entity;
        }
    }
}
