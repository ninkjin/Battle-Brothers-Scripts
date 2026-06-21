// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/patches/patch_mountain.nut
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
            this.Tactical.getTileSquare(_rect.X, _rect.Y).IsSpecialTerrain = true;
            if ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1)) <= 1) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 1) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 1)))
            {
                return ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 1) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 1) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 1));
                if (this.Math.rand(1, 100) < 50)
                {
                }
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
            }
            else
            {
                if ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1)) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2)))
                {
                    return ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2));
                    if (this.Math.rand(1, 100) < 50)
                    {
                        if (this.Math.rand(1, 100) < 25)
                        {
                        }
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                    }
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 2;
                }
                if ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1)) <= 4) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 4) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 4)))
                {
                    return ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 4) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 4) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 4));
                    if (this.Math.rand(1, 100) < 50)
                    {
                        if (this.Math.rand(1, 100) < 25)
                        {
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                        }
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 2;
                    }
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 3;
                }
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 3;
            }
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Level >= 2)
            {
                if (this.Math.rand(1, 100) <= 60)
                {
                    this.MapGen.get("tactical.tile.stone1").fill({}, _properties);
                }
                this.MapGen.get("tactical.tile.stone2").fill({}, _properties);
            }
            if (this.Math.rand(1, 100) <= 50)
            {
                this.MapGen.get("tactical.tile.stone1").fill({}, _properties);
            }
            this.MapGen.get("tactical.tile.stone3").fill({}, _properties);
        }
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.patch.mountain";
    this.m.MinX = 10;
    this.m.MinY = 10;
    return;
}
