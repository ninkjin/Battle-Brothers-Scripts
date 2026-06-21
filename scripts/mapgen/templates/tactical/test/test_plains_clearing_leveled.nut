// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/test/test_plains_clearing_leveled.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (this.MapGen.get("tactical.tile.grass1") == this.MapGen.get("tactical.tile.grass1"))
    {
    }
    if (this.MapGen.get("tactical.tile.grass1") == this.MapGen.get("tactical.tile.earth1"))
    {
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
                if ((_rect.Y == ((_rect.Y + _rect.H) - 1) || (_rect.Y == ((_rect.Y + _rect.H) - 1)) || (_rect.Y == ((_rect.Y + _rect.H) - 1))))
                {
                    return ((_rect.Y == ((_rect.Y + _rect.H) - 1)) || (_rect.Y == ((_rect.Y + _rect.H) - 1)) || (_rect.Y == ((_rect.Y + _rect.H) - 1)));
                    if (this.Math.rand(0, 100) < 25)
                    {
                    }
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
                if (this.Math.rand(0, 100) > (98 - ((((0 + 13) + 13) + 13) * 20)))
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                }
                if (this.Math.rand(0, 100) < (this.Math.rand(5, 10) + 20))
                {
                }
                this.MapGen.get("tactical.tile.grass1").fill({}, _properties);
            }
        }
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.test_plains_clearing_leveled";
    this.m.MinX = 10;
    this.m.MinY = 10;
    return;
}
