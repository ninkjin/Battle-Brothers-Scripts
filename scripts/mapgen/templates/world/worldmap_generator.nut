// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/world/worldmap_generator.nut
// Functions: 26

function <anonymous>(this, _a, _b)
{
    if (_a.Score > _b.Score)
    {
        return _a;
    }
    else
    {
        if (_a.Score < _b.Score)
        {
            return _a;
        }
    }
    return _a;
}

function buildAbandonedFortresses(this, _rect)
{
    this.logInfo("Placing abandoned fortresses...");
    if (5 < ((_rect.X + _rect.W) - 5))
    {
        if (28 <= 38)
        {
            if (this.m.WorldTiles["5"]["28"].IsOccupied)
            {
            }
            else
            {
                if ((this.m.WorldTiles["5"]["28"].Type != this.Const.World.TerrainType.Hills) && (this.m.WorldTiles["5"]["28"].Type != this.Const.World.TerrainType.Hills))
                {
                    return ((this.m.WorldTiles["5"]["28"].Type != this.Const.World.TerrainType.Hills) && (this.m.WorldTiles["5"]["28"].Type != this.Const.World.TerrainType.Hills));
                }
                else
                {
                    if (this.m.WorldTiles["5"]["28"].HasRoad)
                    {
                    }
                    else
                    {
                        foreach (local key, value in r21)
                        {
                            if (null.getTile().getDistanceTo(this.m.WorldTiles["5"]["28"]) < 8)
                            {
                            }
                            else
                            {
                                if (null.getTile().getDistanceTo(this.m.WorldTiles["5"]["28"]) <= 20)
                                {
                                }
                            }
                            if (true && true)
                            {
                                return (true && true);
                            }
                            if (0 < 6)
                            {
                                if (!this.m.WorldTiles["5"]["28"].hasNextTile(0))
                                {
                                }
                                else
                                {
                                    if (this.m.WorldTiles["5"]["28"].getNextTile(0).HasRoad)
                                    {
                                    }
                                    if (this.m.WorldTiles["5"]["28"].Type == this.Const.World.TerrainType.Mountains)
                                    {
                                    }
                                    else
                                    {
                                        if (this.m.WorldTiles["5"]["28"].Type == this.Const.World.TerrainType.Hills)
                                        {
                                        }
                                    }
                                }
                            }
                            [].push({});
                            [].sort(function() /* closure #0 */);
                            if (0 < 2)
                            {
                                if (0 < [].len())
                                {
                                    foreach (local key, value in "Score")
                                    {
                                        if (null.getDistanceTo([]["0"].Tile) <= 12)
                                        {
                                        }
                                        if (true)
                                        {
                                        }
                                        else
                                        {
                                            foreach (local key, value in r54)
                                            {
                                                if ((null.SquareCoords.Y > (this.World.Y * r15) && (null.SquareCoords.Y > (this.World.Y * r15))))
                                                {
                                                    return ((null.SquareCoords.Y > (this.World.Y * r15)) && (null.SquareCoords.Y > (this.World.Y * r15)));
                                                }
                                                this.World.getNavigator().createSettings().ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;
                                                if (!this.World.getNavigator().findPath([]["0"].Tile, null.getTile(), this.World.getNavigator().createSettings(), 0).isEmpty())
                                                {
                                                }
                                                if (!false)
                                                {
                                                }
                                                if (0 >= [].len())
                                                {
                                                }
                                                [].push([]["0"].Tile);
                                                this.World.spawnLocation("scripts/entity/world/locations/abandoned_fortress_location", []["0"].Tile.Coords).onSpawned();
                                                return;
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

function buildAdditionalRoads(this, _rect, _properties)
{
    this.logInfo("Building additional roads...");
    this.World.getNavigator().createSettings().ActionPointCosts = [0, 0, 10, 50, 80, 40, 40, 40, 40, 0, 1, 50, 30, 30, 10, 10, 0, 10];
    this.World.getNavigator().createSettings().RoadMult = 0.25;
    this.World.getNavigator().createSettings().StopAtRoad = false;
    if (0 != this.World.EntityManager.getSettlements().len())
    {
        foreach (local key, value in r20)
        {
            if (!null.isConnected())
            {
            }
            if (!null.getTile().HasRoad)
            {
                [].push(null.getTile());
            }
            foreach (local key, value in r192)
            {
                [].push(this.World.EntityManager.getSettlements()["0"].getTile());
                if (this.World.getNavigator().findPath(this.World.EntityManager.getSettlements()["0"].getTile(), null, this.World.getNavigator().createSettings(), 0).getSize() >= 1)
                {
                    [].push(this.World.getTile(this.World.getNavigator().findPath(this.World.EntityManager.getSettlements()["0"].getTile(), null, this.World.getNavigator().createSettings(), 0).getCurrent()));
                    this.World.getNavigator().findPath(this.World.EntityManager.getSettlements()["0"].getTile(), null, this.World.getNavigator().createSettings(), 0).pop();
                }
                foreach (local key, value in r81)
                {
                    if (null.Type == this.Const.World.TerrainType.Hills)
                    {
                    }
                    else
                    {
                        if (null != null)
                        {
                        }
                        if (null < ([].len() - 1))
                        {
                        }
                        if ((null.RoadDirections == 0) && (null.RoadDirections == 0))
                        {
                            return ((null.RoadDirections == 0) && (null.RoadDirections == 0));
                            if (!this.Const.World.RoadBrushes.has(((null.RoadDirections | this.Const.DirectionBit["0"]) | this.Const.DirectionBit["0"])))
                            {
                            }
                        }
                    }
                    if (true)
                    {
                    }
                    foreach (local key, value in r58)
                    {
                        if (null != null)
                        {
                        }
                        if (null < ([].len() - 1))
                        {
                        }
                        if ((null.RoadDirections == 0) && (null.RoadDirections == 0))
                        {
                            return ((null.RoadDirections == 0) && (null.RoadDirections == 0));
                            null.RoadDirections = ((null.RoadDirections | this.Const.DirectionBit["0"]) | this.Const.DirectionBit["0"]);
                        }
                        return;
                    }
                }
            }
        }
    }
}

function buildElevation(this, _rect)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Ocean)
            {
            }
            else
            {
                if ((_rect.Y <= (_rect.H * r7) && (_rect.Y <= (_rect.H * r7))))
                {
                    return ((_rect.Y <= (_rect.H * r7)) && (_rect.Y <= (_rect.H * r7)));
                }
                else
                {
                    if (this.Math.rand(1, 1000) <= 9)
                    {
                        this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = 0;
                        this.m.Tiles["this.Const.World.TerrainType.Mountains"].fill({}, null);
                    }
                }
            }
        }
    }
    if (this.Math.rand(0, 1) == 0)
    {
        if (_rect.X < (_rect.X + _rect.W))
        {
            if (_rect.Y < (_rect.Y + _rect.H))
            {
                if ((this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Mountains) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Mountains))
                {
                    return ((this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Mountains) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Mountains));
                }
                else
                {
                    if (this.Math.rand(1, 100) <= (this.m.WorldTiles["_rect.X"]["_rect.Y"].getSurroundingTilesOfType(this.Const.World.TerrainType.Mountains) * 30))
                    {
                        this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = 0;
                        this.m.Tiles["this.Const.World.TerrainType.Mountains"].fill({}, null);
                    }
                }
            }
        }
    }
    else
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (_rect.X < (_rect.X + _rect.W))
            {
                if ((this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Mountains) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Mountains))
                {
                    return ((this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Mountains) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Mountains));
                }
                else
                {
                    if (this.Math.rand(1, 100) <= (this.m.WorldTiles["_rect.X"]["_rect.Y"].getSurroundingTilesOfType(this.Const.World.TerrainType.Mountains) * 30))
                    {
                        this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = 0;
                        this.m.Tiles["this.Const.World.TerrainType.Mountains"].fill({}, null);
                    }
                }
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type != this.Const.World.TerrainType.Land)
            {
            }
            else
            {
                if (this.Math.rand(1, 100) <= (this.m.WorldTiles["_rect.X"]["_rect.Y"].getSurroundingTilesOfType(this.Const.World.TerrainType.Mountains) * 25))
                {
                    this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.Hills"].fill({}, null);
                }
            }
        }
    }
    if (_rect.Y < (_rect.Y + _rect.H))
    {
        if (_rect.X < (_rect.X + _rect.W))
        {
            if (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type != this.Const.World.TerrainType.Land)
            {
            }
            else
            {
                if (this.Math.rand(1, 100) <= (this.m.WorldTiles["_rect.X"]["_rect.Y"].getSurroundingTilesOfType(this.Const.World.TerrainType.Hills) * 30))
                {
                    this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.Hills"].fill({}, null);
                }
            }
        }
    }
    return;
}

function buildLabels(this, _rect)
{
    this.logInfo("Building regions...");
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Ocean)
            {
            }
            else
            {
                if ((this.World.findNextRegion(this.m.WorldTiles["_rect.X"]["_rect.Y"], 3, this.m.WorldTiles["_rect.X"]["_rect.Y"].Type) < this.m.WorldTiles["_rect.X"]["_rect.Y"]) && (this.World.findNextRegion(this.m.WorldTiles["_rect.X"]["_rect.Y"], 3, this.m.WorldTiles["_rect.X"]["_rect.Y"].Type) < this.m.WorldTiles["_rect.X"]["_rect.Y"]))
                {
                    return ((this.World.findNextRegion(this.m.WorldTiles["_rect.X"]["_rect.Y"], 3, this.m.WorldTiles["_rect.X"]["_rect.Y"].Type) < this.m.WorldTiles["_rect.X"]["_rect.Y"]) && (this.World.findNextRegion(this.m.WorldTiles["_rect.X"]["_rect.Y"], 3, this.m.WorldTiles["_rect.X"]["_rect.Y"].Type) < this.m.WorldTiles["_rect.X"]["_rect.Y"]));
                    this.m.WorldTiles["_rect.X"]["_rect.Y"].Region = this.World.findNextRegion(this.m.WorldTiles["_rect.X"]["_rect.Y"], 3, this.m.WorldTiles["_rect.X"]["_rect.Y"].Type);
                    []["this.World.findNextRegion(this.m.WorldTiles["_rect.X"]["_rect.Y"], 3, this.m.WorldTiles["_rect.X"]["_rect.Y"].Type)"].Tiles.push(this.m.WorldTiles["_rect.X"]["_rect.Y"]);
                }
                this.m.WorldTiles["_rect.X"]["_rect.Y"].Region = [].len();
                [].push({});
            }
        }
    }
    this.logInfo((("Found " + [].len()) + " separate regions."));
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            this.m.WorldTiles["_rect.X"]["_rect.Y"].Region = {ID = [].len(), Type = this.m.WorldTiles["_rect.X"]["_rect.Y"].Type, Tiles = []};
        }
    }
    foreach (local key, value in r245)
    {
        if (null.Tiles.len() < 80)
        {
        }
        if (this.Const.Strings.TerrainRegionNames["null.Type"].len() == 0)
        {
        }
        foreach (local key, value in null.Tiles)
        {
            if (this.World.findNextTileOfType(this.World.getTile(this.World.worldToTile(this.createVec(((0.0 + null.Pos.X) / null.Tiles.len()), ((0.0 + null.Pos.Y) / null.Tiles.len())))), 9, null.Type, {}))
            {
            }
            this.logInfo("Failed to find decent spot for region label.");
            foreach (local key, value in r27)
            {
                if (null.Pos.X <= ((0.0 + null.Pos.X) / null.Tiles.len()))
                {
                }
                if ((0 <= 1000) && (0 <= 1000))
                {
                    return ((0 <= 1000) && (0 <= 1000));
                }
                if (0 > 1000)
                {
                }
                [].push(this.Const.Strings.TerrainRegionNames["null.Type"]["this.Math.find(0, (this.Const.Strings.TerrainRegionNames["null.Type"].len() - 1))"]);
                if (null.Tiles.len() <= 130)
                {
                }
                else
                {
                    if (null.Tiles.len() <= 170)
                    {
                    }
                }
                this.World.Name(this.Const.Strings.TerrainRegionNames["null.Type"]["this.Math.find(0, (this.Const.Strings.TerrainRegionNames["null.Type"].len() - 1))"], 0.75, (this.Math.getAngleTo(this.createVec(((0.0 + null.Pos.X) / (0 + 16)), ((0.0 + null.Pos.Y) / (0 + 16))), this.createVec(((0.0 + null.Pos.X) / (0 + 17)), ((0.0 + null.Pos.Y) / (0 + 17)))) + 90.0), {}.Result.Pos);
                [].push({});
                foreach (local key, value in null)
                {
                    null.Region = [].len();
                    this.logInfo(((" regions..." + [].len()) + "State"));
                    if (_rect.X < (_rect.X + _rect.W))
                    {
                        if (_rect.Y < (_rect.Y + _rect.H))
                        {
                            if ((this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Ocean) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Ocean))
                            {
                                return ((this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Ocean) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Ocean));
                            }
                            this.m.WorldTiles["_rect.X"]["_rect.Y"].Region = this.World.findNextRegion(this.m.WorldTiles["_rect.X"]["_rect.Y"], 16, 0);
                        }
                    }
                    this.World.Regions.m["k[43]"] = [];
                    return;
                }
            }
        }
    }
}

