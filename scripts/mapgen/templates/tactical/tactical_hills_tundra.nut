// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tactical_hills_tundra.nut
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
    [].push(this.MapGen.get("tactical.patch.tundra_grass"));
    [].push(this.MapGen.get("tactical.patch.tundra_grass"));
    [].push(this.MapGen.get("tactical.patch.tundra_grass"));
    [].push(this.MapGen.get("tactical.patch.tundra_stony"));
    [].push(this.MapGen.get("tactical.patch.tundra_stony"));
    [].push(this.MapGen.get("tactical.patch.tundra_brushes"));
    if ((0 < 3000) && (0 < 3000))
    {
        return ((0 < 3000) && (0 < 3000));
        {}.X = this.Math.rand(1, (_rect.W - this.Math.rand(10, 20)));
        {}.Y = this.Math.rand(1, (_rect.H - this.Math.rand(10, 20)));
        if (({}.X - 1) != (({}.X + this.Math.rand(10, 20) + 1)))
        {
            if (({}.Y - 1) != (({}.Y + this.Math.rand(10, 20) + 1)))
            {
                if (!this.Tactical.isValidTileSquare(({}.X - 1), ({}.Y - 1)))
                {
                }
                else
                {
                    if (this.Tactical.getTileSquare(({}.X - 1), ({}.Y - 1)).IsSpecialTerrain)
                    {
                    }
                }
            }
            if (true)
            {
            }
        }
        if (true)
        {
        }
        this.MapGen.get("tactical.patch.hill_tundra").fill({}, _properties);
    }
    if (6 != 0)
    {
        {}.X = this.Math.rand(1, (_rect.W - this.Math.rand(this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMinX(), 8), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxX(), 20))));
        {}.Y = this.Math.rand(1, (_rect.H - this.Math.rand(this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMinY(), 8), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxY(), 20))));
        []["this.Math.rand(0, ([].len() - 1))"].fill({}, _properties);
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
            if (this.Math.rand(1, 100) > (100 - ((((0 + 19) + 19) + 19) * 10)))
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
            }
            if (this.Math.rand(1, 100) < 40)
            {
                this.MapGen.get("tactical.tile.tundra1").fill({}, _properties);
            }
            if (this.Math.rand(1, 100) < 80)
            {
                this.MapGen.get("tactical.tile.tundra3").fill({}, _properties);
            }
            if (this.Math.rand(1, 100) < 90)
            {
                this.MapGen.get("tactical.tile.tundra4").fill({}, _properties);
            }
            this.MapGen.get("tactical.tile.tundra4").fill({}, _properties);
        }
    }
    this.makeBordersImpassable(_rect);
    return;
}

function init(this)
{
    this.m.Name = "tactical.hills_tundra";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
