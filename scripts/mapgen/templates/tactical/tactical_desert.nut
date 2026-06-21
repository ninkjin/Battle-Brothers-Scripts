// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tactical_desert.nut
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
                if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Level > 0)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = 0;
                    this.MapGen.get("tactical.tile.desert7").fill({}, null);
                }
            }
        }
    }
    return;
}

function fill(this, _rect, _properties, _pass)
{
    this.addRoads(_rect, _properties);
    if (0 < 5)
    {
        [].push(this.MapGen.get("tactical.patch.desert"));
    }
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
        }
    }
    this.makeBordersImpassable(_rect);
    return;
}

function init(this)
{
    this.m.Name = "tactical.desert";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