function buildLandAndSea(this, _rect)
{
    this.logInfo("Building land and sea...");
    if ((!(this.Math.rand(0, 1) == 1) && (!(this.Math.rand(0, 1) == 1)) && (!(this.Math.rand(0, 1) == 1))))
    {
        return ((!(this.Math.rand(0, 1) == 1)) && (!(this.Math.rand(0, 1) == 1)) && (!(this.Math.rand(0, 1) == 1)));
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (_rect.X < (_rect.W * 0.5))
            {
            }
            if (_rect.Y < (_rect.H * 0.5))
            {
            }
            if (this.Math.rand(0, 1) == 1)
            {
                if (_rect.X < (_rect.W * 0.5))
                {
                }
            }
            if (this.Math.rand(0, 1) == 1)
            {
                if (_rect.X > (_rect.W * 0.5))
                {
                }
            }
            if (this.Math.rand(0, 1) == 1)
            {
                if (_rect.Y < (_rect.H * 0.5))
                {
                }
            }
            if (this.Math.rand(0, 1) == 1)
            {
                if (_rect.Y > (_rect.H * 0.5))
                {
                }
            }
            if (this.Math.rand(1, 100) <= (((((((_rect.W - _rect.X) + (_rect.H - _rect.Y) + 0) + 0) + 0) + 0) * this.Const.World.Settings.LandMassMult)))
            {
                this.m.Tiles["this.Const.World.TerrainType.Plains"].fill({}, null);
                this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = this.Const.World.TerrainType.Land;
            }
            this.m.Tiles["this.Const.World.TerrainType.Ocean"].fill({}, null);
            this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = this.Const.World.TerrainType.Ocean;
        }
    }
    if (this.Math.rand(0, 1) == 0)
    {
        if (_rect.X < (_rect.X + _rect.W))
        {
            if (_rect.Y < (_rect.Y + _rect.H))
            {
                if (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Ocean)
                {
                }
                else
                {
                    if (this.Math.rand(1, 100) <= (this.m.WorldTiles["_rect.X"]["_rect.Y"].getSurroundingTilesOfType(this.Const.World.TerrainType.Ocean) * this.Const.World.Settings.WaterConnectivity))
                    {
                        this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = 0;
                        this.m.Tiles["this.Const.World.TerrainType.Ocean"].fill({}, null);
                    }
                }
            }
        }
    }
    else
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (_rect.X < (_rect.X + _rect.W))
            {
                if (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Ocean)
                {
                }
                else
                {
                    if (this.Math.rand(1, 100) <= (this.m.WorldTiles["_rect.X"]["_rect.Y"].getSurroundingTilesOfType(this.Const.World.TerrainType.Ocean) * this.Const.World.Settings.WaterConnectivity))
                    {
                        this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = 0;
                        this.m.Tiles["this.Const.World.TerrainType.Ocean"].fill({}, null);
                    }
                }
            }
        }
    }
    if (!false)
    {
        if (_rect.X < (_rect.X + _rect.W))
        {
            if (_rect.Y < (_rect.Y + _rect.H))
            {
                if (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type == this.Const.World.TerrainType.Ocean)
                {
                }
                else
                {
                    if (this.m.WorldTiles["_rect.X"]["_rect.Y"].getSurroundingTilesNotOfType(this.Const.World.TerrainType.Ocean) <= 1)
                    {
                        this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = {X = _rect.X, Y = _rect.Y, W = 1, H = 1, IsEmpty = true};
                        this.m.Tiles["this.Const.World.TerrainType.Ocean"].fill({}, null);
                    }
                }
            }
        }
    }
    return;
}

