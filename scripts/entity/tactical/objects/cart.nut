// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/cart.nut
// Functions: 7

function getDescription(this)
{
    return this.Const.Strings.Tactical.EntityDescription.Cart;
}

function getName(this)
{
    return this.Const.Strings.Tactical.EntityName.Cart;
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
    this.addSprite("body").setBrush("cart_tactical");
    this.setSpriteOcclusion("body", 1, -2, -2);
    this.setBlockSight(true);
    return;
}

function onSerialize(this, _out)
{
    this.entity.onSerialize(_out);
    return;
}

function setFlipped(this, _f)
{
    this.getSprite("body").setHorizontalFlipping(_f);
    return;
}
