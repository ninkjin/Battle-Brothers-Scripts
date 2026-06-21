// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_move_tentacle.nut
// Functions: 5

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.MoveTentacle;
    this.m.Order = this.Const.AI.Behavior.Order.MoveTentacle;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function onBeforeExecute(this, _entity)
{
    this.getAgent().getOrders().IsEngaging = true;
    this.getAgent().getOrders().IsDefending = false;
    this.getAgent().getIntentions().IsDefendingPosition = false;
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.SelectedSkill = null;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getCurrentProperties().IsRooted)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (this.getAgent().getIntentions().IsDefendingPosition)
    {
        return _entity;
    }
    foreach (local key, value in r26)
    {
        if (_entity.getSkills().getSkillByID(null).isAffordable() && _entity.getSkills().getSkillByID(null).isAffordable())
        {
            return (_entity.getSkills().getSkillByID(null).isAffordable() && _entity.getSkills().getSkillByID(null).isAffordable());
            this.m.SelectedSkill = _entity.getSkills().getSkillByID(null);
        }
        if (this.m.SelectedSkill == null)
        {
            return _entity;
        }
        if (!this.getAgent().hasKnownOpponent())
        {
            return _entity;
        }
        if ((this.Const.Faction.PlayerAnimals + 1) != this.Tactical.Entities.getAllInstances().len())
        {
            if (0 != this.Tactical.Entities.getAllInstances()["(this.Const.Faction.PlayerAnimals + 1)"].len())
            {
                if (this.Tactical.Entities.getAllInstances()["(this.Const.Faction.PlayerAnimals + 1)"]["0"].getType() == this.Const.EntityType.Kraken)
                {
                }
            }
        }
        foreach (local key, value in r232)
        {
            if (this.isAllottedTimeReached(this.Time.getExactTime()))
            {
                yield this;
            }
            if (0.IsRooted && 0.IsRooted)
            {
                return (0.IsRooted && 0.IsRooted);
            }
            this.queryDestinationsInRange(null.Actor.getTile(), this.getProperties().EngageRangeMin, this.Math.max(_entity.getIdealRange(), this.getProperties().EngageRangeMax)).push(_entity.getTile());
            foreach (local key, value in r171)
            {
                foreach (local key, value in null)
                {
                    if (null.ID == null.ID)
                    {
                    }
                    if (true)
                    {
                    }
                    if (this.Tactical.Entities.getAllInstances()["(this.Const.Faction.PlayerAnimals + 1)"]["0"].getTile() != null)
                    {
                    }
                    if (null.Actor.getCurrentProperties().IsRooted)
                    {
                    }
                    foreach (local key, value in null)
                    {
                        if (null.getTile().getDistanceTo(null) <= null.getIdealRange())
                        {
                        }
                        if (_entity.getTile().ID == null.ID)
                        {
                        }
                        if ((null.ID == 1) && (null.ID == 1))
                        {
                            return ((null.ID == 1) && (null.ID == 1));
                        }
                        [].push({});
                        if ([].len() == 0)
                        {
                            return _entity;
                        }
                        [].sort(this.onSortByScore);
                        if (0 < [].len())
                        {
                            if ([]["0"].Tile.ID == _entity.getTile().ID)
                            {
                                this.m.TargetTile = null;
                                return _entity;
                            }
                            else
                            {
                                if (!this.m.SelectedSkill.isUsableOn([]["0"].Tile))
                                {
                                    if (!this.m.SelectedSkill.isUsableOn(_entity.getTile().getTileBetweenThisAnd([]["0"].Tile)))
                                    {
                                    }
                                    this.m.TargetTile = _entity.getTile().getTileBetweenThisAnd([]["0"].Tile);
                                }
                                this.m.TargetTile = []["(0 + 11)"].Tile;
                            }
                        }
                        if (this.m.TargetTile == null)
                        {
                            return _entity;
                        }
                        this.getAgent().getIntentions().TargetTile = this.m.TargetTile;
                        return _entity;
                    }
                }
            }
        }
    }
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        this.m.IsFirstExecuted = false;
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((("* " + _entity.getName()) + ": Moving to engage."));
        }
        this.m.Agent.adjustCameraToTarget(this.m.TargetTile);
        this.m.SelectedSkill.use(this.m.TargetTile);
        if (_entity.isAlive())
        {
            if (!_entity.isHiddenToPlayer())
            {
            }
            if (this.m.TargetTile.IsVisibleForPlayer)
            {
            }
            this.getAgent().declareEvaluationDelay(((0 + 800) + 800));
        }
    }
    else
    {
        if (!_entity.isStoringColor())
        {
            return _entity;
        }
    }
    return _entity;
}

function onSortByScore(this, _a, _b)
{
    if (_a.Score > _b.Score)
    {
        return _a;
    }
    else
    {
        if (_a.Score < _b.Score)
        {
            return _a;
        }
    }
    return _a;
}
