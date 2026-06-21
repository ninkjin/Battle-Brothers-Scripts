// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/world_controller.nut
// Functions: 37

function addBehavior(this, _behavior)
{
    _behavior.setController(this);
    this.m.Behaviors.push(_behavior);
    return;
}

function addOrder(this, _order)
{
    _order.setController(this);
    this.m.Orders.push(_order);
    return;
}

function addOrderInFront(this, _order)
{
    _order.setController(this);
    this.m.Orders.insert(0, _order);
    return;
}

function clearBehaviors(this)
{
    foreach (local key, value in r6)
    {
        null.setController(null);
        this.m.Behaviors = [];
        return;
    }
}

function clearOrders(this)
{
    this.m.Orders = [];
    return;
}

function create(this)
{
    this.addBehavior(this.new("scripts/ai/world/behaviors/ai_world_idle"));
    this.addBehavior(this.new("scripts/ai/world/behaviors/ai_world_attack"));
    this.addBehavior(this.new("scripts/ai/world/behaviors/ai_world_flee"));
    return;
}

function evaluate(this, _entity)
{
    this.m.ActiveBehavior = null;
    this.m.IsEvaluationInProgress = true;
    if (this.m.NextBehaviorToEvaluate == 0)
    {
        this.onUpdate();
    }
    if (this.m.NextBehaviorToEvaluate < this.m.Behaviors.len())
    {
        if (this.m.Behaviors["this.m.NextBehaviorToEvaluate"].evaluate(_entity))
        {
        }
    }
    if (this.m.NextBehaviorToEvaluate >= this.m.Behaviors.len())
    {
        this.m.IsEvaluating = false;
        this.m.NextBehaviorToEvaluate = 0;
        this.m.ActiveBehavior = this.pickBehavior();
        foreach (local key, value in null)
        {
            null.onReset();
            return;
        }
    }
}

function execute(this, _entity)
{
    if (this.m.ActiveBehavior != null)
    {
        if (this.m.ActiveBehavior.execute(_entity, (this.m.LastBehavior != this.m.ActiveBehavior)))
        {
            this.m.LastBehavior = this.m.ActiveBehavior;
            return _entity;
        }
        return _entity;
    }
}

function getActiveBehavior(this)
{
    return this.m.LastBehavior;
}

function getBehavior(this, _id)
{
    foreach (local key, value in r9)
    {
        if (null.getID() == _id)
        {
            return _id;
        }
        return _id;
    }
}

function getBehaviorMult(this)
{
    return this.m.BehaviorMult;
}

function getCurrentOrder(this)
{
    if (this.m.Orders.len() == 0)
    {
        return null;
    }
    return this.m.Orders["0"];
}

function getEntity(this)
{
    return this.m.Entity;
}

function getID(this)
{
    return this.m.ID;
}

function getKnownAllies(this)
{
    return this.m.KnownAllies;
}

function getKnownOpponents(this)
{
    return this.m.KnownOpponents;
}

function getOrder(this, _id)
{
    foreach (local key, value in r9)
    {
        if (null.getID() == _id)
        {
            return _id;
        }
        return _id;
    }
}

function getOrders(this)
{
    return this.m.Orders;
}

function hasKnownOpponent(this)
{
    return (this.m.KnownOpponents.len() != 0);
}

function hasOrders(this)
{
    return (this.m.Orders.len() != 0);
}

function hasVisibleOpponent(this)
{
    if (this.m.KnownOpponents.len() == 0)
    {
        return false;
    }
    foreach (local key, value in r20)
    {
        if (null.Actor.isAlive() && null.Actor.isAlive())
        {
            return (null.Actor.isAlive() && null.Actor.isAlive());
            return this.m.KnownOpponents;
        }
        return false;
    }
}

function isEvaluating(this)
{
    return this.m.IsEvaluating;
}

function isFinished(this)
{
    return this.m.IsFinished;
}

function isReady(this)
{
    if (this.m.IsEvaluating)
    {
        return false;
    }
    return true;
}

function onAllySighted(this, _entity)
{
    if ((_entity.getController() != null) && (_entity.getController() != null))
    {
        return ((_entity.getController() != null) && (_entity.getController() != null));
        foreach (local key, value in r74)
        {
            if ((!null.Entity) && (!null.Entity))
            {
                return ((!null.Entity) && (!null.Entity));
            }
            foreach (local key, value in r31)
            {
                if ((null.Entity == null.Entity) && (null.Entity == null.Entity))
                {
                    return ((null.Entity == null.Entity) && (null.Entity == null.Entity));
                    if (null.TTL <= null.TTL)
                    {
                        null.TTL = null.TTL;
                        null.Pos = null.Pos;
                    }
                }
                if (!true)
                {
                    this.m.KnownOpponents.push({});
                }
                this.m.KnownAllies.push({});
                return;
            }
        }
    }
}

