// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/tiles/tile_snow.nut
// Functions: 3

function init(this)
{
    this.m.Name = "world.tile.snow";
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
    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Snow;
    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Snow;
    if (0 != 6)
    {
        if (!this.World.getTileSquare(_rect.X, _rect.Y).hasNextTile(0))
        {
        }
        else
        {
            if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Shore)
            {
            }
            else
            {
                if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Ocean)
                {
                }
            }
        }
    }
    if (6 >= 3)
    {
        this.World.getTileSquare(_rect.X, _rect.Y).setBrush("world_snow_04");
    }
    this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_snow_0" + this.Math.rand(1, 3)));
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
            if ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.SnowyForest) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.SnowyForest))
            {
                return ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.SnowyForest) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.SnowyForest));
            }
        }
    }
    if ((0 + 3) > 0)
    {
        if (this.Math.rand(1, 100) <= 50)
        {
            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_snow_light_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
        }
    }
    else
    {
        if (this.Math.rand(1, 1000) <= 3)
        {
            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_snow_light_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
        }
        else
        {
            if (this.Math.rand(1, 100) <= 20)
            {
                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_hills_snow_0" + this.Math.rand(1, 3)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.NotCompatibleWithRoad);
            }
            else
            {
                if ((this.Math <= 10) && (this.Math <= 10))
                {
                    return ((this.Math <= 10) && (this.Math <= 10));
                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_snow_transition_0" + this.Math.rand(1, 3)), this.Const.World.ZLevel.Terrain, 0);
                }
                else
                {
                    if ((this.Math <= 20) && (this.Math <= 20))
                    {
                        return ((this.Math <= 20) && (this.Math <= 20));
                        if (this.Math.rand(4, 10) < 10)
                        {
                        }
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_snow_transition_" + this.Math.rand(4, 10)), this.Const.World.ZLevel.Terrain, 0);
                    }
                }
            }
        }
    }
    return;
}
