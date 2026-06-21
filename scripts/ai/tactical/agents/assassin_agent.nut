// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/assassin_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.Assassin;
    this.m.Properties.TargetPriorityHitchanceMult = 0.4000000059604645;
    this.m.Properties.TargetPriorityHitpointsMult = 0.30000001192092896;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.30000001192092896;
    this.m.Properties.TargetPriorityFleeingMult = 0.75;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
    this.m.Properties.TargetPriorityArmorMult = 0.75;
    this.m.Properties.TargetPriorityDebilitatedMult = 1.3300000429153442;
    this.m.Properties.OverallDefensivenessMult = 0.5;
    this.m.Properties.OverallFormationMult = 0.5;
    this.m.Properties.EngageFlankingMult = 1.350000023841858;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 1.5;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.3499999940395355;
    this.m.Properties.PreferWait = true;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_wake_up_ally"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_disengage"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_deathblow"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_gash"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_throw_bomb"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_adrenaline"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_recover"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_ranged"));
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
    this.m.Properties.EngageTargetMultipleOpponentsMult = 1.25;
    return;
}
