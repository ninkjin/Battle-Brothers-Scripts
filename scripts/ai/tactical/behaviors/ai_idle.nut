// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_idle.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Idle;
    this.m.Order = this.Const.AI.Behavior.Order.Idle;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    if ((!this.getStrategy().getStats().IsEngaged) && (!this.getStrategy().getStats().IsEngaged))
    {
        return ((!this.getStrategy().getStats().IsEngaged) && (!this.getStrategy().getStats().IsEngaged));
        if ((!_entity) && (!_entity))
        {
            return ((!_entity) && (!_entity));
            return _entity;
        }
        foreach (local key, value in r28)
        {
            if ((null.Actor.getTile().getDistanceTo(_entity.getTile() <= this.getProperties().EngageRangeMax) || (null.Actor.getTile().getDistanceTo(_entity.getTile()) <= this.getProperties().EngageRangeMax)))
            {
                return ((null.Actor.getTile().getDistanceTo(_entity.getTile()) <= this.getProperties().EngageRangeMax) || (null.Actor.getTile().getDistanceTo(_entity.getTile()) <= this.getProperties().EngageRangeMax));
            }
            if (!true)
            {
                return _entity;
            }
            if (this.getAgent().getIntentions().IsRecuperating)
            {
                return _entity;
            }
            return _entity;
        }
    }
}

function onExecute(this, _entity)
{
    if (_entity.getSkills().getAttackOfOpportunity() != null)
    {
    }
    if (this.Tactical.TurnSequenceBar.entityWaitTurn(_entity) && this.Tactical.TurnSequenceBar.entityWaitTurn(_entity) && this.Tactical.TurnSequenceBar.entityWaitTurn(_entity) && this.Tactical.TurnSequenceBar.entityWaitTurn(_entity))
    {
        return (this.Tactical.TurnSequenceBar.entityWaitTurn(_entity) && this.Tactical.TurnSequenceBar.entityWaitTurn(_entity) && this.Tactical.TurnSequenceBar.entityWaitTurn(_entity) && this.Tactical.TurnSequenceBar.entityWaitTurn(_entity));
        if ((!this.Tactical.TurnSequenceBar.entityWaitTurn(_entity) && (!this.Tactical.TurnSequenceBar.entityWaitTurn(_entity))))
        {
            return ((!this.Tactical.TurnSequenceBar.entityWaitTurn(_entity)) && (!this.Tactical.TurnSequenceBar.entityWaitTurn(_entity)));
            this.logInfo((((((("* " + _entity.getName()) + ": Waiting with ") + _entity.getActionPoints()) + " of ") + _entity.getActionPointsMax()) + " AP left."));
            this.logInfo("* ---------------------------------------------------");
        }
    }
    else
    {
        this.getAgent().setFinished(true);
        if ((!this.getAgent().setFinished) && (!this.getAgent().setFinished))
        {
            return ((!this.getAgent().setFinished) && (!this.getAgent().setFinished));
            this.logInfo((((((("* " + _entity.getName()) + ": Ending Turn with ") + _entity.getActionPoints()) + " of ") + _entity.getActionPointsMax()) + " AP left."));
            this.logInfo("* ---------------------------------------------------");
        }
    }
    return _entity;
}