function buildRoadSprites(this, _rect, _properties)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (!this.m.WorldTiles["_rect.X"]["_rect.Y"].HasRoad)
            {
            }
            if ((!this.m.WorldTiles["_rect.X"]["_rect.Y"].IsOccupied) && (!this.m.WorldTiles["_rect.X"]["_rect.Y"].IsOccupied))
            {
                return ((!this.m.WorldTiles["_rect.X"]["_rect.Y"].IsOccupied) && (!this.m.WorldTiles["_rect.X"]["_rect.Y"].IsOccupied));
                [].resize(this.Const.World.TerrainType.COUNT, 0);
                if (0 < 6)
                {
                    if (!this.m.WorldTiles["_rect.X"]["_rect.Y"].hasNextTile(0))
                    {
                    }
                    else
                    {
                        if ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Mountains) || (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Mountains) || (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Mountains))
                        {
                            return ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Mountains) || (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Mountains) || (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Mountains));
                        }
                    }
                }
                foreach (local key, value in 0)
                {
                    if (null > 0)
                    {
                    }
                    if (null == 0)
                    {
                    }
                    this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = 0;
                    this.m.WorldTiles["_rect.X"]["_rect.Y"].clearAllBut(this.Const.World.DetailType.Houses);
                    this.m.Tiles["this.Const.World.TerrainType.Plains"].fill({}, _properties, 1);
                    this.m.Tiles["this.Const.World.TerrainType.Plains"].fill({}, _properties, 2);
                    this.m.WorldTiles["_rect.X"]["_rect.Y"].clear(((this.Const.World.DetailType.Road | this.Const.World.DetailType.Swamp) | this.Const.World.DetailType.NotCompatibleWithRoad));
                    if ("Type" in "onRoadPass")
                    {
                        this.m.Tiles["this.m.WorldTiles["_rect.X"]["_rect.Y"].Type"].onRoadPass({});
                    }
                    this.m.WorldTiles["_rect.X"]["_rect.Y"].spawnDetail(this.Const.World.RoadBrushes.get(this.m.WorldTiles["_rect.X"]["_rect.Y"].RoadDirections), this.Const.World.ZLevel.Road, this.Const.World.DetailType.Road, false);
                    return;
                }
            }
        }
    }
}

function buildRoads(this, _rect, _properties)
{
    this.logInfo("Building roads...");
    [].resize(this.World.EntityManager.getSettlements().len());
    if (0 != this.World.EntityManager.getSettlements().len())
    {
        []["0"] = [];
        []["0"].resize(this.World.EntityManager.getSettlements().len(), false);
    }
    this.World.getNavigator().createSettings().ActionPointCosts = [0, 0, 10, 50, 60, 40, 40, 40, 40, 0, 1, 50, 30, 30, 10, 10, 0, 10, 10];
    this.World.getNavigator().createSettings().RoadMult = 0.15000000596046448;
    this.World.getNavigator().createSettings().StopAtRoad = false;
    if (0 != this.World.EntityManager.getSettlements().len())
    {
        if ((0 < 50) && (0 < 50))
        {
            return ((0 < 50) && (0 < 50));
            if (0 != this.World.EntityManager.getSettlements().len())
            {
                if (0 == 0)
                {
                }
                else
                {
                    if ([]["0"]["0"] == true)
                    {
                    }
                    else
                    {
                        if (this.World.EntityManager.getSettlements()["0"].getTile().getDistanceTo(this.World.EntityManager.getSettlements()["0"].getTile() < 9000))
                        {
                        }
                    }
                }
            }
            if (this.World.EntityManager.getSettlements()["0"].getTile() != null)
            {
                []["0"]["0"] = true;
                []["0"]["0"] = true;
                if (!this.World.getNavigator().findPath(this.World.EntityManager.getSettlements()["0"].getTile(), this.World.EntityManager.getSettlements()["0"].getTile(), this.World.getNavigator().createSettings(), 0).isEmpty())
                {
                }
                [].push(this.World.EntityManager.getSettlements()["0"].getTile());
                if (this.World.getNavigator().findPath(this.World.EntityManager.getSettlements()["0"].getTile(), this.World.EntityManager.getSettlements()["0"].getTile(), this.World.getNavigator().createSettings(), 0).getSize() >= 1)
                {
                    [].push(this.World.getTile(this.World.getNavigator().findPath(this.World.EntityManager.getSettlements()["0"].getTile(), this.World.EntityManager.getSettlements()["0"].getTile(), this.World.getNavigator().createSettings(), 0).getCurrent()));
                    this.World.getNavigator().findPath(this.World.EntityManager.getSettlements()["0"].getTile(), this.World.EntityManager.getSettlements()["0"].getTile(), this.World.getNavigator().createSettings(), 0).pop();
                }
                foreach (local key, value in r58)
                {
                    if (null != null)
                    {
                    }
                    if (null < ([].len() - 1))
                    {
                    }
                    if ((null.RoadDirections == 0) && (null.RoadDirections == 0))
                    {
                        return ((null.RoadDirections == 0) && (null.RoadDirections == 0));
                        null.RoadDirections = ((null.RoadDirections | this.Const.DirectionBit["0"]) | this.Const.DirectionBit["0"]);
                    }
                    this.removeAutobahnkreuze(_rect, _properties);
                    return;
                }
            }
        }
    }
}

