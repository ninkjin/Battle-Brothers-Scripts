// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/lesser_flesh_golem_agent.nut
// Functions: 2

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.LesserFleshGolem;
    this.m.Properties.TargetPriorityHitchanceMult = 0.25;
    this.m.Properties.TargetPriorityHitpointsMult = 0.25;
    this.m.Properties.TargetPriorityDamageMult = 0.25;
    this.m.Properties.TargetPriorityRandomMult = 0.25;
    this.m.Properties.TargetPriorityFleeingMult = 1.0;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.5;
    this.m.Properties.TargetPriorityCounterSkillsMult = 1.0;
    this.m.Properties.OverallDefensivenessMult = 0.0;
    this.m.Properties.OverallFormationMult = 0.5;
    this.m.Properties.OverallMagnetismMult = 0.5;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
    this.m.Properties.EngageOnGoodTerrainBonusMult = 0.0;
    this.m.Properties.EngageOnBadTerrainPenaltyMult = 0.0;
    this.m.Properties.EngageAgainstSpearwallMult = 0.0;
    this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.0;
    this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 0.0;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.0;
    this.m.Properties.EngageLockDownTargetMult = 1.0;
    this.m.Properties.PreferCarefulEngage = false;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_knock_out"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_decapitate"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_lash"));
    return;
}
