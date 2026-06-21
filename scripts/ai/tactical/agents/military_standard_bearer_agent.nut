// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/military_standard_bearer_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.MilitaryMelee;
    this.m.Properties.TargetPriorityHitchanceMult = 0.4000000059604645;
    this.m.Properties.TargetPriorityHitpointsMult = 0.25;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.3499999940395355;
    this.m.Properties.TargetPriorityFleeingMult = 0.5;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
    this.m.Properties.TargetPriorityArmorMult = 0.6000000238418579;
    this.m.Properties.OverallDefensivenessMult = 1.5;
    this.m.Properties.OverallFormationMult = 2.0;
    this.m.Properties.OverallMagnetismMult = 1.5;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 1.25;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.5;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_wake_up_ally"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_recover"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_rally"));
    return;
}

function onUpdate(this)
{
    this.setEngageRangeBasedOnWeapon();
    return;
}
