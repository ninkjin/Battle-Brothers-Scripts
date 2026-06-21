// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/locations/tactical_goblin_camp.nut
// Functions: 3

function fill(this, _rect, _properties, _pass)
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
                if (_properties.Fortification != 0)
                {
                }
                if (this.Math.rand(1, 100) <= 75)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
                }
                if ((this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > 1) && (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > 1) && (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > 1) && (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > 1) && (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > 1)))
                {
                    return ((this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > 1) && (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > 1) && (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > 1) && (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > 1) && (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > 1));
                    if (0 < 6)
                    {
                        if (!this.Tactical.getTileSquare(_rect.X, _rect.Y).hasNextTile(0))
                        {
                        }
                        else
                        {
                            if (!this.Tactical.getTileSquare(_rect.X, _rect.Y).getNextTile(0).IsEmpty)
                            {
                            }
                        }
                    }
                    if (this.Math.rand(1, 100) <= (2 + ((0 + 15) * 2)))
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                        if (this.Math.rand(1, 3) == 1)
                        {
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/orc_camp_large_remains");
                        }
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/goblin_camp_supplies");
                    }
                }
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if ((this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY).Level == 3) && (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).Level == 3)))
            {
                return ((this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).Level == 3) && (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).Level == 3));
            }
            if ((this.Math.rand(1, 100) <= 1) && (this.Math.rand(1, 100) <= 1) && (this.Math.rand(1, 100) <= 1))
            {
                return ((this.Math.rand(1, 100) <= 1) && (this.Math.rand(1, 100) <= 1) && (this.Math.rand(1, 100) <= 1));
                this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/orc_camp_head").setVariant(0);
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/orc_camp_head").setFlipped((_rect.X < ((_rect.X + _rect.W) / 2)));
            }
            if ((this.Math.rand(1, 100) <= 1) && (this.Math.rand(1, 100) <= 1) && (this.Math.rand(1, 100) <= 1))
            {
                return ((this.Math.rand(1, 100) <= 1) && (this.Math.rand(1, 100) <= 1) && (this.Math.rand(1, 100) <= 1));
                this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/orc_camp_head").setVariant(1);
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/orc_camp_head").setFlipped((_rect.X < ((_rect.X + _rect.W) / 2)));
            }
            if ((this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > (this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius)) && (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > (this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius))))
            {
                return ((this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > (this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius)) && (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) > (this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius)));
            }
            else
            {
                if ((_rect.X != (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY).SquareCoords.X - 4)) && (_rect.X != (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.X - 4)) && (_rect.X != (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.X - 4))))
                {
                    return ((_rect.X != (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.X - 4)) && (_rect.X != (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.X - 4)) && (_rect.X != (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.X - 4)));
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                    if ((_rect.Y == (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY).SquareCoords.Y - 2)) && (_rect.Y == (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.Y - 2)) && (_rect.Y == (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.Y - 2))))
                    {
                        return ((_rect.Y == (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.Y - 2)) && (_rect.Y == (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.Y - 2)) && (_rect.Y == (this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).SquareCoords.Y - 2)));
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
                        if (_properties.Fortification == this.Const.Tactical.FortificationType.Palisade)
                        {
                        }
                        else
                        {
                            if (_properties.Fortification == this.Const.Tactical.FortificationType.Walls)
                            {
                            }
                            if (this.Math.rand(1, 100) <= 50)
                            {
                            }
                        }
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/graveyard_wall").setDirBasedOnCenter(this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)), (this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius));
                        if (0 < 6)
                        {
                            if (!this.Tactical.getTileSquare(_rect.X, _rect.Y).hasNextTile(0))
                            {
                            }
                            else
                            {
                                if ((this.Tactical.getTileSquare(_rect.X, _rect.Y).getNextTile(0).getDistanceTo.Level > this.Tactical.getTileSquare(_rect.X, _rect.Y).Level) && (this.Tactical.getTileSquare(_rect.X, _rect.Y).getNextTile(0).getDistanceTo.Level > this.Tactical.getTileSquare(_rect.X, _rect.Y).Level))
                                {
                                    return ((this.Tactical.getTileSquare(_rect.X, _rect.Y).getNextTile(0).getDistanceTo.Level > this.Tactical.getTileSquare(_rect.X, _rect.Y).Level) && (this.Tactical.getTileSquare(_rect.X, _rect.Y).getNextTile(0).getDistanceTo.Level > this.Tactical.getTileSquare(_rect.X, _rect.Y).Level));
                                    this.Tactical.getTileSquare(_rect.X, _rect.Y).getNextTile(0).Level = this.Tactical.getTileSquare(_rect.X, _rect.Y).Level;
                                }
                                else
                                {
                                    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).getNextTile(0).getDistanceTo(this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)) == this.Tactical.getTileSquare(((_rect.W / 2) + _properties.ShiftX), ((_rect.H / 2) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y))))
                                    {
                                        this.Tactical.getTileSquare(_rect.X, _rect.Y).IsSpecialTerrain = true;
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty)
                    {
                        return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty);
                        if (0 < 6)
                        {
                            if (!this.Tactical.getTileSquare(_rect.X, _rect.Y).hasNextTile(0))
                            {
                            }
                            else
                            {
                                if (!this.Tactical.getTileSquare(_rect.X, _rect.Y).getNextTile(0).IsEmpty)
                                {
                                }
                            }
                        }
                        if ((this.Math <= 1) && (this.Math <= 1))
                        {
                            return ((this.Math <= 1) && (this.Math <= 1));
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/orc_camp_fireplace");
                        }
                        else
                        {
                            if ((this.Math <= 1) && (this.Math <= 1))
                            {
                                return ((this.Math <= 1) && (this.Math <= 1));
                                this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/goblin_camp_brazier");
                            }
                            else
                            {
                                if ((this.Math <= 1) && (this.Math <= 1))
                                {
                                    return ((this.Math <= 1) && (this.Math <= 1));
                                    this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                                    this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/goblin_camp_weapon_display");
                                }
                                else
                                {
                                    if ((this.Math <= 1) && (this.Math <= 1))
                                    {
                                        return ((this.Math <= 1) && (this.Math <= 1));
                                        this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                                        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/goblin_camp_standard");
                                    }
                                    else
                                    {
                                        if ((this.Math <= 1) && (this.Math <= 1))
                                        {
                                            return ((this.Math <= 1) && (this.Math <= 1));
                                            this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                                            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/goblin_camp_cage");
                                        }
                                        else
                                        {
                                            if ((this.Math <= 6) && (this.Math <= 6))
                                            {
                                                return ((this.Math <= 6) && (this.Math <= 6));
                                                this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                                                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(("goblins_" + []["this.Math.rand(0, ([].len() - 1))"]));
                                            }
                                            else
                                            {
                                                if ((this.Math <= 2) && (this.Math <= 2))
                                                {
                                                    return ((this.Math <= 2) && (this.Math <= 2));
                                                    this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                                                    this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(("goblins_" + []["this.Math.rand(0, ([].len() - 1))"]));
                                                }
                                            }
                                        }
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
    this.m.Name = "tactical.goblin_camp";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}

function spawnDetail(this, _tile, _distance, _hasPalisade, _isOnHill)
{
    if (_isOnHill && _isOnHill)
    {
        return (_isOnHill && _isOnHill);
    }
    if ((this.Math <= 6) && (this.Math <= 6))
    {
        return ((this.Math <= 6) && (this.Math <= 6));
        _tile.clear();
        _tile.spawnDetail(("goblins_" + []["this.Math.rand(0, ([].len() - 1))"]));
    }
    else
    {
        if ((this.Math <= 2) && (this.Math <= 2))
        {
            return ((this.Math <= 2) && (this.Math <= 2));
            _tile.clear();
            _tile.spawnDetail(("goblins_" + []["this.Math.rand(0, ([].len() - 1))"]));
        }
    }
    return;
}
