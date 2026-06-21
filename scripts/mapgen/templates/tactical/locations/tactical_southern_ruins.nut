// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/locations/tactical_southern_ruins.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (_properties.Template["1"] != null)
    {
    }
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
                    if ((_rect.Y == (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY).SquareCoords.Y + 2)) && (_rect.Y == (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.Y + 2)) && (_rect.Y == (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.Y + 2))))
                    {
                        return ((_rect.Y == (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.Y + 2)) && (_rect.Y == (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.Y + 2)) && (_rect.Y == (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.Y + 2)));
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
                        if ((!(this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY).Level == 3)) && (!(this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).Level == 3))))
                        {
                            return ((!(this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).Level == 3)) && (!(this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).Level == 3)));
                        }
                        else
                        {
                            if (_properties.Fortification == this.Const.Tactical.FortificationType.Walls)
                            {
                            }
                            else
                            {
                                if (_properties.Fortification == this.Const.Tactical.FortificationType.WallsAndPalisade)
                                {
                                    if (this.Math.rand(1, 100) <= 40)
                                    {
                                    }
                                }
                            }
                        }
                        if (this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/southern_ruins_wall") != null)
                        {
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/southern_ruins_wall").setDirBasedOnCenter(this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)), (this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius));
                        }
                    }
                }
                else
                {
                    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty)
                    {
                        return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty);
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
                            else
                            {
                                if (null != null)
                                {
                                    null.spawnDetail(this.Tactical.getTileSquare(_rect.X, _rect.Y), this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)), (_properties.Fortification != 0), (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).Level == 3));
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
    this.m.Name = "tactical.southern_ruins";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
