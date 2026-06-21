// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/locations/tactical_golems_lair.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Math <= 50)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
            }
            if (_rect.Y >= ((_rect.H / 2) - 2))
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/autumn_boulder1");
            }
            else
            {
                if ((_rect.Y < ((_rect.Y + _rect.H) - 2) && (_rect.Y < ((_rect.Y + _rect.H) - 2)) && (_rect.Y < ((_rect.Y + _rect.H) - 2))))
                {
                    return ((_rect.Y < ((_rect.Y + _rect.H) - 2)) && (_rect.Y < ((_rect.Y + _rect.H) - 2)) && (_rect.Y < ((_rect.Y + _rect.H) - 2)));
                    if (this.Math.rand(1, 100) <= 3)
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Details["this.Math.rand(0, (this.m.Details.len() - 1))"]);
                    }
                }
                else
                {
                    if (this.Math.rand(1, 100) <= 66)
                    {
                        if (this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/golem_spectator") != null)
                        {
                            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Coords.X > ((_rect.X + _rect.W) / 2))
                            {
                                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/golem_spectator").setFlipped(false);
                            }
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/golem_spectator").setFlipped(true);
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
    this.m.Name = "tactical.golems_lair";
    this.m.MinX = 28;
    this.m.MinY = 28;
    return;
}
