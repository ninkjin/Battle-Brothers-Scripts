// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/hyena_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.Hyena;
    this.m.IsUsingHeat = true;
    this.m.Properties.TargetPriorityHitchanceMult = 0.5;
    this.m.Properties.TargetPriorityHitpointsMult = 0.5;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.0;
    this.m.Properties.TargetPriorityFleeingMult = 0.75;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.75;
    this.m.Properties.OverallDefensivenessMult = 0.0;
    this.m.Properties.OverallFormationMult = 1.0;
    this.m.Properties.EngageFlankingMult = 4.0;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 2.5;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.5;
    this.m.Properties.EngageLockDownTargetMult = 2.0;
    this.m.Properties.EngageHeatCostMult = 0.5;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_roam"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    return;
}

function onUpdate(this)
{
    this.setEngageRangeBasedOnWeapon();
    if (this.getStrategy().getStats().IsEngaged)
    {
        this.m.IsUsingHeat = false;
    }
    this.m.IsUsingHeat = true;
    return;
}
