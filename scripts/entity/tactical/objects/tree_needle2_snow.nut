// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/tree_needle2_snow.nut
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
    this.addSprite("bottom").setBrush("tree_needle_03_snow_bottom");
    this.addSprite("bottom").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("bottom").Scale = (0.6000000238418579 + (this.Math.rand(0, 40) / 100.0));
    this.addSprite("bottom").Rotation = this.Math.rand(-6, 6);
    this.addSprite("top").setBrush("tree_needle_03_snow_top");
    this.addSprite("top").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("top").Scale = (((0.6000000238418579 + (this.Math.rand(0, 40) / 100.0)) * 0.8999999761581421) + (this.Math.rand(0, 10) / 100.0));
    this.addSprite("top").Rotation = (this.Math.rand(-3, 3) + this.Math.rand(-6, 6));
    this.setSpriteOcclusion("top", 3, 2, -3);
    this.setBlockSight(true);
    return;
}
