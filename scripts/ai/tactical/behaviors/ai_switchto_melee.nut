// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_switchto_melee.nut
// Functions: 5

function <anonymous>(this, i, v)
{
    return i;
}

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.SwitchToMelee;
    this.m.Order = this.Const.AI.Behavior.Order.SwitchToMelee;
    this.behavior.create();
    return;
}

function getWeaponScore(this, weapon)
{
    if (weapon == null)
    {
        return weapon;
    }
    if (!weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon))
    {
        return weapon;
    }
    if (weapon.isDoubleGrippable())
    {
    }
    return weapon;
}

function onEvaluate(this, _entity)
{
    this.m.WeaponToEquip = null;
    this.m.IsNegatingDisarm = false;
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (_entity.getCurrentProperties().IsStunned)
    {
        return _entity;
    }
    if (!this.getAgent().hasVisibleOpponent())
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
        if ((_entity.getSkills().getAttackOfOpportunity().getActionPointCost() <= 4) && (_entity.getSkills().getAttackOfOpportunity().getActionPointCost() <= 4) && (_entity.getSkills().getAttackOfOpportunity().getActionPointCost() <= 4) && (_entity.getSkills().getAttackOfOpportunity().getActionPointCost() <= 4) && (_entity.getSkills().getAttackOfOpportunity().getActionPointCost() <= 4) && (_entity.getSkills().getAttackOfOpportunity().getActionPointCost() <= 4))
        {
            return ((_entity.getSkills().getAttackOfOpportunity().getActionPointCost() <= 4) && (_entity.getSkills().getAttackOfOpportunity().getActionPointCost() <= 4) && (_entity.getSkills().getAttackOfOpportunity().getActionPointCost() <= 4) && (_entity.getSkills().getAttackOfOpportunity().getActionPointCost() <= 4) && (_entity.getSkills().getAttackOfOpportunity().getActionPointCost() <= 4) && (_entity.getSkills().getAttackOfOpportunity().getActionPointCost() <= 4));
            if ((_entity.getItems().getUnlockedBagSlots() > 0) && (_entity.getItems().getUnlockedBagSlots() > 0))
            {
                return ((_entity.getItems().getUnlockedBagSlots() > 0) && (_entity.getItems().getUnlockedBagSlots() > 0));
                this.m.IsNegatingDisarm = true;
                return _entity;
            }
        }
        if (_entity.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag).len() == 0)
        {
            return _entity;
        }
        if (0 && 0)
        {
            return (0 && 0);
            if ((0 == 0) && (0 == 0))
            {
                return ((0 == 0) && (0 == 0));
                this.logInfo("switching to melee weapon - no ammo!");
            }
            if (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageRanged) == null)
            {
                if ((0.AllyRangedFiring > 0) && (0.AllyRangedFiring > 0))
                {
                    return ((0.AllyRangedFiring > 0) && (0.AllyRangedFiring > 0));
                }
                else
                {
                    if ((this.queryBestRangedTarget(_entity, null, this.queryTargetsInMeleeRange(this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3), this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision).Score < 0) && (this.queryBestRangedTarget(_entity, null, this.queryTargetsInMeleeRange(this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3), this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision)).Score < 0)))
                    {
                        return ((this.queryBestRangedTarget(_entity, null, this.queryTargetsInMeleeRange(this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3), this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision)).Score < 0) && (this.queryBestRangedTarget(_entity, null, this.queryTargetsInMeleeRange(this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3), this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision)).Score < 0));
                        this.logInfo("switching to melee weapon - noone to hit from here!");
                    }
                }
            }
            if (this.queryBestRangedTarget(_entity, null, this.queryTargetsInMeleeRange(this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3), this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision).IsChangingWeapons && this.queryBestRangedTarget(_entity, null, this.queryTargetsInMeleeRange(this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3), this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision)).IsChangingWeapons))
            {
                return (this.queryBestRangedTarget(_entity, null, this.queryTargetsInMeleeRange(this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3), this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision)).IsChangingWeapons && this.queryBestRangedTarget(_entity, null, this.queryTargetsInMeleeRange(this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3), this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision)).IsChangingWeapons);
                return _entity;
            }
            if (!true)
            {
                if (_entity.getCurrentProperties().IsAffectedByNight)
                {
                    if ((!this.queryTargetsInMeleeRange(this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3) && (!this.queryTargetsInMeleeRange(this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3))))
                    {
                        return ((!this.queryTargetsInMeleeRange(this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3)) && (!this.queryTargetsInMeleeRange(this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMin(), _entity.getCurrentProperties().Vision), (this.Math.min(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), _entity.getCurrentProperties().Vision) + _entity.getTile().Level), 3)));
                    }
                    if (_entity.getCurrentProperties().IsAffectedByNight(1, 1).len() == 0)
                    {
                        return _entity;
                    }
                    if (_entity.getCurrentProperties().IsAffectedByNight && _entity.getCurrentProperties().IsAffectedByNight)
                    {
                        return (_entity.getCurrentProperties().IsAffectedByNight && _entity.getCurrentProperties().IsAffectedByNight);
                    }
                    foreach (local key, value in r54)
                    {
                        if (!null.isItemType(this.Const.Items.ItemType.MeleeWeapon))
                        {
                        }
                        else
                        {
                            if (((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchTwoHanderAPCost) < this.Const.Tactical.Settings.SwitchItemAPCost) && ((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchTwoHanderAPCost) < this.Const.Tactical.Settings.SwitchItemAPCost) && ((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchTwoHanderAPCost) < this.Const.Tactical.Settings.SwitchItemAPCost))
                            {
                                return (((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchTwoHanderAPCost) < this.Const.Tactical.Settings.SwitchItemAPCost) && ((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchTwoHanderAPCost) < this.Const.Tactical.Settings.SwitchItemAPCost) && ((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchTwoHanderAPCost) < this.Const.Tactical.Settings.SwitchItemAPCost));
                            }
                            if ((((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchTwoHanderAPCost) < this.Const.Tactical.Settings.SwitchItemAPCost) > this.Const.Tactical.Settings.SwitchItemAPCost) && (((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchTwoHanderAPCost) < this.Const.Tactical.Settings.SwitchItemAPCost) > this.Const.Tactical.Settings.SwitchItemAPCost))
                            {
                                return ((((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchTwoHanderAPCost) < this.Const.Tactical.Settings.SwitchItemAPCost) > this.Const.Tactical.Settings.SwitchItemAPCost) && (((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchTwoHanderAPCost) < this.Const.Tactical.Settings.SwitchItemAPCost) > this.Const.Tactical.Settings.SwitchItemAPCost));
                            }
                            if ((null == (((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchTwoHanderAPCost) < this.Const.Tactical.Settings.SwitchItemAPCost) > this.Const.Tactical.Settings.SwitchItemAPCost) && (null == (((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchTwoHanderAPCost) < this.Const.Tactical.Settings.SwitchItemAPCost) > this.Const.Tactical.Settings.SwitchItemAPCost))))
                            {
                                return ((null == (((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchTwoHanderAPCost) < this.Const.Tactical.Settings.SwitchItemAPCost) > this.Const.Tactical.Settings.SwitchItemAPCost)) && (null == (((_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchTwoHanderAPCost) < this.Const.Tactical.Settings.SwitchItemAPCost) > this.Const.Tactical.Settings.SwitchItemAPCost)));
                                return _entity;
                            }
                            this.m.WeaponToEquip = null;
                            if (!_entity.getSkills().getSkillByID("perk.quick_hands").isSpent())
                            {
                            }
                            else
                            {
                                if (_entity.getSkills().getSkillByID("perk.quick_hands") != null)
                                {
                                }
                            }
                            if (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
                            {
                            }
                            if (!_entity.getCurrentProperties().IsAbleToUseWeaponSkills)
                            {
                            }
                            if (_entity.getSkills().hasSkill("special.night"))
                            {
                            }
                            return _entity;
                        }
                    }
                }
            }
        }
    }
}

