// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_explode_corpse.nut
// Functions: 5

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.ExplodeCorpse;
    this.m.Order = this.Const.AI.Behavior.Order.ExplodeCorpse;
    this.behavior.create();
    return;
}

function evaluateTile(this, _tile, _entity)
{
    if (_tile.IsOccupiedByActor)
    {
        if (_tile.isSameTileAs(_entity.getTile()))
        {
        }
        if (!_entity.isAlliedWith(_tile.getEntity()))
        {
        }
        else
        {
            if (_tile.getEntity().getType() != this.Const.EntityType.FleshCradle)
            {
            }
        }
    }
    return _tile;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    this.m.TargetTile = null;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (_entity.getTile().hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    foreach (local key, value in r15)
    {
        if (null.getType() == this.Const.EntityType.FleshCradle)
        {
            this.Tactical.Entities.getCorpses().push(null.getTile());
        }
        if (this.selectBestTarget(_entity, this.Tactical.Entities.getCorpses() == null))
        {
            return _entity;
        }
        this.m.TargetTile = this.selectBestTarget(_entity, this.Tactical.Entities.getCorpses());
        return _entity;
    }
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        if (r3 && r3)
        {
            return (r3 && r3);
            _entity.setDiscovered(true);
            _entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
        }
        this.getAgent().adjustCameraToTarget(this.m.TargetTile);
        this.m.IsFirstExecuted = false;
        return _entity;
    }
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Using Corpse Explosion!"));
    }
    if (this.m.Skill.use(this.m.TargetTile))
    {
        this.getAgent().declareAction();
        this.getAgent().declareEvaluationDelay();
    }
    this.m.Skill = null;
    this.m.TargetTile = null;
    return _entity;
}

function selectBestTarget(this, _entity, _corpses)
{
    foreach (local key, value in r105)
    {
        if ((!(!null.getEntity().getIsDestroyed()) && (!(!null.getEntity().getIsDestroyed())) && (!null.getEntity().getIsDestroyed())))
        {
            return ((!(!null.getEntity().getIsDestroyed())) && (!(!null.getEntity().getIsDestroyed())) && (!null.getEntity().getIsDestroyed()));
        }
        if ((!null.Properties.IsConsumable) && (!null.Properties.IsConsumable))
        {
            return ((!null.Properties.IsConsumable) && (!null.Properties.IsConsumable));
        }
        if (0 != 6)
        {
            if (!null.hasNextTile(0))
            {
            }
        }
        if ((((0 + this.evaluateTile(null, _entity).Score) + this.evaluateTile(null.getNextTile(0), _entity).Score) > 0) && (((0 + this.evaluateTile(null, _entity).Score) + this.evaluateTile(null.getNextTile(0), _entity).Score) > 0))
        {
            return ((((0 + this.evaluateTile(null, _entity).Score) + this.evaluateTile(null.getNextTile(0), _entity).Score) > 0) && (((0 + this.evaluateTile(null, _entity).Score) + this.evaluateTile(null.getNextTile(0), _entity).Score) > 0));
        }
        return _entity;
    }
}
