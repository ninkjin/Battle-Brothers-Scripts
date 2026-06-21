// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/tiles/tile_forest_leaves.nut
// Functions: 4

function init(this)
{
    this.m.Name = "world.tile.forest_leaves";
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
    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.LeaveForest;
    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.LeaveForest;
    this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_forest_0" + this.Math.rand(1, 4)));
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
        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_leaves_road_0" + this.Math.rand(1, 1)), this.Const.World.ZLevel.Object, 0);
    }
    return;
}

function onSecondPass(this, _rect)
{
    if (this.World.getTileSquare(_rect.X, _rect.Y).getSurroundingTilesOfType(this.Const.World.TerrainType.Urban) != 0)
    {
        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_leaves_cut_0" + this.Math.rand(1, 2)), this.Const.World.ZLevel.Object, 0);
    }
    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_detail_forest_leaves_0" + this.Math.rand(2, 4)), this.Const.World.ZLevel.Object, 0);
    return;
}
