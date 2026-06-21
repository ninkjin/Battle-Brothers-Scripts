// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/tiles/tile_desert.nut
// Functions: 3

function init(this)
{
    this.m.Name = "world.tile.desert";
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
    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Desert;
    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Desert;
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
        this.World.getTileSquare(_rect.X, _rect.Y).setBrush("world_desert_04");
    }
    this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_desert_0" + this.Math.rand(1, 3)));
    return;
}

function onSecondPass(this, _rect)
{
    [].resize(4, 0);
    if (0 != 6)
    {
        if (!this.World.getTileSquare(_rect.X, _rect.Y).hasNextTile(0))
        {
        }
        else
        {
            if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Plains)
            {
            }
            else
            {
                if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Steppe)
                {
                }
                else
                {
                    if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Oasis)
                    {
                    }
                    else
                    {
                        if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.LeaveForest)
                        {
                        }
                        else
                        {
                            if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.AutumnForest)
                            {
                            }
                            else
                            {
                                if ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion != 99) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion != 99))
                                {
                                    return ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion != 99) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion != 99));
                                }
                                else
                                {
                                    if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == 99)
                                    {
                                    }
                                    else
                                    {
                                        if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Shore)
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
    if ((0 + 4) > 0)
    {
        if (this.Math.rand(1, 100) <= 33)
        {
            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_grass_0" + this.Math.rand(1, 6)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.NotCompatibleWithRoad);
        }
    }
    else
    {
        if ((0 + 9) != 0)
        {
            if (this.Math.rand(1, 100) <= (50 + ((0 + 9) * 2)))
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
            if ((0 + 10) != 0)
            {
                if (this.Math.rand(1, 100) <= 33)
                {
                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_oasis_transition_0" + this.Math.rand(1, 6)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.NotCompatibleWithRoad);
                    if (this.Math.rand(1, 100) <= 50)
                    {
                        if (this.Math.rand(9, 13) < 10)
                        {
                        }
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_desert_oasis_" + ("0" + this.Math.rand(9, 13))), this.Const.World.ZLevel.Object, 0);
                    }
                }
                else
                {
                    if (this.Math.rand(1, 100) <= 20)
                    {
                        if (this.Math.rand(9, 12) < 10)
                        {
                        }
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_desert_oasis_" + ("0" + this.Math.rand(9, 12))), this.Const.World.ZLevel.Object, 0);
                    }
                }
            }
            else
            {
                if ((0 + 3) > 0)
                {
                    if (this.Math.rand(1, 100) <= 33)
                    {
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_leaves_light_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                    }
                }
                else
                {
                    if ((0 + 6) > 0)
                    {
                        if (this.Math.rand(1, 100) <= 33)
                        {
                            if (this.Math.rand(1, 10) < 10)
                            {
                            }
                        }
                    }
                    else
                    {
                        if ((this.World.getTileSquare(_rect.X, _rect.Y).Subregion != 99) && (this.World.getTileSquare(_rect.X, _rect.Y).Subregion != 99))
                        {
                            return ((this.World.getTileSquare(_rect.X, _rect.Y).Subregion != 99) && (this.World.getTileSquare(_rect.X, _rect.Y).Subregion != 99));
                            if (this.Math.rand(1, 100) <= 50)
                            {
                                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_plains_stony_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                            }
                        }
                        else
                        {
                            if ((!this.World.getTileSquare(_rect.X, _rect.Y).HasRoad) && (!this.World.getTileSquare(_rect.X, _rect.Y).HasRoad))
                            {
                                return ((!this.World.getTileSquare(_rect.X, _rect.Y).HasRoad) && (!this.World.getTileSquare(_rect.X, _rect.Y).HasRoad));
                                this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.DesertHills;
                                if ((0 + 7) <= 2)
                                {
                                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_desert_hill_0" + this.Math.rand(1, 2)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
                                }
                                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_desert_hill_0" + this.Math.rand(2, 5)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
                                this.World.getTileSquare(_rect.X, _rect.Y).Subregion = 99;
                                this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Hills;
                            }
                            else
                            {
                                if ((0 + 7) >= 2)
                                {
                                    if (!this.World.getTileSquare(_rect.X, _rect.Y).HasRoad)
                                    {
                                        if (this.Math.rand(1, 100) <= 40)
                                        {
                                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_desert_rocks_0" + this.Math.rand(1, 6)), this.Const.World.ZLevel.Object, this.Const.World.DetailType.NotCompatibleWithRoad);
                                        }
                                    }
                                }
                                else
                                {
                                    if (this.Math.rand(1, 100) <= 5)
                                    {
                                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsCommon["this.Math.rand(0, (this.m.DetailsCommon.len() - 1))"], this.Const.World.ZLevel.Object, this.Const.World.DetailType.NotCompatibleWithRoad);
                                    }
                                    else
                                    {
                                        if (this.Math.rand(1, 1000) <= 7)
                                        {
                                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsRuins["this.Math.rand(0, (this.m.DetailsRuins.len() - 1))"], this.Const.World.ZLevel.Object, this.Const.World.DetailType.NotCompatibleWithRoad);
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
    return;
}
