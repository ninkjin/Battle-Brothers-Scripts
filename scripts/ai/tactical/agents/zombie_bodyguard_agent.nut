// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/zombie_bodyguard_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.ZombieBodyguard;
    this.m.Properties.TargetPriorityHitchanceMult = 0.25;
    this.m.Properties.TargetPriorityHitpointsMult = 0.25;
    this.m.Properties.TargetPriorityDamageMult = 0.25;
    this.m.Properties.TargetPriorityRandomMult = 0.25;
    this.m.Properties.TargetPriorityFleeingMult = 1.0;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.5;
    this.m.Properties.TargetPriorityCounterSkillsMult = 1.0;
    this.m.Properties.OverallDefensivenessMult = 0.0;
    this.m.Properties.OverallFormationMult = 0.5;
    this.m.Properties.OverallMagnetismMult = 0.5;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
    this.m.Properties.EngageOnGoodTerrainBonusMult = 0.0;
    this.m.Properties.EngageOnBadTerrainPenaltyMult = 0.0;
    this.m.Properties.EngageAgainstSpearwallMult = 0.0;
    this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.0;
    this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 0.0;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.0;
    this.m.Properties.EngageLockDownTargetMult = 1.0;
    this.m.Properties.PreferCarefulEngage = false;
    this.m.Properties.IgnoreTargetValueOnEngage = true;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_protect"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_knock_back"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_swing"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_split"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_thresh"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_pickup_weapon"));
    return;
}

function onUpdate(this)
{
    this.setEngageRangeBasedOnWeapon();
    if (this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE() && this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE())
    {
        return (this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE() && this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE());
        this.m.Properties.EngageTargetMultipleOpponentsMult = 0.75;
    }
    this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
    return;
}
