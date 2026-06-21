// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/tree_trunk.nut
// Functions: 3

function getDescription(this)
{
    return this.Const.Strings.Tactical.EntityDescription.TreeTrunk;
}

function getName(this)
{
    return this.Const.Strings.Tactical.EntityName.Tree;
}

function onInit(this)
{
    this.addSprite("body").setBrush("swamp_treetrunk_01");
    this.addSprite("body").setHorizontalFlipping((this.Math.rand(0, 100) < 50));
    this.addSprite("body").varyColor(0.07000000029802322, 0.07000000029802322, 0.07000000029802322);
    this.addSprite("body").Scale = (0.699999988079071 + (this.Math.rand(0, 30) / 100.0));
    return;
}
