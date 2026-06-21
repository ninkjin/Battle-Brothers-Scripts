// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/ghoul_medium.nut
// Functions: 2

function create(this)
{
    this.ghoul.create();
    return;
}

function onInit(this)
{
    this.ghoul.onInit();
    this.grow(true);
    return;
}
