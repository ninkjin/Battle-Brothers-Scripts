// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/test/test_hill.nut
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
                    if (this.Math.rand(0, 100) < 66)
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
                    }
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                }
            }
            else
            {
                if ((_rect.Y >= ((_rect.Y + _rect.H) - 2) || (_rect.Y >= ((_rect.Y + _rect.H) - 2)) || (_rect.Y >= ((_rect.Y + _rect.H) - 2))))
                {
                    return ((_rect.Y >= ((_rect.Y + _rect.H) - 2)) || (_rect.Y >= ((_rect.Y + _rect.H) - 2)) || (_rect.Y >= ((_rect.Y + _rect.H) - 2)));
                    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Level < 2)
                    {
                        if (this.Math.rand(0, 100) < 33)
                        {
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
                        }
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                    }
                }
                else
                {
                    if ((_rect.Y >= ((_rect.Y + _rect.H) - 3) || (_rect.Y >= ((_rect.Y + _rect.H) - 3)) || (_rect.Y >= ((_rect.Y + _rect.H) - 3))))
                    {
                        return ((_rect.Y >= ((_rect.Y + _rect.H) - 3)) || (_rect.Y >= ((_rect.Y + _rect.H) - 3)) || (_rect.Y >= ((_rect.Y + _rect.H) - 3)));
                        if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Level < 2)
                        {
                            if (this.Math.rand(0, 100) < 33)
                            {
                                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                            }
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 2;
                        }
                    }
                    if ((_rect.Y >= ((_rect.Y + _rect.H) - 4) || (_rect.Y >= ((_rect.Y + _rect.H) - 4)) || (_rect.Y >= ((_rect.Y + _rect.H) - 4))))
                    {
                        return ((_rect.Y >= ((_rect.Y + _rect.H) - 4)) || (_rect.Y >= ((_rect.Y + _rect.H) - 4)) || (_rect.Y >= ((_rect.Y + _rect.H) - 4)));
                        if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Level < 2)
                        {
                            if (this.Math.rand(0, 100) < 10)
                            {
                                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                            }
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 2;
                        }
                    }
                    if (this.Math.rand(0, 100) < 7)
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 3;
                    }
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 2;
                }
            }
            if (this.Math.rand(0, 100) > 90)
            {
                this.MapGen.get("tactical.tile.earth1").fill({}, _properties);
            }
            this.MapGen.get("tactical.tile.grass1").fill({}, _properties);
        }
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.test_hill";
    this.m.MinX = 10;
    this.m.MinY = 10;
    return;
}
