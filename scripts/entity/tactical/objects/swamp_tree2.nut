// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/swamp_tree2.nut
// Functions: 3

function getDescription(this)
{
    return this.Const.Strings.Tactical.EntityDescription.TreeSwamp;
}

function getName(this)
{
    return this.Const.Strings.Tactical.EntityName.Tree;
}

function onInit(this)
{
    this.addSprite("bottom").setBrush((("swamp_tree_" + []["this.Math.rand(0, ([].len() - 1))"]) + "_bottom"));
    this.addSprite("bottom").setHorizontalFlipping((this.Math.rand(0, 1) == 1));
    this.addSprite("bottom").varyColor(0.07000000029802322, 0.07000000029802322, 0.07000000029802322);
    this.addSprite("bottom").Scale = (0.800000011920929 + (this.Math.rand(0, 20) / 100.0));
    this.addSprite("bottom").Rotation = this.Math.rand(-5, 5);
    this.addSprite("top").setBrush((("swamp_tree_" + []["this.Math.rand(0, ([].len() - 1))"]) + "_top"));
    this.addSprite("top").setHorizontalFlipping((this.Math.rand(0, 1) == 1));
    this.addSprite("top").Color = this.addSprite("bottom").Color;
    this.addSprite("top").Scale = (0.800000011920929 + (this.Math.rand(0, 20) / 100.0));
    this.addSprite("top").Rotation = this.addSprite("bottom").Rotation;
    this.addSprite("web").setBrush("web_03");
    this.addSprite("web").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("web").Scale = (this.addSprite("bottom").Scale * 0.8999999761581421);
    this.addSprite("web").Visible = false;
    if (([]["this.Math.rand(0, ([].len() - 1)"] == []) && ([]["this.Math.rand(0, ([].len() - 1))"] == [])))
    {
        return (([]["this.Math.rand(0, ([].len() - 1))"] == []) && ([]["this.Math.rand(0, ([].len() - 1))"] == []));
        this.setSpriteOcclusion("top", 2, 2, -3);
    }
    this.setSpriteOcclusion("top", 1, 1, -3);
    this.setBlockSight(true);
    return;
}