function buildSettlements(this, _rect)
{
    this.logInfo("Building settlements...");
    foreach (local key, value in r340)
    {
        if (null.IgnoreSide)
        {
            if ((r13 < 3000) && (r13 < 3000))
            {
                return ((r13 < 3000) && (r13 < 3000));
                if (!null.IgnoreSide)
                {
                    if (this.Math.rand(0, 1))
                    {
                    }
                }
                if ([].find(this.m.WorldTiles["this.Math.rand(5, (_rect.W - 6)"]["this.Math.rand(5, (_rect.H * 0.949999988079071))"].ID) != null))
                {
                }
                else
                {
                    [].push(this.m.WorldTiles["this.Math.rand(5, (_rect.W - 6))"]["this.Math.rand(5, (_rect.H * 0.949999988079071))"].ID);
                    foreach (local key, value in r20)
                    {
                        if ("Settlements" in "AdditionalSpace")
                        {
                        }
                        if (this.m.WorldTiles["this.Math.rand(5, (_rect.W - 6)"]["this.Math.rand(5, (_rect.H * 0.949999988079071))"].getDistanceTo(null) < (12 + 0)))
                        {
                        }
                        if (true)
                        {
                        }
                        else
                        {
                            if ((this.getTerrainInRegion(this.m.WorldTiles["this.Math.rand(5, (_rect.W - 6)"]["this.Math.rand(5, (_rect.H * 0.949999988079071))"]).Adjacent[this.Const.World.TerrainType.Shore] >= 3) && (this.getTerrainInRegion(this.m.WorldTiles["this.Math.rand(5, (_rect.W - 6))"]["this.Math.rand(5, (_rect.H * 0.949999988079071))"]).Adjacent[this.Const.World.TerrainType.Shore] >= 3)))
                            {
                                return ((this.getTerrainInRegion(this.m.WorldTiles["this.Math.rand(5, (_rect.W - 6))"]["this.Math.rand(5, (_rect.H * 0.949999988079071))"]).Adjacent[this.Const.World.TerrainType.Shore] >= 3) && (this.getTerrainInRegion(this.m.WorldTiles["this.Math.rand(5, (_rect.W - 6))"]["this.Math.rand(5, (_rect.H * 0.949999988079071))"]).Adjacent[this.Const.World.TerrainType.Shore] >= 3));
                            }
                            else
                            {
                                foreach (local key, value in null.IgnoreSide)
                                {
                                    if (null.isSuitable(this.getTerrainInRegion(this.m.WorldTiles["this.Math.rand(5, (_rect.W - 6))"]["this.Math.rand(5, (_rect.H * 0.949999988079071))"])))
                                    {
                                        [].push(null);
                                    }
                                    if ([].len() == 0)
                                    {
                                    }
                                    else
                                    {
                                        if ((!("AdditionalSpace" in "IsFlexible") && (!("AdditionalSpace" in "IsFlexible")) && (!("AdditionalSpace" in "IsFlexible"))))
                                        {
                                            return ((!("AdditionalSpace" in "IsFlexible")) && (!("AdditionalSpace" in "IsFlexible")) && (!("AdditionalSpace" in "IsFlexible")));
                                        }
                                        else
                                        {
                                            if (!("AdditionalSpace" in "IsCoastal"))
                                            {
                                                if (([].len() - 1) >= 0)
                                                {
                                                    this.World.getNavigator().createSettings().ActionPointCosts = this.Const.World.TerrainTypeNavCost;
                                                    if (!this.World.getNavigator().findPath(this.m.WorldTiles["this.Math.rand(5, (_rect.W - 6)"]["this.Math.rand(5, (_rect.H * 0.949999988079071))"], []["([].len() - 1)"], this.World.getNavigator().createSettings(), 0).isEmpty()))
                                                    {
                                                    }
                                                }
                                                if (false)
                                                {
                                                }
                                                else
                                                {
                                                    if ((0 < 500) && (0 < 500))
                                                    {
                                                        return ((0 < 500) && (0 < 500));
                                                        if (([].len() - 1) >= 0)
                                                        {
                                                            this.World.getNavigator().createSettings().ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;
                                                            if (!this.World.getNavigator().findPath(this.m.WorldTiles["this.Math.rand(5, (_rect.W - 6)"]["this.Math.rand(5, (_rect.H * 0.949999988079071))"], []["([].len() - 1)"], this.World.getNavigator().createSettings(), 0).isEmpty()))
                                                            {
                                                            }
                                                        }
                                                        if (!true)
                                                        {
                                                        }
                                                    }
                                                    this.m.WorldTiles["this.Math.rand(5, (_rect.W - 6))"]["this.Math.rand(5, (_rect.H * 0.949999988079071))"].clear();
                                                    [].push(this.m.WorldTiles["this.Math.rand(5, (_rect.W - 6))"]["this.Math.rand(5, (_rect.H * 0.949999988079071))"]);
                                                    this.logInfo((("Created " + [].len()) + " settlements."));
                                                    return;
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
}

function buildTerrain(this, _rect)
{
    this.logInfo("Building terrain...");
    if (_rect.Y < (_rect.Y + (_rect.H * 0.6499999761581421)))
    {
        if (_rect.X < (_rect.X + _rect.W))
        {
            if (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type != this.Const.World.TerrainType.Land)
            {
            }
            else
            {
                if (this.m.WorldTiles["_rect.X"]["_rect.Y"].getSurroundingTilesOfType(this.Const.World.TerrainType.Swamp) == 0)
                {
                }
                if (this.Math.rand(1, 100) <= (((12 + (_rect.Y * -0.5) + (50 * this.m.WorldTiles["_rect.X"]["_rect.Y"].getSurroundingTilesOfType(this.Const.World.TerrainType.Steppe))) + (5 * this.m.WorldTiles["_rect.X"]["_rect.Y"].getSurroundingTilesOfType(this.Const.World.TerrainType.Ocean)))))
                {
                    this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.Steppe"].fill({}, null);
                }
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if ((_rect.Y + (_rect.H * 0.20000000298023224) < (_rect.Y + (_rect.H * 0.800000011920929))))
        {
            if (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.20000000298023224)"].Type != this.Const.World.TerrainType.Land))
            {
            }
            else
            {
                if (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.20000000298023224)"].getSurroundingTilesOfType(this.Const.World.TerrainType.Steppe) == 0))
                {
                    if ((_rect.Y + (_rect.H * 0.20000000298023224) < (_rect.H * 0.5)))
                    {
                    }
                }
                if (this.Math.rand(1, 100) <= ((((_rect.H - (_rect.Y + (_rect.H * 0.20000000298023224)) * 0.02500000037252903) + (30 * this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.20000000298023224))"].getSurroundingTilesOfType(this.Const.World.TerrainType.Swamp))) + (10 * this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.20000000298023224))"].getSurroundingTilesOfType(this.Const.World.TerrainType.Ocean)))))
                {
                    this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.20000000298023224))"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.Swamp"].fill({}, null);
                }
            }
        }
    }
    if (this.Math.rand(0, 1) == 1)
    {
    }
    if (this.Math.rand(0, 1) == 1)
    {
    }
    if ((_rect.X + 0) < (_rect.X + (_rect.W * 0.5)))
    {
        if (_rect.Y < (_rect.Y + (_rect.H * 0.699999988079071)))
        {
            if (this.m.WorldTiles["(_rect.X + 0)"]["_rect.Y"].Type != this.Const.World.TerrainType.Land)
            {
            }
            else
            {
                if (!(this.Math.rand(0, 1) == 1))
                {
                }
                if (this.Math.rand(1, 100) <= ((((_rect.X + 0) * 0.02500000037252903) + (30 * this.m.WorldTiles["(_rect.X + 0)"]["_rect.Y"].getSurroundingTilesOfType(this.Const.World.TerrainType.LeaveForest)) - (10 * this.m.WorldTiles["(_rect.X + 0)"]["_rect.Y"].getSurroundingTilesOfType(this.Const.World.TerrainType.Ocean)))))
                {
                    this.m.WorldTiles["(_rect.X + 0)"]["_rect.Y"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.LeaveForest"].fill({}, null);
                }
            }
        }
    }
    if (this.Math.rand(0, 1) == 1)
    {
    }
    if (this.Math.rand(0, 1) == 1)
    {
    }
    if ((_rect.X + (_rect.W * 0.5) < (_rect.X + (_rect.W * 1.0))))
    {
        if (_rect.Y < (_rect.Y + (_rect.H * 0.75)))
        {
            if (this.m.WorldTiles["(_rect.X + (_rect.W * 0.5)"]["_rect.Y"].Type != this.Const.World.TerrainType.Land))
            {
            }
            else
            {
                if (this.Math.rand(0, 1) == 1)
                {
                }
                if (0 < this.Const.Direction.COUNT)
                {
                    if (!this.m.WorldTiles["(_rect.X + (_rect.W * 0.5)"]["_rect.Y"].hasNextTile(0)))
                    {
                    }
                    else
                    {
                        if (this.m.WorldTiles["(_rect.X + (_rect.W * 0.5)"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Steppe))
                        {
                        }
                        if (this.m.WorldTiles["(_rect.X + (_rect.W * 0.5)"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.AutumnForest))
                        {
                        }
                        else
                        {
                            if (this.m.WorldTiles["(_rect.X + (_rect.W * 0.5)"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Ocean))
                            {
                            }
                        }
                    }
                }
                if (this.Math.rand(1, 100) <= ((-100 + 30) - 10))
                {
                    this.m.WorldTiles["(_rect.X + (_rect.W * 0.5))"]["_rect.Y"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.AutumnForest"].fill({}, null);
                }
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if ((_rect.Y + (_rect.H * 0.4000000059604645) < (_rect.Y + _rect.H)))
        {
            if (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4000000059604645)"].Type != this.Const.World.TerrainType.Land))
            {
            }
            else
            {
                if ((_rect.Y + (_rect.H * 0.4000000059604645) < (_rect.H * 0.75)))
                {
                }
                if ((_rect.Y + (_rect.H * 0.4000000059604645) > (_rect.H * this.Const.World.Settings.Snowline)))
                {
                }
                if (0 < this.Const.Direction.COUNT)
                {
                    if (!this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4000000059604645)"].hasNextTile(0)))
                    {
                    }
                    else
                    {
                        if (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4000000059604645)"].getNextTile(0).Type == this.Const.World.TerrainType.Steppe))
                        {
                        }
                        if ((this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4000000059604645)"].getNextTile(0).Type == this.Const.World.TerrainType.SnowyForest) && (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4000000059604645))"].getNextTile(0).Type == this.Const.World.TerrainType.SnowyForest)))
                        {
                            return ((this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4000000059604645))"].getNextTile(0).Type == this.Const.World.TerrainType.SnowyForest) && (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4000000059604645))"].getNextTile(0).Type == this.Const.World.TerrainType.SnowyForest));
                        }
                        else
                        {
                            if (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4000000059604645)"].getNextTile(0).Type == this.Const.World.TerrainType.Ocean))
                            {
                            }
                        }
                    }
                }
                if (this.Math.rand(1, 100) <= ((-100 + 30) - 20))
                {
                    this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4000000059604645))"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.Forest"].fill({}, null);
                }
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (((_rect.H * this.Const.World.Settings.Snowline) - 5) < (_rect.Y + _rect.H))
        {
            if (this.m.WorldTiles["_rect.X"]["((_rect.H * this.Const.World.Settings.Snowline) - 5)"].Type != this.Const.World.TerrainType.Land)
            {
            }
            else
            {
                if ((((_rect.H * this.Const.World.Settings.Snowline) - 5) >= ((_rect.H * this.Const.World.Settings.Snowline) - this.Math) && (((_rect.H * this.Const.World.Settings.Snowline) - 5) >= ((_rect.H * this.Const.World.Settings.Snowline) - this.Math))))
                {
                    return ((((_rect.H * this.Const.World.Settings.Snowline) - 5) >= ((_rect.H * this.Const.World.Settings.Snowline) - this.Math)) && (((_rect.H * this.Const.World.Settings.Snowline) - 5) >= ((_rect.H * this.Const.World.Settings.Snowline) - this.Math)));
                    this.m.WorldTiles["_rect.X"]["((_rect.H * this.Const.World.Settings.Snowline) - 5)"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.Snow"].fill({}, null);
                }
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if ((_rect.H * 0.699999988079071) < (_rect.Y + _rect.H))
        {
            if (this.m.WorldTiles["_rect.X"]["(_rect.H * 0.699999988079071)"].Type != this.Const.World.TerrainType.Land)
            {
            }
            else
            {
                if (this.Math.rand(1, 100) <= ((((_rect.H * 0.699999988079071) * 0.20000000298023224) - (200 * this.m.WorldTiles["_rect.X"]["(_rect.H * 0.699999988079071)"].getSurroundingTilesOfType(this.Const.World.TerrainType.Swamp)) + (100 * this.m.WorldTiles["_rect.X"]["(_rect.H * 0.699999988079071)"].getSurroundingTilesOfType(this.Const.World.TerrainType.Tundra)))))
                {
                    this.m.WorldTiles["_rect.X"]["(_rect.H * 0.699999988079071)"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.Tundra"].fill({}, null);
                }
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + (_rect.H * 0.6499999761581421)))
        {
            if (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type != this.Const.World.TerrainType.Steppe)
            {
            }
            else
            {
                if (0 < this.Const.Direction.COUNT)
                {
                    if (!this.m.WorldTiles["_rect.X"]["_rect.Y"].hasNextTile(0))
                    {
                    }
                    else
                    {
                        if (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Steppe)
                        {
                            if (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Subregion == 99)
                            {
                            }
                        }
                    }
                }
                if (this.Math.rand(1, 100) <= ((-1 + 1) + 17))
                {
                    this.m.WorldTiles["_rect.X"]["_rect.Y"].Subregion = 99;
                }
            }
        }
    }
    return;
}

function buildTerrainDLC(this, _rect)
{
    if (_rect.Y < (_rect.Y + (_rect.H * 0.20000000298023224)))
    {
        if (_rect.X < (_rect.X + _rect.W))
        {
            if (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type != this.Const.World.TerrainType.Land)
            {
            }
            else
            {
                if (this.m.WorldTiles["_rect.X"]["_rect.Y"].getSurroundingTilesOfType(this.Const.World.TerrainType.Swamp) == 0)
                {
                    if (_rect.Y > (_rect.Y + (_rect.H * 0.1899999976158142)))
                    {
                    }
                }
                if (this.Math.rand(1, 100) <= ((((50 + (_rect.Y * -0.800000011920929) * 0.25) + (50 * this.m.WorldTiles["_rect.X"]["_rect.Y"].getSurroundingTilesOfType(this.Const.World.TerrainType.Desert))) + (25 * this.m.WorldTiles["_rect.X"]["_rect.Y"].getSurroundingTilesOfType(this.Const.World.TerrainType.Steppe)))))
                {
                    this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.Desert"].fill({}, null);
                }
            }
        }
    }
    if ((_rect.Y + (_rect.H * 0.15000000596046448) < (_rect.Y + (_rect.H * 0.6000000238418579))))
    {
        if (_rect.X < (_rect.X + _rect.W))
        {
            if (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.15000000596046448)"].Type != this.Const.World.TerrainType.Land))
            {
            }
            else
            {
                if (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.15000000596046448)"].getSurroundingTilesOfType(this.Const.World.TerrainType.Swamp) == 0))
                {
                }
                if (this.Math.rand(1, 100) <= ((((16 + ((_rect.Y + (_rect.H * 0.15000000596046448) * -0.4000000059604645)) + (50 * this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.15000000596046448))"].getSurroundingTilesOfType(this.Const.World.TerrainType.Steppe))) + (25 * this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.15000000596046448))"].getSurroundingTilesOfType(this.Const.World.TerrainType.Desert))) + (5 * this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.15000000596046448))"].getSurroundingTilesOfType(this.Const.World.TerrainType.Ocean)))))
                {
                    this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.15000000596046448))"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.Steppe"].fill({}, null);
                }
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if ((_rect.Y + (_rect.H * 0.30000001192092896) < (_rect.Y + (_rect.H * 0.800000011920929))))
        {
            if (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.30000001192092896)"].Type != this.Const.World.TerrainType.Land))
            {
            }
            else
            {
                if (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.30000001192092896)"].getSurroundingTilesOfType(this.Const.World.TerrainType.Steppe) == 0))
                {
                    if ((_rect.Y + (_rect.H * 0.30000001192092896) < (_rect.H * 0.5)))
                    {
                    }
                }
                if (this.Math.rand(1, 100) <= ((((_rect.H - (_rect.Y + (_rect.H * 0.30000001192092896)) * 0.02500000037252903) + (30 * this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.30000001192092896))"].getSurroundingTilesOfType(this.Const.World.TerrainType.Swamp))) + (10 * this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.30000001192092896))"].getSurroundingTilesOfType(this.Const.World.TerrainType.Ocean)))))
                {
                    this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.30000001192092896))"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.Swamp"].fill({}, null);
                }
            }
        }
    }
    if (this.Math.rand(0, 1) == 1)
    {
    }
    if (this.Math.rand(0, 1) == 1)
    {
    }
    if ((_rect.X + 0) < (_rect.X + (_rect.W * 0.5)))
    {
        if ((_rect.Y + (_rect.H * 0.20000000298023224) < (_rect.Y + (_rect.H * 0.699999988079071))))
        {
            if (this.m.WorldTiles["(_rect.X + 0)"]["(_rect.Y + (_rect.H * 0.20000000298023224)"].Type != this.Const.World.TerrainType.Land))
            {
            }
            else
            {
                if (!(this.Math.rand(0, 1) == 1))
                {
                }
                if (this.Math.rand(1, 100) <= ((((_rect.X + 0) * 0.02500000037252903) + (30 * this.m.WorldTiles["(_rect.X + 0)"]["(_rect.Y + (_rect.H * 0.20000000298023224)"].getSurroundingTilesOfType(this.Const.World.TerrainType.LeaveForest))) - (10 * this.m.WorldTiles["(_rect.X + 0)"]["(_rect.Y + (_rect.H * 0.20000000298023224))"].getSurroundingTilesOfType(this.Const.World.TerrainType.Ocean)))))
                {
                    this.m.WorldTiles["(_rect.X + 0)"]["(_rect.Y + (_rect.H * 0.20000000298023224))"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.LeaveForest"].fill({}, null);
                }
            }
        }
    }
    if (this.Math.rand(0, 1) == 1)
    {
    }
    if (this.Math.rand(0, 1) == 1)
    {
    }
    if ((_rect.X + (_rect.W * 0.5) < (_rect.X + (_rect.W * 1.0))))
    {
        if ((_rect.Y + (_rect.H * 0.20000000298023224) < (_rect.Y + (_rect.H * 0.75))))
        {
            if (this.m.WorldTiles["(_rect.X + (_rect.W * 0.5)"]["(_rect.Y + (_rect.H * 0.20000000298023224))"].Type != this.Const.World.TerrainType.Land))
            {
            }
            else
            {
                if (this.Math.rand(0, 1) == 1)
                {
                }
                if (0 < this.Const.Direction.COUNT)
                {
                    if (!this.m.WorldTiles["(_rect.X + (_rect.W * 0.5)"]["(_rect.Y + (_rect.H * 0.20000000298023224))"].hasNextTile(0)))
                    {
                    }
                    else
                    {
                        if (this.m.WorldTiles["(_rect.X + (_rect.W * 0.5)"]["(_rect.Y + (_rect.H * 0.20000000298023224))"].getNextTile(0).Type == this.Const.World.TerrainType.Steppe))
                        {
                        }
                        if (this.m.WorldTiles["(_rect.X + (_rect.W * 0.5)"]["(_rect.Y + (_rect.H * 0.20000000298023224))"].getNextTile(0).Type == this.Const.World.TerrainType.AutumnForest))
                        {
                        }
                        else
                        {
                            if (this.m.WorldTiles["(_rect.X + (_rect.W * 0.5)"]["(_rect.Y + (_rect.H * 0.20000000298023224))"].getNextTile(0).Type == this.Const.World.TerrainType.Ocean))
                            {
                            }
                        }
                    }
                }
                if (this.Math.rand(1, 100) <= ((-100 + 30) - 10))
                {
                    this.m.WorldTiles["(_rect.X + (_rect.W * 0.5))"]["(_rect.Y + (_rect.H * 0.20000000298023224))"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.AutumnForest"].fill({}, null);
                }
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if ((_rect.Y + (_rect.H * 0.4300000071525574) < (_rect.Y + _rect.H)))
        {
            if (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4300000071525574)"].Type != this.Const.World.TerrainType.Land))
            {
            }
            else
            {
                if ((_rect.Y + (_rect.H * 0.4300000071525574) < (_rect.H * 0.75)))
                {
                }
                if ((_rect.Y + (_rect.H * 0.4300000071525574) > (_rect.H * this.Const.World.Settings.Snowline)))
                {
                }
                if (0 < this.Const.Direction.COUNT)
                {
                    if (!this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4300000071525574)"].hasNextTile(0)))
                    {
                    }
                    else
                    {
                        if (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4300000071525574)"].getNextTile(0).Type == this.Const.World.TerrainType.Steppe))
                        {
                        }
                        if ((this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4300000071525574)"].getNextTile(0).Type == this.Const.World.TerrainType.SnowyForest) && (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4300000071525574))"].getNextTile(0).Type == this.Const.World.TerrainType.SnowyForest)))
                        {
                            return ((this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4300000071525574))"].getNextTile(0).Type == this.Const.World.TerrainType.SnowyForest) && (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4300000071525574))"].getNextTile(0).Type == this.Const.World.TerrainType.SnowyForest));
                        }
                        else
                        {
                            if (this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4300000071525574)"].getNextTile(0).Type == this.Const.World.TerrainType.Ocean))
                            {
                            }
                        }
                    }
                }
                if (this.Math.rand(1, 100) <= ((-100 + 30) - 20))
                {
                    this.m.WorldTiles["_rect.X"]["(_rect.Y + (_rect.H * 0.4300000071525574))"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.Forest"].fill({}, null);
                }
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (((_rect.H * this.Const.World.Settings.Snowline) - 5) < (_rect.Y + _rect.H))
        {
            if (this.m.WorldTiles["_rect.X"]["((_rect.H * this.Const.World.Settings.Snowline) - 5)"].Type != this.Const.World.TerrainType.Land)
            {
            }
            else
            {
                if ((((_rect.H * this.Const.World.Settings.Snowline) - 5) >= ((_rect.H * this.Const.World.Settings.Snowline) - this.Math) && (((_rect.H * this.Const.World.Settings.Snowline) - 5) >= ((_rect.H * this.Const.World.Settings.Snowline) - this.Math))))
                {
                    return ((((_rect.H * this.Const.World.Settings.Snowline) - 5) >= ((_rect.H * this.Const.World.Settings.Snowline) - this.Math)) && (((_rect.H * this.Const.World.Settings.Snowline) - 5) >= ((_rect.H * this.Const.World.Settings.Snowline) - this.Math)));
                    this.m.WorldTiles["_rect.X"]["((_rect.H * this.Const.World.Settings.Snowline) - 5)"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.Snow"].fill({}, null);
                }
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if ((_rect.H * 0.699999988079071) < (_rect.Y + _rect.H))
        {
            if (this.m.WorldTiles["_rect.X"]["(_rect.H * 0.699999988079071)"].Type != this.Const.World.TerrainType.Land)
            {
            }
            else
            {
                if (this.Math.rand(1, 100) <= ((((_rect.H * 0.699999988079071) * 0.20000000298023224) - (200 * this.m.WorldTiles["_rect.X"]["(_rect.H * 0.699999988079071)"].getSurroundingTilesOfType(this.Const.World.TerrainType.Swamp)) + (100 * this.m.WorldTiles["_rect.X"]["(_rect.H * 0.699999988079071)"].getSurroundingTilesOfType(this.Const.World.TerrainType.Tundra)))))
                {
                    this.m.WorldTiles["_rect.X"]["(_rect.H * 0.699999988079071)"].Type = 0;
                    this.m.Tiles["this.Const.World.TerrainType.Tundra"].fill({}, null);
                }
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + (_rect.H * 0.6499999761581421)))
        {
            if (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type != this.Const.World.TerrainType.Desert)
            {
            }
            else
            {
                if (0 < this.Const.Direction.COUNT)
                {
                    if (!this.m.WorldTiles["_rect.X"]["_rect.Y"].hasNextTile(0))
                    {
                    }
                    else
                    {
                        if (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Desert)
                        {
                            if (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Subregion == 99)
                            {
                            }
                        }
                    }
                }
                if (this.Math.rand(1, 100) <= ((-1 + 1) + 17))
                {
                    this.m.WorldTiles["_rect.X"]["_rect.Y"].Subregion = 99;
                }
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + (_rect.H * 0.6499999761581421)))
        {
            if (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type != this.Const.World.TerrainType.Steppe)
            {
            }
            else
            {
                if (0 < this.Const.Direction.COUNT)
                {
                    if (!this.m.WorldTiles["_rect.X"]["_rect.Y"].hasNextTile(0))
                    {
                    }
                    else
                    {
                        if (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Steppe)
                        {
                            if (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Subregion == 99)
                            {
                            }
                        }
                    }
                }
                if (this.Math.rand(1, 100) <= ((-1 + 1) + 17))
                {
                    this.m.WorldTiles["_rect.X"]["_rect.Y"].Subregion = 99;
                }
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + (_rect.H * 0.15000000596046448)))
        {
            if (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type != this.Const.World.TerrainType.Plains)
            {
            }
            this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = 0;
            this.m.Tiles["this.Const.World.TerrainType.Oasis"].fill({}, null);
        }
    }
    return;
}

function clearWorld(this, _rect)
{
    this.World.clearTiles();
    return;
}

function defragmentTerrain(this, _rect)
{
    if (0 < 2)
    {
        if (_rect.X < (_rect.X + _rect.W))
        {
            if (_rect.Y < (_rect.Y + _rect.H))
            {
                if ((this.m.WorldTiles["_rect.X"]["_rect.Y"].Type != this.Const.World.TerrainType.Steppe) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type != this.Const.World.TerrainType.Steppe))
                {
                    return ((this.m.WorldTiles["_rect.X"]["_rect.Y"].Type != this.Const.World.TerrainType.Steppe) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type != this.Const.World.TerrainType.Steppe));
                }
                else
                {
                    [].resize(this.Const.World.TerrainType.COUNT, 0);
                    if (0 < this.Const.Direction.COUNT)
                    {
                        if (!this.m.WorldTiles["_rect.X"]["_rect.Y"].hasNextTile(0))
                        {
                        }
                        else
                        {
                            if (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Ocean)
                            {
                            }
                        }
                    }
                    foreach (local key, value in r18)
                    {
                        if (null <= this.Const.World.TerrainType.Land)
                        {
                        }
                        if (null > 0)
                        {
                        }
                        if (((0 + null) >= (4 - (0 + 6)) && ((0 + null) >= (4 - (0 + 6)))))
                        {
                            return (((0 + null) >= (4 - (0 + 6))) && ((0 + null) >= (4 - (0 + 6))));
                            this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = 0;
                            this.m.Tiles.None.fill({}, null);
                        }
                        return;
                    }
                }
            }
        }
    }
}

