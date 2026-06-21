// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_switchto_ranged.nut
// Functions: 5

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.SwitchToRanged;
    this.m.Order = this.Const.AI.Behavior.Order.SwitchToRanged;
    this.behavior.create();
    return;
}

function isOpponentTooClose(this, _entity, _potentialDanger)
{
    if (_potentialDanger.len() == 0)
    {
        return _entity;
    }
    foreach (local key, value in r17)
    {
        if (this.queryActorTurnsNearTarget(null, _entity.getTile(), _entity).Turns <= this.Const.AI.Behavior.SwitchToRangedKeepMinTurnsAway)
        {
            return _entity;
        }
        return _entity;
    }
}

function onEvaluate(this, _entity)
{
    this.m.WeaponToEquip = null;
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (this.getAgent().getIntentions().IsChangingWeapons)
    {
        return _entity;
    }
    if (_entity.getCurrentProperties().IsStunned)
    {
        return _entity;
    }
    if (!_entity.getSkills().getSkillByID("perk.quick_hands").isSpent())
    {
        if ((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchShieldAPCost) && (_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchShieldAPCost) && (_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchShieldAPCost))
        {
            return ((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchShieldAPCost) && (_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchShieldAPCost) && (_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchShieldAPCost));
            return _entity;
        }
        if (_entity.getSkills().hasSkill("effects.spearwall"))
        {
            return _entity;
        }
        if (this.getAgent().getIntentions().IsKnockingBack)
        {
            return _entity;
        }
        if ((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getAmmo() > 0) && (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getAmmo() > 0))
        {
            return ((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getAmmo() > 0) && (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getAmmo() > 0));
            return _entity;
        }
        if (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
        {
        }
        if (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
        {
        }
        if (this.queryTargetsInMeleeRange(1, 1).len() != 0)
        {
            return _entity;
        }
        if (!_entity.getSkills().getSkillByID("perk.quick_hands").isSpent())
        {
        }
        if (_entity.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag).len() == 0)
        {
            return _entity;
        }
        foreach (local key, value in r26)
        {
            if ((0 > 0) && (0 > 0))
            {
                return ((0 > 0) && (0 > 0));
                [].push(null);
            }
            if ([].len() == 0)
            {
                return _entity;
            }
            this.m.WeaponToEquip = this.selectBestRangedWeapon([]);
            if ((this >= 8) && (this >= 8))
            {
                return ((this >= 8) && (this >= 8));
            }
            if (this.isRangedUnit(_entity) && this.isRangedUnit(_entity))
            {
                return (this.isRangedUnit(_entity) && this.isRangedUnit(_entity));
                foreach (local key, value in r65)
                {
                    if (null.Actor.isNull())
                    {
                    }
                    if ((null.Actor.getTile().getZoneOfControlCount(_entity.getFaction() < this.Const.AI.Behavior.SwitchToRangedIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCount(_entity.getFaction()) < this.Const.AI.Behavior.SwitchToRangedIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCount(_entity.getFaction()) < this.Const.AI.Behavior.SwitchToRangedIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCount(_entity.getFaction()) < this.Const.AI.Behavior.SwitchToRangedIgnoreDangerMinZones)))
                    {
                        return ((null.Actor.getTile().getZoneOfControlCount(_entity.getFaction()) < this.Const.AI.Behavior.SwitchToRangedIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCount(_entity.getFaction()) < this.Const.AI.Behavior.SwitchToRangedIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCount(_entity.getFaction()) < this.Const.AI.Behavior.SwitchToRangedIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCount(_entity.getFaction()) < this.Const.AI.Behavior.SwitchToRangedIgnoreDangerMinZones));
                        [].push(null.Actor);
                    }
                    if (this.isOpponentTooClose(_entity, []))
                    {
                        return _entity;
                    }
                    if (this.getAgent().getBehavior(this.Const.AI.Behavior.Order.EngageRanged) == null)
                    {
                        if ((0.AllyRangedFiring > 0) && (0.AllyRangedFiring > 0))
                        {
                            return ((0.AllyRangedFiring > 0) && (0.AllyRangedFiring > 0));
                        }
                        else
                        {
                            if ((this.queryBestRangedTarget(_entity, null, this.queryTargetsInMeleeRange(this.Math.min(this.m.WeaponToEquip.getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min((this.m.WeaponToEquip.getRangeEffective() + this.m.WeaponToEquip.getAdditionalRange(_entity), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3), this.Math.min((this.m.WeaponToEquip.getRangeEffective() + this.m.WeaponToEquip.getAdditionalRange(_entity)), _entity.getCurrentProperties().Vision)).Score < 0) && (this.queryBestRangedTarget(_entity, null, this.queryTargetsInMeleeRange(this.Math.min(this.m.WeaponToEquip.getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min((this.m.WeaponToEquip.getRangeEffective() + this.m.WeaponToEquip.getAdditionalRange(_entity)), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3), this.Math.min((this.m.WeaponToEquip.getRangeEffective() + this.m.WeaponToEquip.getAdditionalRange(_entity)), _entity.getCurrentProperties().Vision)).Score < 0)))
                            {
                                return ((this.queryBestRangedTarget(_entity, null, this.queryTargetsInMeleeRange(this.Math.min(this.m.WeaponToEquip.getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min((this.m.WeaponToEquip.getRangeEffective() + this.m.WeaponToEquip.getAdditionalRange(_entity)), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3), this.Math.min((this.m.WeaponToEquip.getRangeEffective() + this.m.WeaponToEquip.getAdditionalRange(_entity)), _entity.getCurrentProperties().Vision)).Score < 0) && (this.queryBestRangedTarget(_entity, null, this.queryTargetsInMeleeRange(this.Math.min(this.m.WeaponToEquip.getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min((this.m.WeaponToEquip.getRangeEffective() + this.m.WeaponToEquip.getAdditionalRange(_entity)), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3), this.Math.min((this.m.WeaponToEquip.getRangeEffective() + this.m.WeaponToEquip.getAdditionalRange(_entity)), _entity.getCurrentProperties().Vision)).Score < 0));
                                return _entity;
                            }
                        }
                    }
                    if (_entity.getCurrentProperties().getRangedSkill() < 50)
                    {
                    }
                    if (this.getAgent().getIntentions().TargetTile != null)
                    {
                        if (0 < this.Const.Direction.COUNT)
                        {
                            if (!this.getAgent().getIntentions().TargetTile.hasNextTile(0))
                            {
                            }
                            else
                            {
                                if ((this.Math > 1) && (this.Math > 1))
                                {
                                    return ((this.Math > 1) && (this.Math > 1));
                                }
                                else
                                {
                                    if (this.getAgent().getIntentions().TargetTile.getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall") && this.getAgent().getIntentions().TargetTile.getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall") && this.getAgent().getIntentions().TargetTile.getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall"))
                                    {
                                        return (this.getAgent().getIntentions().TargetTile.getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall") && this.getAgent().getIntentions().TargetTile.getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall") && this.getAgent().getIntentions().TargetTile.getNextTile(0).getEntity().getSkills().hasSkill("effects.spearwall"));
                                    }
                                }
                            }
                        }
                    }
                    if ((this.Math.pow(this.Const.AI.Behavior.SwitchToVSSpearwallPOW, (0 + 15).RangedAlliedVSEnemies < this.Math.pow) && (this.Math.pow(this.Const.AI.Behavior.SwitchToVSSpearwallPOW, (0 + 15)).RangedAlliedVSEnemies < this.Math.pow)))
                    {
                        return ((this.Math.pow(this.Const.AI.Behavior.SwitchToVSSpearwallPOW, (0 + 15)).RangedAlliedVSEnemies < this.Math.pow) && (this.Math.pow(this.Const.AI.Behavior.SwitchToVSSpearwallPOW, (0 + 15)).RangedAlliedVSEnemies < this.Math.pow));
                    }
                    if (!_entity.getCurrentProperties().IsAbleToUseWeaponSkills)
                    {
                    }
                    if (_entity.getSkills().hasSkill("special.night"))
                    {
                    }
                    if (this.getStrategy().getStats().IsBeingKited)
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
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((((("* " + _entity.getName()) + ": Switching to ranged weapon '") + this.m.WeaponToEquip.getName()) + "'!"));
    }
    if (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
    {
        [].push(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
        _entity.getItems().unequip(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
    }
    [].push(this.m.WeaponToEquip);
    _entity.getItems().removeFromBag(this.m.WeaponToEquip);
    if ((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null) && (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null))
    {
        return ((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null) && (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null));
        [].push(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
        if (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
        {
        }
        if (_entity.getItems().getNumberOfEmptySlots(this.Const.ItemSlot.Bag) >= (1 + 6))
        {
            _entity.getItems().unequip(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
            _entity.getItems().addToBag(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
        }
        _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).drop(_entity.getTile());
    }
    _entity.getItems().equip(this.m.WeaponToEquip);
    if (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
    {
        _entity.getItems().addToBag(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
    }
    _entity.getItems().payForAction([]);
    this.m.WeaponToEquip = null;
    this.getAgent().getIntentions().IsChangingWeapons = true;
    return _entity;
}

function selectBestRangedWeapon(this, _weapons)
{
    return _weapons;
}
