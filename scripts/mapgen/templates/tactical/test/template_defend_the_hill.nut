// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/test/template_defend_the_hill.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (1 != 0)
    {
        this.MapGen.get("tactical.clear_hill").fill({}, _properties);
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
            {
            }
            this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
            if (this.Math.rand(0, 100) > 94)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
            }
            if ((_rect.Y <= 20) && (_rect.Y <= 20) && (_rect.Y <= 20))
            {
                return ((_rect.Y <= 20) && (_rect.Y <= 20) && (_rect.Y <= 20));
            }
            if (this.Math.rand(0, 100) < 25)
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
    this.m.Name = "tactical.defend_the_hill";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
