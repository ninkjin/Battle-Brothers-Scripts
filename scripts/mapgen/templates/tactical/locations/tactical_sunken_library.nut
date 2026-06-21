// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/locations/tactical_sunken_library.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (!this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
            }
            if (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > (this.Const.Tactical.Settings.CampRadius + 5)))
            {
            }
            else
            {
                if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty)
                {
                    if (this.Math.rand(1, 100) <= 11)
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                        if (this.Math.rand(1, 4) == 1)
                        {
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/southern_ruins");
                        }
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/southern_ruins_big");
                    }
                    if ((this.Math <= 1) && (this.Math <= 1))
                    {
                        return ((this.Math <= 1) && (this.Math <= 1));
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/southern_ruins_statue");
                    }
                    else
                    {
                        if (this.Math.rand(1, 100) <= 20)
                        {
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(("southern_ruins_" + []["this.Math.rand(0, ([].len() - 1))"]));
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
    this.m.Name = "tactical.sunken_library";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