function fill(this, _rect, _properties, _pass)
{
    this.Const.World.Buildings.reset();
    this.m.Tiles.resize(this.Const.World.TerrainType.COUNT);
    if (0 < this.Const.World.TerrainType.COUNT)
    {
        if (this.Const.World.TerrainScript["0"].len() != 0)
        {
            this.m.Tiles["0"] = this.MapGen.get(this.Const.World.TerrainScript["0"]);
        }
    }
    this.m.WorldTiles.resize(_rect.W);
    if (_rect.X < (_rect.X + _rect.W))
    {
        this.m.WorldTiles["_rect.X"] = [];
        this.m.WorldTiles["_rect.X"].resize(_rect.H);
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            this.m.WorldTiles["_rect.X"]["_rect.Y"] = this.World.getTileSquare(_rect.X, _rect.Y);
        }
    }
    this["__ping"]();
    while (r4)
    {
        if (true)
        {
            this.buildLandAndSea(_rect);
            this["__ping"]();
            if (!this.isWorldAcceptable(_rect))
            {
                this.logInfo("World rejected. Creating new one...");
                this.clearWorld(_rect);
            }
            this["__ping"]();
            this.buildElevation(_rect);
            this["__ping"]();
            if (this.Const.DLC.Desert)
            {
            }
            this["__ping"]();
            this.defragmentTerrain(_rect);
            this["__ping"]();
            if ((!this) && (!this))
            {
                return ((!this) && (!this));
                this.logInfo("World rejected. Creating new one...");
                this.clearWorld(_rect);
            }
            this.logInfo("World accepted.");
        }
        this["__ping"]();
        this.removeStraits(_rect);
        this["__ping"]();
        this.refineTerrain(_rect, _properties);
        this["__ping"]();
        this.buildSettlements(_rect);
        this["__ping"]();
        this.buildRoads(_rect, _properties);
        this["__ping"]();
        this.refineSettlements(_rect);
        this["__ping"]();
        this.guaranteeAllBuildingsInSettlements();
        this["__ping"]();
        this.buildAdditionalRoads(_rect, _properties);
        this["__ping"]();
        this.buildRoadSprites(_rect, _properties);
        this["__ping"]();
        this.buildLabels(_rect);
        this["__ping"]();
        if (this.Const.DLC.Desert)
        {
            this.buildAbandonedFortresses(_rect);
        }
        this["__ping"]();
        this.m.Tiles = [];
        this.m.WorldTiles = [];
        return;
    }
}

