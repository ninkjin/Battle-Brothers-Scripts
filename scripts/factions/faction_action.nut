// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/faction_action.nut
// Functions: 23

function create(this)
{
    if (this.m.IsStartingOnCooldown)
    {
        this.m.CooldownUntil = (this.Time.getVirtualTimeF() + this.Math.min(300.0, this.Math.rand(0, (this.m.Cooldown * 0.5))));
    }
    return;
}

function execute(this, _isNewCampaign)
{
    this.onExecute(this.m.Faction);
    this.onClear();
    if (!_isNewCampaign)
    {
        this.m.CooldownUntil = (this.Time.getVirtualTimeF() + this.m.Cooldown);
    }
    return;
}

function getAppropriateBanner(this, _for, _list, _maxDist, _alternativeBanners)
{
    foreach (local key, value in r34)
    {
        if (null.getTile().getDistanceTo(_for.getTile() < 9000))
        {
        }
        if (0 != clone this.len())
        {
            if (clone this["0"] == null.getBanner())
            {
                clone this.remove(0);
            }
        }
        if ((null.getTile().getDistanceTo(_for.getTile() <= _maxDist) && (null.getTile().getDistanceTo(_for.getTile()) <= _maxDist)))
        {
            return ((null.getTile().getDistanceTo(_for.getTile()) <= _maxDist) && (null.getTile().getDistanceTo(_for.getTile()) <= _maxDist));
            return null.getBanner();
            return _for;
        }
        if (clone this.len() != 0)
        {
            return _for;
        }
        return null.getBanner();
        return _for;
    }
}

function getCooldownUntil(this)
{
    return this.m.CooldownUntil;
}

function getDistanceToNextAlly(this, _tile)
{
    foreach (local key, value in r18)
    {
        if (!null.isAlive())
        {
        }
        if (_tile.getDistanceTo(null.getTile() < 999999))
        {
        }
        return _tile;
    }
}

function getDistanceToSettlements(this, _from)
{
    foreach (local key, value in r11)
    {
        if (_from.getDistanceTo(null.getTile() < 1000))
        {
        }
        return _from;
    }
}

function getFaction(this)
{
    return this.m.Faction;
}

function getID(this)
{
    return this.m.ID;
}

function getNearestLocationTo(this, _to, _list, _removeFromList)
{
    foreach (local key, value in r17)
    {
        if (_to.getTile().getDistanceTo(null.getTile() < 9000))
        {
        }
        if ((null != null) && (null != null))
        {
            return ((null != null) && (null != null));
            _list.remove(null);
        }
        return _to;
    }
}

function getRandomConnectedSettlements(this, _num, _startList, _destList, _roadOnly)
{
    if (_destList == null)
    {
    }
    if ((_startList.len() - 1) && (_startList.len() - 1))
    {
        return ((_startList.len() - 1) && (_startList.len() - 1));
        return _num;
    }
    if (0 < (_num - 1))
    {
        if ((0 + 8) > 10)
        {
            return _num;
        }
        if ((!_startList["this.Math.rand(0, (_startList.len() - 1)"].isIsolatedFromRoads()) && (!_startList["this.Math.rand(0, (_startList.len() - 1))"].isIsolatedFromRoads())))
        {
            return ((!_startList["this.Math.rand(0, (_startList.len() - 1))"].isIsolatedFromRoads()) && (!_startList["this.Math.rand(0, (_startList.len() - 1))"].isIsolatedFromRoads()));
            if (_startList["this.Math.rand(0, (_startList.len() - 1))"].isLocationType(this.Const.World.LocationType.Settlement))
            {
                if (_roadOnly)
                {
                }
            }
            if (this.isPathBetween(_startList["this.Math.rand(0, (_startList.len() - 1))"].getTile(), _startList["this.Math.rand(0, (_startList.len() - 1))"].getTile(), _roadOnly))
            {
            }
            else
            {
                if (true)
                {
                }
            }
            if (this.isPathBetween(_startList["this.Math.rand(0, (_startList.len() - 1))"].getTile(), _startList["this.Math.rand(0, (_startList.len() - 1))"].getTile(), _roadOnly))
            {
                [].push(_startList["this.Math.rand(0, (_startList.len() - 1))"]);
            }
            if ([].len() != 0)
            {
                [].push(_startList["this.Math.rand(0, (_startList.len() - 1))"]);
                [].reverse();
            }
            return _num;
        }
    }
}

