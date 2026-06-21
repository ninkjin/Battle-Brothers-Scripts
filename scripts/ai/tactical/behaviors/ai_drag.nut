// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_drag.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Drag;
    this.m.Order = this.Const.AI.Behavior.Order.Drag;
    this.m.IsThreaded = false;
    this.behavior.create();
    return;
}

function onBeforeExecute(this, _entity)
{
    return;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    this.m.TargetTile = null;
    this.m.IsWaiting = false;
    foreach (local key, value in r24)
    {
        if (_entity.getSkills().getSkillByID(null).isAffordable() && _entity.getSkills().getSkillByID(null).isAffordable())
        {
            return (_entity.getSkills().getSkillByID(null).isAffordable() && _entity.getSkills().getSkillByID(null).isAffordable());
            [].push(_entity.getSkills().getSkillByID(null));
        }
        if ([].len() == 0)
        {
            return _entity;
        }
        this.m.Skill = []["this.Math.rand(0, ([].len() - 1))"];
        if ((this.Const.Faction.PlayerAnimals + 1) != this.Tactical.Entities.getAllInstances().len())
        {
            if (0 != this.Tactical.Entities.getAllInstances()["(this.Const.Faction.PlayerAnimals + 1)"].len())
            {
                if (this.Tactical.Entities.getAllInstances()["(this.Const.Faction.PlayerAnimals + 1)"]["0"].getType() == this.Const.EntityType.Kraken)
                {
                }
            }
        }
        if (this.Tactical.Entities.getAllInstances()["(this.Const.Faction.PlayerAnimals + 1)"]["0"] == null)
        {
            return _entity;
        }
        this.Tactical.getNavigator().createSettings().ActionPointCosts = this.Const.PathfinderMovementAPCost;
        this.Tactical.getNavigator().createSettings().FatigueCosts = this.Const.NoMovementFatigueCost;
        this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
        this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = 0;
        this.Tactical.getNavigator().createSettings().FatigueCostPerLevel = 0;
        this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = true;
        this.Tactical.getNavigator().createSettings().ZoneOfControlCost = 0;
        this.Tactical.getNavigator().createSettings().AlliedFactions = _entity.getAlliedFactions();
        this.Tactical.getNavigator().createSettings().Faction = _entity.getFaction();
        if (this.Tactical.getNavigator().findPath(_entity.getTile(), this.Tactical.Entities.getAllInstances()["(this.Const.Faction.PlayerAnimals + 1)"]["0"].getTile(), this.Tactical.getNavigator().createSettings(), 1))
        {
            this.m.TargetTile = this.Tactical.getNavigator().getCostForPath(_entity, this.Tactical.getNavigator().createSettings(), 9, 100).End;
        }
        else
        {
            if (this.Tactical.TurnSequenceBar.entityWaitTurn(_entity))
            {
                this.m.IsWaiting = true;
            }
            return _entity;
        }
        return _entity;
    }
}

function onExecute(this, _entity)
{
    if (this.m.IsWaiting)
    {
        this.Tactical.TurnSequenceBar.entityWaitTurn(_entity);
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((("* " + _entity.getName()) + ": Waiting until others have moved!"));
        }
        return _entity;
    }
    this.getAgent().adjustCameraToDestination(this.m.TargetTile);
    if (this.m.Skill.use(this.m.TargetTile))
    {
        if (!_entity.isHiddenToPlayer())
        {
        }
        if (this.m.TargetTile.IsVisibleForPlayer)
        {
        }
        this.getAgent().declareEvaluationDelay(((0 + 800) + 1250));
    }
    return _entity;
}
