// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/locations/tactical_arena_floor.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if ((_rect.Y < ((_rect.Y + _rect.H) - 2) && (_rect.Y < ((_rect.Y + _rect.H) - 2)) && (_rect.Y < ((_rect.Y + _rect.H) - 2))))
            {
                return ((_rect.Y < ((_rect.Y + _rect.H) - 2)) && (_rect.Y < ((_rect.Y + _rect.H) - 2)) && (_rect.Y < ((_rect.Y + _rect.H) - 2)));
                if (this.Math.rand(1, 100) <= 3)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Details["this.Math.rand(0, (this.m.Details.len() - 1))"]);
                }
            }
            else
            {
                if (this.Math.rand(1, 100) <= 66)
                {
                    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Coords.X > ((_rect.X + _rect.W) / 2))
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/arena_spectator").setFlipped(true);
                    }
                }
            }
        }
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.arena_floor";
    this.m.MinX = 26;
    this.m.MinY = 26;
    return;
}
