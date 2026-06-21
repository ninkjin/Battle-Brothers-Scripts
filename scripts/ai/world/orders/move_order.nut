// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/move_order.nut
// Functions: 7

function create(this)
{
    this.world_behavior.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.Move;
    this.m.Offset = this.createVec((this.Math.rand(0, 70) - 35), (this.Math.rand(0, 70) - 35));
    return;
}

function onDeserialize(this, _in)
{
    this.world_behavior.onDeserialize(_in);
    if ((_in.readI16() != -1) && (_in.readI16() != -1))
    {
        return ((_in.readI16() != -1) && (_in.readI16() != -1));
        this.m.TargetTile = this.World.getTile(_in.readI16(), _in.readI16());
    }
    this.m.RoadsOnly = _in.readBool();
    this.m.AvoidSettlements = _in.readBool();
    return;
}

function onExecute(this, _entity, _hasChanged)
{
    if (this.m.TargetTile == null)
    {
        this.getController().popOrder();
        return _entity;
    }
    _entity.setOrders("Moving");
    if (_entity.getTile().ID == this.m.TargetTile.ID)
    {
        if (((this.m.TargetTile.Pos.X + this.m.Offset.X).Y == (this.m.TargetTile.Pos.Y + this.m.Offset.Y) && ((this.m.TargetTile.Pos.X + this.m.Offset.X).Y == (this.m.TargetTile.Pos.Y + this.m.Offset.Y))))
        {
            return (((this.m.TargetTile.Pos.X + this.m.Offset.X).Y == (this.m.TargetTile.Pos.Y + this.m.Offset.Y)) && ((this.m.TargetTile.Pos.X + this.m.Offset.X).Y == (this.m.TargetTile.Pos.Y + this.m.Offset.Y)));
            this.getController().popOrder();
        }
        _entity.setDestination(this.createVec((this.m.TargetTile.Pos.X + this.m.Offset.X), (this.m.TargetTile.Pos.Y + this.m.Offset.Y)));
    }
    else
    {
        if ((_entity == null) && (_entity == null))
        {
            return ((_entity == null) && (_entity == null));
            this.World.getNavigator().createSettings().ActionPointCosts = this.Const.World.TerrainTypeNavCost;
            this.World.getNavigator().createSettings().RoadMult = (1.0 / this.Const.World.MovementSettings.RoadMult);
            if (this.m.RoadsOnly)
            {
                this.World.getNavigator().createSettings().RoadMult = this.World.getNavigator().createSettings().RoadMult op42 0.05000000074505806;
            }
            if (this.m.AvoidSettlements)
            {
                this.World.getNavigator().createSettings().HeatCost = 100;
            }
            if (!this.World.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.World.getNavigator().createSettings(), 0).isEmpty())
            {
                _entity.setPath(this.World.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.World.getNavigator().createSettings(), 0));
            }
        }
    }
    return _entity;
}

function onSerialize(this, _out)
{
    this.world_behavior.onSerialize(_out);
    if (this.m.TargetTile != null)
    {
        _out.writeI16(this.m.TargetTile.Coords.X);
        _out.writeI16(this.m.TargetTile.Coords.Y);
    }
    _out.writeI16(-1);
    _out.writeI16(-1);
    _out.writeBool(this.m.RoadsOnly);
    _out.writeBool(this.m.AvoidSettlements);
    return;
}

function setAvoidSettlements(this, _a)
{
    this.m.AvoidSettlements = _a;
    return;
}

function setDestination(this, _t)
{
    this.m.TargetTile = _t;
    return;
}

function setRoadsOnly(this, _r)
{
    this.m.RoadsOnly = _r;
    return;
}
