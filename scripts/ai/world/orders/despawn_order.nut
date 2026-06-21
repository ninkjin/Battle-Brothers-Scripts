// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/despawn_order.nut
// Functions: 4

function create(this)
{
    this.world_behavior.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.Despawn;
    return;
}

function onDeserialize(this, _in)
{
    this.world_behavior.onDeserialize(_in);
    return;
}

function onExecute(this, _entity, _hasChanged)
{
    _entity.fadeOutAndDie();
    this.getController().popOrder();
    return _entity;
}

function onSerialize(this, _out)
{
    this.world_behavior.onSerialize(_out);
    return;
}
