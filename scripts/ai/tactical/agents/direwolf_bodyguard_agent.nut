// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/direwolf_bodyguard_agent.nut
// Functions: 2

function create(this)
{
    this.direwolf_agent.create();
    return;
}

function onAddBehaviors(this)
{
    this.direwolf_agent.onAddBehaviors();
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_protect"));
    return;
}
