// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/skeleton_priest_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.SkeletonPriest;
    this.m.Properties.TargetPriorityHitchanceMult = 0.0;
    this.m.Properties.TargetPriorityHitpointsMult = 0.5;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityMoraleMult = 0.25;
    this.m.Properties.TargetPriorityBraveryMult = 0.25;
    this.m.Properties.TargetPriorityHittingAlliesMult = 1.0;
    this.m.Properties.OverallDefensivenessMult = 0.10000000149011612;
    this.m.Properties.OverallFormationMult = 1.0;
    this.m.Properties.EngageRangeMin = 5;
    this.m.Properties.EngageRangeMax = 7;
    this.m.Properties.EngageRangeIdeal = 7;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_ranged"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_horror"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_miasma"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_rotation"));
    return;
}

function onUpdate(this)
{
    return;
}
