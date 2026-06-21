// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/spider_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.Spider;
    this.m.Properties.TargetPriorityHitchanceMult = 0.5;
    this.m.Properties.TargetPriorityHitpointsMult = 0.25;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.25;
    this.m.Properties.TargetPriorityFleeingMult = 0.75;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.75;
    this.m.Properties.OverallDefensivenessMult = 0.0;
    this.m.Properties.OverallFormationMult = 0.5;
    this.m.Properties.EngageAgainstSpearwallMult = 1.0;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 1.3300000429153442;
    this.m.Properties.EngageFlankingMult = 1.600000023841858;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.5;
    this.m.Properties.EngageLockDownTargetMult = 2.0;
    this.m.Properties.PreferCarefulEngage = false;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_roam"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_disengage"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_throw_net"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    return;
}

function onUpdate(this)
{
    if ((this.Math <= 25) && (this.Math <= 25))
    {
        return ((this.Math <= 25) && (this.Math <= 25));
        this.m.Properties.EngageAgainstSpearwallMult = 1.3300000429153442;
    }
    this.m.Properties.EngageAgainstSpearwallMult = 1.0;
    return;
}
