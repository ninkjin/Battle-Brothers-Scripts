// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/barbarian_melee_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.BarbarianMelee;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Defend"] = 0.5;
    this.m.Properties.TargetPriorityHitchanceMult = 0.5;
    this.m.Properties.TargetPriorityHitpointsMult = 0.25;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.25;
    this.m.Properties.TargetPriorityFleeingMult = 0.5;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
    this.m.Properties.TargetPriorityArmorMult = 0.75;
    this.m.Properties.OverallDefensivenessMult = 0.75;
    this.m.Properties.OverallFormationMult = 0.75;
    this.m.Properties.EngageFlankingMult = 1.25;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 1.25;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.5;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_rotation"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_wake_up_ally"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_indomitable"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_puncture"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_splitshield"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_swing"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_split"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_thresh"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_crush_armor"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_decapitate"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_knock_out"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_lash"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_knock_back"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_riposte"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_recover"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_ranged"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_adrenaline"));
    return;
}

function onUpdate(this)
{
    if ((this.Time.getRound() <= 2) && (this.Time.getRound() <= 2) && (this.Time.getRound() <= 2))
    {
        return ((this.Time.getRound() <= 2) && (this.Time.getRound() <= 2) && (this.Time.getRound() <= 2));
        foreach (local key, value in r22)
        {
            if ((this.Const.EntityType.BarbarianUnhold == this.Const.EntityType.BarbarianUnholdFrost) && (this.Const.EntityType.BarbarianUnhold == this.Const.EntityType.BarbarianUnholdFrost))
            {
                return ((this.Const.EntityType.BarbarianUnhold == this.Const.EntityType.BarbarianUnholdFrost) && (this.Const.EntityType.BarbarianUnhold == this.Const.EntityType.BarbarianUnholdFrost));
            }
            if (true)
            {
                this.m.Properties.EngageRangeMin = 4;
                this.m.Properties.EngageRangeMax = 4;
                this.m.Properties.EngageRangeIdeal = 4;
                this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Adrenaline"] = 0.0;
            }
            this.setEngageRangeBasedOnWeapon();
            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Adrenaline"] = 1.0;
            if (this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE() && this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE())
            {
                return (this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE() && this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE());
                this.m.Properties.EngageTargetMultipleOpponentsMult = 0.75;
            }
            this.m.Properties.EngageTargetMultipleOpponentsMult = 1.25;
            return;
        }
    }
}
