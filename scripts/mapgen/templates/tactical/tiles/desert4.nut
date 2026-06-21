// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tiles/desert4.nut
// Functions: 2

function init(this)
{
    this.m.Name = "tactical.tile.desert4";
    this.m.MinX = 1;
    this.m.MinY = 1;
    this.createTileTransition().setBlendIntoSockets(false);
    this.createTileTransition().setBrush(this.Const.Direction.N, "transition_desert_04_N");
    this.createTileTransition().setBrush(this.Const.Direction.NE, "transition_desert_04_NE");
    this.createTileTransition().setBrush(this.Const.Direction.SE, "transition_desert_04_SE");
    this.createTileTransition().setBrush(this.Const.Direction.S, "transition_desert_04_S");
    this.createTileTransition().setBrush(this.Const.Direction.SW, "transition_desert_04_SW");
    this.createTileTransition().setBrush(this.Const.Direction.NW, "transition_desert_04_NW");
    this.createTileTransition().setSocket("socket_desert");
    this.Tactical.setTransitions("tile_desert_04", this.createTileTransition());
    return;
}

function onFirstPass(this, _rect)
{
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
    {
        return;
    }
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = this.Const.Tactical.TerrainType.FlatGround;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Subtype = this.Const.Tactical.TerrainSubtype.PlashyGrass;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).BlendPriority = this.Const.Tactical.TileBlendPriority.Desert4;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).IsBadTerrain = false;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).setBrush("tile_desert_04");
    if (this.Math.rand(1, 100) <= this.m.ChanceToSpawnHiding)
    {
        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingBack["this.Math.rand(0, (this.m.HidingBack.len() - 1))"]);
        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingFront["this.Math.rand(0, (this.m.HidingFront.len() - 1))"], 0, (this.Math.rand(0, 1) == 1));
        this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity = true;
    }
    else
    {
        if (this.Math.rand(0, 100) < this.m.ChanceToSpawnObject)
        {
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject(this.m.Objects["this.Math.rand(0, (this.m.Objects.len() - 1))"]);
        }
        else
        {
            if (this.Math.rand(0, 100) < this.m.ChanceToSpawnDetails)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Details["this.Math.rand(0, (this.m.Details.len() - 1))"]);
            }
        }
    }
    return;
}
