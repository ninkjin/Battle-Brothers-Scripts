// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/tiles/tile_farmland.nut
// Functions: 3

function init(this)
{
    this.m.Name = "world.tile.farmland";
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
    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Farmland;
    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Farmland;
    return;
}

function onSecondPass(this, _rect)
{
    if (0 != 6)
    {
        if (!this.World.getTileSquare(_rect.X, _rect.Y).hasNextTile(0))
        {
        }
        else
        {
            if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Heath)
            {
            }
            else
            {
                if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Tundra)
                {
                }
            }
        }
    }
    if ((0 + 3) >= 3)
    {
        this.World.getTileSquare(_rect.X, _rect.Y).setBrush("world_heath_01");
    }
    if ((0 + 4) >= 3)
    {
        this.World.getTileSquare(_rect.X, _rect.Y).setBrush("world_highlands_01");
    }
    this.World.getTileSquare(_rect.X, _rect.Y).setBrush("world_plains_01");
    if (this.Math.rand(0, 1) == 1)
    {
    }
    if (1 <= this.Math.rand(2, 3))
    {
        if (this.Math.rand(0, 1) == 0)
        {
            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_fields_wheat_0" + 1), this.Const.World.ZLevel.Terrain, 0, false);
        }
        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_fields_cabbage_0" + 1), this.Const.World.ZLevel.Terrain, 0, false);
    }
    return;
}
