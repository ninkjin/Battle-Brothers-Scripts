// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tactical_mountain.nut
// Functions: 3

function campify(this, _rect, _properties)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(((_rect.X + (_rect.W / 2) + _properties.ShiftX), ((_rect.Y + (_rect.H / 2)) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > ((this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius) + 3)))
            {
            }
            else
            {
                if (this.Tactical.getTileSquare(((_rect.X + (_rect.W / 2) + _properties.ShiftX), ((_rect.Y + (_rect.H / 2)) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) <= (this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius)))
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 3;
                }
                else
                {
                    if ((this.Tactical.getTileSquare(_rect.X, _rect.Y).Level != 3) && (this.Tactical.getTileSquare(_rect.X, _rect.Y).Level != 3))
                    {
                        return ((this.Tactical.getTileSquare(_rect.X, _rect.Y).Level != 3) && (this.Tactical.getTileSquare(_rect.X, _rect.Y).Level != 3));
                        if (this.Math.rand(1, 100) <= 50)
                        {
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 3;
                        }
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 2;
                    }
                    else
                    {
                        if ((this.Tactical.getTileSquare(_rect.X, _rect.Y).Level != 3) && (this.Tactical.getTileSquare(_rect.X, _rect.Y).Level != 3))
                        {
                            return ((this.Tactical.getTileSquare(_rect.X, _rect.Y).Level != 3) && (this.Tactical.getTileSquare(_rect.X, _rect.Y).Level != 3));
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 2;
                        }
                        else
                        {
                            if ((this.Tactical.getTileSquare(_rect.X, _rect.Y).Level != 3) && (this.Tactical.getTileSquare(_rect.X, _rect.Y).Level != 3))
                            {
                                return ((this.Tactical.getTileSquare(_rect.X, _rect.Y).Level != 3) && (this.Tactical.getTileSquare(_rect.X, _rect.Y).Level != 3));
                                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                            }
                        }
                    }
                }
            }
        }
    }
    return;
}

function fill(this, _rect, _properties, _pass)
{
    this.addRoads(_rect, _properties);
    if ((0 < 3000) && (0 < 3000))
    {
        return ((0 < 3000) && (0 < 3000));
        {}.X = this.Math.rand(1, (_rect.W - this.Math.rand(8, 16)));
        {}.Y = this.Math.rand(1, (_rect.H - this.Math.rand(8, 16)));
        this.MapGen.get("tactical.patch.mountain").fill({}, _properties);
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
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
            this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
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
    this.m.Name = "tactical.mountain";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
