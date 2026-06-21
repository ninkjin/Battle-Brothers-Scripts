// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/spider_bodyguard.nut
// Functions: 1

function create(this)
{
    this.spider.create();
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/spider_bodyguard_agent");
    this.m.AIAgent.setActor(this);
    return;
}
