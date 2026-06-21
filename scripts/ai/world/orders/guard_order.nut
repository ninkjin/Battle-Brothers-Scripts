// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/guard_order.nut
// Functions: 6

function create(this)
{
    this.world_behavior.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.Guard;
    return;
}

function onDeserialize(this, _in)
{
    this.world_behavior.onDeserialize(_in);
    this.m.TargetTile = this.World.getTile(_in.readI16(), _in.readI16());
    this.m.WaitTime = _in.readF32();
    this.m.WaitTimeStart = _in.readF32();
    return;
}

function onExecute(this, _entity, _hasChanged)
{
    if (_entity.getTile().ID == this.m.TargetTile.ID)
    {
        _entity.setOrders("Guarding");
        if (this.m.WaitTimeStart == 0)
        {
            this.m.WaitTimeStart = this.Time.getVirtualTimeF();
        }
        else
        {
            if (((this.m.WaitTimeStart + this.m.WaitTime) <= this.Time) && ((this.m.WaitTimeStart + this.m.WaitTime) <= this.Time))
            {
                return (((this.m.WaitTimeStart + this.m.WaitTime) <= this.Time) && ((this.m.WaitTimeStart + this.m.WaitTime) <= this.Time));
                this.getController().popOrder();
            }
        }
    }
    else
    {
        _entity.setOrders("Falling back");
        if ((_entity == null) && (_entity == null))
        {
            return ((_entity == null) && (_entity == null));
            this.World.getNavigator().createSettings().ActionPointCosts = this.Const.World.TerrainTypeNavCost;
            this.World.getNavigator().createSettings().RoadMult = 1.0;
            if (!this.World.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.World.getNavigator().createSettings(), 0).isEmpty())
            {
                _entity.setPath(this.World.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.World.getNavigator().createSettings(), 0));
            }
            this.m.TargetTile = null;
        }
    }
    return _entity;
}

function onSerialize(this, _out)
{
    this.world_behavior.onSerialize(_out);
    _out.writeI16(this.m.TargetTile.Coords.X);
    _out.writeI16(this.m.TargetTile.Coords.Y);
    _out.writeF32(this.m.WaitTime);
    _out.writeF32(this.m.WaitTimeStart);
    return;
}

function setTarget(this, _t)
{
    this.m.TargetTile = _t;
    return;
}

function setTime(this, _t)
{
    this.m.WaitTime = _t;
    return;
}
