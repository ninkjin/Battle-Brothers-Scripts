// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/tiles/tile_steppe.nut
// Functions: 3

function init(this)
{
    this.m.Name = "world.tile.steppe";
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
    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Steppe;
    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Steppe;
    this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_steppe_0" + this.Math.rand(1, 3)));
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
    if ((0 + 4) > 0)
    {
        if (this.Math.rand(1, 100) <= 33)
        {
            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_grass_0" + this.Math.rand(1, 6)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.NotCompatibleWithRoad);
        }
    }
    else
    {
        if ((0 + 5) > 0)
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
            if ((0 + 3) > 0)
            {
                if (this.Math.rand(1, 100) <= 33)
                {
                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_leaves_light_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                }
            }
            else
            {
                if ((0 + 7) > 0)
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
                            this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.SteppeHills;
                            if ((0 + 8) <= 2)
                            {
                                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_hill_0" + this.Math.rand(1, 2)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
                            }
                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_hill_0" + this.Math.rand(2, 4)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
                            this.World.getTileSquare(_rect.X, _rect.Y).Subregion = 99;
                            this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Hills;
                            if (this.Math.rand(1, 100) <= 25)
                            {
                                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_dry_0" + this.Math.rand(1, 7)), this.Const.World.ZLevel.Object, this.Const.World.DetailType.NotCompatibleWithRoad);
                            }
                        }
                        else
                        {
                            if ((0 + 8) >= 2)
                            {
                                if (this.World.getTileSquare(_rect.X, _rect.Y).HasRoad)
                                {
                                    if (this.Math.rand(1, 100) <= 50)
                                    {
                                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_steppe_stony_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                                    }
                                }
                                else
                                {
                                    if ((this.Math <= 50) && (this.Math <= 50))
                                    {
                                        return ((this.Math <= 50) && (this.Math <= 50));
                                        if (this.Math.rand(1, 100) <= 50)
                                        {
                                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_detail_0" + this.Math.rand(1, 7)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.NotCompatibleWithRoad);
                                        }
                                        else
                                        {
                                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_detail_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Terrain, 0);
                                            if (this.Math.rand(1, 100) <= 25)
                                            {
                                                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_steppe_stony_0" + this.Math.rand(1, 8)), this.Const.World.ZLevel.Object, 0);
                                            }
                                        }
                                    }
                                    else
                                    {
                                        if (this.Math.rand(1, 100) <= 50)
                                        {
                                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_steppe_stony_0" + this.Math.rand(1, 8)), this.Const.World.ZLevel.Object, 0);
                                        }
                                    }
                                }
                            }
                            else
                            {
                                if ((this.Math <= 15) && (this.Math <= 15))
                                {
                                    return ((this.Math <= 15) && (this.Math <= 15));
                                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_grass_0" + this.Math.rand(1, 3)), this.Const.World.ZLevel.Object, this.Const.World.DetailType.NotCompatibleWithRoad);
                                }
                                else
                                {
                                    if (this.Math.rand(1, 100) <= 12)
                                    {
                                        if (this.Math.rand(1, 11) < 10)
                                        {
                                        }
                                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_brush_" + this.Math.rand(1, 11)), this.Const.World.ZLevel.Object, 0).Saturation = 0.800000011920929;
                                    }
                                    else
                                    {
                                        if (this.Math.rand(1, 100) <= 15)
                                        {
                                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_steppe_flowers_0" + this.Math.rand(1, 6)), this.Const.World.ZLevel.Object, this.Const.World.DetailType.NotCompatibleWithRoad);
                                        }
                                        else
                                        {
                                            if (this.Math.rand(1, 100) <= 5)
                                            {
                                                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_tree_0" + this.Math.rand(1, 4)), this.Const.World.ZLevel.Object, 0);
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
