// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/patches/patch_autumn_stony.nut
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
                if ((this.Tactical.Level == 1) && (this.Tactical.Level == 1))
                {
                    return ((this.Tactical.Level == 1) && (this.Tactical.Level == 1));
                }
                if ((this.Tactical.Level == 1) && (this.Tactical.Level == 1))
                {
                    return ((this.Tactical.Level == 1) && (this.Tactical.Level == 1));
                }
                if ((this.Tactical.Level == 1) && (this.Tactical.Level == 1))
                {
                    return ((this.Tactical.Level == 1) && (this.Tactical.Level == 1));
                }
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
                if (this.Math.rand(0, 100) > (98 - ((((0 + 11) + 11) + 11) * 20)))
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                }
                if (this.Math.rand(1, 100) <= 40)
                {
                    if (this.Math.rand(0, 100) < 33)
                    {
                    }
                }
                if (this.Math.rand(1, 100) <= 70)
                {
                    if (this.Math.rand(0, 100) < 33)
                    {
                    }
                }
                if (this.Math.rand(0, 100) < 33)
                {
                }
                return;
            }
        }
    }
}

function init(this)
{
    this.m.Name = "tactical.patch.autumn_stony";
    this.m.MinX = 10;
    this.m.MinY = 10;
    return;
}
