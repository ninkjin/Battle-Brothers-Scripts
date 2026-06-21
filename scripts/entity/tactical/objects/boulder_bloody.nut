// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/boulder_bloody.nut
// Functions: 4

function getDescription(this)
{
    return this.Const.Strings.Tactical.EntityDescription.Boulder;
}

function getName(this)
{
    return this.Const.Strings.Tactical.EntityName.Boulder;
}

function onFinish(this)
{
    return;
}

function onInit(this)
{
    this.addSprite("body").setBrush("boulder_01");
    this.addSprite("body").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("body").varyColor(0.029999999329447746, 0.029999999329447746, 0.029999999329447746);
    this.addSprite("blood").setBrush("boulder_01_blood");
    this.addSprite("blood").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.setSpriteOcclusion("body", 1, -2, -2);
    this.setBlockSight(true);
    return;
}