function fillWithTile(this, _x, _y, _type, _template, _baseChance, _vicinityChance, _xChance, _yChance, _inVicinityOnly)
{
    if ((this.m.WorldTiles["_x"]["_y"].getSurroundingTilesOfType(_type) == 0) && (this.m.WorldTiles["_x"]["_y"].getSurroundingTilesOfType(_type) == 0))
    {
        return ((this.m.WorldTiles["_x"]["_y"].getSurroundingTilesOfType(_type) == 0) && (this.m.WorldTiles["_x"]["_y"].getSurroundingTilesOfType(_type) == 0));
    }
    if (this.Math.rand(0, 100) > (((_baseChance - (this.m.WorldTiles["_x"]["_y"].getSurroundingTilesOfType(_type) * _vicinityChance) - (_xChance * _x)) - (_yChance * _y))))
    {
        this.m.WorldTiles["_x"]["_y"].Type = 0;
        _template.fill({}, null);
    }
    return;
}

function getRect(this, _rect, _x, _y, _width, _height)
{
    return _rect;
}

function getTerrainInRegion(this, _tile)
{
    {}.Adjacent.resize(this.Const.World.TerrainType.COUNT, 0);
    {}.Region.resize(this.Const.World.TerrainType.COUNT, 0);
    if (0 < 6)
    {
        if (!_tile.hasNextTile(0))
        {
        }
    }
    this.World.queryTilesInRange(_tile, 1, 4, this.onTileInRegionQueried.bindenv(this), {}.Region);
    return _tile;
}

