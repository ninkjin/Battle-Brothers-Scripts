// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_wake_up_ally.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.WakeUpAlly;
    this.m.Order = this.Const.AI.Behavior.Order.WakeUpAlly;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    this.m.Target = null;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if ((!this.Tactical.State.isAutoRetreat() && (!this.Tactical.State.isAutoRetreat())))
    {
        return ((!this.Tactical.State.isAutoRetreat()) && (!this.Tactical.State.isAutoRetreat()));
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (0 < 6)
    {
        if (!_entity.getTile().hasNextTile(0))
        {
        }
        else
        {
            if (this.m.Skill.onVerifyTarget(_entity.getTile(), _entity.getTile().getNextTile(0) && this.m.Skill.onVerifyTarget(_entity.getTile(), _entity.getTile().getNextTile(0))))
            {
                return (this.m.Skill.onVerifyTarget(_entity.getTile(), _entity.getTile().getNextTile(0)) && this.m.Skill.onVerifyTarget(_entity.getTile(), _entity.getTile().getNextTile(0)));
                this.m.Target = _entity.getTile().getNextTile(0);
            }
        }
    }
    if (this.m.Target == null)
    {
        return _entity;
    }
    return _entity;
}

function onExecute(this, _entity)
{
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Wakes Up Ally!"));
    }
    this.m.Skill.use(this.m.Target);
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
    }
    this.m.Skill = null;
    this.m.Target = null;
    return _entity;
}
