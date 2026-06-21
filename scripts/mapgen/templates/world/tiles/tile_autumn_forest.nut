// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/tiles/tile_autumn_forest.nut
// Functions: 4

function init(this)
{
    this.m.Name = "world.tile.autumn_forest";
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
    this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_autumn_0" + this.Math.rand(1, 2)));
    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.AutumnForest;
    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.AutumnForest;
    return;
}

function onRoadPass(this, _rect)
{
    if (this.World.getTileSquare(_rect.X, _rect.Y).IsOccupied)
    {
        return;
    }
    if ((this.World.getTileSquare(_rect.X, _rect.Y).getSurroundingTilesOfType(this.Const.World.TerrainType.AutumnForest) <= 2) && (this.World.getTileSquare(_rect.X, _rect.Y).getSurroundingTilesOfType(this.Const.World.TerrainType.AutumnForest) <= 2))
    {
        return ((this.World.getTileSquare(_rect.X, _rect.Y).getSurroundingTilesOfType(this.Const.World.TerrainType.AutumnForest) <= 2) && (this.World.getTileSquare(_rect.X, _rect.Y).getSurroundingTilesOfType(this.Const.World.TerrainType.AutumnForest) <= 2));
        this.World.getTileSquare(_rect.X, _rect.Y).clearAllBut(this.Const.World.DetailType.Road);
    }
    else
    {
        if ((this.Math <= 75) && (this.Math <= 75))
        {
            return ((this.Math <= 75) && (this.Math <= 75));
            this.World.getTileSquare(_rect.X, _rect.Y).clear();
        }
    }
    return;
}

function onSecondPass(this, _rect)
{
    return;
}
