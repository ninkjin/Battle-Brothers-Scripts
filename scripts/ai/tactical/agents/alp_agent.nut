// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/alp_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.Alp;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.AttackDefault"] = 1.25;
    this.m.Properties.TargetPriorityHitchanceMult = 0.0;
    this.m.Properties.TargetPriorityHitpointsMult = 0.4000000059604645;
    this.m.Properties.TargetPriorityRandomMult = 0.20000000298023224;
    this.m.Properties.TargetPriorityDamageMult = 0.0;
    this.m.Properties.TargetPriorityFleeingMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityFinishOpponentMult = 2.75;
    this.m.Properties.TargetPriorityCounterSkillsMult = 1.0;
    this.m.Properties.TargetPriorityArmorMult = 1.0;
    this.m.Properties.TargetPriorityMoraleMult = 0.0;
    this.m.Properties.TargetPriorityBraveryMult = 0.4000000059604645;
    this.m.Properties.OverallDefensivenessMult = 0.10000000149011612;
    this.m.Properties.OverallFormationMult = 0.10000000149011612;
    this.m.Properties.OverallHideMult = 2.0;
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
    this.m.Properties.EngageRangeMax = 2;
    this.m.Properties.EngageRangeIdeal = 2;
    this.m.Properties.PreferCarefulEngage = true;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_alp_teleport"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_sleep"));
    return;
}

function onUpdate(this)
{
    return;
}
