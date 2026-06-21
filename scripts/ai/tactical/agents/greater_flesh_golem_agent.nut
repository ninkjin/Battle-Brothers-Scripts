// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/greater_flesh_golem_agent.nut
// Functions: 2

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.GreaterFleshGolem;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Retreat"] = 0.25;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.AttackDefault"] = 0.75;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Spike"] = 1.100000023841858;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Flurry"] = 1.100000023841858;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.CorpseHurl"] = 1.0;
    this.m.Properties.TargetPriorityHitchanceMult = 0.5;
    this.m.Properties.TargetPriorityHitpointsMult = 0.25;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.25;
    this.m.Properties.TargetPriorityFleeingMult = 0.6000000238418579;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.550000011920929;
    this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
    this.m.Properties.TargetPriorityArmorMult = 0.8999999761581421;
    this.m.Properties.OverallDefensivenessMult = 0.0;
    this.m.Properties.OverallFormationMult = 0.10000000149011612;
    this.m.Properties.OverallMagnetismMult = 0.0;
    this.m.Properties.EngageLockDownTargetMult = 1.0;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 0.30000001192092896;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.100000023841858;
    this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 1.100000023841858;
    this.m.Properties.EngageOnGoodTerrainBonusMult = 0.0;
    this.m.Properties.EngageOnBadTerrainPenaltyMult = 0.0;
    this.m.Properties.EngageAgainstSpearwallMult = 0.4000000059604645;
    this.m.Properties.EngageEnemiesInLinePreference = 3;
    this.m.Properties.PreferCarefulEngage = false;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_ranged"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_corpse_hurl"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_flurry"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_spike"));
    return;
}
