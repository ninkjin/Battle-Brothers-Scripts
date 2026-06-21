// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/test/test_template.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (this.Math.rand(1, 100) <= 50)
    {
        while (r16)
        {
            if (true)
            {
                this.MapGen.get("tactical.tile.road").fill({}, _properties);
                this.MapGen.get("tactical.tile.road").fill({}, _properties);
                if (0 == (_rect.W - 1))
                {
                }
                if ((this.Math.rand(0, 100) < 33) && (this.Math.rand(0, 100) < 33))
                {
                    return ((this.Math.rand(0, 100) < 33) && (this.Math.rand(0, 100) < 33));
                }
                else
                {
                    if (((this.Math.rand(5, (_rect.H - 5) + 1) < (_rect.H - 1)) && ((this.Math.rand(5, (_rect.H - 5)) + 1) < (_rect.H - 1))))
                    {
                        return (((this.Math.rand(5, (_rect.H - 5)) + 1) < (_rect.H - 1)) && ((this.Math.rand(5, (_rect.H - 5)) + 1) < (_rect.H - 1)));
                    }
                    else
                    {
                        if (((this.Math.rand(5, (_rect.H - 5) + 13) - 1) >= 1))
                        {
                        }
                    }
                }
            }
            if (this.Math.rand(1, 100) <= 50)
            {
                [].push(this.MapGen.get("tactical.test_hill"));
            }
            if (this.Math.rand(1, 100) <= 33)
            {
                [].push(this.MapGen.get("tactical.test_marshland"));
            }
            if (this.Math.rand(1, 100) <= 33)
            {
                [].push(this.MapGen.get("tactical.test_forest"));
            }
            if (this.Math.rand(1, 100) <= 33)
            {
                [].push(this.MapGen.get("tactical.test_clearing"));
            }
            if ([].len() <= 1)
            {
            }
            if (8 != 0)
            {
                {}.X = this.Math.rand(1, (_rect.W - this.Math.rand(8, 16)));
                {}.Y = this.Math.rand(1, (_rect.H - this.Math.rand(8, 16)));
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
                    if (this.Math.rand(0, 100) > (100 - ((((0 + 18) + 18) + 18) * 25)))
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                    }
                    if (this.Math.rand(0, 100) < 20)
                    {
                        this.MapGen.get("tactical.tile.earth1").fill({}, _properties);
                    }
                    this.MapGen.get("tactical.tile.grass1").fill({}, _properties);
                }
            }
            this.makeBordersImpassable(_rect);
            return;
        }
    }
}

function init(this)
{
    this.m.Name = "tactical.test_template";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
