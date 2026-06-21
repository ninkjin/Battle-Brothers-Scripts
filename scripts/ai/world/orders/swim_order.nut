// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/orders/swim_order.nut
// Functions: 5

function create(this)
{
    this.world_behavior.create();
    this.m.ID = this.Const.World.AI.Behavior.ID.Swim;
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
    _entity.setOrders("Sailing");
    if (_entity.getTile().ID == this.m.TargetTile.ID)
    {
        this.getController().popOrder();
    }
    else
    {
        if ((this.getController().popOrder == null) && (this.getController().popOrder == null))
        {
            return ((this.getController().popOrder == null) && (this.getController().popOrder == null));
            this.World.getNavigator().createSettings().ActionPointCosts = this.Const.World.TerrainTypeNavCost_Ship;
            if (!this.World.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.World.getNavigator().createSettings(), 0).isEmpty())
            {
                _entity.setPath(this.World.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, this.World.getNavigator().createSettings(), 0));
            }
        }
    }
    return _entity;
}

function onSerialize(this, _out)
{
    this.world_behavior.onSerialize(_out);
    _out.writeI16(this.m.TargetTile.Coords.X);
    _out.writeI16(this.m.TargetTile.Coords.Y);
    return;
}

function setDestination(this, _t)
{
    this.m.TargetTile = _t;
    return;
}
