// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/lesser_flesh_golem_unarmed.nut
// Functions: 2

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new("scripts/items/helmets/golems/flesh_golem_facewrap"));
    this.m.Items.equip(this.new("scripts/items/armor/golems/flesh_golem_robes"));
    return;
}

function onInit(this)
{
    this.lesser_flesh_golem.onInit();
    this.m.Skills.add(this.new("scripts/skills/actives/golem_grapple_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/lesser_flesh_golem_attack_skill"));
    return;
}
