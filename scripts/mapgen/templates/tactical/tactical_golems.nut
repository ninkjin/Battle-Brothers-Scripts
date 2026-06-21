// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tactical_golems.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    this.MapGen.get("tactical.tile.stone1").m.ChanceToSpawnObject = 7;
    this.MapGen.get("tactical.tile.stone2").m.ChanceToSpawnObject = 4;
    this.MapGen.get("tactical.tile.earth1").m.ChanceToSpawnAltDetails = 0;
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if ((_rect.Y >= ((_rect.Y + _rect.H) - 2) && (_rect.Y >= ((_rect.Y + _rect.H) - 2))))
            {
                return ((_rect.Y >= ((_rect.Y + _rect.H) - 2)) && (_rect.Y >= ((_rect.Y + _rect.H) - 2)));
                if ((_rect.Y >= ((_rect.Y + _rect.H) - 1) || (_rect.Y >= ((_rect.Y + _rect.H) - 1)) || (_rect.Y >= ((_rect.Y + _rect.H) - 1))))
                {
                    return ((_rect.Y >= ((_rect.Y + _rect.H) - 1)) || (_rect.Y >= ((_rect.Y + _rect.H) - 1)) || (_rect.Y >= ((_rect.Y + _rect.H) - 1)));
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 3;
                }
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 2;
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = 0;
                if (this.Math.rand(1, 2) < 2)
                {
                    this.MapGen.get("tactical.tile.stone1").fill({}, _properties, 1);
                }
                this.MapGen.get("tactical.tile.stone2").fill({}, _properties, 1);
            }
            else
            {
                if ((this.Math <= 8) && (this.Math <= 8))
                {
                    return ((this.Math <= 8) && (this.Math <= 8));
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
                }
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
                if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
                {
                }
                else
                {
                    if (this.Math.rand(1, 5) == 1)
                    {
                        this.MapGen.get("tactical.tile.earth1").fill({}, _properties, 1);
                        this.MapGen.get("tactical.tile.earth1").fill({}, _properties, 2);
                    }
                    if (this.Math.rand(1, 5) <= 3)
                    {
                        this.MapGen.get("tactical.tile.stone1").fill({}, _properties, 1);
                        this.MapGen.get("tactical.tile.stone1").fill({}, _properties, 2);
                    }
                    else
                    {
                        if (this.Math.rand(1, 5) <= 5)
                        {
                            this.MapGen.get("tactical.tile.stone2").fill({}, _properties, 1);
                            this.MapGen.get("tactical.tile.stone2").fill({}, _properties, 2);
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
    this.m.Name = "tactical.golems";
    this.m.MinX = 28;
    this.m.MinY = 28;
    return;
}
