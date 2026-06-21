// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/golem_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.Golem;
    this.m.Properties.TargetPriorityHitchanceMult = 0.5;
    this.m.Properties.TargetPriorityHitpointsMult = 0.25;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.25;
    this.m.Properties.TargetPriorityFleeingMult = 1.25;
    this.m.Properties.TargetPriorityHittingAlliesMult = 1.0;
    this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
    this.m.Properties.TargetPriorityCounterSkillsMult = 1.0;
    this.m.Properties.TargetPriorityArmorMult = 1.0;
    this.m.Properties.TargetPriorityMoraleMult = 0.0;
    this.m.Properties.TargetPriorityBraveryMult = 0.0;
    this.m.Properties.OverallDefensivenessMult = 0.0;
    this.m.Properties.OverallFormationMult = 1.350000023841858;
    this.m.Properties.OverallMagnetismMult = 1.350000023841858;
    this.m.Properties.EngageAgainstSpearwallMult = 1.25;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.75;
    this.m.Properties.EngageFlankingMult = 1.25;
    this.m.Properties.EngageRangeMin = 1;
    this.m.Properties.EngageRangeMax = 1;
    this.m.Properties.EngageRangeIdeal = 1;
    this.m.Properties.PreferCarefulEngage = true;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_move_to_merge"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_merge"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_bow"));
    return;
}

function onUpdate(this)
{
    if (this.getActor().getSize() > 1)
    {
    }
    this.m.Properties.EngageRangeMax = 1;
    if (this.getActor().getSize() > 1)
    {
    }
    this.m.Properties.EngageRangeIdeal = 1;
    return;
}
