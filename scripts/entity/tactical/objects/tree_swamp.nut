// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/tree_swamp.nut
// Functions: 6

function getDescription(this)
{
    return this.Const.Strings.Tactical.EntityDescription.TreeSwamp;
}

function getName(this)
{
    return this.Const.Strings.Tactical.EntityName.Tree;
}

function onDeserialize(this, _in)
{
    this.entity.onDeserialize(_in);
    return;
}

function onFinish(this)
{
    return;
}

function onInit(this)
{
    this.addSprite("body").setBrush("swamp_tree_01");
    this.addSprite("body").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("body").varyColor(0.07000000029802322, 0.07000000029802322, 0.07000000029802322);
    this.addSprite("body").Rotation = this.Math.rand(-10, 10);
    if (this.Math.rand(0, 100) < 50)
    {
        this.addSprite("body").Scale = (0.8999999761581421 + (this.Math.rand(0, 10) / 100.0));
    }
    return;
}

function onSerialize(this, _out)
{
    this.entity.onSerialize(_out);
    return;
}
