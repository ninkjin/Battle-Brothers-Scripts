// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_deathblow.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Deathblow;
    this.m.Order = this.Const.AI.Behavior.Order.Deathblow;
    this.m.PossibleSkills = ["actives.deathblow"];
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    if (((this.ai_attack_default.onEvaluate(_entity) / this.Const.AI.Behavior.Score.Attack) * this.Const.AI.Behavior.Score.Deathblow) > 0)
    {
        this.getAgent().getBehavior(this.Const.AI.Behavior.ID.AttackDefault).m.Score = this.getAgent().getBehavior(this.Const.AI.Behavior.ID.AttackDefault).m.Score op42 0.25;
    }
    return _entity;
}

function queryBestMeleeTarget(this, _entity, _skill, _targets)
{
    if ((_targets.len() - 1) >= 0)
    {
        if ((!_targets["(_targets.len() - 1)"].getCurrentProperties().IsRooted) && (!_targets["(_targets.len() - 1)"].getCurrentProperties().IsRooted) && (!_targets["(_targets.len() - 1)"].getCurrentProperties().IsRooted))
        {
            return ((!_targets["(_targets.len() - 1)"].getCurrentProperties().IsRooted) && (!_targets["(_targets.len() - 1)"].getCurrentProperties().IsRooted) && (!_targets["(_targets.len() - 1)"].getCurrentProperties().IsRooted));
            _targets.remove((_targets.len() - 1));
        }
    }
    return this.behavior.queryBestMeleeTarget(_entity, _skill, _targets);
    return _entity;
}

function queryBestRangedTarget(this, _entity, _skill, _targets, _maxRange)
{
    if ((_targets.len() - 1) >= 0)
    {
        if ((!_targets["(_targets.len() - 1)"].getCurrentProperties().IsRooted) && (!_targets["(_targets.len() - 1)"].getCurrentProperties().IsRooted) && (!_targets["(_targets.len() - 1)"].getCurrentProperties().IsRooted))
        {
            return ((!_targets["(_targets.len() - 1)"].getCurrentProperties().IsRooted) && (!_targets["(_targets.len() - 1)"].getCurrentProperties().IsRooted) && (!_targets["(_targets.len() - 1)"].getCurrentProperties().IsRooted));
            _targets.remove((_targets.len() - 1));
        }
    }
    return this.behavior.queryBestRangedTarget(_entity, _skill, _targets, _maxRange);
    return _entity;
}
