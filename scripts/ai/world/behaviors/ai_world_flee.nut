// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/behaviors/ai_world_flee.nut
// Functions: 7

function create(this)
{
    this.m.ID = this.Const.World.AI.Behavior.ID.Flee;
    this.world_behavior.create();
    return;
}

function onDeserialize(this, _in)
{
    this.world_behavior.onDeserialize(_in);
    this.m.DecidedToFleeTime = _in.readF32();
    return;
}

function onEvaluate(this, _entity)
{
    if ((!_entity.isAttackable() || (!_entity.isAttackable())))
    {
        return ((!_entity.isAttackable()) || (!_entity.isAttackable()));
        return _entity;
    }
    if (_entity.getStrength() == 0)
    {
        return _entity;
    }
    if (_entity.isInCombat())
    {
        return _entity;
    }
    if (!this.getController().hasKnownOpponent())
    {
        return _entity;
    }
    if ((this.Const.World.AI.Behavior.ID.Guard == this.Const.World.AI.Behavior.ID.Despawn) && (this.Const.World.AI.Behavior.ID.Guard == this.Const.World.AI.Behavior.ID.Despawn))
    {
        return ((this.Const.World.AI.Behavior.ID.Guard == this.Const.World.AI.Behavior.ID.Despawn) && (this.Const.World.AI.Behavior.ID.Guard == this.Const.World.AI.Behavior.ID.Despawn));
        return _entity;
    }
    if ((this.Time.getVirtualTimeF() - this.m.DecidedToFleeTime) <= this.Const.World.AI.Behavior.FleeMinTime)
    {
        return _entity;
    }
    foreach (local key, value in r169)
    {
        if ((!null.Entity.isLocation() || (!null.Entity.isLocation())))
        {
            return ((!null.Entity.isLocation()) || (!null.Entity.isLocation()));
        }
        else
        {
            if (null.Entity.isLocation())
            {
            }
            else
            {
                if (null.Entity.getStrength() == 0)
                {
                }
                else
                {
                    if (null.Entity && null.Entity)
                    {
                        return (null.Entity && null.Entity);
                    }
                    if (this.getVecDistance(_entity.getPos(), null.Entity.getPos() > this.Const.World.AI.Behavior.AttackMaxRange))
                    {
                    }
                    if (_entity.isAbleToSee(null.Entity))
                    {
                    }
                    if ((null.Entity.getStrength() / _entity.getStrength() <= 1.3300000429153442))
                    {
                    }
                    if ((null.Entity.isLocation < null.Entity) && (null.Entity.isLocation < null.Entity))
                    {
                        return ((null.Entity.isLocation < null.Entity) && (null.Entity.isLocation < null.Entity));
                    }
                    if ((((((1.0 * ((1.0 - this.Const.World.AI.Behavior.AttackDistanceMult) + ((1.0 - (this.getVecDistance(_entity.getPos(), null.Entity.getPos() / this.Const.World.AI.Behavior.AttackMaxRange)) * this.Const.World.AI.Behavior.AttackDistanceMult))) * this.Const.World.AI.Behavior.FleeFromVisibleTargetMult) * (null.Entity.getStrength() / (_entity.getStrength() * 1.3300000429153442))) * 0.5) + (((((1.0 * ((1.0 - this.Const.World.AI.Behavior.AttackDistanceMult) + ((1.0 - (this.getVecDistance(_entity.getPos(), null.Entity.getPos()) / this.Const.World.AI.Behavior.AttackMaxRange)) * this.Const.World.AI.Behavior.AttackDistanceMult))) * this.Const.World.AI.Behavior.FleeFromVisibleTargetMult) * (null.Entity.getStrength() / (_entity.getStrength() * 1.3300000429153442))) * (_entity.getBaseMovementSpeed() / null.Entity.getBaseMovementSpeed())) * 0.5)) >= this.Const.World.AI.Behavior.FleeMinScore))
                    {
                    }
                    if ((0 + 5) == 0)
                    {
                        return _entity;
                    }
                    return _entity;
                }
            }
        }
    }
}

