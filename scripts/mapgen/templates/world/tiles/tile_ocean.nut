// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/tiles/tile_ocean.nut
// Functions: 4

function init(this)
{
    this.m.Name = "world.tile.ocean";
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
    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Ocean;
    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Plains;
    this.World.getTileSquare(_rect.X, _rect.Y).resetBrush();
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
            if ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Shore) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Shore))
            {
                return ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Shore) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Shore));
            }
            else
            {
                if ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.Hills) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.Hills))
                {
                    return ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.Hills) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.Hills));
                }
                else
                {
                    if ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.SteppeHills) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.SteppeHills))
                    {
                        return ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.SteppeHills) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.SteppeHills));
                    }
                    else
                    {
                        if ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.DesertHills) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.DesertHills))
                        {
                            return ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.DesertHills) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.DesertHills));
                        }
                        else
                        {
                            if ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.HighlandsHills) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.HighlandsHills))
                            {
                                return ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.HighlandsHills) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.HighlandsHills));
                            }
                            else
                            {
                                if ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.SnowyHills) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.SnowyHills))
                                {
                                    return ((this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.SnowyHills) && (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType == this.Const.World.TerrainTacticalType.SnowyHills));
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if ((0 + 4) == 6)
    {
        this.World.getTileSquare(_rect.X, _rect.Y).clear();
        this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Plains;
        this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Plains;
        this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_grassland_0" + this.Math.rand(1, 4)));
    }
    else
    {
        if ((0 | this.Const.DirectionBit["0"]) != 0)
        {
            this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Shore;
            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.Const.World.ShoreBrushes.get((0 | this.Const.DirectionBit["0"])), (this.Const.World.ZLevel.Terrain + 1000), this.Const.World.DetailType.Shore, false);
            this.World.getTileSquare(_rect.X, _rect.Y).Subregion = (0 | this.Const.DirectionBit["0"]);
            if (((0 + 6) >= (0 + 9) && ((0 + 6) >= (0 + 9)) && ((0 + 6) >= (0 + 9))))
            {
                return (((0 + 6) >= (0 + 9)) && ((0 + 6) >= (0 + 9)) && ((0 + 6) >= (0 + 9)));
                this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Highlands;
            }
            else
            {
                if (((0 + 8) >= (0 + 9) && ((0 + 8) >= (0 + 9)) && ((0 + 8) >= (0 + 9))))
                {
                    return (((0 + 8) >= (0 + 9)) && ((0 + 8) >= (0 + 9)) && ((0 + 8) >= (0 + 9)));
                    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Steppe;
                }
                else
                {
                    if (((0 + 9) >= (0 + 8) && ((0 + 9) >= (0 + 8)) && ((0 + 9) >= (0 + 8))))
                    {
                        return (((0 + 9) >= (0 + 8)) && ((0 + 9) >= (0 + 8)) && ((0 + 9) >= (0 + 8)));
                        this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Desert;
                    }
                    if (((0 + 7) >= (0 + 9) && ((0 + 7) >= (0 + 9)) && ((0 + 7) >= (0 + 9))))
                    {
                        return (((0 + 7) >= (0 + 9)) && ((0 + 7) >= (0 + 9)) && ((0 + 7) >= (0 + 9)));
                        this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Snow;
                    }
                    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Plains;
                }
            }
        }
    }
    return;
}

function onThirdPass(this, _rect)
{
    if (0 != 6)
    {
        if (!this.World.getTileSquare(_rect.X, _rect.Y).hasNextTile(0))
        {
        }
        else
        {
            if (this.World.getTileSquare(_rect.X, _rect.Y).Type == this.Const.World.TerrainType.Ocean)
            {
            }
            if (0 != 6)
            {
                if (!this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).hasNextTile(0))
                {
                }
                else
                {
                    if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).getNextTile(0).Type == this.Const.World.TerrainType.Hills)
                    {
                    }
                    else
                    {
                        if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).getNextTile(0).Type == this.Const.World.TerrainType.Mountains)
                        {
                        }
                        else
                        {
                            if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).getNextTile(0).Type == this.Const.World.TerrainType.Shore)
                            {
                            }
                        }
                    }
                }
            }
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
                    if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Hills)
                    {
                    }
                    else
                    {
                        if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Mountains)
                        {
                        }
                    }
                }
            }
        }
    }
    if (this.World.getTileSquare(_rect.X, _rect.Y).Type == this.Const.World.TerrainType.Shore)
    {
        if (_rect.Y > (this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline))
        {
        }
        else
        {
            if (this.Math.rand(1, 100) <= 5)
            {
                this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_coast_detail_" + this.Math.rand(23, 28)), this.Const.World.ZLevel.Object, 0);
            }
        }
    }
    else
    {
        if (((0 + 3) + 3) >= 1)
        {
            if (_rect.Y > (this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline))
            {
                if (this.Math.rand(1, 100) <= (5 + ((0 + 3) + 3)))
                {
                    if (this.Math.rand(1, 100) <= 60)
                    {
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_coast_detail_" + this.Math.rand(11, 16)), this.Const.World.ZLevel.Object, 0);
                    }
                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_coast_detail_ice_0" + this.Math.rand(1, 4)), this.Const.World.ZLevel.Object, 0);
                }
            }
            else
            {
                if (this.Math.rand(1, 100) <= ((1 + ((0 + 5) + 5) + ((0 + 6) + 6))))
                {
                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_coast_detail_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                }
                else
                {
                    if (this.Math.rand(1, 100) <= (((0 + 5) + 5) + ((0 + 6) + 6)))
                    {
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_coast_detail_0" + this.Math.rand(1, 7)), this.Const.World.ZLevel.Object, 0);
                    }
                }
            }
        }
        else
        {
            if (_rect.Y > ((this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline) + 4))
            {
                if (this.Math.rand(1, 1000) <= (75 + (((0 + 3) + 3) * 50)))
                {
                    if (this.Math.rand(1, 100) <= 60)
                    {
                        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_coast_detail_1" + this.Math.rand(1, 6)), this.Const.World.ZLevel.Object, 0);
                    }
                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_coast_detail_ice_0" + this.Math.rand(1, 4)), this.Const.World.ZLevel.Object, 0);
                }
            }
            else
            {
                if (this.Math.rand(1, 1000) <= 3)
                {
                    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_coast_detail_0" + this.Math.rand(1, 5)), this.Const.World.ZLevel.Object, 0);
                }
            }
        }
    }
    return;
}
