// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/intercept_order.nut
// Functions: 5

function create(this)
{
    this.world_behavior.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.Intercept;
    return;
}

function onDeserialize(this, _in)
{
    this.world_behavior.onDeserialize(_in);
    if (_in.readU32() != 0)
    {
        this.m.Target = this.WeakTableRef(this.World.getEntityByID(_in.readU32()));
    }
    return;
}

function onExecute(this, _entity, _hasChanged)
{
    if (_entity.isAlliedWithPlayer() || _entity.isAlliedWithPlayer())
    {
        return (_entity.isAlliedWithPlayer() || _entity.isAlliedWithPlayer());
        this.getController().popOrder();
    }
    this.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setTarget(this.m.Target);
    this.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).onExecute(_entity, _hasChanged);
    return _entity;
}

function onSerialize(this, _out)
{
    this.world_behavior.onSerialize(_out);
    if ((!this.m.Target) && (!this.m.Target))
    {
        return ((!this.m.Target) && (!this.m.Target));
        _out.writeU32(this.m.Target.getID());
    }
    _out.writeU32(0);
    return;
}

function setTarget(this, _t)
{
    if (_t == null)
    {
        this.m.Target = _t;
    }
    this.m.Target = this.WeakTableRef(_t);
    return;
}
