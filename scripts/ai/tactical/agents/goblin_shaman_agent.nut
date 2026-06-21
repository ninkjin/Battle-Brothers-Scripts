// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/goblin_shaman_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.GoblinShaman;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Defend"] = 1.0;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.KeepSafe"] = 0.5;
    this.m.Properties.IsRangedUnit = true;
    this.m.Properties.TargetPriorityHitchanceMult = 0.5;
    this.m.Properties.TargetPriorityHitpointsMult = 0.30000001192092896;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.20000000298023224;
    this.m.Properties.TargetPriorityFleeingMult = 0.5;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
    this.m.Properties.TargetPriorityArmorMult = 0.75;
    this.m.Properties.OverallDefensivenessMult = 2.0;
    this.m.Properties.OverallFormationMult = 1.5;
    this.m.Properties.EngageFlankingMult = 1.25;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 1.25;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.5;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_ranged"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_wake_up_ally"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_knock_out"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_root"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_swarm_of_insects"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_grant_night_vision"));
    return;
}

function onUpdate(this)
{
    this.setEngageRangeBasedOnWeapon();
    return;
}
