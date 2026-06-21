// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/tree_forest.nut
// Functions: 6

function getDescription(this)
{
    return this.Const.Strings.Tactical.EntityDescription.Tree;
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
    this.addSprite("bottom").setBrush("tree_05_bottom");
    this.addSprite("bottom").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("bottom").varyColor(0.03999999910593033, 0.03999999910593033, 0.03999999910593033);
    this.addSprite("bottom").Scale = (0.75 + (this.Math.rand(0, 25) / 100.0));
    this.addSprite("top").setBrush("tree_05_top");
    this.addSprite("top").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("top").varyColor(0.15000000596046448, 0.15000000596046448, 0.15000000596046448);
    this.addSprite("top").varySaturation(0.10000000149011612);
    this.addSprite("top").Scale = (((0.75 + (this.Math.rand(0, 25) / 100.0)) * 0.8999999761581421) + (this.Math.rand(0, 10) / 100.0));
    this.addSprite("top").Rotation = this.Math.rand(-3, 3);
    this.setSpriteOcclusion("bottom", 1, -1, -2);
    this.setSpriteOcclusion("top", 3, 2, -3);
    this.setBlockSight(true);
    return;
}

function onSerialize(this, _out)
{
    this.entity.onSerialize(_out);
    return;
}
