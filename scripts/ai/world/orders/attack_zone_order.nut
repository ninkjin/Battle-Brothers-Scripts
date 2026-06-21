// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/attack_zone_order.nut
// Functions: 6

function <anonymous>(this)
{
    if (outer[0].onEnteringCombatWithPlayer(false))
    {
        this.World.State.showCombatDialog(false, true, true, null, outer[0].getPos());
    }
    return;
}

function create(this)
{
    this.world_behavior.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.AttackZone;
    return;
}

function onDeserialize(this, _in)
{
    this.world_behavior.onDeserialize(_in);
    this.m.TargetTile = this.World.getTile(_in.readI16(), _in.readI16());
    return;
}

function onExecute(this, _entity, _hasChanged)
{
    if ((_entity.getTile().ID != this.m.TargetTile.ID) && (_entity.getTile().ID != this.m.TargetTile.ID))
    {
        return ((_entity.getTile().ID != this.m.TargetTile.ID) && (_entity.getTile().ID != this.m.TargetTile.ID));
        this.new("scripts/ai/world/orders/move_order").setDestination(this.m.TargetTile);
        this.getController().addOrderInFront(this.new("scripts/ai/world/orders/move_order"));
        return _entity;
    }
    _entity.setOrders("Attacking Zone");
    if (this.World.getAllEntitiesAtPos(_entity.getPos(), this.Const.World.CombatSettings.CombatPlayerDistance).len() > 1)
    {
        foreach (local key, value in r33)
        {
            if (null.isPlayerControlled())
            {
            }
            if ((!null) && (!null))
            {
                return ((!null) && (!null));
            }
            if ((!null) && (!null))
            {
                return ((!null) && (!null));
            }
            if (null != null)
            {
                if (true && true)
                {
                    return (true && true);
                    this.World.State.setAIEngageCallback(function() /* closure #0 */);
                }
                this.World.Combat.startCombat(_entity, null);
            }
            this.getController().popOrder();
            return _entity;
        }
    }
}

function onSerialize(this, _out)
{
    this.world_behavior.onSerialize(_out);
    _out.writeI16(this.m.TargetTile.Coords.X);
    _out.writeI16(this.m.TargetTile.Coords.Y);
    return;
}

function setTargetTile(this, _t)
{
    this.m.TargetTile = _t;
    return;
}
