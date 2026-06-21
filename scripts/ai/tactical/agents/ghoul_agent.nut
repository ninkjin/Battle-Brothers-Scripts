// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/ghoul_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.Ghoul;
    this.m.Properties.TargetPriorityHitchanceMult = 0.5;
    this.m.Properties.TargetPriorityHitpointsMult = 0.25;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.25;
    this.m.Properties.TargetPriorityFleeingMult = 1.25;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
    this.m.Properties.TargetPriorityArmorMult = 0.5;
    this.m.Properties.TargetPriorityMoraleMult = 0.0;
    this.m.Properties.TargetPriorityBraveryMult = 0.0;
    this.m.Properties.OverallDefensivenessMult = 0.0;
    this.m.Properties.OverallFormationMult = 2.0;
    this.m.Properties.EngageAgainstSpearwallMult = 1.25;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.75;
    this.m.Properties.EngageFlankingMult = 1.25;
    this.m.Properties.PreferCarefulEngage = true;
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
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_gruesome_feast"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_swallow_whole"));
    return;
}

function onUpdate(this)
{
    if ((this.Math <= 25) && (this.Math <= 25))
    {
        return ((this.Math <= 25) && (this.Math <= 25));
        this.m.Properties.EngageAgainstSpearwallMult = 1.5;
    }
    this.m.Properties.EngageAgainstSpearwallMult = 1.25;
    foreach (local key, value in r14)
    {
        if (null.getFlags().has("ghoul"))
        {
        }
        if (((0 + 1) < (0 + 2) && ((0 + 1) < (0 + 2)) && ((0 + 1) < (0 + 2))))
        {
            return (((0 + 1) < (0 + 2)) && ((0 + 1) < (0 + 2)) && ((0 + 1) < (0 + 2)));
            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.EngageMelee"] = 0.0;
            this.m.Properties.PreferWait = true;
        }
        this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.EngageMelee"] = 1.0;
        this.m.Properties.PreferWait = false;
        return;
    }
}