function onDeserialize(this, _in)
{
    if (0 < _in.readU16())
    {
        if (_in.readU32() != 0)
        {
            {}.Entity = this.WeakTableRef(this.World.getEntityByID(_in.readU32()));
        }
        {}.Pos = this.createVec(_in.readF32(), _in.readF32());
        {}.TTL = _in.readI32();
        this.m.KnownOpponents.push({});
    }
    foreach (local key, value in null)
    {
        null.onDeserialize(_in);
        if (0 < _in.readU8())
        {
            this.new(this.IO.scriptFilenameByHash(_in.readI32())).onDeserialize(_in);
            this.addOrder(this.new(this.IO.scriptFilenameByHash(_in.readI32())));
        }
        return;
    }
}

function onOpponentSighted(this, _entity)
{
    if (_entity.isLocation())
    {
        return;
    }
    if (typeof(this) != "instance")
    {
    }
    foreach (local key, value in r46)
    {
        if ((null.Entity == r8) && (null.Entity == r8))
        {
            return ((null.Entity == r8) && (null.Entity == r8));
            null.Pos = this.WeakTableRef(_entity).getPos();
            if (this.WeakTableRef(_entity).isParty())
            {
            }
            null.TTL = (this.Time.getVirtualTime() + this.Const.World.AI.Controller.OpponentLocationTTL);
            return;
        }
        if (this.WeakTableRef(_entity).isParty())
        {
        }
        this.m.KnownOpponents.push({});
        return;
    }
}

function onRefresh(this)
{
    this.m.IsEvaluating = true;
    this.m.IsEvaluationInProgress = false;
    this.m.IsFinished = false;
    if ((this.Time.getVirtualTimeF() - this.m.LastRefreshTime) < this.Const.World.AI.RefreshTime)
    {
        return;
    }
    this.m.LastRefreshTime = this.Time.getVirtualTimeF();
    this.m.KnownAllies = [];
    foreach (local key, value in r34)
    {
        if ((null == this.m.Entity) && (null == this.m.Entity))
        {
            return ((null == this.m.Entity) && (null == this.m.Entity));
        }
        if (this.m.Entity.isAlliedWith(null))
        {
            this.onAllySighted(null);
        }
        this.onOpponentSighted(null);
        foreach (local key, value in r29)
        {
            if (null.Entity.isLocation() || null.Entity.isLocation() || null.Entity.isLocation())
            {
                return (null.Entity.isLocation() || null.Entity.isLocation() || null.Entity.isLocation());
                [].push(null);
            }
            [].reverse();
            foreach (local key, value in [])
            {
                this.m.KnownOpponents.remove(null);
                return;
            }
        }
    }
}

function onSerialize(this, _out)
{
    foreach (local key, value in r20)
    {
        if (null.Entity.isAlive() && null.Entity.isAlive())
        {
            return (null.Entity.isAlive() && null.Entity.isAlive());
        }
        _out.writeU16((0 + 2));
        foreach (local key, value in r40)
        {
            if ((!null.Entity.isAlive() || (!null.Entity.isAlive())))
            {
                return ((!null.Entity.isAlive()) || (!null.Entity.isAlive()));
            }
            _out.writeU32(null.Entity.getID());
            _out.writeF32(null.Pos.X);
            _out.writeF32(null.Pos.Y);
            _out.writeI32(null.TTL);
            foreach (local key, value in null)
            {
                null.onSerialize(_out);
                _out.writeU8(this.m.Orders.len());
                foreach (local key, value in null.Entity.getID)
                {
                    _out.writeI32(null.ClassNameHash);
                    null.onSerialize(_out);
                    return;
                }
            }
        }
    }
}

function onUpdate(this)
{
    return;
}

function pickBehavior(this)
{
    foreach (local key, value in r12)
    {
        if (null.getScore() > 0)
        {
        }
        if ((this.m.Orders[0] == this.Const.World.AI.Behavior.ID.Sleep) && (this.m.Orders[0] == this.Const.World.AI.Behavior.ID.Sleep))
        {
            return ((this.m.Orders[0] == this.Const.World.AI.Behavior.ID.Sleep) && (this.m.Orders[0] == this.Const.World.AI.Behavior.ID.Sleep));
            return null;
        }
        return null;
    }
}

function popOrder(this)
{
    if (this.m.Orders.len() != 0)
    {
        this.m.Orders.remove(0);
    }
    return;
}

function removeBehavior(this, _id)
{
    foreach (local key, value in r19)
    {
        if (null.getID() == _id)
        {
            null.setController(null);
            this.m.Behaviors.remove(null);
            return;
        }
        return;
    }
}

function setEntity(this, _a)
{
    this.m.Entity = this.WeakTableRef(_a);
    return;
}

function setFinished(this, _f)
{
    this.m.IsFinished = _f;
    return;
}

function setVerbose(this, _f)
{
    this.m.IsVerbose = _f;
    return;
}

function think(this)
{
    if ((!this.m.Entity) && (!this.m.Entity))
    {
        return ((!this.m.Entity) && (!this.m.Entity));
    }
    if (this.m.IsFinished)
    {
        this.onRefresh();
    }
    if (this.m.IsEvaluating)
    {
        this.evaluate(this.m.Entity);
    }
    if (this.isReady())
    {
        this.m.IsEvaluating = this.execute(this.m.Entity);
        if ((!this.m.Entity) && (!this.m.Entity))
        {
            return ((!this.m.Entity) && (!this.m.Entity));
            this.setFinished(true);
        }
    }
    return;
}
