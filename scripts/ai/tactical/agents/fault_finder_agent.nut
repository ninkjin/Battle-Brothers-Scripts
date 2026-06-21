// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/fault_finder_agent.nut
// Functions: 2

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.FaultFinder;
    this.m.Properties.OverallMagnetismMult = 3.0;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.KnockBack"] = 0.8999999761581421;
    this.m.Properties.TargetPriorityStaggeredMult = 0.5;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_puncture"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_knock_back"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_explode_corpse"));
    this.getBehavior(this.Const.AI.Behavior.ID.KnockBack).m.IsVisionRequired = false;
    return;
}
