// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/steppe_boulder1.nut
// Functions: 3

function getDescription(this)
{
    return this.Const.Strings.Tactical.EntityDescription.Boulder;
}

function getName(this)
{
    return this.Const.Strings.Tactical.EntityName.Boulder;
}

function onInit(this)
{
    this.addSprite("body").setBrush("steppe_stone_01");
    this.addSprite("body").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("body").varyColor(0.029999999329447746, 0.029999999329447746, 0.029999999329447746);
    this.addSprite("body").Scale = (0.800000011920929 + (this.Math.rand(0, 20) / 100.0));
    this.setBlockSight(true);
    return;
}
