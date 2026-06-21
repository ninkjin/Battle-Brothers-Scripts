// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/ambush_order.nut
// Functions: 6

function create(this)
{
    this.world_behavior.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.Ambush;
    return;
}

function findTargetTile(this, _entity)
{
    this.m.TargetTile = null;
    foreach (local key, value in r9)
    {
        null.Distance = null.Tile.getDistanceTo(_entity.getTile());
        this.World.EntityManager.getAmbushSpots().sort(this.onSortByLowestDistance);
        this.m.TargetTile = this.World.EntityManager.getAmbushSpots()["this.Math.rand(0, this.Math.min((this.World.EntityManager.getAmbushSpots().len() - 1), this.Const.World.AI.Behavior.AmbushMaxSpots))"].Tile;
        return;
    }
}

function onDeserialize(this, _in)
{
    this.world_behavior.onDeserialize(_in);
    this.m.WaitTimeStart = _in.readF32();
    return;
}

function onExecute(this, _entity, _hasChanged)
{
    if ((null.ID == this.m.TargetTile.ID) && (null.ID == this.m.TargetTile.ID))
    {
        return ((null.ID == this.m.TargetTile.ID) && (null.ID == this.m.TargetTile.ID));
        if (this.m.WaitTimeStart == 0)
        {
            _entity.setOrders("Lying in Ambush");
            this.m.WaitTimeStart = this.Time.getVirtualTimeF();
        }
        else
        {
            if ((this.m.WaitTimeStart + this.Const.World.AI.Behavior.AmbushWaitTime) <= this.Time.getVirtualTimeF())
            {
                this.getController().popOrder();
            }
        }
    }
    else
    {
        _entity.setOrders("Preparing Ambush");
        if ((_entity == null) && (_entity == null))
        {
            return ((_entity == null) && (_entity == null));
            this.findTargetTile(_entity);
            if (this.m.TargetTile == null)
            {
                this.getController().popOrder();
            }
            this.World.getNavigator().createSettings().ActionPointCosts = this.Const.World.TerrainTypeNavCost_Sneak;
            this.World.getNavigator().createSettings().RoadMult = 1.0;
            this.World.getNavigator().createSettings().HeatCost = 100;
            if (!this.World.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.World.getNavigator().createSettings(), 0).isEmpty())
            {
                _entity.setPath(this.World.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.World.getNavigator().createSettings(), 0));
            }
            else
            {
                this.m.TargetTile = null;
                if ((this.m + 5) >= 10)
                {
                    this.getController().popOrder();
                }
            }
        }
    }
    return _entity;
}

function onSerialize(this, _out)
{
    this.world_behavior.onSerialize(_out);
    _out.writeF32(this.m.WaitTimeStart);
    return;
}

function onSortByLowestDistance(this, _d1, _d2)
{
    if (_d1.Distance > _d2.Distance)
    {
        return _d1;
    }
    else
    {
        if (_d1.Distance < _d2.Distance)
        {
            return _d1;
        }
    }
    return _d1;
}
