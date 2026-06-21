// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tiles/desert1.nut
// Functions: 3

function init(this)
{
    this.m.Name = "tactical.tile.desert1";
    this.m.MinX = 1;
    this.m.MinY = 1;
    this.createTileTransition().setSocket("socket_desert");
    this.Tactical.setTransitions("tile_desert_01", this.createTileTransition());
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
    this.Tactical.getTileSquare(_rect.X, _rect.Y).BlendPriority = this.Const.Tactical.TileBlendPriority.Desert1;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).IsBadTerrain = false;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).setBrush("tile_desert_01");
    if (_rect.IsEmpty)
    {
        return;
    }
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
        if (this.Math.rand(0, 100) < this.m.ChanceToSpawnDetails)
        {
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Details["this.Math.rand(0, (this.m.Details.len() - 1))"]);
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
    return;
}
