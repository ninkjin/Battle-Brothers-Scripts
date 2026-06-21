// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/barbarian_drummer_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.BarbarianDrummer;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Defend"] = 1.0;
    this.m.Properties.IsRangedUnit = true;
    this.m.Properties.TargetPriorityHitchanceMult = 0.6000000238418579;
    this.m.Properties.TargetPriorityHitpointsMult = 0.20000000298023224;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.20000000298023224;
    this.m.Properties.TargetPriorityFleeingMult = 0.5;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
    this.m.Properties.TargetPriorityArmorMult = 0.5;
    this.m.Properties.OverallDefensivenessMult = 1.100000023841858;
    this.m.Properties.OverallFormationMult = 1.5;
    this.m.Properties.OverallHideMult = 0.75;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 1.350000023841858;
    this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 1.5;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_rotation"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_wake_up_ally"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_ranged"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_puncture"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_recover"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_ranged"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_boost_stamina"));
    return;
}

function onUpdate(this)
{
    return;
}