function getReputationToDifficultyLightMult(this)
{
    return ((1.0 + this.Math.minf(2.0, (this.World.getTime().Days * 0.014000000432133675))) - 0.10000000149011612);
}

function getScaledDifficultyMult(this)
{
    return this.Math.maxf(0.5, (0.6000000238418579 * this.Math.pow((0.009999999776482582 * this.World.State.getPlayer().getStrength()), 0.8999999761581421)));
}

function getScore(this)
{
    return this.m.Score;
}

function getTileToSpawnLocation(this, _maxTries, _notOnTerrain, _minDistToSettlements, _maxDistToSettlements, _maxDistanceToAllies, _minDistToEnemyLocations, _minDistToAlliedLocations, _nearTile, _minY, _maxY)
{
    this.World.getNavigator().createSettings().ActionPointCosts = this.Const.World.TerrainTypeNavCost;
    this.World.getNavigator().createSettings().RoadMult = 1.0;
    if ((r15 + 14) < _maxTries)
    {
        if (_nearTile != null)
        {
        }
        if ([].find(this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).ID) != null))
        {
        }
        else
        {
            [].push(this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).ID);
            if (this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).HasRiver || this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).HasRiver))
            {
                return (this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).HasRiver || this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).HasRiver);
            }
            else
            {
                if ((this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).Type == this.Const.World.TerrainType.Shore) && (this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).Type == this.Const.World.TerrainType.Shore)))
                {
                    return ((this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).Type == this.Const.World.TerrainType.Shore) && (this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).Type == this.Const.World.TerrainType.Shore));
                }
                else
                {
                    if ((this.World.State < 6) && (this.World.State < 6))
                    {
                        return ((this.World.State < 6) && (this.World.State < 6));
                    }
                    else
                    {
                        foreach (local key, value in _maxY)
                        {
                            if (this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).Type == null))
                            {
                            }
                            if (true)
                            {
                            }
                            else
                            {
                                if (0 != 6)
                                {
                                    if (!this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).hasNextTile(0)))
                                    {
                                    }
                                    else
                                    {
                                        if ((this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).getNextTile(0).Type == this.Const.World.TerrainType.Shore) || (this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).getNextTile(0).Type == this.Const.World.TerrainType.Shore)))
                                        {
                                            return ((this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).getNextTile(0).Type == this.Const.World.TerrainType.Shore) || (this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).getNextTile(0).Type == this.Const.World.TerrainType.Shore));
                                        }
                                    }
                                }
                                if (true)
                                {
                                }
                                else
                                {
                                    foreach (local key, value in this.World.getNavigator().createSettings())
                                    {
                                        if (null.getTile().getDistanceTo(this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY))))) < 1000))
                                        {
                                        }
                                        if ((null.getTile().getDistanceTo(this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY))))) > _maxDistToSettlements) && (null.getTile().getDistanceTo(this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY))))) > _maxDistToSettlements)))
                                        {
                                            return ((null.getTile().getDistanceTo(this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY))))) > _maxDistToSettlements) && (null.getTile().getDistanceTo(this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY))))) > _maxDistToSettlements));
                                        }
                                        else
                                        {
                                            if ((_minDistToEnemyLocations != 0) && (_minDistToEnemyLocations != 0))
                                            {
                                                return ((_minDistToEnemyLocations != 0) && (_minDistToEnemyLocations != 0));
                                                foreach (local key, value in r35)
                                                {
                                                    if ((this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).getDistanceTo(null.getTile()) < _minDistToEnemyLocations) && (this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).getDistanceTo(null.getTile()) < _minDistToEnemyLocations)))
                                                    {
                                                        return ((this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).getDistanceTo(null.getTile()) < _minDistToEnemyLocations) && (this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3)), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))).getDistanceTo(null.getTile()) < _minDistToEnemyLocations));
                                                    }
                                                    if (true)
                                                    {
                                                    }
                                                    else
                                                    {
                                                        if ((_maxDistanceToAllies != 1000) && (_maxDistanceToAllies != 1000))
                                                        {
                                                            return ((_maxDistanceToAllies != 1000) && (_maxDistanceToAllies != 1000));
                                                            foreach (local key, value in this.World.getNavigator().createSettings())
                                                            {
                                                                if (null.getTile().getDistanceTo(this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY))))) < 1000))
                                                                {
                                                                }
                                                                if (null.getTile().getDistanceTo(this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY))))) > _maxDistanceToAllies))
                                                                {
                                                                }
                                                                if ((this.Math.rand(3, (this.World.getMapSize().X - 3) - 3) < (this.Math.rand(3, (this.World.getMapSize().X - 3)) + 3)))
                                                                {
                                                                    if ((this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY))) - 3) < (this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY))) + 3)))
                                                                    {
                                                                        if (!this.World.isValidTileSquare((this.Math.rand(3, (this.World.getMapSize().X - 3) - 3), (this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY))) - 3))))
                                                                        {
                                                                        }
                                                                        else
                                                                        {
                                                                            if (this.World.getTileSquare((this.Math.rand(3, (this.World.getMapSize().X - 3)) - 3), (this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY))) - 3)).HasRoad)
                                                                            {
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                                if (true)
                                                                {
                                                                }
                                                                foreach (local key, value in null.getTile().getDistanceTo)
                                                                {
                                                                    if (null.isIsolated())
                                                                    {
                                                                    }
                                                                    if (!this.World.getNavigator().findPath(this.World.getTileSquare(this.Math.rand(3, (this.World.getMapSize().X - 3), this.Math.rand(this.Math.max(3, (this.World.getMapSize().Y * _minY)), this.Math.min((this.World.getMapSize().Y - 4), (this.World.getMapSize().Y * _maxY)))), null.getTile(), this.World.getNavigator().createSettings(), 0).isEmpty()))
                                                                    {
                                                                    }
                                                                    if (false)
                                                                    {
                                                                    }
                                                                    return _maxTries;
                                                                    return _maxTries;
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
            }
        }
    }
}

