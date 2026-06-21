// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/zombie_knight_bodyguard.nut
// Functions: 2

function create(this)
{
    this.m.IsCreatingAgent = false;
    this.zombie_knight.create();
    this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/zombie_knight_bodyguard";
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/zombie_bodyguard_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.zombie_knight.onInit();
    this.m.BaseProperties.IsSpecializedInShields = true;
    return;
}
