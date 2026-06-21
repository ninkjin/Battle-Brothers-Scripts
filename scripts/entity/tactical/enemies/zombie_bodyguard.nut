// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/zombie_bodyguard.nut
// Functions: 1

function create(this)
{
    this.m.IsCreatingAgent = false;
    this.zombie.create();
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/zombie_bodyguard_agent");
    this.m.AIAgent.setActor(this);
    return;
}
