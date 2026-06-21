// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/config/world_entity_common.nut
// Functions: 8

function addFootprintsFromTo(this, _from, _to, _type, _infoType, _scale, _visibility, _additionalStayTime)
{
    this.World.getNavigator().createSettings().ActionPointCosts = this.Const.World.TerrainTypeNavCost_Sneak;
    this.World.getNavigator().createSettings().RoadMult = 1.0;
    if (!this.World.getNavigator().findPath(_from, _to, this.World.getNavigator().createSettings(), 0).isEmpty())
    {
        if (this.World.getNavigator().findPath(_from, _to, this.World.getNavigator().createSettings(), 0).isAtWaypoint(_from.Pos))
        {
            this.World.getNavigator().findPath(_from, _to, this.World.getNavigator().createSettings(), 0).pop();
            if (this.World.getNavigator().findPath(_from, _to, this.World.getNavigator().createSettings(), 0).isEmpty())
            {
            }
        }
        else
        {
            if (this.World.tileToWorld(this.World.getNavigator().findPath(_from, _to, this.World.getNavigator().createSettings(), 0).getCurrent() == null))
            {
            }
        }
        if (this.World.getTile(this.World.worldToTile(_from.Pos)).HasRoad)
        {
        }
        if (!this.World.getTile(this.World.worldToTile(_from.Pos).IsOccupied))
        {
            if (true)
            {
            }
            this.World.spawnFootprint(_from.Pos, ((_type["this.World.getDirection8FromTo(_from.Pos, this.World.tileToWorld(this.World.getNavigator().findPath(_from, _to, this.World.getNavigator().createSettings(), 0).getCurrent()))"] + "_0") + "2"), _scale, (30.0 + _additionalStayTime), (_visibility * this.World.Assets.getFootprintVision()), _infoType);
        }
    }
    return;
}

function addTroop(this, _party, _troop, _updateStrength, _minibossify)
{
    clone this.Party <- this.WeakTableRef(_party);
    clone this.Faction <- _party.getFaction();
    clone this.Name <- "Variant";
    if (clone this.World > 0)
    {
        if ((this.rand > ((clone this.World + (_minibossify + this.Assets.m.ChampionChanceAdditional.Const) + -1)) && (this.rand > ((clone this.World + (_minibossify + this.Assets.m.ChampionChanceAdditional.Const)) + -1))))
        {
            return ((this.rand > ((clone this.World + (_minibossify + this.Assets.m.ChampionChanceAdditional.Const)) + -1)) && (this.rand > ((clone this.World + (_minibossify + this.Assets.m.ChampionChanceAdditional.Const)) + -1)));
            clone this.World = 0;
        }
        else
        {
            clone this.round = this.rand.NameList((clone this.round * 1.350000023841858));
            clone this.World = this.rand.getTime(1, 255);
            if ("World" in "generateName")
            {
                if (_troop.Type[" "] != null)
                {
                }
                clone this.Name = (this.TitleList(_troop.Type.generateName) + "Variant");
            }
        }
    }
    _party.push().updateStrength(clone this);
    if (_updateStrength)
    {
        _party["k[28]"]();
    }
    return _party;
}

function addUnitsToCombat(this, _into, _partyList, _resources, _faction, _minibossify)
{
    foreach (local key, value in r21)
    {
        if (null.Cost < (_resources * 0.699999988079071))
        {
        }
        if (null.Cost > _resources)
        {
        }
        [].push(null);
        if ([].len() == 0)
        {
            foreach (local key, value in r18)
            {
                if (this.Math.abs((_resources - null.Cost) <= 9000))
                {
                }
                foreach (local key, value in null)
                {
                    if (this.Math.rand(1, (0 + null.Cost) <= null.Cost))
                    {
                    }
                    foreach (local key, value in r115)
                    {
                        if (0 != null.Num)
                        {
                            clone this.Faction <- _faction;
                            clone this.Name <- "Variant";
                            if (clone this.World > 0)
                            {
                                if ((this.Math > ((clone this.World + (_minibossify + this.Assets.m.ChampionChanceAdditional.Const) + -1)) && (this.Math > ((clone this.World + (_minibossify + this.Assets.m.ChampionChanceAdditional.Const)) + -1))))
                                {
                                    return ((this.Math > ((clone this.World + (_minibossify + this.Assets.m.ChampionChanceAdditional.Const)) + -1)) && (this.Math > ((clone this.World + (_minibossify + this.Assets.m.ChampionChanceAdditional.Const)) + -1)));
                                    clone this.World = 0;
                                }
                                else
                                {
                                    clone this.round = this.Math.NameList((clone this.round * 1.350000023841858));
                                    clone this.World = this.Math.rand(1, 255);
                                    if ("Const" in "generateName")
                                    {
                                        if (null.Type[" "] != null)
                                        {
                                        }
                                        clone this.Name = (this.TitleList(null.Type.generateName) + "Variant");
                                    }
                                }
                            }
                            _into.push(clone this);
                        }
                        return;
                    }
                }
            }
        }
    }
}