function guaranteeAllBuildingsInSettlements(this)
{
    if (this.Const.World.Buildings.Fletchers < 2)
    {
        foreach (local key, value in r22)
        {
            if ((!null.hasBuilding("building.fletcher") && (!null.hasBuilding("building.fletcher"))))
            {
                return ((!null.hasBuilding("building.fletcher")) && (!null.hasBuilding("building.fletcher")));
                [].push(null);
            }
            if (this.Const.World.Buildings.Fletchers <= 2)
            {
                [].remove(this.Math.rand(0, ([].len() - 1)));
                []["this.Math.rand(0, ([].len() - 1))"].addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
                if ([].len() == 0)
                {
                }
            }
            if (this.Const.World.Buildings.Temples < 2)
            {
                foreach (local key, value in r22)
                {
                    if ((!null.hasBuilding("building.temple") && (!null.hasBuilding("building.temple"))))
                    {
                        return ((!null.hasBuilding("building.temple")) && (!null.hasBuilding("building.temple")));
                        [].push(null);
                    }
                    if (this.Const.World.Buildings.Temples <= 2)
                    {
                        [].remove(this.Math.rand(0, ([].len() - 1)));
                        []["this.Math.rand(0, ([].len() - 1))"].addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
                        if ([].len() == 0)
                        {
                        }
                    }
                    if (this.Const.World.Buildings.Barbers < 2)
                    {
                        foreach (local key, value in r27)
                        {
                            if ((!null.hasBuilding("building.barber") && (!null.hasBuilding("building.barber")) && (!null.hasBuilding("building.barber"))))
                            {
                                return ((!null.hasBuilding("building.barber")) && (!null.hasBuilding("building.barber")) && (!null.hasBuilding("building.barber")));
                                [].push(null);
                            }
                            if (this.Const.World.Buildings.Barbers <= 2)
                            {
                                [].remove(this.Math.rand(0, ([].len() - 1)));
                                []["this.Math.rand(0, ([].len() - 1))"].addBuilding(this.new("scripts/entity/world/settlements/buildings/barber_building"));
                                if ([].len() == 0)
                                {
                                }
                            }
                            if (this.Const.World.Buildings.Kennels < 2)
                            {
                                foreach (local key, value in r20)
                                {
                                    if ((!null.hasBuilding("building.kennel") && (!null.hasBuilding("building.kennel"))))
                                    {
                                        return ((!null.hasBuilding("building.kennel")) && (!null.hasBuilding("building.kennel")));
                                        [].push(null);
                                    }
                                    if (this.Const.World.Buildings.Kennels <= 2)
                                    {
                                        [].remove(this.Math.rand(0, ([].len() - 1)));
                                        []["this.Math.rand(0, ([].len() - 1))"].addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
                                        if ([].len() == 0)
                                        {
                                        }
                                    }
                                    if ((this.Const.World.Buildings.Taxidermists < 2) && (this.Const.World.Buildings.Taxidermists < 2))
                                    {
                                        return ((this.Const.World.Buildings.Taxidermists < 2) && (this.Const.World.Buildings.Taxidermists < 2));
                                        foreach (local key, value in r21)
                                        {
                                            if ((!null.hasBuilding("building.taxidermist") && (!null.hasBuilding("building.taxidermist"))))
                                            {
                                                return ((!null.hasBuilding("building.taxidermist")) && (!null.hasBuilding("building.taxidermist")));
                                                [].push(null);
                                            }
                                            if (this.Const.World.Buildings.Taxidermists <= 2)
                                            {
                                                [].remove(this.Math.rand(0, ([].len() - 1)));
                                                []["this.Math.rand(0, ([].len() - 1))"].addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));
                                                if ([].len() == 0)
                                                {
                                                }
                                            }
                                            return;
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

function init(this)
{
    this.m.Name = "world.worldmap_generator";
    this.m.MinX = this.Const.World.Settings.SizeX;
    this.m.MinY = this.Const.World.Settings.SizeY;
    return;
}

function isDesertAcceptable(this, _rect)
{
    return _rect;
}

function isWorldAcceptable(this, _rect)
{
    return _rect;
}

function onTileInRegionQueried(this, _tile, _region)
{
    return;
}

function refineSettlements(this, _rect)
{
    foreach (local key, value in r8)
    {
        null.updateProperties();
        null.build();
        foreach (local key, value in null)
        {
            [].push(null.getTile());
            this.World.updateTilesWithHeat([], 6);
            return;
        }
    }
}

function refineTerrain(this, _rect, _properties)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.m.Tiles["this.m.WorldTiles["_rect.X"]["_rect.Y"].Type"] != null)
            {
                this.m.Tiles["this.m.WorldTiles["_rect.X"]["_rect.Y"].Type"].fill({}, _properties, 2);
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.m.Tiles["this.m.WorldTiles["_rect.X"]["_rect.Y"].Type"] != null)
            {
                this.m.Tiles["this.m.WorldTiles["_rect.X"]["_rect.Y"].Type"].fill({}, _properties, 3);
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type != this.Const.World.TerrainType.Shore)
            {
            }
            if (0 != 3)
            {
                if (!this.m.WorldTiles["_rect.X"]["_rect.Y"].hasNextTile(0))
                {
                }
                else
                {
                    if ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Shore) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Shore))
                    {
                        return ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Shore) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Shore));
                    }
                    else
                    {
                        if ((0 + 3) <= 5)
                        {
                        }
                        if (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 3) - 6).hasNextTile(((0 + 3) - 6)) && this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 3) - 6)).hasNextTile(((0 + 3) - 6))))
                        {
                            return (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 3) - 6)).hasNextTile(((0 + 3) - 6)) && this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 3) - 6)).hasNextTile(((0 + 3) - 6)));
                            if ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 3) - 6).getNextTile(((0 + 3) - 6)).Type != this.Const.World.TerrainType.Shore) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 3) - 6)).getNextTile(((0 + 3) - 6)).Type != this.Const.World.TerrainType.Shore)))
                            {
                                return ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 3) - 6)).getNextTile(((0 + 3) - 6)).Type != this.Const.World.TerrainType.Shore) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 3) - 6)).getNextTile(((0 + 3) - 6)).Type != this.Const.World.TerrainType.Shore));
                                if ((((0 + 3) - 6) - 1) >= 0)
                                {
                                }
                                if ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(5).Type != this.Const.World.TerrainType.Shore) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(5).Type != this.Const.World.TerrainType.Shore))
                                {
                                    return ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(5).Type != this.Const.World.TerrainType.Shore) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(5).Type != this.Const.World.TerrainType.Shore));
                                }
                                if ((((0 + 3) - 6) + 1) <= 5)
                                {
                                }
                                if ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type != this.Const.World.TerrainType.Shore) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type != this.Const.World.TerrainType.Shore))
                                {
                                    return ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type != this.Const.World.TerrainType.Shore) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type != this.Const.World.TerrainType.Shore));
                                }
                                this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 3) - 6)).clearAllBut(this.Const.World.DetailType.Shore);
                            }
                        }
                    }
                }
            }
            if (((0 + 3) - 6) == -1)
            {
            }
            this.m.WorldTiles["_rect.X"]["_rect.Y"].clearAllBut(this.Const.World.DetailType.Shore);
            if (((0 + 3) - 6) == 3)
            {
            }
            else
            {
                if (((0 + 3) - 6) == 4)
                {
                }
                else
                {
                    if (((0 + 3) - 6) == 5)
                    {
                    }
                }
            }
            this.m.WorldTiles["_rect.X"]["_rect.Y"].spawnDetail([]["this.Math.rand(0, ([].len() - 1))"], this.Const.World.ZLevel.Terrain, 0, (this.Math.rand(0, 1) == 1), false, this.createVec(0, 0));
        }
    }
    return;
}

