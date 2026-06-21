// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/test/test_marshland.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
            {
            }
            else
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
                if ((_rect.Y == ((_rect.Y + _rect.H) - 1) || (_rect.Y == ((_rect.Y + _rect.H) - 1)) || (_rect.Y == ((_rect.Y + _rect.H) - 1))))
                {
                    return ((_rect.Y == ((_rect.Y + _rect.H) - 1)) || (_rect.Y == ((_rect.Y + _rect.H) - 1)) || (_rect.Y == ((_rect.Y + _rect.H) - 1)));
                    if (this.Math.rand(0, 100) < 33)
                    {
                        this.MapGen.get("tactical.tile.earth1").fill({}, _properties, 1);
                    }
                    if (this.Math.rand(0, 100) < 66)
                    {
                        this.MapGen.get("tactical.tile.grass2").fill({}, _properties, 1);
                    }
                    this.MapGen.get("tactical.tile.swamp").fill({}, _properties, 1);
                }
                if ((_rect.Y == ((_rect.Y + _rect.H) - 2) || (_rect.Y == ((_rect.Y + _rect.H) - 2)) || (_rect.Y == ((_rect.Y + _rect.H) - 2))))
                {
                    return ((_rect.Y == ((_rect.Y + _rect.H) - 2)) || (_rect.Y == ((_rect.Y + _rect.H) - 2)) || (_rect.Y == ((_rect.Y + _rect.H) - 2)));
                    if (this.Math.rand(0, 100) < 25)
                    {
                        this.MapGen.get("tactical.tile.earth1").fill({}, _properties, 1);
                    }
                    if (this.Math.rand(0, 100) < 50)
                    {
                        this.MapGen.get("tactical.tile.grass2").fill({}, _properties, 1);
                    }
                    this.MapGen.get("tactical.tile.swamp").fill({}, _properties, 1);
                }
                if (this.Math.rand(0, 100) < 9)
                {
                    this.MapGen.get("tactical.tile.earth1").fill({}, _properties, 1);
                }
                if (this.Math.rand(0, 100) < 18)
                {
                    this.MapGen.get("tactical.tile.grass2").fill({}, _properties, 1);
                }
                this.MapGen.get("tactical.tile.swamp").fill({}, _properties, 1);
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != this.Const.Tactical.TerrainType.Swamp)
            {
            }
            else
            {
                if (!this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty)
                {
                }
                this.MapGen.get("tactical.tile.swamp").fill({}, _properties, 2);
            }
        }
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.test_marshland";
    this.m.MinX = 10;
    this.m.MinY = 10;
    return;
}
