// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/test/test_road.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    while (r9)
    {
        if (true)
        {
            this.MapGen.get("tactical.tile.road").fill({}, _properties, 1);
            this.MapGen.get("tactical.tile.road").fill({}, _properties, 1);
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
                    if (((this.Math.rand(5, (_rect.H - 5) + 6) - 1) >= 1))
                    {
                    }
                }
            }
        }
        return;
    }
}

function init(this)
{
    this.m.Name = "tactical.test_road";
    this.m.MinX = 8;
    this.m.MinY = 8;
    return;
}
