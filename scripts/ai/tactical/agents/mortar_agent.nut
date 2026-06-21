// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/mortar_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.Idle;
    this.m.Properties.OverallDefensivenessMult = 2.0;
    this.m.Properties.OverallMagnetismMult = 4.0;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_mortar"));
    return;
}

function onUpdate(this)
{
    return;
}
