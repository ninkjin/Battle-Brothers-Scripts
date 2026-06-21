// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/tree_desert_large.nut
// Functions: 3

function getDescription(this)
{
    return this.Const.Strings.Tactical.EntityDescription.Tree;
}

function getName(this)
{
    return this.Const.Strings.Tactical.EntityName.Tree;
}

function onInit(this)
{
    this.addSprite("bottom").setBrush("tree_desert_01_bottom");
    this.addSprite("bottom").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("bottom").varyColor(0.029999999329447746, 0.029999999329447746, 0.029999999329447746);
    this.addSprite("bottom").Rotation = this.Math.rand(-5, 5);
    this.addSprite("middle").setBrush("tree_desert_01_middle");
    this.addSprite("middle").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("middle").Color = this.addSprite("bottom").Color;
    this.addSprite("middle").Rotation = this.Math.rand(-5, 5);
    this.addSprite("top").setBrush("tree_desert_01_top");
    this.addSprite("top").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("top").varyColor(0.125, 0.125, 0.125);
    this.addSprite("top").Rotation = (this.Math.rand(-5, 5) + this.Math.rand(-5, 5));
    this.addSprite("top").Scale = (0.800000011920929 + (this.Math.rand(0, 20) / 100.0));
    this.addSprite("web").setBrush("web_01");
    this.addSprite("web").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("web").Scale = (this.addSprite("bottom").Scale * 0.75);
    this.addSprite("web").Visible = false;
    this.setSpriteOcclusion("middle", 2, 3, -3);
    this.setSpriteOcclusion("top", 2, 3, -3);
    this.setBlockSight(true);
    return;
}
