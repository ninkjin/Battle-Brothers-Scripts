// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/patches/patch_mound.nut
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
            if ((_rect.Y == ((_rect.Y + _rect.H) - 1) || (_rect.Y == ((_rect.Y + _rect.H) - 1)) || (_rect.Y == ((_rect.Y + _rect.H) - 1))))
            {
                return ((_rect.Y == ((_rect.Y + _rect.H) - 1)) || (_rect.Y == ((_rect.Y + _rect.H) - 1)) || (_rect.Y == ((_rect.Y + _rect.H) - 1)));
                if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Level < 2)
                {
                    if (this.Math.rand(0, 100) < 75)
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
                    }
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                }
            }
            if ((_rect.Y >= ((_rect.Y + _rect.H) - 2) || (_rect.Y >= ((_rect.Y + _rect.H) - 2)) || (_rect.Y >= ((_rect.Y + _rect.H) - 2))))
            {
                return ((_rect.Y >= ((_rect.Y + _rect.H) - 2)) || (_rect.Y >= ((_rect.Y + _rect.H) - 2)) || (_rect.Y >= ((_rect.Y + _rect.H) - 2)));
                if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Level < 2)
                {
                    if (this.Math.rand(0, 100) < 50)
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                    }
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 2;
                }
            }
            if (this.Math.rand(0, 100) < 90)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 3;
            }
            this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 2;
            if (this.Math.rand(0, 100) > 60)
            {
                this.MapGen.get("tactical.tile.grass1").fill({}, _properties);
            }
            this.MapGen.get("tactical.tile.grass2").fill({}, _properties);
        }
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.patch.mound";
    this.m.MinX = 6;
    this.m.MinY = 6;
    this.m.MaxX = 7;
    this.m.MaxY = 8;
    return;
}
