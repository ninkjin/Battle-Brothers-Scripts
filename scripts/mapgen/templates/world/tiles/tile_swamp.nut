// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/tiles/tile_swamp.nut
// Functions: 4

function init(this)
{
    this.m.Name = "world.tile.swamp";
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
    this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Swamp;
    this.World.getTileSquare(_rect.X, _rect.Y).TacticalType = this.Const.World.TerrainTacticalType.Swamp;
    this.World.getTileSquare(_rect.X, _rect.Y).setBrush(("world_swamp_0" + this.Math.rand(1, 4)));
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
        this.World.getTileSquare(_rect.X, _rect.Y).clearAllBut((this.Const.World.DetailType.Road | this.Const.World.DetailType.Houses));
        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail("world_detail_swamp_road_01", this.Const.World.ZLevel.Object, 0);
        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_swamp_fog_0" + this.Math.rand(1, 4)), (this.Const.World.ZLevel.Object + 5), 0).Alpha = 150;
    }
    return;
}

function onSecondPass(this, _rect)
{
    this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Details["this.Math.rand(0, (this.m.Details.len() - 1))"], this.Const.World.ZLevel.Object, (this.Const.World.DetailType.Swamp | this.Const.World.DetailType.NotCompatibleWithRoad));
    if (this.World.getTileSquare(_rect.X, _rect.Y).getSurroundingTilesOfType(this.Const.World.TerrainType.Swamp) >= 1)
    {
        this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_swamp_fog_0" + this.Math.rand(1, 4)), (this.Const.World.ZLevel.Object + 300), 0).Alpha = this.Math.min(255, (this.World.getTileSquare(_rect.X, _rect.Y).getSurroundingTilesOfType(this.Const.World.TerrainType.Swamp) * 40));
        if (this.World.getTileSquare(_rect.X, _rect.Y).getSurroundingTilesOfType(this.Const.World.TerrainType.Swamp) >= 3)
        {
            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_swamp_fog_0" + this.Math.rand(5, 6)), (this.Const.World.ZLevel.Object + 305), 0).Alpha = this.Math.min(255, (this.World.getTileSquare(_rect.X, _rect.Y).getSurroundingTilesOfType(this.Const.World.TerrainType.Swamp) * 25));
            this.World.getTileSquare(_rect.X, _rect.Y).spawnDetail(("world_swamp_fog_0" + this.Math.rand(5, 6)), (this.Const.World.ZLevel.Object + 305), 0).Torque = (this.Math.rand(0, 30) - 15);
        }
    }
    return;
}