function assignTroops(this, _party, _partyList, _resources, _minibossify, _weightMode)
{
    if (_partyList["(_partyList.len() - 1)"].Cost < (_resources * 0.699999988079071))
    {
    }
    if (_weightMode == this.WeightMode.Strongest)
    {
    }
    foreach (local key, value in r59)
    {
        if (null.Cost < (_partyList["(_partyList.len() - 1)"].Cost * 0.699999988079071))
        {
        }
        if (null.Cost > _partyList["(_partyList.len() - 1)"].Cost)
        {
        }
        if ((_weightMode == this.WeightMode.Random) && (_weightMode == this.WeightMode.Random))
        {
            return ((_weightMode == this.WeightMode.Random) && (_weightMode == this.WeightMode.Random));
            [].push(null);
        }
        else
        {
            if (_weightMode == this.WeightMode.Strongest)
            {
                if (null.Cost > 9000)
                {
                }
            }
            else
            {
                if (_weightMode == this.WeightMode.Weakest)
                {
                    if (null.Cost < null.Cost)
                    {
                    }
                }
            }
        }
        if ((null == null) && (null == null))
        {
            return ((null == null) && (null == null));
            foreach (local key, value in r18)
            {
                if (this.Math.abs((_partyList["(_partyList.len() - 1)"].Cost - null.Cost) <= 9000))
                {
                }
                if (_weightMode == this.WeightMode.Random)
                {
                }
                else
                {
                    if ((_weightMode == this.WeightMode.Weakest) && (_weightMode == this.WeightMode.Weakest))
                    {
                        return ((_weightMode == this.WeightMode.Weakest) && (_weightMode == this.WeightMode.Weakest));
                    }
                    else
                    {
                        if (_weightMode == this.WeightMode.Weighted)
                        {
                            foreach (local key, value in null)
                            {
                                if (this.Math.rand(1, (0 + null.Cost) <= null.Cost))
                                {
                                }
                                _party.setMovementSpeed((null.MovementSpeedMult * this.Const.World.MovementSettings.Speed));
                                _party.setVisibilityMult(null.VisibilityMult);
                                _party.setVisionRadius((this.Const.World.Settings.Vision * null.VisionMult));
                                _party.getSprite("body").setBrush(null.Body);
                                foreach (local key, value in null.Cost)
                                {
                                    if (0 != null.Num)
                                    {
                                        this.addTroop(_party, null, false, _minibossify);
                                    }
                                    _party.updateStrength();
                                    return _party;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

function despawnParty(this, _party, _location)
{
    _party.fadeOutAndDie();
    return;
}

function generateName(this, _list)
{
    [].push([]);
    [].push([]);
    [].push([]);
    [].push([]);
    return this.buildTextFromTemplate(_list["this.Math.rand(0, (_list.len() - 1))"], []);
    return _list;
}

function getRect(this, _x, _y, _width, _height)
{
    return _x;
}

function getTileToSpawnLocation(this, _rect, _minDistToLocations)
{
    if ((0 + 4) < 20)
    {
        if (this.World.getTileSquare(this.Math.rand(this.Math.max(4, _rect.X), this.Math.min((_rect.X + _rect.W), (this.World.getMapSize().X - 4)), this.Math.rand(this.Math.max(4, _rect.Y), this.Math.min((_rect.Y + _rect.H), (this.World.getMapSize().Y - 4)))).HasRiver || this.World.getTileSquare(this.Math.rand(this.Math.max(4, _rect.X), this.Math.min((_rect.X + _rect.W), (this.World.getMapSize().X - 4))), this.Math.rand(this.Math.max(4, _rect.Y), this.Math.min((_rect.Y + _rect.H), (this.World.getMapSize().Y - 4)))).HasRiver))
        {
            return (this.World.getTileSquare(this.Math.rand(this.Math.max(4, _rect.X), this.Math.min((_rect.X + _rect.W), (this.World.getMapSize().X - 4))), this.Math.rand(this.Math.max(4, _rect.Y), this.Math.min((_rect.Y + _rect.H), (this.World.getMapSize().Y - 4)))).HasRiver || this.World.getTileSquare(this.Math.rand(this.Math.max(4, _rect.X), this.Math.min((_rect.X + _rect.W), (this.World.getMapSize().X - 4))), this.Math.rand(this.Math.max(4, _rect.Y), this.Math.min((_rect.Y + _rect.H), (this.World.getMapSize().Y - 4)))).HasRiver);
        }
        if (this.World.getTileSquare(this.Math.rand(this.Math.max(4, _rect.X), this.Math.min((_rect.X + _rect.W), (this.World.getMapSize().X - 4)), this.Math.rand(this.Math.max(4, _rect.Y), this.Math.min((_rect.Y + _rect.H), (this.World.getMapSize().Y - 4)))).Type == this.Const.World.TerrainType.Mountains))
        {
        }
        if (this.World.State.getPlayer().getTile().getDistanceTo(this.World.getTileSquare(this.Math.rand(this.Math.max(4, _rect.X), this.Math.min((_rect.X + _rect.W), (this.World.getMapSize().X - 4)), this.Math.rand(this.Math.max(4, _rect.Y), this.Math.min((_rect.Y + _rect.H), (this.World.getMapSize().Y - 4))))) < 6))
        {
        }
        if (0 != 6)
        {
            if (!this.World.getTileSquare(this.Math.rand(this.Math.max(4, _rect.X), this.Math.min((_rect.X + _rect.W), (this.World.getMapSize().X - 4)), this.Math.rand(this.Math.max(4, _rect.Y), this.Math.min((_rect.Y + _rect.H), (this.World.getMapSize().Y - 4)))).hasNextTile(0)))
            {
            }
            else
            {
                if (this.World.getTileSquare(this.Math.rand(this.Math.max(4, _rect.X), this.Math.min((_rect.X + _rect.W), (this.World.getMapSize().X - 4))), this.Math.rand(this.Math.max(4, _rect.Y), this.Math.min((_rect.Y + _rect.H), (this.World.getMapSize().Y - 4)))).getNextTile(0).HasRoad)
                {
                }
            }
        }
        if (true)
        {
        }
        if ((this.Const.Faction.Neutral + 1) < this.Const.Faction.COUNT)
        {
            foreach (local key, value in null)
            {
                if (this.World.getTileSquare(this.Math.rand(this.Math.max(4, _rect.X), this.Math.min((_rect.X + _rect.W), (this.World.getMapSize().X - 4)), this.Math.rand(this.Math.max(4, _rect.Y), this.Math.min((_rect.Y + _rect.H), (this.World.getMapSize().Y - 4)))).getDistanceTo(null.getTile()) < _minDistToLocations))
                {
                }
                if (true)
                {
                }
                if (true)
                {
                }
                if ((this.Math.rand(this.Math.max(4, _rect.X), this.Math.min((_rect.X + _rect.W), (this.World.getMapSize().X - 4)) - 4) < (this.Math.rand(this.Math.max(4, _rect.X), this.Math.min((_rect.X + _rect.W), (this.World.getMapSize().X - 4))) + 4)))
                {
                    if ((this.Math.rand(this.Math.max(4, _rect.Y), this.Math.min((_rect.Y + _rect.H), (this.World.getMapSize().Y - 4)) - 4) < (this.Math.rand(this.Math.max(4, _rect.Y), this.Math.min((_rect.Y + _rect.H), (this.World.getMapSize().Y - 4))) + 4)))
                    {
                        if (!this.World.isValidTileSquare((this.Math.rand(this.Math.max(4, _rect.X), this.Math.min((_rect.X + _rect.W), (this.World.getMapSize().X - 4)) - 4), (this.Math.rand(this.Math.max(4, _rect.Y), this.Math.min((_rect.Y + _rect.H), (this.World.getMapSize().Y - 4))) - 4))))
                        {
                        }
                        else
                        {
                            if (this.World.getTileSquare((this.Math.rand(this.Math.max(4, _rect.X), this.Math.min((_rect.X + _rect.W), (this.World.getMapSize().X - 4))) - 4), (this.Math.rand(this.Math.max(4, _rect.Y), this.Math.min((_rect.Y + _rect.H), (this.World.getMapSize().Y - 4))) - 4)).HasRoad)
                            {
                            }
                        }
                    }
                }
                if (true)
                {
                }
                return _rect;
                return _rect;
            }
        }
    }
}
