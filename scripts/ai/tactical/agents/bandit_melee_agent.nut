// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/bandit_melee_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.BanditMelee;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Defend"] = 1.0;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Protect"] = 0.0;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Shieldwall"] = 0.8999999761581421;
    this.m.Properties.TargetPriorityHitchanceMult = 0.5;
    this.m.Properties.TargetPriorityHitpointsMult = 0.30000001192092896;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.20000000298023224;
    this.m.Properties.TargetPriorityFleeingMult = 0.5;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
    this.m.Properties.TargetPriorityArmorMult = 0.75;
    this.m.Properties.OverallDefensivenessMult = 1.0;
    this.m.Properties.OverallFormationMult = 1.0;
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
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_puncture"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_splitshield"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_swing"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_split"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_thresh"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_crush_armor"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_decapitate"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_knock_out"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_distract"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_lash"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_gash"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_deathblow"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_reap"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_spearwall"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_shieldwall"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_knock_back"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_riposte"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_recover"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_ranged"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_protect"));
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
    if ((this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeIdeal() == 2) && (this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeIdeal() == 2))
    {
        return ((this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeIdeal() == 2) && (this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeIdeal() == 2));
        this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.25;
    }
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.5;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Protect"] = 0.0;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.SwitchToRanged"] = 1.0;
    if ((!this.isKindOf(this.getActor().get(), "bandit_leader") && (!this.isKindOf(this.getActor().get(), "bandit_leader")) && (!this.isKindOf(this.getActor().get(), "bandit_leader"))))
    {
        return ((!this.isKindOf(this.getActor().get(), "bandit_leader")) && (!this.isKindOf(this.getActor().get(), "bandit_leader")) && (!this.isKindOf(this.getActor().get(), "bandit_leader")));
        if (this.m.Actor.getItems().getItemAtSlot && this.m.Actor.getItems().getItemAtSlot)
        {
            return (this.m.Actor.getItems().getItemAtSlot && this.m.Actor.getItems().getItemAtSlot);
            foreach (local key, value in r55)
            {
                if (null.getID() == this.getActor().getID())
                {
                }
                if ((1.0.BehaviorMult[this.Const.AI.Behavior.ID.Protect] >= this.Const.AI.Behavior.ID.Protect) && (1.0.BehaviorMult[this.Const.AI.Behavior.ID.Protect] >= this.Const.AI.Behavior.ID.Protect))
                {
                    return ((1.0.BehaviorMult[this.Const.AI.Behavior.ID.Protect] >= this.Const.AI.Behavior.ID.Protect) && (1.0.BehaviorMult[this.Const.AI.Behavior.ID.Protect] >= this.Const.AI.Behavior.ID.Protect));
                }
                else
                {
                    if (null.getCurrentProperties().TargetAttractionMult > 1.0)
                    {
                        if (null.getTile().getDistanceTo(this.getActor().getTile() <= 2))
                        {
                        }
                    }
                }
                if (((0 + 4) <= (this.m.KnownAllies / 14) && ((0 + 4) <= (this.m.KnownAllies / 14))))
                {
                    return (((0 + 4) <= (this.m.KnownAllies / 14)) && ((0 + 4) <= (this.m.KnownAllies / 14)));
                    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Protect"] = 1.0;
                    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.SwitchToRanged"] = 0.0;
                }
                return;
            }
        }
    }
}
