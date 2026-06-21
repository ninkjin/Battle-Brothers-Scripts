// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/tiles/tile_oasis.nut
// Functions: 3

function init(this)
{
    this.m.Name = "world.tile.oasis";
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
    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Oasis;
    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Oasis;
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
        this.World.getTileSquare(_rect.X, _rect.Y).setBrush("world_desert_10");
    }
    this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_desert_0" + this.Math.rand(6, 9)));
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
                            if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Plains)
                            {
                            }
                            else
                            {
                                if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Swamp)
                                {
                                }
                                else
                                {
                                    if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Urban)
                                    {
                                    }
                                    else
                                    {
                                        if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Tundra)
                                        {
                                        }
                                        else
                                        {
                                            if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Steppe)
                                            {
                                            }
                                            else
                                            {
                                                if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Desert)
                                                {
                                                }
                                                else
                                                {
                                                    if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Plains)
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
    }
    if (((0 + 14) + 14) > 0)
    {
        if (this.Math.rand(1, 100) <= 33)
        {
            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_grass_0" + this.Math.rand(1, 6)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.NotCompatibleWithRoad);
        }
    }
    else
    {
        if (((0 + 3) > (0 + 5) && ((0 + 3) > (0 + 5))))
        {
            return (((0 + 3) > (0 + 5)) && ((0 + 3) > (0 + 5)));
            if (this.Math.rand(1, 100) <= 50)
            {
                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_light_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
            }
        }
        else
        {
            if (((0 + 4) > (0 + 5) && ((0 + 4) > (0 + 5))))
            {
                return (((0 + 4) > (0 + 5)) && ((0 + 4) > (0 + 5)));
                if (this.Math.rand(1, 100) <= 50)
                {
                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_leaves_light_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                }
            }
            else
            {
                if (((0 + 5) > (0 + 4) && ((0 + 5) > (0 + 4))))
                {
                    return (((0 + 5) > (0 + 4)) && ((0 + 5) > (0 + 4)));
                    if (this.Math.rand(1, 100) <= (50 + ((0 + 5) * 10)))
                    {
                        if (this.Math.rand(1, 10) < 10)
                        {
                        }
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_autumn_light_" + this.Math.rand(1, 10)), this.Const.World.ZLevel.Object, 0);
                    }
                }
                else
                {
                    if ((0 + 9) != 0)
                    {
                        if (this.Math.rand(1, 100) <= (50 + ((0 + 9) * 4)))
                        {
                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_swamp_light_0" + this.Math.rand(0, 9)), this.Const.World.ZLevel.Object, this.Const.World.DetailType.Swamp);
                        }
                    }
                    else
                    {
                        if ((0 + 12) != 0)
                        {
                            if (this.Math.rand(1, 100) <= (50 + ((0 + 12) * 2)))
                            {
                                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_transition_0" + this.Math.rand(1, 4)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.NotCompatibleWithRoad).setBrightness(0.949999988079071);
                            }
                            else
                            {
                                if (this.Math.rand(1, 100) <= 10)
                                {
                                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_brush_0" + this.Math.rand(1, 6)), this.Const.World.ZLevel.Object, 0).Saturation = 0.800000011920929;
                                }
                            }
                        }
                        else
                        {
                            if (!this.World.getTileSquare(_rect.X, _rect.Y).HasRoad)
                            {
                                if (this.Math.rand(1, 8) < 10)
                                {
                                }
                                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_desert_oasis_" + ("0" + this.Math.rand(1, 8))), this.Const.World.ZLevel.Object, this.Const.World.DetailType.NotCompatibleWithRoad);
                            }
                            if (this.Math.rand(9, 13) < 10)
                            {
                            }
                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_desert_oasis_" + ("0" + this.Math.rand(9, 13))), this.Const.World.ZLevel.Object, this.Const.World.DetailType.NotCompatibleWithRoad);
                        }
                    }
                }
            }
        }
    }
    return;
}
