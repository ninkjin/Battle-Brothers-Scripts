// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/test/template_canyon.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (4 != 0)
    {
        {}.X = this.Math.rand(1, (_rect.W - this.Math.rand(5, 10)));
        {}.Y = this.Math.rand(1, (_rect.H - this.Math.rand(5, 10)));
        this.MapGen.get("tactical.test_dry_marshland").fill({}, _properties);
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
            {
            }
            if (this.Math.rand(1, 100) < 10)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 2;
            }
            else
            {
                if (this.Math.rand(1, 100) < 15)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 3;
                }
            }
            this.MapGen.get("tactical.tile.earth1").fill({}, _properties);
        }
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.canyon";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
