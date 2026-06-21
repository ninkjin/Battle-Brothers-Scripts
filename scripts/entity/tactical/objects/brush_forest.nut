// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/brush_forest.nut
// Functions: 3

function getDescription(this)
{
    return this.Const.Strings.Tactical.EntityDescription.Brush;
}

function getName(this)
{
    return this.Const.Strings.Tactical.EntityName.Brush;
}

function onInit(this)
{
    this.addSprite("body").setBrush(("brush_0" + this.Math.rand(2, 2)));
    this.addSprite("body").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("body").setBrightness(0.800000011920929);
    this.addSprite("body").varyColor(0.07000000029802322, 0.07000000029802322, 0.07000000029802322);
    this.addSprite("body").Scale = (0.8999999761581421 + (this.Math.rand(0, 10) / 100.0));
    this.addSprite("web").setBrush("web_03");
    this.addSprite("web").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("web").Scale = (this.addSprite("body").Scale * 0.8999999761581421);
    this.addSprite("web").Visible = false;
    this.setBlockSight(true);
    return;
}
