// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/mercenary_order.nut
// Functions: 5

function create(this)
{
    this.world_behavior.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.Mercenary;
    return;
}

function onDeserialize(this, _in)
{
    this.world_behavior.onDeserialize(_in);
    if (_in.readU32() != 0)
    {
        if (this.World.getEntityByID(_in.readU32() != null))
        {
            this.m.TargetSettlement = this.WeakTableRef(this.World.getEntityByID(_in.readU32()));
        }
    }
    return;
}

function onExecute(this, _entity, _hasChanged)
{
    if ((!this.m.TargetSettlement.isAlive() || (!this.m.TargetSettlement.isAlive())))
    {
        return ((!this.m.TargetSettlement.isAlive()) || (!this.m.TargetSettlement.isAlive()));
        this.getController().popOrder();
        return _entity;
    }
    if (this.m.TargetSettlement.getTile().ID != _entity.getTile().ID)
    {
        this.new("scripts/ai/world/orders/move_order").setDestination(this.m.TargetSettlement.getTile());
        this.getController().addOrderInFront(this.new("scripts/ai/world/orders/move_order"));
        return _entity;
    }
    _entity.setOrders("Getting Hired");
    _entity.clearTroops();
    this.Const.World.Common.assignTroops(_entity, this.Const.World.Spawn.Mercenaries, this.Math.rand((this.Math.min(350, (150 + this.World.getTime().Days)) * 0.800000011920929), this.Math.min(350, (150 + this.World.getTime().Days))), 0);
    _entity.getSprite("body").setBrush(_entity.getSprite("body").getBrush().Name);
    if (this.m.TargetSettlement.getFactions().len() == 1)
    {
        _entity.setFaction(this.m.TargetSettlement.getOwner().getID());
    }
    _entity.setFaction(this.m.TargetSettlement.getFactionOfType(this.Const.FactionType.Settlement).getID());
    this.getController().popOrder();
    return _entity;
}

function onSerialize(this, _out)
{
    this.world_behavior.onSerialize(_out);
    if (this.m.TargetSettlement.isAlive() && this.m.TargetSettlement.isAlive())
    {
        return (this.m.TargetSettlement.isAlive() && this.m.TargetSettlement.isAlive());
        _out.writeU32(this.m.TargetSettlement.getID());
    }
    _out.writeU32(0);
    return;
}

function setSettlement(this, _t)
{
    this.m.TargetSettlement = this.WeakTableRef(_t);
    return;
}
