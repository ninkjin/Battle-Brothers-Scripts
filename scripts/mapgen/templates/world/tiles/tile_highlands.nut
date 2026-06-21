// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/tiles/tile_highlands.nut
// Functions: 3

function init(this)
{
    this.m.Name = "world.tile.highlands";
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
    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Tundra;
    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Highlands;
    if (this.Math.rand(1, 100) <= 40)
    {
        this.World.getTileSquare(_rect.X, _rect.Y).setBrush("world_highlands_01");
    }
    if (this.Math.rand(1, 100) <= 80)
    {
        this.World.getTileSquare(_rect.X, _rect.Y).setBrush("world_highlands_02");
    }
    this.World.getTileSquare(_rect.X, _rect.Y).setBrush("world_highlands_03");
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
            if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Mountains)
            {
            }
            else
            {
                if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Hills)
                {
                }
                else
                {
                    if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Forest)
                    {
                    }
                    else
                    {
                        if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.LeaveForest)
                        {
                        }
                        else
                        {
                            if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Swamp)
                            {
                            }
                            else
                            {
                                if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Plains)
                                {
                                }
                                else
                                {
                                    if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Hills)
                                    {
                                    }
                                    else
                                    {
                                        if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Snow)
                                        {
                                        }
                                        else
                                        {
                                            if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Ocean)
                                            {
                                            }
                                            else
                                            {
                                                if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Shore)
                                                {
                                                }
                                                else
                                                {
                                                    if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.AutumnForest)
                                                    {
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if ((((0 + 11) + 11) >= 2) && (((0 + 11) + 11) >= 2) && (((0 + 11) + 11) >= 2))
    {
        return ((((0 + 11) + 11) >= 2) && (((0 + 11) + 11) >= 2) && (((0 + 11) + 11) >= 2));
        this.World.getTileSquare(_rect.X, _rect.Y).setBrush("world_highlands_03");
    }
    if (((0 + 5) > (0 + 6) && ((0 + 5) > (0 + 6))))
    {
        return (((0 + 5) > (0 + 6)) && ((0 + 5) > (0 + 6)));
        if (this.Math.rand(1, 100) <= 50)
        {
            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_light_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
        }
    }
    else
    {
        if (((0 + 6) > (0 + 5) && ((0 + 6) > (0 + 5))))
        {
            return (((0 + 6) > (0 + 5)) && ((0 + 6) > (0 + 5)));
            if (this.Math.rand(1, 100) <= 50)
            {
                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_leaves_light_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
            }
        }
        else
        {
            if (((0 + 7) > (0 + 6) && ((0 + 7) > (0 + 6))))
            {
                return (((0 + 7) > (0 + 6)) && ((0 + 7) > (0 + 6)));
                if (this.Math.rand(1, 100) <= (50 + ((0 + 7) * 10)))
                {
                    if (this.Math.rand(1, 10) < 10)
                    {
                    }
                }
            }
            else
            {
                if ((((0 + 11) + 11) >= 2) && (((0 + 11) + 11) >= 2))
                {
                    return ((((0 + 11) + 11) >= 2) && (((0 + 11) + 11) >= 2));
                    if (this.Math.rand(1, 100) <= 50)
                    {
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_plains_stony_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                    }
                }
                else
                {
                    if ((0 + 8) != 0)
                    {
                        if (this.Math.rand(1, 100) <= (50 + ((0 + 8) * 4)))
                        {
                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_swamp_light_0" + this.Math.rand(0, 9)), this.Const.World.ZLevel.Object, this.Const.World.DetailType.Swamp);
                        }
                    }
                    else
                    {
                        if (this.Math.rand(1, 100) <= 10)
                        {
                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_light_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                        }
                        else
                        {
                            if ((this.Math.rand(1, 100) <= 10) && (this.Math.rand(1, 100) <= 10))
                            {
                                return ((this.Math.rand(1, 100) <= 10) && (this.Math.rand(1, 100) <= 10));
                                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsTerrain["this.Math.rand(0, (this.m.DetailsTerrain.len() - 1))"], this.Const.World.ZLevel.Terrain, 0);
                            }
                            else
                            {
                                if (this.Math.rand(1, 100) <= 66)
                                {
                                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsObject["this.Math.rand(0, (this.m.DetailsObject.len() - 1))"], this.Const.World.ZLevel.Object, 0);
                                }
                                else
                                {
                                    if ((this.Math <= 2) && (this.Math <= 2))
                                    {
                                        return ((this.Math <= 2) && (this.Math <= 2));
                                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsSpecial["this.Math.rand(0, (this.m.DetailsSpecial.len() - 1))"], this.Const.World.ZLevel.Object, this.Const.World.DetailType.Swamp);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if ((this.Math.rand(1, 100) <= 33) && (this.Math.rand(1, 100) <= 33) && (this.Math.rand(1, 100) <= 33))
    {
        return ((this.Math.rand(1, 100) <= 33) && (this.Math.rand(1, 100) <= 33) && (this.Math.rand(1, 100) <= 33));
        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail("world_snow_cover_01", (this.Const.World.ZLevel.Terrain + 200), 0);
    }
    return;
}
