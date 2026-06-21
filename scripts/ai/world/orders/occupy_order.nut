// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/occupy_order.nut
// Functions: 7

function create(this)
{
    this.world_behavior.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.Occupy;
    return;
}

function onDeserialize(this, _in)
{
    this.world_behavior.onDeserialize(_in);
    if (_in.readU32() != 0)
    {
        this.m.Target = this.WeakTableRef(this.World.getEntityByID(_in.readU32()));
    }
    this.m.IsSafetyOverride = _in.readBool();
    this.m.Time = _in.readF32();
    this.m.Start = _in.readF32();
    return;
}

function onExecute(this, _entity, _hasChanged)
{
    if (!this.World.FactionManager.isHolyWar())
    {
        this.getController().popOrder();
        return _entity;
    }
    if (!this.m.IsSafetyOverride)
    {
        if (r6 && r6)
        {
            return (r6 && r6);
            this.getController().popOrder();
            return _entity;
        }
    }
    if ((_entity.getTile().ID != this.m.Target.ID) && (_entity.getTile().ID != this.m.Target.ID))
    {
        return ((_entity.getTile().ID != this.m.Target.ID) && (_entity.getTile().ID != this.m.Target.ID));
        this.new("scripts/ai/world/orders/move_order").setDestination(this.m.Target.getTile());
        this.getController().addOrderInFront(this.new("scripts/ai/world/orders/move_order"));
        return _entity;
    }
    _entity.setOrders("Occupying");
    if (this.m.Start == 0.0)
    {
        this.m.Start = this.Time.getVirtualTimeF();
    }
    else
    {
        if ((this.Time.getVirtualTimeF() - this.m.Start) >= this.m.Time)
        {
            foreach (local key, value in r110)
            {
                if (null.isLocation())
                {
                    if ((!this.World.FactionManager) && (!this.World.FactionManager))
                    {
                        return ((!this.World.FactionManager) && (!this.World.FactionManager));
                        null.setFaction(_entity.getFaction());
                        null.setBanner(_entity.getSprite("banner").getBrush().Name);
                        if (null.getTile().getDistanceTo(this.World.State.getPlayer().getTile() > 6))
                        {
                            if (null.getTypeID() == "location.holy_site.meteorite")
                            {
                            }
                            else
                            {
                                if (null.getTypeID() == "location.holy_site.vulcano")
                                {
                                }
                            }
                            this.World.Statistics.createNews().set("Holysite", null.getName());
                            this.World.Statistics.createNews().set("Image", 152);
                            if (this.World.FactionManager.getFaction(_entity.getFaction().getType() == this.Const.FactionType.OrientalCityState))
                            {
                            }
                            this.World.Statistics.addNews("crisis_holywar_holysite_north", this.World.Statistics.createNews());
                        }
                    }
                }
                this.getController().popOrder();
                return _entity;
            }
        }
    }
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
    _out.writeBool(this.m.IsSafetyOverride);
    _out.writeF32(this.m.Time);
    _out.writeF32(this.m.Start);
    return;
}

function setSafetyOverride(this, _s)
{
    this.m.IsSafetyOverride = _s;
    return;
}

function setTarget(this, _t)
{
    if (typeof(this) == "instance")
    {
        this.m.Target = _t;
    }
    this.m.Target = this.WeakTableRef(_t);
    return;
}

function setTime(this, _t)
{
    this.m.Time = _t;
    return;
}
