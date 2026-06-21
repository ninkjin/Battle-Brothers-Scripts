// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/desert_cactus2.nut
// Functions: 3

function getDescription(this)
{
    return this.Const.Strings.Tactical.EntityDescription.Plant;
}

function getName(this)
{
    return this.Const.Strings.Tactical.EntityName.Plant;
}

function onInit(this)
{
    this.addSprite("body").setBrush(("desert_cactus_0" + this.Math.rand(2, 3)));
    this.addSprite("body").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("body").varyColor(0.029999999329447746, 0.029999999329447746, 0.029999999329447746);
    return;
}
