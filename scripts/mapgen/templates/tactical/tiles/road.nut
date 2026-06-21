// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tiles/road.nut
// Functions: 4

function init(this)
{
    this.m.Name = "tactical.tile.road";
    this.m.MinX = 1;
    this.m.MinY = 1;
    this.createTileTransition().setBlendIntoSockets(false);
    this.createTileTransition().setBrush(this.Const.Direction.N, "transition_road_N");
    this.createTileTransition().setBrush(this.Const.Direction.NE, "transition_road_NE");
    this.createTileTransition().setBrush(this.Const.Direction.SE, "transition_road_SE");
    this.createTileTransition().setBrush(this.Const.Direction.S, "transition_road_S");
    this.createTileTransition().setBrush(this.Const.Direction.SW, "transition_road_SW");
    this.createTileTransition().setBrush(this.Const.Direction.NW, "transition_road_NW");
    this.createTileTransition().setSocket("socket_earth");
    this.Tactical.setTransitions("tile_road", this.createTileTransition());
    return;
}

function onDeserialize(this, _in)
{
    this.map_template.onDeserialize(_in);
    return;
}

function onFirstPass(this, _rect)
{
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
    {
        return;
    }
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = this.Const.Tactical.TerrainType.PavedGround;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Subtype = this.Const.Tactical.TerrainSubtype.CobblestoneRoad;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).BlendPriority = this.Const.Tactical.TileBlendPriority.Road;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).setBrush("tile_road");
    if (this.Math.rand(0, 100) < this.m.ChanceToSpawnObject)
    {
        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject(this.m.Objects["this.Math.rand(0, (this.m.Objects.len() - 1))"]);
    }
    else
    {
        if (this.m.Details.len() > 0)
        {
        }
        if ((this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails) && (this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails))
        {
            return ((this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails) && (this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails));
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Details["this.Math.rand(0, (this.m.Details.len() - 1))"]);
        }
    }
    return;
}

function onSerialize(this, _out)
{
    this.map_template.onSerialize(_out);
    return;
}
