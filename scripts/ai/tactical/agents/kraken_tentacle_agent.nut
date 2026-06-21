// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/kraken_tentacle_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.KrakenTentacle;
    this.m.IsUpdatingAlliesBeforeEvaluation = true;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.EngageMelee"] = 0.0;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.AttackDefault"] = 2.5;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.MoveTentacle"] = 0.75;
    this.m.Properties.TargetPriorityHitchanceMult = 0.3499999940395355;
    this.m.Properties.TargetPriorityHitpointsMult = 0.25;
    this.m.Properties.TargetPriorityRandomMult = 0.15000000596046448;
    this.m.Properties.TargetPriorityDamageMult = 0.25;
    this.m.Properties.TargetPriorityFleeingMult = 0.75;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityArmorMult = 1.0;
    this.m.Properties.OverallDefensivenessMult = 0.0;
    this.m.Properties.OverallFormationMult = 0.0;
    this.m.Properties.EngageWhenAlreadyEngagedMult = 0.0;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
    this.m.Properties.EngageOnGoodTerrainBonusMult = 0.5;
    this.m.Properties.EngageOnBadTerrainPenaltyMult = 0.5;
    this.m.Properties.EngageAgainstSpearwallMult = 0.0;
    this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.0;
    this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 0.5;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.0;
    this.m.Properties.EngageLockDownTargetMult = 1.0;
    this.m.Properties.EngageRangeMin = 1;
    this.m.Properties.EngageRangeMax = 2;
    this.m.Properties.EngageRangeIdeal = 2;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_move_tentacle"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_throw_net"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    return;
}

function onUpdate(this)
{
    return;
}
