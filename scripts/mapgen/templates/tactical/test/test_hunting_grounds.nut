// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/test/test_hunting_grounds.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    [].push(this.MapGen.get("tactical.test_forest"));
    this.MapGen.get("tactical.test_plains_clearing_leveled").fill({}, _properties);
    if (10 != 0)
    {
        {}.X = this.Math.rand(1, (_rect.W - this.Math.rand(25, 25)));
        {}.Y = this.Math.rand(1, (_rect.H - this.Math.rand(25, 25)));
        []["this.Math.rand(0, ([].len() - 1))"].fill({}, _properties);
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if ((_rect.Y <= 19) && (_rect.Y <= 19) && (_rect.Y <= 19))
            {
                return ((_rect.Y <= 19) && (_rect.Y <= 19) && (_rect.Y <= 19));
                this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
            }
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
            if (this.Math.rand(0, 100) > (100 - ((((0 + 19) + 19) + 19) * 25)))
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

function init(this)
{
    this.m.Name = "tactical.test_hunting_grounds";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