function removeAutobahnkreuze(this, _rect, _properties)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (!this.m.WorldTiles["_rect.X"]["_rect.Y"].HasRoad)
            {
            }
            else
            {
                if (0 < 6)
                {
                    if ((this.m.WorldTiles["_rect.X"]["_rect.Y"].RoadDirections & this.Const.DirectionBit["0"]) == 0)
                    {
                    }
                    else
                    {
                        if (!this.m.WorldTiles["_rect.X"]["_rect.Y"].hasNextTile(0))
                        {
                        }
                        else
                        {
                            if ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).RoadDirections & this.Const.DirectionBit["this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).getDirectionTo(this.m.WorldTiles["_rect.X"]["_rect.Y"])"]) == 0)
                            {
                            }
                            else
                            {
                                if ((0 - 1) >= 0)
                                {
                                }
                                if ((0 + 1) <= 5)
                                {
                                }
                                if (0 < [].len())
                                {
                                    if ((this.m.WorldTiles["_rect.X"]["_rect.Y"].RoadDirections & this.Const.DirectionBit["[]["0"]"]) == 0)
                                    {
                                    }
                                    else
                                    {
                                        if (!this.m.WorldTiles["_rect.X"]["_rect.Y"].hasNextTile([]["0"]))
                                        {
                                        }
                                        else
                                        {
                                            if ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).RoadDirections == 0) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).RoadDirections == 0))
                                            {
                                                return ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).RoadDirections == 0) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).RoadDirections == 0));
                                            }
                                            this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).RoadDirections = (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).RoadDirections & (~this));
                                            this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile([]["0"]).RoadDirections = (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile([]["0"]).RoadDirections & (~this));
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

function removeStraits(this, _rect)
{
    this.logInfo("Spacing terrain...");
    if (0 < 8)
    {
        if (_rect.X < (_rect.X + _rect.W))
        {
            if (_rect.Y < (_rect.Y + _rect.H))
            {
                if (this.m.WorldTiles["_rect.X"]["_rect.Y"].Type != this.Const.World.TerrainType.Ocean)
                {
                }
                else
                {
                    if (0 != 6)
                    {
                        if (0 != 6)
                        {
                            if ((0 + 0) > 5)
                            {
                            }
                            if (!this.m.WorldTiles["_rect.X"]["_rect.Y"].hasNextTile(((0 + 0) - 6)))
                            {
                            }
                            if ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 0) - 6).Type == this.Const.World.TerrainType.Ocean) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 0) - 6)).Type == this.Const.World.TerrainType.Ocean)))
                            {
                                return ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 0) - 6)).Type == this.Const.World.TerrainType.Ocean) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 0) - 6)).Type == this.Const.World.TerrainType.Ocean));
                            }
                            else
                            {
                                if ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 0) - 6).Type != this.Const.World.TerrainType.Ocean) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 0) - 6)).Type != this.Const.World.TerrainType.Ocean)))
                                {
                                    return ((this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 0) - 6)).Type != this.Const.World.TerrainType.Ocean) && (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 0) - 6)).Type != this.Const.World.TerrainType.Ocean));
                                }
                            }
                        }
                        if ((6 + 10) > 0)
                        {
                        }
                    }
                    if ((((0 + 11) + 11) > 0) && (((0 + 11) + 11) > 0))
                    {
                        return ((((0 + 11) + 11) > 0) && (((0 + 11) + 11) > 0));
                        if (0 != 6)
                        {
                            if ((0 + 0) > 5)
                            {
                            }
                            if (!this.m.WorldTiles["_rect.X"]["_rect.Y"].hasNextTile(((0 + 0) - 6)))
                            {
                            }
                            else
                            {
                                if (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 0) - 6).Type != this.Const.World.TerrainType.Ocean))
                                {
                                    if (((6 + 10) >= 5) && ((6 + 10) >= 5))
                                    {
                                        return (((6 + 10) >= 5) && ((6 + 10) >= 5));
                                        if (((6 + 10) < 5) && ((6 + 10) < 5))
                                        {
                                            return (((6 + 10) < 5) && ((6 + 10) < 5));
                                            this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(((0 + 0) - 6)).Type = 0;
                                            this.m.Tiles["this.Const.World.TerrainType.Ocean"].fill({}, null);
                                        }
                                        [].resize(this.Const.World.TerrainType.COUNT, 0);
                                        if (0 < 6)
                                        {
                                            if (!this.m.WorldTiles["_rect.X"]["_rect.Y"].hasNextTile(0))
                                            {
                                            }
                                            else
                                            {
                                                if (this.m.WorldTiles["_rect.X"]["_rect.Y"].getNextTile(0).Type == this.Const.World.TerrainType.Ocean)
                                                {
                                                }
                                            }
                                        }
                                        foreach (local key, value in ((0 + 11) + 11))
                                        {
                                            if (null > 0)
                                            {
                                            }
                                            if (null == 0)
                                            {
                                            }
                                            this.m.WorldTiles["_rect.X"]["_rect.Y"].Type = 0;
                                            this.m.Tiles["this.Const.World.TerrainType.Plains"].fill({}, null);
                                            return;
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
