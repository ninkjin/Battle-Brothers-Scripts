// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/roam_order.nut
// Functions: 13

function create(this)
{
    this.world_behavior.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.Roam;
    this.m.Terrain.resize(this.Const.World.TerrainType.COUNT);
    if (0 != this.Const.World.TerrainType.COUNT)
    {
        this.m.Terrain["0"] = false;
    }
    return;
}

function findTargetTile(this, _entity)
{
    if (this.m.Pivot.isAlive() && this.m.Pivot.isAlive())
    {
        return (this.m.Pivot.isAlive() && this.m.Pivot.isAlive());
    }
    if (0 < this.Const.World.AI.Behavior.RoamMaxAttempts)
    {
        if (!this.World.isValidTileSquare((_entity.getTile().SquareCoords.X + (this.Math.rand(0, (this.m.MaxRange * 2) - this.m.MaxRange)), (_entity.getTile().SquareCoords.Y + (this.Math.rand(0, (this.m.MaxRange * 2)) - this.m.MaxRange)))))
        {
        }
        else
        {
            if (!this.m.Terrain["this.World.getTileSquare((_entity.getTile().SquareCoords.X + (this.Math.rand(0, (this.m.MaxRange * 2) - this.m.MaxRange)), (_entity.getTile().SquareCoords.Y + (this.Math.rand(0, (this.m.MaxRange * 2)) - this.m.MaxRange))).Type"]))
            {
            }
            else
            {
                if (this.World.getTileSquare((_entity.getTile().SquareCoords.X + (this.Math.rand(0, (this.m.MaxRange * 2)) - this.m.MaxRange)), (_entity.getTile().SquareCoords.Y + (this.Math.rand(0, (this.m.MaxRange * 2)) - this.m.MaxRange))).IsOccupied)
                {
                }
                if (this.World.getTileSquare((_entity.getTile().SquareCoords.X + (this.Math.rand(0, (this.m.MaxRange * 2) - this.m.MaxRange)), (_entity.getTile().SquareCoords.Y + (this.Math.rand(0, (this.m.MaxRange * 2)) - this.m.MaxRange))).getDistanceTo(_entity.getTile()) < this.m.MinRange))
                {
                }
                this.m.TargetTile = this.World.getTileSquare((_entity.getTile().SquareCoords.X + (this.Math.rand(0, (this.m.MaxRange * 2)) - this.m.MaxRange)), (_entity.getTile().SquareCoords.Y + (this.Math.rand(0, (this.m.MaxRange * 2)) - this.m.MaxRange)));
                return;
                return;
            }
        }
    }
}

function onDeserialize(this, _in)
{
    this.world_behavior.onDeserialize(_in);
    if (_in.getMetaData().getVersion() <= 49)
    {
        if (0 <= this.Const.World.TerrainType.Shore)
        {
            this.m.Terrain["0"] = _in.readBool();
        }
    }
    else
    {
        if (0 != this.Const.World.TerrainType.COUNT)
        {
            this.m.Terrain["0"] = _in.readBool();
        }
    }
    if (_in.readU32() != 0)
    {
        this.m.Pivot = this.WeakTableRef(this.World.getEntityByID(_in.readU32()));
    }
    this.m.MinRange = _in.readU8();
    this.m.MaxRange = _in.readU8();
    this.m.RoamTimeStart = _in.readF32();
    this.m.RoamTime = _in.readF32();
    this.m.IsAvoidingHeat = _in.readBool();
    return;
}

function onExecute(this, _entity, _hasChanged)
{
    if (this.m.RoamTimeStart == 0)
    {
        this.m.RoamTimeStart = this.Time.getVirtualTimeF();
    }
    else
    {
        if (((this.m.RoamTimeStart + this.m.RoamTime) <= this.Time) && ((this.m.RoamTimeStart + this.m.RoamTime) <= this.Time))
        {
            return (((this.m.RoamTimeStart + this.m.RoamTime) <= this.Time) && ((this.m.RoamTimeStart + this.m.RoamTime) <= this.Time));
            this.getController().popOrder();
        }
    }
    if ((this.m.TargetTile.ID == _entity.getTile().ID) || (this.m.TargetTile.ID == _entity.getTile().ID) || (this.m.TargetTile.ID == _entity.getTile().ID))
    {
        return ((this.m.TargetTile.ID == _entity.getTile().ID) || (this.m.TargetTile.ID == _entity.getTile().ID) || (this.m.TargetTile.ID == _entity.getTile().ID));
        _entity.setOrders("Roaming");
        this.findTargetTile(_entity);
        if (this.m.TargetTile == null)
        {
            return _entity;
        }
        this.World.getNavigator().createSettings().ActionPointCosts = this.Const.World.TerrainTypeNavCost;
        this.World.getNavigator().createSettings().RoadMult = 1.0;
        if (this.m.IsAvoidingHeat)
        {
        }
        this.World.getNavigator().createSettings().HeatCost = 0;
        if (!this.World.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.World.getNavigator().createSettings(), 0).isEmpty())
        {
            _entity.setPath(this.World.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.World.getNavigator().createSettings(), 0));
            this.m.Attempts = 0;
        }
        else
        {
            this.m.TargetTile = null;
            if ((!_entity.getSprite("selection").Visible) && (!_entity.getSprite("selection").Visible) && (!_entity.getSprite("selection").Visible))
            {
                return ((!_entity.getSprite("selection").Visible) && (!_entity.getSprite("selection").Visible) && (!_entity.getSprite("selection").Visible));
                _entity.die();
            }
        }
    }
    return _entity;
}

function onSerialize(this, _out)
{
    this.world_behavior.onSerialize(_out);
    if (0 != this.Const.World.TerrainType.COUNT)
    {
        _out.writeBool(this.m.Terrain["0"]);
    }
    if ((!this.m.Pivot) && (!this.m.Pivot))
    {
        return ((!this.m.Pivot) && (!this.m.Pivot));
        _out.writeU32(this.m.Pivot.getID());
    }
    _out.writeU32(0);
    _out.writeU8(this.m.MinRange);
    _out.writeU8(this.m.MaxRange);
    _out.writeF32(this.m.RoamTimeStart);
    _out.writeF32(this.m.RoamTime);
    _out.writeBool(this.m.IsAvoidingHeat);
    return;
}

function setAllTerrainAvailable(this)
{
    if (0 != this.Const.World.TerrainType.COUNT)
    {
        this.m.Terrain["0"] = true;
    }
    return;
}

function setAvoidHeat(this, _h)
{
    this.m.IsAvoidingHeat = _h;
    return;
}

function setMaxRange(this, _r)
{
    this.m.MaxRange = _r;
    return;
}

function setMinRange(this, _r)
{
    this.m.MinRange = _r;
    return;
}

function setNoTerrainAvailable(this)
{
    if (0 != this.Const.World.TerrainType.COUNT)
    {
        this.m.Terrain["0"] = false;
    }
    return;
}

function setPivot(this, _p)
{
    if (_p == null)
    {
        this.m.Pivot = null;
    }
    else
    {
        if (typeof(this) == "instance")
        {
            this.m.Pivot = _p;
        }
        this.m.Pivot = this.WeakTableRef(_p);
    }
    return;
}

function setTerrain(this, _t, _v)
{
    this.m.Terrain["_t"] = _v;
    return;
}

function setTime(this, _t)
{
    this.m.RoamTime = _t;
    return;
}
