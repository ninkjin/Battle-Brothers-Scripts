// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tactical_quarry.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    this.addRoads(_rect, _properties);
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
            {
            }
            if ((_rect.Y >= ((_rect.Y + _rect.H) - 1) || (_rect.Y >= ((_rect.Y + _rect.H) - 1)) || (_rect.Y >= ((_rect.Y + _rect.H) - 1))))
            {
                return ((_rect.Y >= ((_rect.Y + _rect.H) - 1)) || (_rect.Y >= ((_rect.Y + _rect.H) - 1)) || (_rect.Y >= ((_rect.Y + _rect.H) - 1)));
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
            }
            else
            {
                if ((_rect.Y >= ((_rect.Y + _rect.H) - 2) && (_rect.Y >= ((_rect.Y + _rect.H) - 2))))
                {
                    return ((_rect.Y >= ((_rect.Y + _rect.H) - 2)) && (_rect.Y >= ((_rect.Y + _rect.H) - 2)));
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                }
                else
                {
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
                    if (this.Math.rand(1, 100) > (100 - ((((0 + 10) + 10) + 10) * 5)))
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                    }
                }
            }
            if (this.Math.rand(1, 100) < 60)
            {
                this.MapGen.get("tactical.tile.stone1").fill({}, _properties);
            }
            this.MapGen.get("tactical.tile.stone2").fill({}, _properties);
        }
    }
    this.makeBordersImpassable(_rect);
    return;
}

function init(this)
{
    this.m.Name = "tactical.quarry";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
