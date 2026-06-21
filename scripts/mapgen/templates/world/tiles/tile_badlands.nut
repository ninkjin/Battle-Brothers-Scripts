// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/tiles/tile_badlands.nut
// Functions: 3

function init(this)
{
    this.m.Name = "world.tile.badlands";
    this.m.MinX = 1;
    this.m.MinY = 1;
    return;
}

function onFirstPass(this, _rect)
{
    if (this.World.getTileSquare(_rect.X, _rect.Y).Type != 0)
    {
        return;
    }
    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Badlands;
    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Badlands;
    this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_badlands_0" + this.Math.rand(1, 3)));
    this.World.getTileSquare(_rect.X, _rect.Y).IsFlipped = (this.Math.rand(0, 1) == 1);
    return;
}

function onSecondPass(this, _rect)
{
    if (this.World.getTileSquare(_rect.X, _rect.Y).getSurroundingTilesOfType(this.Const.World.TerrainType.Mountains) != 0)
    {
        if (this.Math.rand(1, 100) <= 50)
        {
            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_plains_stony_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
        }
    }
    else
    {
        if (this.Math.rand(1, 100) <= 13)
        {
            if (this.Math.rand(1, 13) < 10)
            {
            }
            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_badlands_" + this.Math.rand(1, 13)), this.Const.World.ZLevel.Object, 0);
        }
    }
    return;
}
