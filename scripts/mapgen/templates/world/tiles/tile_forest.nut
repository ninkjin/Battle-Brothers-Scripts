// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/tiles/tile_forest.nut
// Functions: 4

function init(this)
{
    this.m.Name = "world.tile.forest";
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
    if (_rect.Y < (((this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline) - (_rect.X % 3) - 3)))
    {
        this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_needles_0" + this.Math.rand(1, 3)));
        this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Forest;
        this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Forest;
    }
    this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_snow_0" + this.Math.rand(1, 3)));
    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.SnowyForest;
    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.SnowyForest;
    return;
}

function onRoadPass(this, _rect)
{
    if (this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied)
    {
        return;
    }
    if (this.World.getTileSquare(_rect.X, _rect.Y).HasRoad)
    {
        this.World.getTileSquare(_rect.X, _rect.Y).clearAllBut(this.Const.World.DetailType.Road);
        if (_rect.Y < ((this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline) - (_rect.X % 3)))
        {
            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_road_0" + this.Math.rand(1, 1)), this.Const.World.ZLevel.Object, 0);
            this.World.getTileSquare(_rect.X, _rect.Y).setBrush("world_forest_needle_02");
        }
        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_snow_road_0" + this.Math.rand(1, 1)), this.Const.World.ZLevel.Object, 0);
    }
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
            if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Urban)
            {
            }
            else
            {
                if (this.World.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Type == this.Const.World.TerrainType.Snow)
                {
                }
            }
        }
    }
    if ((_rect.Y < ((this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline) - (_rect.X % 3)) && (_rect.Y < ((this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline) - (_rect.X % 3)))))
    {
        return ((_rect.Y < ((this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline) - (_rect.X % 3))) && (_rect.Y < ((this.Const.World.Settings.SizeY * this.Const.World.Settings.Snowline) - (_rect.X % 3))));
        this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_needles_0" + this.Math.rand(1, 3)));
        if ((this.Math <= 75) && (this.Math <= 75))
        {
            return ((this.Math <= 75) && (this.Math <= 75));
            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_cut_0" + this.Math.rand(1, 2)), this.Const.World.ZLevel.Object, 0);
            this.World.getTileSquare(_rect.X, _rect.Y).setBrush("world_forest_needle_02");
        }
        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_0" + this.Math.rand(1, 3)), this.Const.World.ZLevel.Object, 0);
    }
    this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_snow_0" + this.Math.rand(1, 3)));
    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_snow_0" + this.Math.rand(1, 3)), this.Const.World.ZLevel.Object, 0);
    return;
}
