// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tactical_tundra.nut
// Functions: 3

function campify(this, _rect, _properties)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(((_rect.X + (_rect.W / 2) + _properties.ShiftX), ((_rect.Y + (_rect.H / 2)) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) <= (this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius)))
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
                if (this.Math.rand(1, 100) <= 50)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = 0;
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                    if (this.Math.rand(1, 2) == 1)
                    {
                        this.MapGen.get("tactical.tile.tundra2").fill({}, null);
                    }
                    else
                    {
                        if (this.Math.rand(1, 2) == 2)
                        {
                            this.MapGen.get("tactical.tile.tundra3").fill({}, null);
                        }
                    }
                }
            }
            if ((this.Math.rand(1, 100) <= 4) && (this.Math.rand(1, 100) <= 4) && (this.Math.rand(1, 100) <= 4))
            {
                return ((this.Math.rand(1, 100) <= 4) && (this.Math.rand(1, 100) <= 4) && (this.Math.rand(1, 100) <= 4));
                if (0 < 6)
                {
                    if (!this.Tactical.getTileSquare(_rect.X, _rect.Y).hasNextTile(0))
                    {
                    }
                    else
                    {
                        if (!this.Tactical.getTileSquare(_rect.X, _rect.Y).getNextTile(0).IsEmpty)
                        {
                        }
                    }
                }
                if (false)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/tree_stump2");
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
    if (12 != 0)
    {
        {}.X = this.Math.rand(1, (_rect.W - this.Math.rand(this.Math.max([]["this.Math.rand(0, ([].len() - 1))"].getMinX(), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxX(), 6)), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxX(), 12))));
        {}.Y = this.Math.rand(1, (_rect.H - this.Math.rand(this.Math.max([]["this.Math.rand(0, ([].len() - 1))"].getMinY(), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxY(), 6)), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxY(), 12))));
        []["this.Math.rand(0, ([].len() - 1))"].fill({}, _properties);
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
            {
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
                if (this.Math.rand(1, 100) > (this.Math.rand(90, 100) - ((((0 + 16) + 16) + 16) * 25)))
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                }
                if (this.Math.rand(1, 4) == 1)
                {
                    this.MapGen.get("tactical.tile.tundra1").fill({}, _properties);
                }
                else
                {
                    if (this.Math.rand(1, 4) == 2)
                    {
                        this.MapGen.get("tactical.tile.tundra2").fill({}, _properties);
                    }
                    else
                    {
                        if (this.Math.rand(1, 4) == 3)
                        {
                            this.MapGen.get("tactical.tile.tundra3").fill({}, _properties);
                        }
                        else
                        {
                            if (this.Math.rand(1, 4) == 4)
                            {
                                this.MapGen.get("tactical.tile.tundra4").fill({}, _properties);
                            }
                        }
                    }
                }
            }
        }
    }
    this.makeBordersImpassable(_rect);
    return;
}

function init(this)
{
    this.m.Name = "tactical.tundra";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
