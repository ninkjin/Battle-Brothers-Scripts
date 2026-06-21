// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/locations/tactical_graveyard.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (this.Math.rand(1, 100) <= 80)
    {
        if (_rect.X < (_rect.X + _rect.W))
        {
            if (_rect.Y < (_rect.Y + _rect.H))
            {
                if ((this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > (this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius)) && (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > (this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius))))
                {
                    return ((this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > (this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius)) && (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > (this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius)));
                }
                else
                {
                    if (this.Math.rand(1, 100) <= 50)
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
                    }
                    if ((_rect.Y != this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY).SquareCoords.Y) && (_rect.Y != this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.Y)))
                    {
                        return ((_rect.Y != this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.Y) && (_rect.Y != this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.Y));
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                        if ((this.Math < 50) && (this.Math < 50))
                        {
                            return ((this.Math < 50) && (this.Math < 50));
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/graveyard_wall").setDirBasedOnCenter(this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)), (this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius));
                        }
                    }
                    else
                    {
                        if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty)
                        {
                            return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty);
                            if (this.Math.rand(1, 100) <= 2)
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
                                if (this.Math.rand(1, 100) <= 4)
                                {
                                    this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                                    this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/graveyard_grave");
                                }
                                else
                                {
                                    if (this.Math.rand(1, 100) <= 20)
                                    {
                                        this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                                        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(("graveyard_" + []["this.Math.rand(0, ([].len() - 1))"]));
                                    }
                                }
                            }
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
    this.m.Name = "tactical.graveyard";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
