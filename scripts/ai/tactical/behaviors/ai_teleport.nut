// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_teleport.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Teleport;
    this.m.Order = this.Const.AI.Behavior.Order.Teleport;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function findBestTarget(this, _entity, _targets)
{
    if (!this.Tactical.isValidTileSquare(this.Math.rand(3, (this.Tactical.getMapSize().X - 3), this.Math.rand(3, (this.Tactical.getMapSize().Y - 3)))))
    {
    }
    else
    {
        if (!this.Tactical.getTileSquare(this.Math.rand(3, (this.Tactical.getMapSize().X - 3), this.Math.rand(3, (this.Tactical.getMapSize().Y - 3))).IsEmpty))
        {
        }
        else
        {
            if (!this.m.Skill.isUsableOn(this.Tactical.getTileSquare(this.Math.rand(3, (this.Tactical.getMapSize().X - 3), this.Math.rand(3, (this.Tactical.getMapSize().Y - 3))), _entity.getTile())))
            {
            }
            else
            {
                if (this.isAllottedTimeReached(this.Time.getExactTime()))
                {
                    yield this;
                }
                foreach (local key, value in r63)
                {
                    if (((null.Actor.getTile().getDistanceTo(this.Tactical.getTileSquare(this.Math.rand(3, (this.Tactical.getMapSize().X - 3), this.Math.rand(3, (this.Tactical.getMapSize().Y - 3)))) + 1) < this.m.FollowupSkill) && ((null.Actor.getTile().getDistanceTo(this.Tactical.getTileSquare(this.Math.rand(3, (this.Tactical.getMapSize().X - 3)), this.Math.rand(3, (this.Tactical.getMapSize().Y - 3)))) + 1) < this.m.FollowupSkill)))
                    {
                        return (((null.Actor.getTile().getDistanceTo(this.Tactical.getTileSquare(this.Math.rand(3, (this.Tactical.getMapSize().X - 3)), this.Math.rand(3, (this.Tactical.getMapSize().Y - 3)))) + 1) < this.m.FollowupSkill) && ((null.Actor.getTile().getDistanceTo(this.Tactical.getTileSquare(this.Math.rand(3, (this.Tactical.getMapSize().X - 3)), this.Math.rand(3, (this.Tactical.getMapSize().Y - 3)))) + 1) < this.m.FollowupSkill));
                    }
                    if (0 < 6)
                    {
                        if (!null.Actor.getTile().hasNextTile(0))
                        {
                        }
                        else
                        {
                            if (this.m.FollowupSkill.isUsableOn(null.Actor.getTile().getNextTile(0), this.Tactical.getTileSquare(this.Math.rand(3, (this.Tactical.getMapSize().X - 3)), this.Math.rand(3, (this.Tactical.getMapSize().Y - 3)))))
                            {
                            }
                        }
                    }
                    if (true)
                    {
                    }
                    if (true)
                    {
                        this.m.TargetTile = this.Tactical.getTileSquare(this.Math.rand(3, (this.Tactical.getMapSize().X - 3)), this.Math.rand(3, (this.Tactical.getMapSize().Y - 3)));
                    }
                    else
                    {
                        if (1)
                        {
                        }
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
    if (_entity.getActionPoints() != _entity.getActionPointsMax())
    {
        return _entity;
    }
    if ((this.Time == 2) && (this.Time == 2))
    {
        return ((this.Time == 2) && (this.Time == 2));
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    this.m.FollowupSkill = this.selectSkill(this.m.PossibleFollowupSkills);
    if (this.m.FollowupSkill == null)
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
    this.getAgent().declareEvaluationDelay(3000);
    this.getAgent().declareAction();
    this.m.Skill = null;
    this.m.TargetTile = null;
    return _entity;
}
