// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/destroy_order.nut
// Functions: 8

function create(this)
{
    this.world_behavior.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.Destroy;
    return;
}

function onDeserialize(this, _in)
{
    this.world_behavior.onDeserialize(_in);
    this.m.TargetTile = this.World.getTile(_in.readI16(), _in.readI16());
    this.m.TargetID = _in.readU32();
    this.m.IsSafetyOverride = _in.readBool();
    this.m.Time = _in.readF32();
    this.m.Start = _in.readF32();
    return;
}

function onExecute(this, _entity, _hasChanged)
{
    if (!this.World.FactionManager.isGreaterEvil())
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
    _entity.setOrders("Destroying");
    if (this.m.Start == 0.0)
    {
        this.m.Start = this.Time.getVirtualTimeF();
    }
    else
    {
        if ((this.Time.getVirtualTimeF() - this.m.Start) >= this.m.Time)
        {
            foreach (local key, value in r89)
            {
                if ((null == this.m.TargetID) && (null == this.m.TargetID))
                {
                    return ((null == this.m.TargetID) && (null == this.m.TargetID));
                    if ((!this.World.Assets.isPermanentDestruction) && (!this.World.Assets.isPermanentDestruction))
                    {
                        return ((!this.World.Assets.isPermanentDestruction) && (!this.World.Assets.isPermanentDestruction));
                        this.World.Statistics.createNews().set("City", null.getName());
                        this.World.Statistics.addNews("crisis_greenskins_town_destroyed", this.World.Statistics.createNews());
                        this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnTownDestroyed);
                        null.setActive(false);
                        null.getTile().spawnDetail((null.m.Sprite + "_ruins"), (this.Const.World.ZLevel.Object - 3), 0, false);
                        null.fadeOutAndDie();
                        this.World.EntityManager.updateSettlementHeat();
                    }
                    null.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 14);
                }
                this.getController().popOrder();
                if (!this.m.IsBurning)
                {
                    this.m.IsBurning = true;
                    foreach (local key, value in 14)
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
    _out.writeU32(this.m.TargetID);
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

function setTargetID(this, _id)
{
    this.m.TargetID = _id;
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
