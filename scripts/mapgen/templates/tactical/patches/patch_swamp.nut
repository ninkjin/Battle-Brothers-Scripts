// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/patches/patch_swamp.nut
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
                if ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1)) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2)))
                {
                    return ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2));
                    if (this.Math.rand(0, 100) < 33)
                    {
                    }
                }
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
                if (this.Math.rand(0, 100) <= 50)
                {
                    this.MapGen.get("tactical.tile.swamp3").fill({}, _properties, 1);
                }
                if (this.Math.rand(0, 100) <= 75)
                {
                    this.MapGen.get("tactical.tile.swamp2").fill({}, _properties, 1);
                }
                this.MapGen.get("tactical.tile.swamp1").fill({}, _properties, 1);
            }
        }
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.patch.swamp";
    this.m.MinX = 10;
    this.m.MinY = 10;
    return;
}
