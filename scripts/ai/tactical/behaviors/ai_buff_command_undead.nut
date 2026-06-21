// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_buff_command_undead.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.CommandUndead;
    this.m.Order = this.Const.AI.Behavior.Order.CommandUndead;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
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
    if (!this.getAgent().hasKnownOpponent())
    {
        return _entity;
    }
    if (!this.getAgent().hasKnownAllies())
    {
        return _entity;
    }
    if (this.queryTargetsInMeleeRange().len() != 0)
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    foreach (local key, value in r189)
    {
        if (this.m.Skill.getMaxRange() && this.m.Skill.getMaxRange())
        {
            return (this.m.Skill.getMaxRange() && this.m.Skill.getMaxRange());
            if (this.isAllottedTimeReached(this.Time.getExactTime()))
            {
                yield this;
            }
            if (!this.m.Skill.isUsableOn(null.getTile()))
            {
            }
            foreach (local key, value in r34)
            {
                if (null.Actor.isNull())
                {
                }
                if (null.getTile().hasZoneOfOccupationOtherThan(null.getAlliedFactions()))
                {
                }
                if (null.getSkills().hasSkill("effects.command_undead"))
                {
                }
                if ((!null.IsAbleToUseWeaponSkills) && (!null.IsAbleToUseWeaponSkills))
                {
                    return ((!null.IsAbleToUseWeaponSkills) && (!null.IsAbleToUseWeaponSkills));
                }
                if (!null.isTurnDone())
                {
                }
                [].push({});
                if ([].len() == 0)
                {
                    return _entity;
                }
                if (this.isAllottedTimeReached(this.Time.getExactTime()))
                {
                    yield this;
                }
                [].sort(this.onSortByScore);
                this.m.TargetTile = []["0"].Target.getTile();
                if ([]["0"].IsAlreadyBuffed)
                {
                }
                foreach (local key, value in r31)
                {
                    if (null.Actor.isNull())
                    {
                    }
                    return _entity;
                }
            }
        }
    }
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        this.getAgent().adjustCameraToTarget(this.m.TargetTile);
        this.m.IsFirstExecuted = false;
        return _entity;
    }
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((((("* " + _entity.getName()) + ": Using Command Undead on ") + this.m.TargetTile.getEntity().getName()) + "!"));
    }
    this.m.Skill.use(this.m.TargetTile);
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
    }
    this.m.Skill = null;
    this.m.TargetTile = null;
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
