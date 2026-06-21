// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/boulder.nut
// Functions: 6

function getDescription(this)
{
    return this.Const.Strings.Tactical.EntityDescription.Boulder;
}

function getName(this)
{
    return this.Const.Strings.Tactical.EntityName.Boulder;
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
    this.addSprite("body").setBrush("boulder_01");
    this.addSprite("body").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("body").varyColor(0.029999999329447746, 0.029999999329447746, 0.029999999329447746);
    this.addSprite("body").Scale = (0.6499999761581421 + (this.Math.rand(0, 35) / 100.0));
    this.setSpriteOcclusion("body", 1, -2, -2);
    this.setBlockSight(true);
    return;
}

function onSerialize(this, _out)
{
    this.entity.onSerialize(_out);
    return;
}
