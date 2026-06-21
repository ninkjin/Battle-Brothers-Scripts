// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_corpse_hurl.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.CorpseHurl;
    this.m.Order = this.Const.AI.Behavior.Order.CorpseHurl;
    this.behavior.create();
    return;
}

function getBestTarget(this, _entity, _targets)
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
        foreach (local key, value in r126)
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
                    }
                }
            }
            if ((((((((0 + 2) + 1) - 3) - 2) + 2) + 1) - 4) <= 0)
            {
            }
            if ((((((((0 + 2) + 1) - 3) - 2) + 2) + 1) - 4) > 0)
            {
            }
            return _entity;
        }
    }
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (this.getBestTarget(_entity, this.getAgent().getKnownOpponents().Target == null))
    {
        return _entity;
    }
    this.m.TargetTile = this.getBestTarget(_entity, this.getAgent().getKnownOpponents()).Target;
    this.m.TargetScore = this.getBestTarget(_entity, this.getAgent().getKnownOpponents()).Score;
    return _entity;
}

function onExecute(this, _entity)
{
    this.m.Skill.use(this.m.TargetTile);
    if (_entity.isAlive())
    {
        this.getAgent().declareAction();
        if (this.m.Skill.getDelay() != 0)
        {
            this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
        }
    }
    this.m.Skill = null;
    this.m.TargetTile = null;
    return _entity;
}
