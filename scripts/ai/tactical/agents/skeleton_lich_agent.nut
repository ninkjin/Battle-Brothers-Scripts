// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/skeleton_lich_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.SkeletonPriest;
    this.m.Properties.TargetPriorityHitchanceMult = 0.0;
    this.m.Properties.TargetPriorityHitpointsMult = 0.5;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityMoraleMult = 0.25;
    this.m.Properties.TargetPriorityBraveryMult = 0.25;
    this.m.Properties.TargetPriorityHittingAlliesMult = 1.0;
    this.m.Properties.OverallDefensivenessMult = 0.10000000149011612;
    this.m.Properties.OverallFormationMult = 1.0;
    this.m.Properties.EngageRangeMin = 5;
    this.m.Properties.EngageRangeMax = 7;
    this.m.Properties.EngageRangeIdeal = 7;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_ranged"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_always_use"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_horror"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_miasma"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_mirror_image"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flying_skulls"));
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
        if (this.Math.max(0, ((0 + 2) - (this.Time.getRound() / 7)) <= 2))
        {
            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Miasma"] = 0.0;
            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Horror"] = 0.0;
            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.MirrorImage"] = 1.0;
            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.FlyingSkulls"] = 1.0;
            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.LightningStorm"] = 1.0;
            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.AlwaysUse"] = 4.0;
        }
        else
        {
            if (this.Math.max(0, ((0 + 2) - (this.Time.getRound() / 7)) <= 3))
            {
                this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Miasma"] = 0.5;
                this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Horror"] = 0.0;
                this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.MirrorImage"] = 1.0;
                this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.FlyingSkulls"] = 0.0;
                this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.LightningStorm"] = 1.0;
                this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.AlwaysUse"] = 4.0;
            }
            else
            {
                if (this.Math.max(0, ((0 + 2) - (this.Time.getRound() / 7)) <= 4))
                {
                    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Miasma"] = 0.5;
                    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Horror"] = 0.0;
                    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.MirrorImage"] = 1.0;
                    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.FlyingSkulls"] = 0.0;
                    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.LightningStorm"] = 1.0;
                    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.AlwaysUse"] = 4.0;
                }
                else
                {
                    if (this.Math.max(0, ((0 + 2) - (this.Time.getRound() / 7)) <= 6))
                    {
                        this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Miasma"] = 0.5;
                        this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Horror"] = 0.5;
                        this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.MirrorImage"] = 1.0;
                        this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.FlyingSkulls"] = 0.0;
                        this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.LightningStorm"] = 0.0;
                        this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.AlwaysUse"] = 4.0;
                    }
                    else
                    {
                        if (this.Math.max(0, ((0 + 2) - (this.Time.getRound() / 7)) <= 9))
                        {
                            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Miasma"] = 0.0;
                            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Horror"] = 0.5;
                            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.MirrorImage"] = 0.0;
                            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.FlyingSkulls"] = 1.0;
                            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.LightningStorm"] = 0.0;
                            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.AlwaysUse"] = 0.0;
                        }
                        else
                        {
                            if (this.Math.max(0, ((0 + 2) - (this.Time.getRound() / 7)) >= 10))
                            {
                                this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Miasma"] = 1.0;
                                this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Horror"] = 1.0;
                                this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.MirrorImage"] = 0.0;
                                this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.FlyingSkulls"] = 0.0;
                                this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.LightningStorm"] = 0.0;
                                this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.AlwaysUse"] = 0.0;
                            }
                        }
                    }
                }
            }
        }
        return;
    }
}
