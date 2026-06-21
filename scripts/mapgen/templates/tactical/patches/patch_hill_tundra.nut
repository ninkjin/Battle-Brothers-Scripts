// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/patches/patch_hill_tundra.nut
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
                if (this.Math.rand(1, 100) < 35)
                {
                }
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
            }
            else
            {
                if ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1)) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2)))
                {
                    return ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2));
                    if (this.Math.rand(1, 100) < 35)
                    {
                        if (this.Math.rand(1, 100) < 15)
                        {
                        }
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                    }
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 2;
                }
                if ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1)) <= 3) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 3) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 3)))
                {
                    return ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 3) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 3) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 3));
                    if (this.Math.rand(1, 100) < 35)
                    {
                        if (this.Math.rand(1, 100) < 15)
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
                if (this.Math.rand(1, 100) <= 10)
                {
                    this.MapGen.get("tactical.tile.tundra5").fill({}, _properties);
                }
                if (this.Math.rand(1, 100) <= 20)
                {
                    this.MapGen.get("tactical.tile.stone1").fill({}, _properties);
                }
                if (this.Math.rand(1, 100) <= 70)
                {
                    this.MapGen.get("tactical.tile.tundra2").fill({}, _properties);
                }
                this.MapGen.get("tactical.tile.tundra3").fill({}, _properties);
            }
            if (this.Math.rand(1, 100) <= 50)
            {
                this.MapGen.get("tactical.tile.tundra2").fill({}, _properties);
            }
            this.MapGen.get("tactical.tile.tundra3").fill({}, _properties);
        }
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.patch.hill_tundra";
    this.m.MinX = 10;
    this.m.MinY = 10;
    return;
}
