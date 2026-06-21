// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/zombie_nomad_bodyguard.nut
// Functions: 1

function create(this)
{
    this.m.IsCreatingAgent = false;
    this.zombie_nomad.create();
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/zombie_bodyguard_agent");
    this.m.AIAgent.setActor(this);
    return;
}
