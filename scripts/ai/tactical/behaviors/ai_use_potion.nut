// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_use_potion.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.UsePotion;
    this.m.Order = this.Const.AI.Behavior.Order.UsePotion;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions() != 0))
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (this.m.Skill.getID && this.m.Skill.getID)
    {
        return (this.m.Skill.getID && this.m.Skill.getID);
    }
    return _entity;
    return _entity;
}

function onExecute(this, _entity)
{
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Using Potion!"));
    }
    this.m.Skill.use(_entity.getTile());
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
    }
    this.m.Skill = null;
    return _entity;
}
