// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/patches/patch_swamp_pond.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
            {
            }
            else
            {
                if ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1)) <= 0) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 0) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 0)))
                {
                    return ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 0) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 0) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 0));
                    if (this.Math.rand(1, 100) < 33)
                    {
                    }
                }
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
                if (this.Math.rand(1, 100) <= 90)
                {
                    this.MapGen.get("tactical.tile.swamp4").onFirstPass({});
                }
                this.MapGen.get("tactical.tile.swamp5").onFirstPass({});
            }
        }
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.patch.swamp_pond";
    this.m.MinX = 10;
    this.m.MinY = 10;
    return;
}
