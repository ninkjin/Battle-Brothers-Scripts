// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/unload_order.nut
// Functions: 2

function create(this)
{
    this.world_behavior.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.Unload;
    return;
}

function onExecute(this, _entity, _hasChanged)
{
    foreach (local key, value in r26)
    {
        if (null && null)
        {
            return (null && null);
            foreach (local key, value in null)
            {
                null.addImportedProduce(null);
                _entity.clearInventory();
                this.getController().popOrder();
                return _entity;
            }
        }
    }
}
