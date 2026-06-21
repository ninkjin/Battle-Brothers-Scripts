// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tiles/steppe5.nut
// Functions: 2

function init(this)
{
    this.m.Name = "tactical.tile.steppe5";
    this.m.MinX = 1;
    this.m.MinY = 1;
    this.createTileTransition().setBlendIntoSockets(false);
    this.createTileTransition().setBrush(this.Const.Direction.N, "transition_steppe_05_N");
    this.createTileTransition().setBrush(this.Const.Direction.NE, "transition_steppe_05_NE");
    this.createTileTransition().setBrush(this.Const.Direction.SE, "transition_steppe_05_SE");
    this.createTileTransition().setBrush(this.Const.Direction.S, "transition_steppe_05_S");
    this.createTileTransition().setBrush(this.Const.Direction.SW, "transition_steppe_05_SW");
    this.createTileTransition().setBrush(this.Const.Direction.NW, "transition_steppe_05_NW");
    this.createTileTransition().setSocket("socket_steppe");
    this.Tactical.setTransitions("tile_steppe_05", this.createTileTransition());
    return;
}

function onFirstPass(this, _rect)
{
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
    {
        return;
    }
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = this.Const.Tactical.TerrainType.FlatGround;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Subtype = this.Const.Tactical.TerrainSubtype.FlatStone;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).BlendPriority = this.Const.Tactical.TileBlendPriority.Steppe5;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).IsBadTerrain = false;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).setBrush("tile_steppe_05");
    if (this.Math.rand(0, 100) < this.m.ChanceToSpawnObject)
    {
        if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty)
        {
            return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty);
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject(this.m.Objects["this.Math.rand(0, (this.m.Objects.len() - 1))"]);
        }
    }
    else
    {
        if ((this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails) && (this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails))
        {
            return ((this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails) && (this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails));
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Details["this.Math.rand(0, (this.m.Details.len() - 1))"]);
        }
    }
    return;
}
