// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/orc_berserker_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.OrcBerserker;
    this.m.Properties.TargetPriorityHitchanceMult = 0.5;
    this.m.Properties.TargetPriorityHitpointsMult = 0.25;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.25;
    this.m.Properties.TargetPriorityFleeingMult = 0.800000011920929;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
    this.m.Properties.TargetPriorityArmorMult = 0.800000011920929;
    this.m.Properties.OverallDefensivenessMult = 0.33000001311302185;
    this.m.Properties.OverallFormationMult = 0.0;
    this.m.Properties.OverallMagnetismMult = 0.0;
    this.m.Properties.EngageFlankingMult = 1.5;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 0.75;
    this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 1.5;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.5;
    this.m.Properties.EngageAgainstSpearwallMult = 1.100000023841858;
    this.m.Properties.EngageRangeMin = 1;
    this.m.Properties.EngageRangeMax = 2;
    this.m.Properties.EngageRangeIdeal = 2;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_charge"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_thresh"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_splitshield"));
    return;
}

function onUpdate(this)
{
    if (this.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
    {
        if (this.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.TwoHanded))
        {
            this.m.Properties.EngageTargetMultipleOpponentsMult = -1.0;
        }
        this.m.Properties.EngageTargetMultipleOpponentsMult = 0.75;
    }
    return;
}
