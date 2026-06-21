// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_charge.nut
// Functions: 2

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Charge;
    this.m.Order = this.Const.AI.Behavior.Order.Charge;
    this.m.IsThreaded = false;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    if (this.selectSkill(this.m.PossibleSkills) != null)
    {
        if (this.queryTargetsInMeleeRange(1, (this.selectSkill(this.m.PossibleSkills).getMaxRange() + 1).len() != 0))
        {
            this.getProperties().EngageRangeMin = _entity.getIdealRange();
            this.getProperties().EngageRangeMax = _entity.getIdealRange();
            this.getProperties().EngageRangeIdeal = _entity.getIdealRange();
        }
        this.getProperties().EngageRangeMin = this.selectSkill(this.m.PossibleSkills).getMinRange();
        this.getProperties().EngageRangeMax = (this.selectSkill(this.m.PossibleSkills).getMaxRange() + 1);
        this.getProperties().EngageRangeIdeal = (this.selectSkill(this.m.PossibleSkills).getMaxRange() + 1);
    }
    return _entity;
}
