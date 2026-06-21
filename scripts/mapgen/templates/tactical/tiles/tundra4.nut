// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tiles/tundra4.nut
// Functions: 2

function init(this)
{
    this.m.Name = "tactical.tile.tundra4";
    this.m.MinX = 1;
    this.m.MinY = 1;
    this.createTileTransition().setBlendIntoSockets(true);
    this.createTileTransition().setBrush(this.Const.Direction.N, "transition_tundra_04_N");
    this.createTileTransition().setBrush(this.Const.Direction.NE, "transition_tundra_04_NE");
    this.createTileTransition().setBrush(this.Const.Direction.SE, "transition_tundra_04_SE");
    this.createTileTransition().setBrush(this.Const.Direction.S, "transition_tundra_04_S");
    this.createTileTransition().setBrush(this.Const.Direction.SW, "transition_tundra_04_SW");
    this.createTileTransition().setBrush(this.Const.Direction.NW, "transition_tundra_04_NW");
    this.createTileTransition().setSocket("socket_earth");
    this.Tactical.setTransitions("tile_tundra_04", this.createTileTransition());
    return;
}

function onFirstPass(this, _rect)
{
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
    {
        return;
    }
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = this.Const.Tactical.TerrainType.FlatGround;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Subtype = this.Const.Tactical.TerrainSubtype.Tundra;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).BlendPriority = this.Const.Tactical.TileBlendPriority.Tundra4;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).IsBadTerrain = false;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).setBrush("tile_tundra_04");
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
        if (this.Math.rand(1, 100) <= this.m.ChanceToSpawnDetails)
        {
            if (this.Math.rand(1, 100) <= 25)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsStones["this.Math.rand(0, (this.m.DetailsStones.len() - 1))"]);
            }
            else
            {
                if (this.Math.rand(1, 100) <= 50)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Details["this.Math.rand(0, (this.m.Details.len() - 1))"]);
                }
                else
                {
                    if ((this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails) && (this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails))
                    {
                        return ((this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails) && (this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails));
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Details["this.Math.rand(0, (this.m.Details.len() - 1))"]);
                    }
                }
            }
            return;
        }
    }
}
