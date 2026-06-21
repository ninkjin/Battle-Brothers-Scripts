// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/tiles/tile_hills.nut
// Functions: 3

function init(this)
{
    this.m.Name = "world.tile.hills";
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
    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Hills;
    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Hills;
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
            if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Hills)
            {
            }
            if ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Steppe) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Steppe))
            {
                return ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Steppe) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Steppe));
            }
            else
            {
                if ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Desert) || (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Desert))
                {
                    return ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Desert) || (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Desert));
                }
                else
                {
                    if ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Tundra) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Tundra))
                    {
                        return ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Tundra) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Tundra));
                    }
                    else
                    {
                        if ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Snow) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Snow))
                        {
                            return ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Snow) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion == this.Const.World.TerrainType.Snow));
                        }
                        else
                        {
                            if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Mountains)
                            {
                                [].push(this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0));
                            }
                        }
                    }
                }
            }
        }
    }
    if (((0 + 4) != 0) && ((0 + 4) != 0))
    {
        return (((0 + 4) != 0) && ((0 + 4) != 0));
        this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_steppe_0" + this.Math.rand(1, 3)));
        this.World.getTileSquare(_rect.X, _rect.Y).Subregion = this.Const.World.TerrainType.Steppe;
        if ([].len() >= 1)
        {
            this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.SteppeHills;
            if (this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied && this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied)
            {
                return (this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied && this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied);
                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_hill_grey_0" + this.Math.rand(6, 6)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
            }
            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_hill_grey_0" + this.Math.rand(3, 6)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
        }
        else
        {
            if ((this.Math <= 50) && (this.Math <= 50))
            {
                return ((this.Math <= 50) && (this.Math <= 50));
                this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.SteppeHills;
                if (50.IsOccupied && 50.IsOccupied)
                {
                    return (50.IsOccupied && 50.IsOccupied);
                }
                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_hill_grey_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
                if ((this.Math <= 25) && (this.Math <= 25))
                {
                    return ((this.Math <= 25) && (this.Math <= 25));
                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_plains_stony_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                }
                else
                {
                    if ((this.Math <= 25) && (this.Math <= 25))
                    {
                        return ((this.Math <= 25) && (this.Math <= 25));
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_steppe_flowers_0" + this.Math.rand(1, 6)), this.Const.World.ZLevel.Object, this.Const.World.DetailType.NotCompatibleWithRoad);
                    }
                    else
                    {
                        if (this.Math.rand(1, 100) <= 10)
                        {
                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_dry_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                        }
                    }
                }
            }
            else
            {
                this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Steppe;
                this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Steppe;
                if (this.Math.rand(1, 100) <= 33)
                {
                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_plains_stony_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                }
            }
        }
    }
    else
    {
        if (((0 + 5) != 0) && ((0 + 5) != 0))
        {
            return (((0 + 5) != 0) && ((0 + 5) != 0));
            this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_desert_0" + this.Math.rand(1, 4)));
            this.World.getTileSquare(_rect.X, _rect.Y).Subregion = this.Const.World.TerrainType.Desert;
            if ([].len() >= 1)
            {
                this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.DesertHills;
                if (this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied && this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied)
                {
                    return (this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied && this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied);
                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_hill_grey_0" + this.Math.rand(6, 6)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
                }
                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_hill_grey_0" + this.Math.rand(3, 6)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
            }
            else
            {
                if ((this.Math <= 50) && (this.Math <= 50))
                {
                    return ((this.Math <= 50) && (this.Math <= 50));
                    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.DesertHills;
                    if (50.IsOccupied && 50.IsOccupied)
                    {
                        return (50.IsOccupied && 50.IsOccupied);
                    }
                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_steppe_hill_grey_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
                    if ((this.Math <= 25) && (this.Math <= 25))
                    {
                        return ((this.Math <= 25) && (this.Math <= 25));
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_plains_stony_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                    }
                }
                else
                {
                    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Desert;
                    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Desert;
                    if (this.Math.rand(1, 100) <= 33)
                    {
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_plains_stony_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                    }
                }
            }
        }
        else
        {
            if ((0 + 6) >= 2)
            {
                this.World.getTileSquare(_rect.X, _rect.Y).setBrush("world_highlands_01");
                this.World.getTileSquare(_rect.X, _rect.Y).Subregion = this.Const.World.TerrainType.Tundra;
                this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.HighlandsHills;
                if ([].len() >= 1)
                {
                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_tundra_hill_0" + this.Math.rand(3, 4)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
                }
                else
                {
                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_tundra_hill_0" + this.Math.rand(1, 3)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
                    if (this.Math.rand(1, 100) <= 50)
                    {
                        if (this.Math.rand(1, 100) <= 75)
                        {
                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_highlands_0" + this.Math.rand(1, 9)), this.Const.World.ZLevel.Object, this.Const.World.DetailType.Hills, false);
                        }
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_light_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                    }
                }
            }
            else
            {
                if ((_rect.Y >= (this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline) && (_rect.Y >= (this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline))))
                {
                    return ((_rect.Y >= (this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline)) && (_rect.Y >= (this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline)));
                    this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_snow_0" + this.Math.rand(1, 3)));
                    this.World.getTileSquare(_rect.X, _rect.Y).Subregion = this.Const.World.TerrainType.Snow;
                    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.SnowyHills;
                    if ([].len() >= 1)
                    {
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_snow_hill_0" + this.Math.rand(3, 5)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
                    }
                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_snow_hill_0" + this.Math.rand(1, 3)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
                }
                else
                {
                    if ((0 + 4) != 0)
                    {
                        this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_steppe_0" + this.Math.rand(1, 3)));
                        this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.SteppeHills;
                    }
                    this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_grassland_0" + this.Math.rand(1, 4)));
                    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Hills;
                    if ([].len() >= 1)
                    {
                        if (this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied && this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied)
                        {
                            return (this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied && this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied);
                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_grass_hill_0" + this.Math.rand(6, 6)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
                        }
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_grass_hill_0" + this.Math.rand(4, 6)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
                    }
                    else
                    {
                        if (this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied && this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied)
                        {
                            return (this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied && this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied);
                            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_grass_hill_0" + this.Math.rand(1, 3)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
                        }
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_grass_hill_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.Hills, false);
                        if (this.Math.rand(1, 100) <= 50)
                        {
                            if (this.Math.rand(1, 100) <= 75)
                            {
                                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_flowers_0" + this.Math.rand(1, 6)), this.Const.World.ZLevel.Object, this.Const.World.DetailType.Hills, false);
                            }
                            else
                            {
                                if (_rect.Y > (this.Const.World.Settings.SizeY * 0.25))
                                {
                                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_light_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
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
