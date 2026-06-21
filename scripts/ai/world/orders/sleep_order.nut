// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/sleep_order.nut
// Functions: 6

function create(this)
{
    this.world_behavior.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.Sleep;
    return;
}

function onDeserialize(this, _in)
{
    this.world_behavior.onDeserialize(_in);
    this.m.Time = _in.readF32();
    this.m.Start = _in.readF32();
    return;
}

function onEvaluate(this, _entity)
{
    return _entity;
}

function onExecute(this, _entity, _hasChanged)
{
    _entity.setOrders("Sleeping");
    if (this.m.Start == 0.0)
    {
        this.m.Start = this.Time.getVirtualTimeF();
    }
    else
    {
        if ((this.Time.getVirtualTimeF() - this.m.Start) >= this.m.Time)
        {
            this.getController().popOrder();
        }
    }
    return _entity;
}

function onSerialize(this, _out)
{
    this.world_behavior.onSerialize(_out);
    _out.writeF32(this.m.Time);
    _out.writeF32(this.m.Start);
    return;
}

function setTime(this, _t)
{
    this.m.Time = _t;
    return;
}
