// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/swamp_tree1.nut
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
    this.addSprite("body").setBrush(("swamp_tree_" + []["this.Math.rand(0, ([].len() - 1))"]));
    this.addSprite("body").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("body").varyColor(0.07000000029802322, 0.07000000029802322, 0.07000000029802322);
    this.addSprite("body").Rotation = this.Math.rand(-10, 10);
    if (this.Math.rand(0, 100) < 50)
    {
        this.addSprite("body").Scale = (0.800000011920929 + (this.Math.rand(0, 20) / 100.0));
    }
    this.addSprite("web").setBrush("web_03");
    this.addSprite("web").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("web").Scale = (this.addSprite("body").Scale * 0.800000011920929);
    this.addSprite("web").Visible = false;
    return;
}
