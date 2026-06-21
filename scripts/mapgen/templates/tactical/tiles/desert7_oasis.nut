// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tiles/desert7_oasis.nut
// Functions: 3

function init(this)
{
    this.m.Name = "tactical.tile.desert7_oasis";
    this.m.MinX = 1;
    this.m.MinY = 1;
    this.createTileTransition().setBlendIntoSockets(false);
    this.createTileTransition().setBrush(this.Const.Direction.N, "transition_desert_07_N");
    this.createTileTransition().setBrush(this.Const.Direction.NE, "transition_desert_07_NE");
    this.createTileTransition().setBrush(this.Const.Direction.SE, "transition_desert_07_SE");
    this.createTileTransition().setBrush(this.Const.Direction.S, "transition_desert_07_S");
    this.createTileTransition().setBrush(this.Const.Direction.SW, "transition_desert_07_SW");
    this.createTileTransition().setBrush(this.Const.Direction.NW, "transition_desert_07_NW");
    this.createTileTransition().setSocket("socket_desert");
    this.Tactical.setTransitions("tile_desert_07", this.createTileTransition());
    return;
}

function onFirstPass(this, _rect)
{
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
    {
        return;
    }
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = this.Const.Tactical.TerrainType.Sand;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Subtype = this.Const.Tactical.TerrainSubtype.Desert;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).BlendPriority = this.Const.Tactical.TileBlendPriority.Desert7;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).IsBadTerrain = false;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).setBrush("tile_desert_07");
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
        if (this.Math.rand(0, 100) < 66)
        {
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsHigh["this.Math.rand(0, (this.m.DetailsHigh.len() - 1))"]);
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

function onSecondPass(this, _rect)
{
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
    {
        return;
    }
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
    {
        return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity);
    }
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
    {
        return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity);
    }
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
    {
        return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity);
    }
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
    {
        return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity);
    }
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
    {
        return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity);
    }
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
    {
        return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity);
    }
    if (((((((0 + 3) + 3) + 3) + 3) + 3) + 3) != 0)
    {
        this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
        if (0 < this.Math.rand(2, this.Math.min(this.Math.max(2, ((((((0 + 3) + 3) + 3) + 3) + 3) + 3), 4))))
        {
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingExtras["this.Math.rand(0, (this.m.HidingExtras.len() - 1))"]);
        }
    }
    else
    {
        if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty)
        {
            if (0 < 6)
            {
                if (!this.Tactical.getTileSquare(_rect.X, _rect.Y).hasNextTile(0))
                {
                }
                else
                {
                    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Subtype == this.Const.Tactical.TerrainSubtype.ShallowWater)
                    {
                    }
                }
            }
            if (this.Math.rand(1, 100) <= (0 + 100))
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsPuddle["this.Math.rand(0, (this.m.DetailsPuddle.len() - 1))"]);
            }
        }
    }
    return;
}
