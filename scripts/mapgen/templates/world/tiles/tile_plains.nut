// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/tiles/tile_plains.nut
// Functions: 3

function init(this)
{
    this.m.Name = "world.tile.plains";
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
    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Plains;
    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Plains;
    this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_grassland_0" + this.Math.rand(1, 4)));
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
                                                    if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Oasis)
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
                if (((0 + 7) >= 2) && ((0 + 7) >= 2))
                {
                    return (((0 + 7) >= 2) && ((0 + 7) >= 2));
                    if (this.Math.rand(1, 100) <= 50)
                    {
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_plains_stony_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
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
                        if ((0 + 14) != 0)
                        {
                            if (this.Math.rand(1, 100) <= 33)
                            {
                                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_oasis_transition_0" + this.Math.rand(1, 6)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.NotCompatibleWithRoad);
                            }
                            if (this.Math.rand(1, 100) <= 25)
                            {
                                if (this.Math.rand(9, 13) < 10)
                                {
                                }
                                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_desert_oasis_" + ("0" + this.Math.rand(9, 13))), this.Const.World.ZLevel.Object, 0);
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
                                if ((this.Math <= 25) && (this.Math <= 25))
                                {
                                    return ((this.Math <= 25) && (this.Math <= 25));
                                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsUrban["this.Math.rand(0, (this.m.DetailsUrban.len() - 1))"], this.Const.World.ZLevel.Object, 0);
                                }
                                else
                                {
                                    if (this.Math.rand(1, 1000) <= 25)
                                    {
                                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsTerrain["this.Math.rand(0, (this.m.DetailsTerrain.len() - 1))"], this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.NotCompatibleWithRoad);
                                    }
                                    else
                                    {
                                        if (this.Math.rand(1, 1000) <= 100)
                                        {
                                            if (this.Math.rand(0, 1) == 1)
                                            {
                                                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsObject["this.Math.rand(0, (this.m.DetailsObject.len() - 1))"], this.Const.World.ZLevel.Object, 0);
                                            }
                                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsGrass["this.Math.rand(0, (this.m.DetailsGrass.len() - 1))"], this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.NotCompatibleWithRoad);
                                        }
                                        else
                                        {
                                            if (this.Math.rand(1, 1000) <= 50)
                                            {
                                                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsMore["this.Math.rand(0, (this.m.DetailsMore.len() - 1))"], this.Const.World.ZLevel.Object, 0);
                                            }
                                            else
                                            {
                                                if (this.Math.rand(1, 1000) <= 10)
                                                {
                                                    if (_rect.Y < (this.Const.World.Settings.SizeY * 0.5))
                                                    {
                                                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_leaves_light_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                                                    }
                                                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_light_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
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
    return;
}
