// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/spider_bodyguard_agent.nut
// Functions: 2

function create(this)
{
    this.spider_agent.create();
    return;
}

function onAddBehaviors(this)
{
    this.spider_agent.onAddBehaviors();
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_protect"));
    return;
}
