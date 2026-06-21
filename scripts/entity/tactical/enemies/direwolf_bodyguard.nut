// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/direwolf_bodyguard.nut
// Functions: 1

function create(this)
{
    this.direwolf_high.create();
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/direwolf_bodyguard_agent");
    this.m.AIAgent.setActor(this);
    return;
}
