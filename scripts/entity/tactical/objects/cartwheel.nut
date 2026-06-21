// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/cartwheel.nut
// Functions: 6

function getDescription(this)
{
    return this.Const.Strings.Tactical.EntityDescription.Cartwheel;
}

function getName(this)
{
    return this.Const.Strings.Tactical.EntityName.Cartwheel;
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
    this.addSprite("body").setBrush("road_cartwheel");
    this.addSprite("body").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    return;
}

function onSerialize(this, _out)
{
    this.entity.onSerialize(_out);
    return;
}
