// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/ghost_knight_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.Ghost;
    this.m.Properties.TargetPriorityHitchanceMult = 0.5;
    this.m.Properties.TargetPriorityHitpointsMult = 0.25;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.0;
    this.m.Properties.TargetPriorityFleeingMult = 1.0;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityFinishOpponentMult = 2.75;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
    this.m.Properties.TargetPriorityArmorMult = 2.0;
    this.m.Properties.TargetPriorityMoraleMult = 0.25;
    this.m.Properties.TargetPriorityBraveryMult = 0.25;
    this.m.Properties.OverallDefensivenessMult = 0.5;
    this.m.Properties.OverallFormationMult = 0.5;
    this.m.Properties.EngageWhenAlreadyEngagedMult = 0.0;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
    this.m.Properties.EngageOnGoodTerrainBonusMult = 1.0;
    this.m.Properties.EngageOnBadTerrainPenaltyMult = 1.0;
    this.m.Properties.EngageAgainstSpearwallMult = 0.25;
    this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.25;
    this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 1.0;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.0;
    this.m.Properties.EngageLockDownTargetMult = 1.0;
    this.m.Properties.EngageRangeMin = 1;
    this.m.Properties.EngageRangeMax = 1;
    this.m.Properties.EngageRangeIdeal = 1;
    this.m.Properties.EngageEnemiesInLinePreference = 2;
    this.m.Properties.PreferCarefulEngage = false;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_split"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_swing"));
    return;
}

function onUpdate(this)
{
    return;
}
