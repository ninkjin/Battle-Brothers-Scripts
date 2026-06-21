// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tactical_sinkhole.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (12 != 0)
    {
        {}.X = this.Math.rand(1, (_rect.W - this.Math.rand(this.Math.max([]["this.Math.rand(0, ([].len() - 1))"].getMinX(), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxX(), 8)), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxX(), 16))));
        {}.Y = this.Math.rand(1, (_rect.H - this.Math.rand(this.Math.max([]["this.Math.rand(0, ([].len() - 1))"].getMinY(), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxY(), 8)), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxY(), 16))));
        []["this.Math.rand(0, ([].len() - 1))"].fill({}, _properties);
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type == 0)
            {
                if (this.Math.rand(1, 3) == 1)
                {
                    this.MapGen.get("tactical.tile.desert1").fill({}, _properties, 1);
                    this.MapGen.get("tactical.tile.desert1").fill({}, _properties, 2);
                }
                else
                {
                    if (this.Math.rand(1, 3) == 2)
                    {
                        this.MapGen.get("tactical.tile.desert2").fill({}, _properties, 1);
                        this.MapGen.get("tactical.tile.desert2").fill({}, _properties, 2);
                    }
                    else
                    {
                        if (this.Math.rand(1, 3) == 3)
                        {
                            this.MapGen.get("tactical.tile.desert7").fill({}, _properties, 1);
                            this.MapGen.get("tactical.tile.desert7").fill({}, _properties, 2);
                        }
                    }
                }
            }
            if ((_rect.Y >= ((_rect.Y + _rect.H) - 1) || (_rect.Y >= ((_rect.Y + _rect.H) - 1)) || (_rect.Y >= ((_rect.Y + _rect.H) - 1))))
            {
                return ((_rect.Y >= ((_rect.Y + _rect.H) - 1)) || (_rect.Y >= ((_rect.Y + _rect.H) - 1)) || (_rect.Y >= ((_rect.Y + _rect.H) - 1)));
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 2;
            }
            else
            {
                if ((_rect.Y >= ((_rect.Y + _rect.H) - 2) && (_rect.Y >= ((_rect.Y + _rect.H) - 2))))
                {
                    return ((_rect.Y >= ((_rect.Y + _rect.H) - 2)) && (_rect.Y >= ((_rect.Y + _rect.H) - 2)));
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 2;
                }
                else
                {
                    if ((_rect.Y >= ((_rect.Y + _rect.H) - 3) || (_rect.Y >= ((_rect.Y + _rect.H) - 3)) || (_rect.Y >= ((_rect.Y + _rect.H) - 3))))
                    {
                        return ((_rect.Y >= ((_rect.Y + _rect.H) - 3)) || (_rect.Y >= ((_rect.Y + _rect.H) - 3)) || (_rect.Y >= ((_rect.Y + _rect.H) - 3)));
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                    }
                    if ((_rect.Y >= ((_rect.Y + _rect.H) - 4) && (_rect.Y >= ((_rect.Y + _rect.H) - 4))))
                    {
                        return ((_rect.Y >= ((_rect.Y + _rect.H) - 4)) && (_rect.Y >= ((_rect.Y + _rect.H) - 4)));
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                    }
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
                }
            }
        }
    }
    this.makeBordersImpassable(_rect);
    return;
}

function init(this)
{
    this.m.Name = "tactical.sinkhole";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
