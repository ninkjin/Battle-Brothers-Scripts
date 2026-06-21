// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/lesser_flesh_golem_unarmed_bodyguard.nut
// Functions: 1

function create(this)
{
    this.lesser_flesh_golem_unarmed.create();
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/lesser_flesh_golem_bodyguard_agent");
    this.m.AIAgent.setActor(this);
    return;
}
