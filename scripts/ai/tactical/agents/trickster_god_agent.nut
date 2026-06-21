// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/trickster_god_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.TricksterGod;
    this.m.Properties.TargetPriorityHitchanceMult = 0.5;
    this.m.Properties.TargetPriorityHitpointsMult = 0.25;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.25;
    this.m.Properties.TargetPriorityFleeingMult = 0.6000000238418579;
    this.m.Properties.TargetPriorityHittingAlliesMult = 1.0;
    this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
    this.m.Properties.TargetPriorityArmorMult = 0.8999999761581421;
    this.m.Properties.OverallDefensivenessMult = 0.0;
    this.m.Properties.OverallFormationMult = 0.10000000149011612;
    this.m.Properties.OverallMagnetismMult = 0.0;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 0.5;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.100000023841858;
    this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 1.100000023841858;
    this.m.Properties.EngageRangeMin = 1;
    this.m.Properties.EngageRangeMax = 1;
    this.m.Properties.EngageRangeIdeal = 1;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_charge"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_teleport"));
    return;
}

function onUpdate(this)
{
    return;
}
