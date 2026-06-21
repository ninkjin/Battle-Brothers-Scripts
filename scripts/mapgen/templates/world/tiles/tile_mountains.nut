// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/tiles/tile_mountains.nut
// Functions: 5

function init(this)
{
    this.m.Name = "world.tile.mountains";
    this.m.MinX = 1;
    this.m.MinY = 1;
    return;
}

function onFirstPass(this, _rect)
{
    if ((this.World.getTileSquare(_rect.X, _rect.Y).Type != this.Const.World.TerrainType.Mountains) && (this.World.getTileSquare(_rect.X, _rect.Y).Type != this.Const.World.TerrainType.Mountains))
    {
        return ((this.World.getTileSquare(_rect.X, _rect.Y).Type != this.Const.World.TerrainType.Mountains) && (this.World.getTileSquare(_rect.X, _rect.Y).Type != this.Const.World.TerrainType.Mountains));
    }
    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Mountains;
    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Mountains;
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
            if ((this.World.getTileSquare(_rect.X, _rect.Y).Subregion != 100) && (this.World.getTileSquare(_rect.X, _rect.Y).Subregion != 100) && (this.World.getTileSquare(_rect.X, _rect.Y).Subregion != 100))
            {
                return ((this.World.getTileSquare(_rect.X, _rect.Y).Subregion != 100) && (this.World.getTileSquare(_rect.X, _rect.Y).Subregion != 100) && (this.World.getTileSquare(_rect.X, _rect.Y).Subregion != 100));
            }
        }
    }
    if ((0 + 4) >= 6)
    {
        if (_rect.Y < (this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline))
        {
        }
        this.World.getTileSquare(_rect.X, _rect.Y).Subregion = 100;
        this.World.getTileSquare(_rect.X, _rect.Y).Type = 0;
        this.MapGen.get("world.tile.hills").onFirstPass({});
        this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Mountains;
        this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Mountains;
    }
    if (0 != 6)
    {
        if (!this.World.getTileSquare(_rect.X, _rect.Y).hasNextTile(0))
        {
        }
        else
        {
            if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion != 100)
            {
                this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).clear();
                this.placeHills(this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0));
                this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type = this.Const.World.TerrainType.Mountains;
                this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).TacticalType = this.Const.World.TerrainTacticalType.Mountains;
            }
            this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subregion = 100;
            if ((0 == 5) || (0 == 5))
            {
                return ((0 == 5) || (0 == 5));
                this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).IsOccupied = true;
            }
        }
    }
    return;
}

function onThirdPass(this, _rect)
{
    if (this.World.getTileSquare(_rect.X, _rect.Y).Subregion != 100)
    {
        this.World.getTileSquare(_rect.X, _rect.Y).clear();
        this.World.getTileSquare(_rect.X, _rect.Y).Type = 0;
        this.MapGen.get("world.tile.hills").onFirstPass(_rect);
        this.MapGen.get("world.tile.hills").onSecondPass(_rect);
    }
    return;
}

function placeHills(this, _tile)
{
    if (0 != 6)
    {
        if (!_tile.hasNextTile(0))
        {
        }
        else
        {
            if ((_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Tundra) && (_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Tundra))
            {
                return ((_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Tundra) && (_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Tundra));
            }
            else
            {
                if ((_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Snow) && (_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Snow))
                {
                    return ((_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Snow) && (_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Snow));
                }
                else
                {
                    if ((_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Steppe) && (_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Steppe))
                    {
                        return ((_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Steppe) && (_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Steppe));
                    }
                    else
                    {
                        if ((_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Desert) && (_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Desert))
                        {
                            return ((_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Desert) && (_tile.getNextTile(0).Subregion == this.Const.World.TerrainType.Desert));
                        }
                        else
                        {
                            if (_tile.getNextTile(0).Type == this.Const.World.TerrainType.Mountains)
                            {
                                [].push(_tile.getNextTile(0));
                            }
                        }
                    }
                }
            }
        }
    }
    if ((0 + 2) >= 1)
    {
        _tile.setBrush("world_highlands_01");
        _tile.spawnDetail(("world_tundra_hill_0" + this.Math.rand(2, 4)), (this.Const.World.ZLevel.Terrain + 500), this.Const.World.DetailType.Hills, false);
        _tile.TacticalType = this.Const.World.TerrainTacticalType.HighlandsHills;
    }
    if ((_tile.SquareCoords.Y >= (this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline) && (_tile.SquareCoords.Y >= (this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline))))
    {
        return ((_tile.SquareCoords.Y >= (this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline)) && (_tile.SquareCoords.Y >= (this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline)));
        _tile.setBrush(("world_snow_0" + this.Math.rand(1, 3)));
        _tile.spawnDetail(("world_snow_hill_0" + this.Math.rand(2, 5)), (this.Const.World.ZLevel.Terrain + 500), this.Const.World.DetailType.Hills, false);
        _tile.TacticalType = this.Const.World.TerrainTacticalType.SnowyHills;
    }
    if ((0 + 4) >= 1)
    {
        _tile.setBrush(("world_steppe_0" + this.Math.rand(1, 3)));
        _tile.spawnDetail(("world_grass_hill_0" + this.Math.rand(5, 6)), (this.Const.World.ZLevel.Terrain + 500), this.Const.World.DetailType.Hills, false);
        _tile.TacticalType = this.Const.World.TerrainTacticalType.SteppeHills;
    }
    if ((0 + 5) >= 1)
    {
        _tile.setBrush("world_desert_04");
        _tile.spawnDetail(("world_grass_hill_0" + this.Math.rand(4, 5)), (this.Const.World.ZLevel.Terrain + 500), this.Const.World.DetailType.Hills, false);
        _tile.TacticalType = this.Const.World.TerrainTacticalType.DesertHills;
    }
    _tile.setBrush(("world_grassland_0" + this.Math.rand(1, 4)));
    _tile.spawnDetail(("world_grass_hill_0" + this.Math.rand(2, 6)), (this.Const.World.ZLevel.Terrain + 500), this.Const.World.DetailType.Hills, false);
    _tile.TacticalType = this.Const.World.TerrainTacticalType.Hills;
    return;
}
