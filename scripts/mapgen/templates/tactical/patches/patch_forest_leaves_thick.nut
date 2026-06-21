// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/patches/patch_forest_leaves_thick.nut
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
            if ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1)) <= 0) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 0) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 0)))
            {
                return ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 0) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 0) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 0));
                if ((this.Math.rand(1, 100) < 10) && (this.Math.rand(1, 100) < 10))
                {
                    return ((this.Math.rand(1, 100) < 10) && (this.Math.rand(1, 100) < 10));
                }
                else
                {
                    if (_rect.Y != _rect.Y)
                    {
                    }
                    else
                    {
                        if (this.Math.rand(1, 100) <= 50)
                        {
                        }
                    }
                }
            }
            if (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1)) <= 1))
            {
            }
            if (_rect.Y == ((_rect.Y + _rect.H) - 2))
            {
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
            if ((this.Tactical.Level == 1) && (this.Tactical.Level == 1))
            {
                return ((this.Tactical.Level == 1) && (this.Tactical.Level == 1));
            }
            this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
            this.MapGen.get("tactical.tile.forest2").onFirstPass({}, 100.0);
            this.Tactical.getTileSquare(_rect.X, _rect.Y).IsSpecialTerrain = true;
        }
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.patch.forest_leaves_thick";
    this.m.MinX = 10;
    this.m.MinY = 10;
    return;
}
