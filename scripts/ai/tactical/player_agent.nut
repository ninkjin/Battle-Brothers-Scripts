// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/player_agent.nut
// Functions: 1

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.Player;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Retreat"] = 0.0;
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    return;
}
