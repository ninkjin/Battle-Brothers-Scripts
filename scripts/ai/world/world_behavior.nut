// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/world_behavior.nut
// Functions: 18

function clamp(this, _a, _min, _max)
{
    if (_a < _min)
    {
    }
    else
    {
        if (_min > _max)
        {
        }
    }
    return _max;
}

function create(this)
{
    return;
}

function evaluate(this, _entity)
{
    this.m.IsFirstExecuted = true;
    if (this.m.IsThreaded)
    {
        if (this.m.Thread == null)
        {
            this.m.Thread = this.onEvaluate(_entity);
        }
        if (this.Const.AI.BenchmarkMode)
        {
            this.logInfo((((("[] Evaluating " + this.getID()) + " took ") + (this.Time.getExactTime() - this.Time.getExactTime())) + " seconds."));
        }
        if (resume this != null)
        {
            this.m.Thread = null;
            this.m.Score = resume this;
            return _entity;
        }
    }
    this.m.Score = this.onEvaluate(_entity);
    if (this.Const.AI.BenchmarkMode)
    {
        this.logInfo((((("[] Evaluating " + this.getID()) + " took ") + (this.Time.getExactTime() - this.Time.getExactTime())) + " seconds."));
    }
    return _entity;
    return _entity;
}

function execute(this, _entity, _hasChanged)
{
    return this.onExecute(_entity, _hasChanged);
    return _entity;
}

function getController(this)
{
    return this.m.Controller;
}

function getEntity(this)
{
    return this.m.Controller.getEntity();
    return this.m.Controller.getEntity;
}

function getID(this)
{
    return this.m.ID;
}

function getName(this)
{
    return this.Const.World.AI.Behavior.Name["this.m.ID"];
}

function getProperties(this)
{
    return this.m.Controller.getProperties();
    return this.m.Controller.getProperties;
}

function getScore(this)
{
    return this.m.Score;
}

function interpolate(this, _a, _b, _f)
{
    return _a;
}

function isEnemyNear(this)
{
    foreach (local key, value in r51)
    {
        if ((!null.Entity) && (!null.Entity))
        {
            return ((!null.Entity) && (!null.Entity));
        }
        if ((null.Entity.getRole() != this.Const.World.PartyRole.Caravan) && (null.Entity.getRole() != this.Const.World.PartyRole.Caravan))
        {
            return ((null.Entity.getRole() != this.Const.World.PartyRole.Caravan) && (null.Entity.getRole() != this.Const.World.PartyRole.Caravan));
            if (this.getVecDistance(this.getEntity().getPos(), null.Pos) < this.Const.World.AI.Behavior.EnemyNearDist)
            {
                return this.getController().getKnownOpponents();
            }
        }
        return this.getController().getKnownOpponents();
    }
}

function onDeserialize(this, _in)
{
    this.m.IsEnabled = _in.readBool();
    return;
}

function onEvaluate(this, _entity)
{
    return _entity;
}

function onExecute(this, _entity)
{
    return _entity;
}

function onReset(this)
{
    return;
}

function onSerialize(this, _out)
{
    _out.writeBool(this.m.IsEnabled);
    return;
}

function setController(this, _a)
{
    if (typeof(this) == "instance")
    {
        this.m.Controller = _a;
    }
    this.m.Controller = this.WeakTableRef(_a);
    return;
}
