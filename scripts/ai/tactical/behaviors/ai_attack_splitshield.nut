// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_splitshield.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.SplitShield;
    this.m.Order = this.Const.AI.Behavior.Order.SplitShield;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.Skill = null;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (!this.getAgent().hasVisibleOpponent())
    {
        return _entity;
    }
    if (_entity.getActionPoints() < (_entity.getActionPointsMax() - 2))
    {
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange(), this.m.Skill.getMaxLevelDifference().len() == 0))
    {
        return _entity;
    }
    if (this.m.Skill && this.m.Skill)
    {
        return (this.m.Skill && this.m.Skill);
    }
    foreach (local key, value in r180)
    {
        if ((!this.m.Skill) && (!this.m.Skill))
        {
            return ((!this.m.Skill) && (!this.m.Skill));
        }
        if (null.getSkills().hasSkill("perk.shield_expert"))
        {
        }
        if ((null.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).getCondition() * 1.0) > 500)
        {
        }
        if ((((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage() * 1.0) + (this.Math.max(1, ((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage() * 1.0) / 2) * 1.0)) - (this.Math.max(1, (((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage() * 1.0) + (this.Math.max(1, ((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage() * 1.0) / 2)) * 1.0)) / 2)) * 1.0)) >= (null.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).getCondition() * 1.0)))
        {
        }
        if (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions() > 1))
        {
        }
        foreach (local key, value in r25)
        {
            if ((null >= (this.queryTargetValue(_entity, null, null) * this.Const.AI.Behavior.SplitShieldAlternativeTargetValuePct) && (null >= (this.queryTargetValue(_entity, null, null) * this.Const.AI.Behavior.SplitShieldAlternativeTargetValuePct))))
            {
                return ((null >= (this.queryTargetValue(_entity, null, null) * this.Const.AI.Behavior.SplitShieldAlternativeTargetValuePct)) && (null >= (this.queryTargetValue(_entity, null, null) * this.Const.AI.Behavior.SplitShieldAlternativeTargetValuePct)));
            }
            if (((((((((1.0 * this.queryTargetValue(_entity, null, null) + ((null.getCurrentProperties().getMeleeDefense() * this.Const.AI.Behavior.SplitShieldDefenseMult) * 0.009999999776482582)) * (null.getHitpoints() / null.getHitpointsMax())) * this.Math.pow(this.Math.minf(1.0, ((this.Math.maxf(1.0, (((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage() * 1.0) + (this.Math.max(1, ((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage() * 1.0) / 2)) * 1.0)) - (this.Math.max(1, (((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage() * 1.0) + (this.Math.max(1, ((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage() * 1.0) / 2)) * 1.0)) / 2)) * 1.0))) * this.Const.AI.Behavior.SplitShieldDamageValueMult) / (null.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).getCondition() * 1.0))), 2)) * this.Const.AI.Behavior.SplitShieldDestroyBonusMult) * (1.0 - ((this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange(), this.m.Skill.getMaxLevelDifference()).len() - 1) / 6.0))) * this.Math.pow(this.Const.AI.Behavior.SplitShieldAlliesAlsoEngagedMult, (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) - 1))) * this.Const.AI.Behavior.SplitShieldAlternativeTargetMult) > -9000.0))
            {
            }
            if (null == null)
            {
                return _entity;
            }
            this.m.TargetTile = null.getTile();
            return _entity;
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
    if (this.m.TargetTile.IsOccupiedByActor && this.m.TargetTile.IsOccupiedByActor)
    {
        return (this.m.TargetTile.IsOccupiedByActor && this.m.TargetTile.IsOccupiedByActor);
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((((("* " + _entity.getName()) + ": Using Split Shield against ") + this.m.TargetTile.getEntity().getName()) + "!"));
        }
        this.m.Skill.use(this.m.TargetTile);
        if (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer)
        {
            return (this.m.TargetTile.IsVisibleForPlayer && this.m.TargetTile.IsVisibleForPlayer);
            this.getAgent().declareAction();
        }
        this.m.TargetTile = null;
    }
    return _entity;
}
