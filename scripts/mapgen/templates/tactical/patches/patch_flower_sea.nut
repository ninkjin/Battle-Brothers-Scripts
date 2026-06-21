// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/patches/patch_flower_sea.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1)) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2)))
            {
                return ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2));
                if (this.Math.rand(0, 100) < 33)
                {
                }
                else
                {
                    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type == 0)
                    {
                        this.MapGen.get("tactical.tile.grass1").fill({}, _properties);
                    }
                    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty)
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                        if (this.Math.rand(1, 100) < 15)
                        {
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
                        }
                        if (this.Math.rand(1, 100) < 30)
                        {
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
                        }
                        if (this.Math.rand(1, 100) < 45)
                        {
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
                        }
                        if ((this.Math <= 50) && (this.Math <= 50))
                        {
                            return ((this.Math <= 50) && (this.Math <= 50));
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
                        }
                    }
                }
                return;
            }
        }
    }
}

function init(this)
{
    this.m.Name = "tactical.patch.flower_sea";
    this.m.MinX = 4;
    this.m.MaxX = 8;
    this.m.MinY = 4;
    this.m.MaxY = 8;
    return;
}
