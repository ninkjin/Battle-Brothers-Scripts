// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_mortar.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Mortar;
    this.m.Order = this.Const.AI.Behavior.Order.Mortar;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (this.m.Skill.isWaitingOnImpact())
    {
        return _entity;
    }
    if (0 < 6)
    {
        if (!_entity.getTile().hasNextTile(0))
        {
        }
        else
        {
            if (!_entity.getTile().getNextTile(0).IsOccupiedByActor)
            {
            }
            else
            {
                if ((!_entity.getTile().getNextTile(0).hasZoneOfControlOtherThan(_entity.getTile().getNextTile(0).getEntity().getAlliedFactions()) && (!_entity.getTile().getNextTile(0).hasZoneOfControlOtherThan(_entity.getTile().getNextTile(0).getEntity().getAlliedFactions()))))
                {
                    return ((!_entity.getTile().getNextTile(0).hasZoneOfControlOtherThan(_entity.getTile().getNextTile(0).getEntity().getAlliedFactions())) && (!_entity.getTile().getNextTile(0).hasZoneOfControlOtherThan(_entity.getTile().getNextTile(0).getEntity().getAlliedFactions())));
                }
            }
        }
    }
    if (!true)
    {
        _entity.getSprite("body").setBrush("mortar_01");
        return _entity;
    }
    _entity.getSprite("body").setBrush("mortar_02");
    this.m.Target = this.selectBestTarget(_entity, this.getAgent().getKnownOpponents());
    if (this.m.Target == null)
    {
        return _entity;
    }
    return _entity;
}

function onExecute(this, _entity)
{
    if (this.m.Target == null)
    {
        this.m.Skill.updateImpact();
    }
    this.m.Skill.use(this.m.Target);
    if (_entity.isAlive())
    {
        this.getAgent().declareAction();
        if (this.m.Skill.getDelay() != 0)
        {
            this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
        }
    }
    this.m.Skill = null;
    this.m.Target = null;
    return _entity;
}

function selectBestTarget(this, _entity, _targets)
{
    foreach (local key, value in r42)
    {
        if (null.Actor.getTile().IsHidingEntity)
        {
        }
        [].push(null.Actor.getTile());
        if (0 < 6)
        {
            if (!null.Actor.getTile().hasNextTile(0))
            {
            }
            [].push(null.Actor.getTile().getNextTile(0));
        }
        foreach (local key, value in r146)
        {
            if (!this.m.Skill.isUsableOn(null))
            {
            }
            if (null.IsOccupiedByActor)
            {
                if (!_entity.isAlliedWith(null.getEntity()))
                {
                    if (null.hasZoneOfControlOtherThan(null.getEntity().getAlliedFactions() || null.hasZoneOfControlOtherThan(null.getEntity().getAlliedFactions())))
                    {
                        return (null.hasZoneOfControlOtherThan(null.getEntity().getAlliedFactions()) || null.hasZoneOfControlOtherThan(null.getEntity().getAlliedFactions()));
                    }
                }
                if (null.getEntity().getType() == this.Const.EntityType.Slave)
                {
                }
            }
            if (0 < 6)
            {
                if (!null.hasNextTile(0))
                {
                }
                else
                {
                    if (!null.getNextTile(0).IsOccupiedByActor)
                    {
                    }
                    else
                    {
                        if (!_entity.isAlliedWith(null.getNextTile(0).getEntity()))
                        {
                            if (null.hasZoneOfControlOtherThan(null.getNextTile(0).getEntity().getAlliedFactions() || null.hasZoneOfControlOtherThan(null.getNextTile(0).getEntity().getAlliedFactions())))
                            {
                                return (null.hasZoneOfControlOtherThan(null.getNextTile(0).getEntity().getAlliedFactions()) || null.hasZoneOfControlOtherThan(null.getNextTile(0).getEntity().getAlliedFactions()));
                            }
                        }
                        if (null.getNextTile(0).getEntity().getType() == this.Const.EntityType.Slave)
                        {
                        }
                    }
                }
            }
            if (((((((((0 + 10) + 5) - 10) - 20) + 10) + 5) - 10) - 20) <= 0)
            {
            }
            if (((((((((0 + 10) + 5) - 10) - 20) + 10) + 5) - 10) - 20) > 0)
            {
            }
            return _entity;
        }
    }
}
