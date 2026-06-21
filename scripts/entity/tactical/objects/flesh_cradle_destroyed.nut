// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/flesh_cradle_destroyed.nut
// Functions: 4

function getDescription(this)
{
    return "A destroyed stone receptacle. The guts and gore once housed within have slopped onto the surrounding ground.";
}

function getName(this)
{
    return "Destroyed Flesh Cradle";
}

function isDying(this)
{
    return true;
}

function onInit(this)
{
    this.addSprite("body").setBrush("flesh_cradle_01_destroyed");
    this.setBlockSight(false);
    return;
}
