// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/goblin_melee_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.GoblinMelee;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Defend"] = 1.0;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Shieldwall"] = 1.0;
    this.m.Properties.TargetPriorityHitchanceMult = 0.5;
    this.m.Properties.TargetPriorityHitpointsMult = 0.30000001192092896;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.20000000298023224;
    this.m.Properties.TargetPriorityFleeingMult = 0.5;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
    this.m.Properties.TargetPriorityArmorMult = 0.75;
    this.m.Properties.OverallDefensivenessMult = 1.149999976158142;
    this.m.Properties.OverallFormationMult = 1.5;
    this.m.Properties.EngageFlankingMult = 1.25;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 1.5;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.5;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_disengage"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_wake_up_ally"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_puncture"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_throw_net"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_spearwall"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_shieldwall"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_knock_back"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_ranged"));
    if (this.Math.rand(1, 100) <= this.Const.AI.Agent.ChanceToHaveProtectBehavior)
    {
        this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_protect"));
    }
    return;
}

function onUpdate(this)
{
    this.setEngageRangeBasedOnWeapon();
    return;
}
