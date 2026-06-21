// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/desert_boulder3.nut
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
    this.addSprite("bottom").setBrush("desert_stone_01_bottom");
    this.addSprite("bottom").setHorizontalFlipping((this.Math.rand(0, 1) == 1));
    this.addSprite("bottom").varyColor(0.029999999329447746, 0.029999999329447746, 0.029999999329447746);
    this.addSprite("bottom").Scale = (0.800000011920929 + (this.Math.rand(0, 20) / 100.0));
    this.addSprite("top").setBrush("desert_stone_01_top");
    this.addSprite("top").setHorizontalFlipping((this.Math.rand(0, 1) == 1));
    this.addSprite("top").Color = this.addSprite("bottom").Color;
    this.addSprite("top").Scale = this.addSprite("bottom").Scale;
    this.setSpriteOcclusion("top", 1, 2, -3);
    this.setBlockSight(true);
    return;
}
