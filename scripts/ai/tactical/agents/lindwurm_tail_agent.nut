// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/lindwurm_tail_agent.nut
// Functions: 2

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.Lindwurm;
    this.m.Properties.TargetPriorityHitchanceMult = 0.5;
    this.m.Properties.TargetPriorityHitpointsMult = 0.25;
    this.m.Properties.TargetPriorityRandomMult = 0.25;
    this.m.Properties.TargetPriorityDamageMult = 0.25;
    this.m.Properties.TargetPriorityFleeingMult = 0.5;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.25;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.75;
    this.m.Properties.OverallDefensivenessMult = 0.0;
    this.m.Properties.OverallFormationMult = 0.75;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.5;
    this.m.Properties.EngageLockDownTargetMult = 2.0;
    this.m.Properties.PreferCarefulEngage = false;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_move_tail"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_split"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_swing"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_thresh"));
    this.getBehavior(this.Const.AI.Behavior.ID.Swing).m.MinTargets = 1;
    this.getBehavior(this.Const.AI.Behavior.ID.Thresh).m.MinTargets = 3;
    return;
}
