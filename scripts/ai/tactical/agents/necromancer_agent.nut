// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/necromancer_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.Necromancer;
    this.m.Properties.OverallMagnetismMult = 3.0;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_puncture"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_raise_undead"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_possess_undead"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_ranged"));
    return;
}

function onTurnStarted(this)
{
    this.agent.onTurnStarted();
    foreach (local key, value in r23)
    {
        if (null.getID() == this.getActor().getID())
        {
        }
        if (null.getTile().getDistanceTo(this.getActor().getTile() < 9999))
        {
        }
        if (null.getTile().getDistanceTo(this.getActor().getTile() >= 10))
        {
            this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.EngageRanged"] = 1.0;
        }
        this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.EngageRanged"] = 0.0;
        return;
    }
}
