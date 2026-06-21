// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_defend_riposte.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Riposte;
    this.m.Order = this.Const.AI.Behavior.Order.Riposte;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
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
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (_entity.getSkills().hasSkill("effects.adrenaline"))
    {
        return _entity;
    }
    foreach (local key, value in null)
    {
        if ((0 + null.getDamage() >= _entity.getHitpoints()))
        {
            return _entity;
        }
        if (_entity.getAttackedCount() > 0)
        {
        }
        return _entity;
        if (this.queryTargetsInMeleeRange().len() == 0)
        {
            return _entity;
        }
        if (this.queryTargetsInMeleeRange().len() != 0)
        {
        }
        foreach (local key, value in r98)
        {
            if ((!null.getCurrentProperties().IsAbleToUseWeaponSkills) || (!null.getCurrentProperties().IsAbleToUseWeaponSkills) || (!null.getCurrentProperties().IsAbleToUseWeaponSkills) || (!null.getCurrentProperties().IsAbleToUseWeaponSkills) || (!null.getCurrentProperties().IsAbleToUseWeaponSkills))
            {
                return ((!null.getCurrentProperties().IsAbleToUseWeaponSkills) || (!null.getCurrentProperties().IsAbleToUseWeaponSkills) || (!null.getCurrentProperties().IsAbleToUseWeaponSkills) || (!null.getCurrentProperties().IsAbleToUseWeaponSkills) || (!null.getCurrentProperties().IsAbleToUseWeaponSkills));
            }
            if (null.getTile().Level > _entity.getTile().Level)
            {
                if (0 != 6)
                {
                    if (!null.getTile().hasNextTile(0))
                    {
                    }
                    else
                    {
                        if ((!0) && (!0))
                        {
                            return ((!0) && (!0));
                        }
                    }
                }
            }
            if ((0 + 10) < 2)
            {
                return _entity;
            }
            if ((0 + ((50.0 / null.getCurrentProperties().getMeleeSkill() - ((0 + 14) * 0.5))) > 0))
            {
            }
            else
            {
                if ((0 + ((50.0 / null.getCurrentProperties().getMeleeSkill() - ((0 + 14) * 0.5))) < 0))
                {
                }
            }
            if (null.getTile().Level > _entity.getTile().Level)
            {
            }
            if (_entity.getSkills().hasSkill("effects.shieldwall"))
            {
            }
            if (this.getAgent().getIntentions().IsDefendingPosition)
            {
            }
            return _entity;
        }
    }
}

function onExecute(this, _entity)
{
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Using Riposte!"));
    }
    this.m.Skill.use(_entity.getTile());
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
    }
    this.m.Skill = null;
    return _entity;
}
