// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/desert_plant.nut
// Functions: 3

function getDescription(this)
{
    return this.Const.Strings.Tactical.EntityDescription.Plant;
}

function getName(this)
{
    return this.Const.Strings.Tactical.EntityName.Plant;
}

function onInit(this)
{
    this.addSprite("body").setBrush(("desert_plant_0" + this.Math.rand(1, 5)));
    this.addSprite("body").setHorizontalFlipping((this.Math.rand(0, 1) == 1));
    this.addSprite("body").varyColor(0.029999999329447746, 0.029999999329447746, 0.029999999329447746);
    this.addSprite("body").Scale = (0.800000011920929 + (this.Math.rand(0, 20) / 100.0));
    this.setBlockSight(true);
    return;
}