function onExecute(this, _entity)
{
    if (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
    {
        [].push(_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
    }
    if (_entity.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag).len() == _entity.getItems().getUnlockedBagSlots())
    {
    }
    foreach (local key, value in r30)
    {
        if (null.isItemType(this.Const.Items.ItemType.Shield))
        {
        }
        else
        {
            if ((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null) && (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null))
            {
                return ((_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null) && (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null));
            }
            [].push(null);
            if (this.m.IsNegatingDisarm)
            {
                _entity.getSkills().removeByID("effects.disarmed");
                _entity.getItems().payForAction([]);
                _entity.getItems().payForAction([]);
                this.Tactical.EventLog.log((this.Const.UI.getColorizedEntityName(_entity) + " equips their weapon again"));
                if (this.Const.AI.VerboseMode)
                {
                    this.logInfo((((("* " + _entity.getName()) + ": Countering disarm with weapon '") + _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getID()) + "'!"));
                }
                this.m.IsNegatingDisarm = false;
                this.m.WeaponToEquip = null;
                return _entity;
            }
            if (this.Const.AI.VerboseMode)
            {
                this.logInfo((((("* " + _entity.getName()) + ": Switching to melee weapon '") + this.m.WeaponToEquip.getID()) + "'!"));
            }
            if (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
            {
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
    }
}
