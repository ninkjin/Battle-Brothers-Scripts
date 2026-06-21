// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tiles/desert3.nut
// Functions: 2

function init(this)
{
    this.m.Name = "tactical.tile.desert3";
    this.m.MinX = 1;
    this.m.MinY = 1;
    this.createTileTransition().setBlendIntoSockets(false);
    this.createTileTransition().setBrush(this.Const.Direction.N, "transition_desert_03_N");
    this.createTileTransition().setBrush(this.Const.Direction.NE, "transition_desert_03_NE");
    this.createTileTransition().setBrush(this.Const.Direction.SE, "transition_desert_03_SE");
    this.createTileTransition().setBrush(this.Const.Direction.S, "transition_desert_03_S");
    this.createTileTransition().setBrush(this.Const.Direction.SW, "transition_desert_03_SW");
    this.createTileTransition().setBrush(this.Const.Direction.NW, "transition_desert_03_NW");
    this.createTileTransition().setSocket("socket_desert");
    this.Tactical.setTransitions("tile_desert_03", this.createTileTransition());
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
    this.Tactical.getTileSquare(_rect.X, _rect.Y).BlendPriority = this.Const.Tactical.TileBlendPriority.Desert3;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).IsBadTerrain = false;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).setBrush("tile_desert_03");
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
        if (this.Math.rand(0, 100) < 20)
        {
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsHigh["this.Math.rand(0, (this.m.DetailsHigh.len() - 1))"]);
        }
        else
        {
            if (this.Math.rand(0, 100) < 30)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsGrass["this.Math.rand(0, (this.m.DetailsGrass.len() - 1))"]);
                if ((50 < 2) && (50 < 2))
                {
                    return ((50 < 2) && (50 < 2));
                }
            }
            else
            {
                if (this.Math.rand(0, 100) < this.m.ChanceToSpawnDetails)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Details["this.Math.rand(0, (this.m.Details.len() - 1))"]);
                }
            }
        }
    }
    return;
}
