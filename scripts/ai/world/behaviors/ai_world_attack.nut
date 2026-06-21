// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/behaviors/ai_world_attack.nut
// Functions: 9

function <anonymous>(this)
{
    if (outer[0].onEnteringCombatWithPlayer(false))
    {
        this.World.State.showCombatDialog(false, true, true, null, outer[0].getPos());
    }
    return;
}

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
    this.m.ID = this.Const.World.AI.Behavior.ID.Attack;
    this.world_behavior.create();
    return;
}

function onDeserialize(this, _in)
{
    this.world_behavior.onDeserialize(_in);
    if (_in.readU32() != 0)
    {
        this.m.Target = this.WeakTableRef(this.World.getEntityByID(_in.readU32()));
    }
    this.m.DecidedToAttackTime = _in.readF32();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.Target = null;
    if (!this.m.IsEnabled)
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
    if ((_entity.getVisibilityMult() == 0.0) || (_entity.getVisibilityMult() == 0.0))
    {
        return ((_entity.getVisibilityMult() == 0.0) || (_entity.getVisibilityMult() == 0.0));
        return _entity;
    }
    if ((null == (_entity.getVisibilityMult() == 0.0) && (null == (_entity.getVisibilityMult() == 0.0))))
    {
        return ((null == (_entity.getVisibilityMult() == 0.0)) && (null == (_entity.getVisibilityMult() == 0.0)));
        if (_entity.getFlags().get && _entity.getFlags().get)
        {
            return (_entity.getFlags().get && _entity.getFlags().get);
        }
    }
    foreach (local key, value in r20)
    {
        if ((!null.Entity) && (!null.Entity))
        {
            return ((!null.Entity) && (!null.Entity));
        }
        foreach (local key, value in r194)
        {
            if ((null.Entity.getVisibilityMult() == 0.0) || (null.Entity.getVisibilityMult() == 0.0) || (null.Entity.getVisibilityMult() == 0.0) || (null.Entity.getVisibilityMult() == 0.0) || (null.Entity.getVisibilityMult() == 0.0) || (null.Entity.getVisibilityMult() == 0.0))
            {
                return ((null.Entity.getVisibilityMult() == 0.0) || (null.Entity.getVisibilityMult() == 0.0) || (null.Entity.getVisibilityMult() == 0.0) || (null.Entity.getVisibilityMult() == 0.0) || (null.Entity.getVisibilityMult() == 0.0) || (null.Entity.getVisibilityMult() == 0.0));
            }
            else
            {
                if ((!null.Entity) && (!null.Entity))
                {
                    return ((!null.Entity) && (!null.Entity));
                }
                if ((this.World.State.getEscortedEntity().getID() == null.Entity.getID() && (this.World.State.getEscortedEntity().getID() == null.Entity.getID()) && (this.World.State.getEscortedEntity().getID() == null.Entity.getID())))
                {
                    return ((this.World.State.getEscortedEntity().getID() == null.Entity.getID()) && (this.World.State.getEscortedEntity().getID() == null.Entity.getID()) && (this.World.State.getEscortedEntity().getID() == null.Entity.getID()));
                }
                if (this.getVecDistance(_entity.getPos(), null.Entity.getPos() > this.Const.World.AI.Behavior.AttackMaxRange))
                {
                }
                if (null.Entity.isPlayerControlled())
                {
                }
                if ((((!true) / null.Entity) <= null.Entity) && (((!true) / null.Entity) <= null.Entity) && (((!true) / null.Entity) <= null.Entity))
                {
                    return ((((!true) / null.Entity) <= null.Entity) && (((!true) / null.Entity) <= null.Entity) && (((!true) / null.Entity) <= null.Entity));
                }
                if (_entity.isAbleToSee(null.Entity))
                {
                }
                if ((((1.0 * ((1.0 - this.Const.World.AI.Behavior.AttackDistanceMult) + ((1.0 - (this.getVecDistance(_entity.getPos(), null.Entity.getPos() / this.Const.World.AI.Behavior.AttackMaxRange)) * this.Const.World.AI.Behavior.AttackDistanceMult))) * this.Const.World.AI.Behavior.AttackVisibleTargetMult) * (_entity.getStrength() / null.Entity.getStrength())) > -9000.0))
                {
                }
                if (null == null)
                {
                    return _entity;
                }
                if ((this.World.FactionManager == this.Const.FactionType.Goblins) && (this.World.FactionManager == this.Const.FactionType.Goblins))
                {
                    return ((this.World.FactionManager == this.Const.FactionType.Goblins) && (this.World.FactionManager == this.Const.FactionType.Goblins));
                }
                if ((((_entity.getStrength() + null.Entity.getStrength() / (0 + null.Entity.getStrength())) <= 0.6499999761581421) && (((_entity.getStrength() + null.Entity.getStrength()) / (0 + null.Entity.getStrength())) <= 0.6499999761581421) && (((_entity.getStrength() + null.Entity.getStrength()) / (0 + null.Entity.getStrength())) <= 0.6499999761581421)))
                {
                    return ((((_entity.getStrength() + null.Entity.getStrength()) / (0 + null.Entity.getStrength())) <= 0.6499999761581421) && (((_entity.getStrength() + null.Entity.getStrength()) / (0 + null.Entity.getStrength())) <= 0.6499999761581421) && (((_entity.getStrength() + null.Entity.getStrength()) / (0 + null.Entity.getStrength())) <= 0.6499999761581421));
                    return _entity;
                }
                this.m.Target = null.Entity;
                return _entity;
            }
        }
    }
}

