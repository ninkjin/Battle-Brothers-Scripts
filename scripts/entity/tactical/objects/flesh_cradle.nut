// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/flesh_cradle.nut
// Functions: 4

function getDescription(this)
{
    return "A stone receptacle housing a variety of gore and viscera.";
}

function getName(this)
{
    return "Flesh Cradle";
}

function isDying(this)
{
    return true;
}

function onInit(this)
{
    this.addSprite("bottom").setBrush("flesh_cradle_01_bottom");
    this.addSprite("top").setBrush("flesh_cradle_01_top");
    this.setBlockSight(false);
    return;
}