function isPathBetween(this, _start, _dest, _roadOnly)
{
    this.World.getNavigator().createSettings().ActionPointCosts = this.Const.World.TerrainTypeNavCost;
    this.World.getNavigator().createSettings().RoadOnly = _roadOnly;
    return _start;
}

function onClear(this)
{
    return;
}

function onExecute(this, _faction)
{
    return;
}

function onUpdate(this, _faction)
{
    return;
}

function pickWeightedRandom(this, _list)
{
    if (0 < _list.len())
    {
    }
    if (0 < _list.len())
    {
        if (this.Math.rand(1, (0 + _list["0"].P) <= _list["0"].P))
        {
            return _list;
        }
    }
    return _list;
}

function resetCooldown(this)
{
    this.m.CooldownUntil = 0.0;
    return;
}

function setCooldownUntil(this, _c)
{
    this.m.CooldownUntil = _c;
    return;
}

function setFaction(this, _f)
{
    this.m.Faction = this.WeakTableRef(_f);
    return;
}

function update(this, _isNewCampaign)
{
    this.m.Score = 0;
    this.onClear();
    if ((this.m.Faction == 0) && (this.m.Faction == 0))
    {
        return ((this.m.Faction == 0) && (this.m.Faction == 0));
    }
    if ((this.Time >= this.m.CooldownUntil) && (this.Time >= this.m.CooldownUntil) && (this.Time >= this.m.CooldownUntil))
    {
        return ((this.Time >= this.m.CooldownUntil) && (this.Time >= this.m.CooldownUntil) && (this.Time >= this.m.CooldownUntil));
        this.onUpdate(this.m.Faction);
    }
    return;
}
