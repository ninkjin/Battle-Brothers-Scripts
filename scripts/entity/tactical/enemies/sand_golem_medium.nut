// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/sand_golem_medium.nut
// Functions: 2

function create(this)
{
    this.sand_golem.create();
    return;
}

function onInit(this)
{
    this.sand_golem.onInit();
    this.grow(true);
    return;
}