function onExecute(this, _entity, _hasChanged)
{
    if ((_entity.getVisibilityMult() == 0.0) || (_entity.getVisibilityMult() == 0.0))
    {
        return ((_entity.getVisibilityMult() == 0.0) || (_entity.getVisibilityMult() == 0.0));
        return _entity;
    }
    if ((this.World.State.getEscortedEntity().getID() == this.m.Target.getID() && (this.World.State.getEscortedEntity().getID() == this.m.Target.getID()) && (this.World.State.getEscortedEntity().getID() == this.m.Target.getID())))
    {
        return ((this.World.State.getEscortedEntity().getID() == this.m.Target.getID()) && (this.World.State.getEscortedEntity().getID() == this.m.Target.getID()) && (this.World.State.getEscortedEntity().getID() == this.m.Target.getID()));
        return _entity;
    }
    _entity.setOrders(("Attacking " + this.m.Target.getName()));
    if (this.getVecDistance(this.m.Target.getPos(), _entity.getPos() <= this.Const.World.CombatSettings.CombatDistance))
    {
        if (this.m.Target.isPlayerControlled())
        {
            if (!_entity.isAlliedWithPlayer())
            {
                this.World.State.setAIEngageCallback(function() /* closure #0 */);
            }
        }
        if (!_entity.isAlliedWithPlayer())
        {
            foreach (local key, value in r10)
            {
                if (null.isPlayerControlled())
                {
                }
                if ((this.World.State.getEscortedEntity().getID() == this.m.Target.getID() && (this.World.State.getEscortedEntity().getID() == this.m.Target.getID()) && (this.World.State.getEscortedEntity().getID() == this.m.Target.getID())))
                {
                    return ((this.World.State.getEscortedEntity().getID() == this.m.Target.getID()) && (this.World.State.getEscortedEntity().getID() == this.m.Target.getID()) && (this.World.State.getEscortedEntity().getID() == this.m.Target.getID()));
                    return _entity;
                }
                if (true)
                {
                    this.World.State.setAIEngageCallback(function() /* closure #1 */);
                }
                this.World.Combat.startCombat(_entity, this.m.Target);
                return _entity;
                if (this.getVecDistance(_entity.getPos(), this.m.Target.getPos() <= this.Const.World.AI.Behavior.AttackDirectMovementDistance))
                {
                    this.m.Target.getPos().X = this.m.Target.getPos().X op43 (this.getVecDir(_entity.getPos(), this.m.Target.getPos()).X * 20.0);
                    this.m.Target.getPos().Y = this.m.Target.getPos().Y op43 (this.getVecDir(_entity.getPos(), this.m.Target.getPos()).Y * 20.0);
                    _entity.setPath(null);
                    _entity.setDestination(this.m.Target.getPos());
                }
                else
                {
                    if ((!this.World.getTile(_entity.getPath().getLast().isSameTileAs(this.m.Target.getTile())) || (!this.World.getTile(_entity.getPath().getLast()).isSameTileAs(this.m.Target.getTile()))))
                    {
                        return ((!this.World.getTile(_entity.getPath().getLast()).isSameTileAs(this.m.Target.getTile())) || (!this.World.getTile(_entity.getPath().getLast()).isSameTileAs(this.m.Target.getTile())));
                        this.World.getNavigator().createSettings().ActionPointCosts = this.Const.World.TerrainTypeNavCost;
                        this.World.getNavigator().createSettings().RoadMult = (1.0 / this.Const.World.MovementSettings.RoadMult);
                        if (!this.World.getNavigator().findPath(_entity.getTile(), this.m.Target.getTile(), this.World.getNavigator().createSettings(), 0).isEmpty())
                        {
                            _entity.setPath(this.World.getNavigator().findPath(_entity.getTile(), this.m.Target.getTile(), this.World.getNavigator().createSettings(), 0));
                        }
                    }
                }
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
    _out.writeF32(this.m.DecidedToAttackTime);
    return;
}

function setEnabled(this, _e)
{
    this.m.IsEnabled = _e;
    return;
}

function setTarget(this, _t)
{
    this.m.Target = _t;
    return;
}
