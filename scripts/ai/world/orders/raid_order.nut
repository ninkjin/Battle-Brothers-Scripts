// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/raid_order.nut
// Functions: 6

function create(this)
{
    this.world_behavior.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.Raid;
    return;
}

function onDeserialize(this, _in)
{
    this.world_behavior.onDeserialize(_in);
    this.m.TargetTile = this.World.getTile(_in.readI16(), _in.readI16());
    this.m.Time = _in.readF32();
    this.m.Start = _in.readF32();
    return;
}

function onExecute(this, _entity, _hasChanged)
{
    if ((null.ID != this.m.TargetTile.ID) && (null.ID != this.m.TargetTile.ID))
    {
        return ((null.ID != this.m.TargetTile.ID) && (null.ID != this.m.TargetTile.ID));
        this.new("scripts/ai/world/orders/move_order").setDestination(this.m.TargetTile);
        this.getController().addOrderInFront(this.new("scripts/ai/world/orders/move_order"));
        return _entity;
    }
    _entity.setOrders("Raiding");
    if (this.m.Start == 0.0)
    {
        this.m.Start = this.Time.getVirtualTimeF();
    }
    else
    {
        if ((this.Time.getVirtualTimeF() - this.m.Start) >= this.m.Time)
        {
            foreach (local key, value in r81)
            {
                if (null.isLocation())
                {
                    null.setActive(false);
                    if (null.getSettlement().isAlive() && null.getSettlement().isAlive())
                    {
                        return (null.getSettlement().isAlive() && null.getSettlement().isAlive());
                        if ((this.Const.FactionType.Undead == this.Const.FactionType.Zombies) && (this.Const.FactionType.Undead == this.Const.FactionType.Zombies))
                        {
                            return ((this.Const.FactionType.Undead == this.Const.FactionType.Zombies) && (this.Const.FactionType.Undead == this.Const.FactionType.Zombies));
                        }
                        this.new("scripts/entity/world/settlements/situations/raided_situation").setValidForDays(2);
                        null.getSettlement().addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"));
                    }
                }
                this.getController().popOrder();
                if (!this.m.IsBurning)
                {
                    this.m.IsBurning = true;
                    foreach (local key, value in this.new("scripts/entity/world/settlements/situations/raided_situation"))
                    {
                        if (null.isLocation())
                        {
                            null.spawnFireAndSmoke();
                        }
                        return _entity;
                    }
                }
            }
        }
    }
}

function onSerialize(this, _out)
{
    this.world_behavior.onSerialize(_out);
    _out.writeI16(this.m.TargetTile.Coords.X);
    _out.writeI16(this.m.TargetTile.Coords.Y);
    _out.writeF32(this.m.Time);
    _out.writeF32(this.m.Start);
    return;
}

function setTargetTile(this, _t)
{
    this.m.TargetTile = _t;
    return;
}

function setTime(this, _t)
{
    this.m.Time = _t;
    return;
}
