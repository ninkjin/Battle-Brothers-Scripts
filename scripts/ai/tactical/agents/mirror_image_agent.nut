// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/mirror_image_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.MirrorImage;
    this.m.Properties.TargetPriorityHitchanceMult = 0.5;
    this.m.Properties.TargetPriorityHitpointsMult = 0.5;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityMoraleMult = 0.0;
    this.m.Properties.TargetPriorityBraveryMult = 0.0;
    this.m.Properties.TargetPriorityHittingAlliesMult = 1.0;
    this.m.Properties.OverallDefensivenessMult = 0.0;
    this.m.Properties.OverallFormationMult = 1.0;
    this.m.Properties.EngageRangeMin = 5;
    this.m.Properties.EngageRangeMax = 7;
    this.m.Properties.EngageRangeIdeal = 7;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_ranged"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_raise_undead"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_wither"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_lightning_storm"));
    return;
}

function onUpdate(this)
{
    foreach (local key, value in r12)
    {
        if (null.getType() == this.Const.EntityType.SkeletonPhylactery)
        {
        }
        if (this.Math.max(0, ((0 + 2) - (this.Time.getRound() / 9)) <= 1))
        {
            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.LightningStorm"] = 1.0;
        }
        this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.LightningStorm"] = 0.0;
        return;
    }
}