function onExecute(this, _entity, _hasChanged)
{
    if (((this.Time.getVirtualTimeF() - this.m.DecidedToFleeTime) >= this.Const.World.AI.Behavior.FleeMinTime) || ((this.Time.getVirtualTimeF() - this.m.DecidedToFleeTime) >= this.Const.World.AI.Behavior.FleeMinTime))
    {
        return (((this.Time.getVirtualTimeF() - this.m.DecidedToFleeTime) >= this.Const.World.AI.Behavior.FleeMinTime) || ((this.Time.getVirtualTimeF() - this.m.DecidedToFleeTime) >= this.Const.World.AI.Behavior.FleeMinTime));
        this.m.DecidedToFleeTime = this.Time.getVirtualTimeF();
        clone this.extend(this.getController().getKnownAllies());
        foreach (local key, value in r145)
        {
            if ((!null.Entity.isLocation() || (!null.Entity.isLocation())))
            {
                return ((!null.Entity.isLocation()) || (!null.Entity.isLocation()));
            }
            if (this.getVecDistance(_entity.getPos(), null.Entity.getPos() > this.Const.World.AI.Behavior.AttackMaxRange))
            {
            }
            if ((null.Entity.getStrength() / _entity.getStrength() <= 0.5))
            {
            }
            if (_entity.isAlliedWith(null.Entity))
            {
            }
            if ((_entity.getDirectionTo(null.Entity.get() - 1) >= 0))
            {
            }
            if ((_entity.getDirectionTo(null.Entity.get() - 2) >= 0))
            {
            }
            if ((_entity.getDirectionTo(null.Entity.get() + 1) < this.Const.Direction.COUNT))
            {
            }
            if ((_entity.getDirectionTo(null.Entity.get() + 2) < this.Const.Direction.COUNT))
            {
            }
            []["_entity.getDirectionTo(null.Entity.get())"].Score = []["_entity.getDirectionTo(null.Entity.get())"].Score op43 (4 * 1);
            []["(this.Const.Direction.COUNT - 1)"].Score = []["(this.Const.Direction.COUNT - 1)"].Score op43 (3 * 1);
            []["(this.Const.Direction.COUNT - 2)"].Score = []["(this.Const.Direction.COUNT - 2)"].Score op43 (1 * 1);
            []["0"].Score = []["0"].Score op43 (3 * 1);
            []["1"].Score = []["1"].Score op43 (1 * 1);
            [].sort(this.onSortByLowestScore);
            this.World.getNavigator().createSettings().ActionPointCosts = this.Const.World.TerrainTypeNavCost;
            this.World.getNavigator().createSettings().RoadMult = (1.0 / this.Const.World.MovementSettings.RoadMult);
            foreach (local key, value in r95)
            {
                if (0 < this.Const.World.AI.Behavior.FleeMaxAttemptsPerDirection)
                {
                    if ((0 + 7) > this.Const.World.AI.Behavior.FleeMaxAttempts)
                    {
                    }
                    if (!this.World.isValidTile((_entity.getTile().X + (this.Const.DirectionStep["null.Dir"]["0"] * this.Math.rand(2, 5)), (_entity.getTile().Y + (this.Const.DirectionStep["null.Dir"]["1"] * this.Math.rand(2, 5))))))
                    {
                    }
                    else
                    {
                        if (this.World.getTile((_entity.getTile().X + (this.Const.DirectionStep["null.Dir"]["0"] * this.Math.rand(2, 5)), (_entity.getTile().Y + (this.Const.DirectionStep["null.Dir"]["1"] * this.Math.rand(2, 5)))).Type == this.Const.World.TerrainType.Ocean))
                        {
                        }
                        else
                        {
                            if (!this.World.getNavigator().findPath(_entity.getTile(), this.World.getTile((_entity.getTile().X + (this.Const.DirectionStep["null.Dir"]["0"] * this.Math.rand(2, 5)), (_entity.getTile().Y + (this.Const.DirectionStep["null.Dir"]["1"] * this.Math.rand(2, 5)))), this.World.getNavigator().createSettings(), 0).isEmpty()))
                            {
                                _entity.setPath(this.World.getNavigator().findPath(_entity.getTile(), this.World.getTile((_entity.getTile().X + (this.Const.DirectionStep["null.Dir"]["0"] * this.Math.rand(2, 5))), (_entity.getTile().Y + (this.Const.DirectionStep["null.Dir"]["1"] * this.Math.rand(2, 5)))), this.World.getNavigator().createSettings(), 0));
                            }
                        }
                    }
                }
                _entity.setOrders("Fleeing");
                return _entity;
            }
        }
    }
}

function onSerialize(this, _out)
{
    this.world_behavior.onSerialize(_out);
    _out.writeF32(this.m.DecidedToFleeTime);
    return;
}

function onSortByLowestScore(this, _d1, _d2)
{
    if (_d1.Score < _d2.Score)
    {
        return _d1;
    }
    else
    {
        if (_d1.Score > _d2.Score)
        {
            return _d1;
        }
    }
    return _d1;
}

function setEnabled(this, _e)
{
    this.m.IsEnabled = _e;
    return;
}
