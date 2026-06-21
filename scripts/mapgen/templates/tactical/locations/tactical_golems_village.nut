// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/locations/tactical_golems_village.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if ((this.Math <= 50) && (this.Math <= 50))
            {
                return ((this.Math <= 50) && (this.Math <= 50));
                this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
            }
            else
            {
                if (this.Math.rand(1, 100) <= 10)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                    if (this.Math.rand(1, 4) == 1)
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/graveyard_ruins");
                    }
                    else
                    {
                        if (this.Math.rand(1, 4) == 2)
                        {
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/graveyard_sarcophagus");
                        }
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/graveyard_ruins_big");
                    }
                }
                else
                {
                    if (this.Math.rand(1, 100) <= 20)
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/graveyard_grave");
                    }
                    else
                    {
                        if (this.Math.rand(1, 100) <= 30)
                        {
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(("graveyard_" + []["this.Math.rand(0, ([].len() - 1))"]));
                        }
                    }
                }
            }
        }
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.golems_village";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
