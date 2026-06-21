// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/patrol_order.nut
// Functions: 6

function <anonymous>(this, _a, _b)
{
    if (_a.getTile().getDistanceTo(outer[0]) > _b.getTile().getDistanceTo(outer[0]))
    {
        return _a;
    }
    else
    {
        if (_a.getTile().getDistanceTo(outer[0]) < _b.getTile().getDistanceTo(outer[0]))
        {
            return _a;
        }
    }
    return _a;
}

function create(this)
{
    this.move_order.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.Patrol;
    return;
}

function onDeserialize(this, _in)
{
    this.move_order.onDeserialize(_in);
    this.m.WaitTime = _in.readF32();
    return;
}

function onExecute(this, _entity, _hasChanged)
{
    if (this.m.TargetTile == null)
    {
        if (this.m.WaitTime != 0)
        {
            this.new("scripts/ai/world/orders/wait_order").setTime(this.m.WaitTime);
            this.getController().addOrderInFront(this.new("scripts/ai/world/orders/wait_order"));
        }
        clone this.sort(function() /* closure #0 */);
        this.m.TargetTile = clone this["this.Math.rand(0, this.Math.max(3, (clone this.len() - 1)))"].getTile();
        return _entity;
    }
    _entity.setOrders("Patrolling");
    if (_entity.getTile().ID == this.m.TargetTile.ID)
    {
        if (((this.m.TargetTile.Pos.X + this.m.Offset.X).Y == (this.m.TargetTile.Pos.Y + this.m.Offset.Y) && ((this.m.TargetTile.Pos.X + this.m.Offset.X).Y == (this.m.TargetTile.Pos.Y + this.m.Offset.Y))))
        {
            return (((this.m.TargetTile.Pos.X + this.m.Offset.X).Y == (this.m.TargetTile.Pos.Y + this.m.Offset.Y)) && ((this.m.TargetTile.Pos.X + this.m.Offset.X).Y == (this.m.TargetTile.Pos.Y + this.m.Offset.Y)));
            this.m.TargetTile = null;
            return _entity;
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
    this.move_order.onSerialize(_out);
    _out.writeF32(this.m.WaitTime);
    return;
}

function setWaitTime(this, _w)
{
    this.m.WaitTime = _w;
    return;
}
