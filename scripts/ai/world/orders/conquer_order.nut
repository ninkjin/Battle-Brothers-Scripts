// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/conquer_order.nut
// Functions: 7

function create(this)
{
    this.world_behavior.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.Conquer;
    return;
}

function onDeserialize(this, _in)
{
    this.world_behavior.onDeserialize(_in);
    this.m.TargetTile = this.World.getTile(_in.readI16(), _in.readI16());
    this.m.IsSafetyOverride = _in.readBool();
    this.m.Time = _in.readF32();
    this.m.Start = _in.readF32();
    return;
}

function onExecute(this, _entity, _hasChanged)
{
    if (!this.World.FactionManager.isCivilWar())
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
    if ((_entity.getTile().ID != this.m.TargetTile.ID) && (_entity.getTile().ID != this.m.TargetTile.ID))
    {
        return ((_entity.getTile().ID != this.m.TargetTile.ID) && (_entity.getTile().ID != this.m.TargetTile.ID));
        this.new("scripts/ai/world/orders/move_order").setDestination(this.m.TargetTile);
        this.getController().addOrderInFront(this.new("scripts/ai/world/orders/move_order"));
        return _entity;
    }
    _entity.setOrders("Conquering");
    if (this.m.Start == 0.0)
    {
        this.m.Start = this.Time.getVirtualTimeF();
    }
    else
    {
        if ((this.Time.getVirtualTimeF() - this.m.Start) >= this.m.Time)
        {
            foreach (local key, value in r179)
            {
                if (null.isLocation())
                {
                    if ((!(null.getOwner().getID() != _entity.getFaction()) && (!(null.getOwner().getID() != _entity.getFaction())) && (!(null.getOwner().getID() != _entity.getFaction()))))
                    {
                        return ((!(null.getOwner().getID() != _entity.getFaction())) && (!(null.getOwner().getID() != _entity.getFaction())) && (!(null.getOwner().getID() != _entity.getFaction())));
                        this.World.Statistics.createNews().set("Conqueror", this.World.FactionManager.getFaction(_entity.getFaction()).getName());
                        this.World.Statistics.createNews().set("Defeated", null.getOwner().getName());
                        this.World.Statistics.createNews().set("City", null.getName());
                        this.World.Statistics.addNews("crisis_civilwar_town_conquered", this.World.Statistics.createNews());
                        if (null.getOwner() != null)
                        {
                            null.getOwner().removeAlly(null.getFactionOfType(this.Const.FactionType.Settlement).getID());
                            null.removeFaction(null.getOwner().getID());
                        }
                        this.World.FactionManager.getFaction(_entity.getFaction()).addSettlement(null);
                        this.World.FactionManager.getFaction(_entity.getFaction()).addAlly(null.getFactionOfType(this.Const.FactionType.Settlement).getID());
                        null.getFactionOfType(this.Const.FactionType.Settlement).cloneAlliesFrom(this.World.FactionManager.getFaction(_entity.getFaction()));
                        if ((!this.World.FactionManager.getFaction(_entity.getFaction()) && (!this.World.FactionManager.getFaction(_entity.getFaction()))))
                        {
                            return ((!this.World.FactionManager.getFaction(_entity.getFaction())) && (!this.World.FactionManager.getFaction(_entity.getFaction())));
                            if (null.getFactionOfType(this.Const.FactionType.Settlement).getPlayerRelation() < 25.0)
                            {
                                null.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelationEx(this.Math.minf(25.0, (25.0 - null.getFactionOfType(this.Const.FactionType.Settlement).getPlayerRelation())));
                            }
                        }
                        else
                        {
                            if ((!null.getOwner() && (!null.getOwner())))
                            {
                                return ((!null.getOwner()) && (!null.getOwner()));
                                if (null.getFactionOfType(this.Const.FactionType.Settlement).getPlayerRelation() >= 20.0)
                                {
                                    null.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelationEx((-this));
                                }
                            }
                        }
                        this.new("scripts/entity/world/settlements/situations/conquered_situation").setValidForDays(3);
                        null.addSituation(this.new("scripts/entity/world/settlements/situations/conquered_situation"));
                    }
                }
                this.getController().popOrder();
                if (!this.m.IsBurning)
                {
                    this.m.IsBurning = true;
                    foreach (local key, value in null.getFactionOfType(this.Const.FactionType.Settlement))
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
