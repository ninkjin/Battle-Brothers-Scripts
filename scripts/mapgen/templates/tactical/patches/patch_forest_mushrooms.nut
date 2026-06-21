// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/patches/patch_forest_mushrooms.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            this.MapGen.get("tactical.tile.forest1").fill({}, _properties, 1);
            if ((this.Tactical.getTileSquare(_rect.X, _rect.Y).Type == this.Const.Tactical.TerrainType.Forest) && (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type == this.Const.Tactical.TerrainType.Forest))
            {
                return ((this.Tactical.getTileSquare(_rect.X, _rect.Y).Type == this.Const.Tactical.TerrainType.Forest) && (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type == this.Const.Tactical.TerrainType.Forest));
                if (this.Math.rand(0, 5) != 0)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                    if (0 < this.Math.rand(0, 5))
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
                    }
                }
            }
        }
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.patch.forest_mushrooms";
    this.m.MinX = 6;
    this.m.MaxX = 10;
    this.m.MinY = 6;
    this.m.MaxY = 10;
    return;
}
