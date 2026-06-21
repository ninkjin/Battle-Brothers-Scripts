// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/global/data_helper.nut
// Functions: 30

function addCharacterToUIData(this, _entity, _target)
{
    _target.name <- _entity.getNameOnly();
    _target.title <- _entity.getTitle();
    _target.imagePath <- _entity.getImagePath();
    _target.imageOffsetX <- _entity.getImageOffsetX();
    _target.imageOffsetY <- _entity.getImageOffsetY();
    _target.perkPoints <- _entity.getPerkPoints();
    _target.perkPointsSpent <- _entity.getPerkPointsSpent();
    _target.level <- _entity.getLevel();
    _target.levelUp <- null;
    _target.daysWithCompany <- _entity.getDaysWithCompany();
    _target.xpValue <- _entity.getXP();
    _target.xpValueMax <- _entity.getXPForNextLevel();
    _target.dailyMoneyCost <- _entity.getDailyCost();
    _target.daysWounded <- _entity.getDaysWounded();
    _target.leveledUp <- _entity.isLeveled();
    _target.moodIcon <- (("ui/icons/mood_0" + (_entity.getMoodState() + 1)) + ".png");
    _target.isPlayerCharacter <- _entity.getFlags().get("IsPlayerCharacter");
    if (_entity.getLevelUps() > 0)
    {
        _target.levelUp = _entity.getAttributeLevelUpValues();
    }
    return;
}

function addFlagsToUIData(this, _entity, _activeEntity, _target)
{
    _target.isSelected <- false;
    if ((_entity == _activeEntity) && (_entity == _activeEntity))
    {
        return ((_entity == _activeEntity) && (_entity == _activeEntity));
        _target.isSelected <- true;
    }
    return;
}

function addPerksToUIData(this, _entity, _perks, _target)
{
    foreach (local key, value in r7)
    {
        _target.push(null.getID());
        return;
    }
}

function addSkillsToUIData(this, _skills, _target)
{
    if ((r4 > 0) && (r4 > 0))
    {
        return ((r4 > 0) && (r4 > 0));
        if (this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Body"]) != null)
        {
            if ("Const" in "body")
            {
                _target.body.extend(this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Body"]));
            }
            _target.body <- this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Body"]);
        }
        if (this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Head"]) != null)
        {
            if ("Const" in "head")
            {
                _target.head.extend(this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Head"]));
            }
            _target.head <- this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Head"]);
        }
        if (this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Mainhand"]) != null)
        {
            if ("Const" in "mainhand")
            {
                _target.mainhand.extend(this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Mainhand"]));
            }
            _target.mainhand <- this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Mainhand"]);
        }
        if (this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Offhand"]) != null)
        {
            if ("Const" in "offhand")
            {
                _target.offhand.extend(this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Offhand"]));
            }
            _target.offhand <- this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Offhand"]);
        }
        if (this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Accessory"]) != null)
        {
            if ("Const" in "accessory")
            {
                _target.accessory.extend(this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Accessory"]));
            }
            _target.accessory <- this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Accessory"]);
        }
        if (this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Free"]) != null)
        {
            if ("Const" in "free")
            {
                _target.free.extend(this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Free"]));
            }
            _target.free <- this.convertSkillsToUIData(_skills["this.Const.ItemSlot.Free"]);
        }
    }
    return;
}

function addStatsToUIData(this, _entity, _target)
{
    _target.hitpoints <- _entity.getHitpoints();
    _target.hitpointsMax <- _entity.getHitpointsMax();
    _target.hitpointsTalent <- _entity.getTalents()["this.Const.Attributes.Hitpoints"];
    _target.fatigue <- _entity.getFatigue();
    _target.fatigueMax <- _entity.getFatigueMax();
    _target.fatigueTalent <- _entity.getTalents()["this.Const.Attributes.Fatigue"];
    _target.initiative <- _entity.getInitiative();
    _target.initiativeMax <- this.Const.CharacterMaxValue.Initiative;
    _target.initiativeTalent <- _entity.getTalents()["this.Const.Attributes.Initiative"];
    _target.bravery <- _entity.getBravery();
    _target.braveryMax <- this.Const.CharacterMaxValue.Bravery;
    _target.braveryTalent <- _entity.getTalents()["this.Const.Attributes.Bravery"];
    _target.meleeSkill <- _entity.getCurrentProperties().getMeleeSkill();
    _target.meleeSkillMax <- this.Const.CharacterMaxValue.MeleeSkill;
    _target.meleeSkillTalent <- _entity.getTalents()["this.Const.Attributes.MeleeSkill"];
    _target.rangeSkill <- _entity.getCurrentProperties().getRangedSkill();
    _target.rangeSkillMax <- this.Const.CharacterMaxValue.RangedSkill;
    _target.rangeSkillTalent <- _entity.getTalents()["this.Const.Attributes.RangedSkill"];
    _target.meleeDefense <- _entity.getCurrentProperties().getMeleeDefense();
    _target.meleeDefenseMax <- this.Const.CharacterMaxValue.MeleeDefense;
    _target.meleeDefenseTalent <- _entity.getTalents()["this.Const.Attributes.MeleeDefense"];
    _target.rangeDefense <- _entity.getCurrentProperties().getRangedDefense();
    _target.rangeDefenseMax <- this.Const.CharacterMaxValue.RangedDefense;
    _target.rangeDefenseTalent <- _entity.getTalents()["this.Const.Attributes.RangedDefense"];
    _target.actionPoints <- _entity.getActionPoints();
    _target.actionPointsMax <- _entity.getActionPointsMax();
    _target.morale <- _entity.getMoraleState();
    _target.moraleMax <- (this.Const.MoraleState.COUNT - 1);
    _target.moraleLabel <- this.Const.MoraleStateName["_entity.getMoraleState()"];
    if (_entity.isArmedWithMeleeWeapon())
    {
    }
    _target.regularDamage <- (_entity.getCurrentProperties().getRegularDamageAverage() * (1.0 * 1.0));
    _target.regularDamageMax <- this.Const.CharacterMaxValue.RegularDamage;
    _target.regularDamageLabel <- ((this.Math.floor((_entity.getCurrentProperties().getDamageRegularMin() * (1.0 * 1.0))) + " - ") + this.Math.floor((_entity.getCurrentProperties().getDamageRegularMax() * (1.0 * 1.0))));
    _target.armorHead <- _entity.getArmor(this.Const.BodyPart.Head);
    _target.armorHeadMax <- _entity.getArmorMax(this.Const.BodyPart.Head);
    _target.armorHeadTalent <- 0;
    _target.armorBody <- _entity.getArmor(this.Const.BodyPart.Body);
    _target.armorBodyMax <- _entity.getArmorMax(this.Const.BodyPart.Body);
    _target.armorBodyTalent <- 0;
    _target.crushingDamage <- this.Math.floor((_entity.getCurrentProperties().getDamageArmorMult() * 100));
    _target.crushingDamageMax <- this.Const.CharacterMaxValue.ArmorDamage;
    _target.crushingDamageLabel <- (this.Math.floor((_entity.getCurrentProperties().getDamageArmorMult() * 100)) + "%");
    _target.chanceToHitHead <- _entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head);
    _target.chanceToHitHeadMax <- this.Const.CharacterMaxValue.Hitchance;
    _target.chanceToHitHeadLabel <- (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) + "%");
    _target.sightDistance <- _entity.getCurrentProperties().getVision();
    _target.sightDistanceMax <- this.Const.CharacterMaxValue.Vision;
    return;
}

function convertAssetsInformationToUIData(this)
{
    if (this.World.getPlayerRoster().getAll() != null)
    {
    }
    return this.World.getPlayerRoster();
}

function convertBagItemsToUIData(this, _items, _target)
{
    if (_items == null)
    {
        return;
    }
    if (0 < this.Const.ItemSlotSpaces["this.Const.ItemSlot.Bag"])
    {
        if (0 < _items.getUnlockedBagSlots())
        {
            _target.push(this.convertItemToUIData(_items.getItemAtBagSlot(0), true));
        }
    }
    return;
}

function convertCampaignStorageToUIData(this, _meta)
{
    if (_meta.getInt("ironman") == 1)
    {
    }
    return;
}

function convertCampaignStoragesToUIData(this)
{
    if (this.World.Assets != null)
    {
    }
    foreach (local key, value in r59)
    {
        if ((null.getFileName() == ((this.World.Assets.getName() + "_") + this.World.Assets.getCampaignID()) && (null.getFileName() == ((this.World.Assets.getName() + "_") + this.World.Assets.getCampaignID()))))
        {
            return ((null.getFileName() == ((this.World.Assets.getName() + "_") + this.World.Assets.getCampaignID())) && (null.getFileName() == ((this.World.Assets.getName() + "_") + this.World.Assets.getCampaignID())));
        }
        if ((this.Const.Strings.Difficulty.len() >= this.Const.Strings.Difficulty) && (this.Const.Strings.Difficulty.len() >= this.Const.Strings.Difficulty))
        {
            return ((this.Const.Strings.Difficulty.len() >= this.Const.Strings.Difficulty) && (this.Const.Strings.Difficulty.len() >= this.Const.Strings.Difficulty));
        }
        (this.World.Assets != null).push(this.convertCampaignStorageToUIData(null));
        return (this.World.Assets != null);
    }
}

function convertCombatResultLootToUIData(this)
{
    if (this.Tactical.CombatResultLoot.getItems() != null)
    {
        foreach (local key, value in r9)
        {
            [].push(this.convertItemToUIData(null, true));
            return this.Tactical.CombatResultLoot.getItems();
            return this.Tactical.CombatResultLoot.getItems();
        }
    }
}

function convertCombatResultRosterToUIData(this)
{
    if (this.Tactical.CombatResultRoster != null)
    {
        foreach (local key, value in r13)
        {
            [].push(this.convertStatisticsEntityToUIData(null));
            if (((0 + null.getCombatStats().Kills) >= 24) && ((0 + null.getCombatStats().Kills) >= 24))
            {
                return (((0 + null.getCombatStats().Kills) >= 24) && ((0 + null.getCombatStats().Kills) >= 24));
                this.updateAchievement("Outnumbered", 1, 1);
            }
            return this.Tactical.CombatResultRoster;
            return this.Tactical.CombatResultRoster;
        }
    }
}

function convertContractToUIData(this, _contract)
{
    if (_contract != null)
    {
        {}.content <- [];
        {}.buttons <- _contract.getButtons();
        if (_contract.getBulletpoints().len() != 0)
        {
            {}.content.push({});
        }
        return _contract;
    }
}

function convertContractsToUIData(this, _contracts)
{
    if ((r3 == 0) && (r3 == 0))
    {
        return ((r3 == 0) && (r3 == 0));
        return _contracts;
    }
    foreach (local key, value in r8)
    {
        [].push(this.convertContractToUIData(null));
        return _contracts;
    }
}

function convertEntityHireInformationToUIData(this, _entity)
{
    return _entity;
}

function convertEntityToUIData(this, _entity, _activeEntity)
{
    {}.flags <- {};
    {}.character <- {};
    {}.stats <- {};
    {}.activeSkills <- {};
    {}.passiveSkills <- {};
    {}.statusEffects <- {};
    {}.injuries <- [];
    {}.perks <- [];
    {}.equipment <- {};
    {}.bag <- [];
    {}.ground <- [];
    this.addFlagsToUIData(_entity, _activeEntity, {}.flags);
    this.addCharacterToUIData(_entity, {}.character);
    this.addStatsToUIData(_entity, {}.stats);
    this.addSkillsToUIData(_entity.getSkills().querySortedByItems(this.Const.SkillType.Active), {}.activeSkills);
    this.addSkillsToUIData(_entity.getSkills().querySortedByItems((this.Const.SkillType.Trait | this.Const.SkillType.PermanentInjury)), {}.passiveSkills);
    foreach (local key, value in r15)
    {
        {}.injuries.push({});
        this.addSkillsToUIData(_entity.getSkills().querySortedByItems(this.Const.SkillType.StatusEffect, this.Const.SkillType.Trait), {}.passiveSkills);
        this.addPerksToUIData(_entity, _entity.getSkills().query(this.Const.SkillType.Perk, true), {}.perks);
        this.convertPaperdollEquipmentToUIData(_entity.getItems(), {}.equipment);
        this.convertBagItemsToUIData(_entity.getItems(), {}.bag);
        if ((this.Tactical.isActive != null) && (this.Tactical.isActive != null))
        {
            return ((this.Tactical.isActive != null) && (this.Tactical.isActive != null));
            this.convertItemsToUIData(_entity.getTile().Items, {}.ground);
            {}.ground.push(null);
        }
        return _entity;
    }
}

function convertHireRosterToUIData(this, _rosterID)
{
    if (this.World.getRoster(_rosterID) == null)
    {
        return _rosterID;
    }
    if (this.World.getRoster(_rosterID).getAll() != null)
    {
        foreach (local key, value in null)
        {
            [].push(this.convertEntityHireInformationToUIData(null));
            return _rosterID;
            return _rosterID;
        }
    }
}

function convertItemToUIData(this, _item, _forceSmallIcon, _owner)
{
    if (_item == null)
    {
        return _item;
    }
    if (_item.getSlotType() == this.Const.ItemSlot.Body)
    {
    }
    if (_item.getSlotType() == this.Const.ItemSlot.Head)
    {
    }
    if (_item.getSlotType() == this.Const.ItemSlot.Mainhand)
    {
    }
    if (_item.getSlotType() == this.Const.ItemSlot.Offhand)
    {
    }
    if (_item.getSlotType() == this.Const.ItemSlot.Accessory)
    {
    }
    if (_item.getSlotType() == this.Const.ItemSlot.Ammo)
    {
    }
    if (_item.getSlotType() == this.Const.ItemSlot.Free)
    {
    }
    if (("slot" != null) && ("slot" != null))
    {
        return (("slot" != null) && ("slot" != null));
    }
    if ((null == this.Const.ItemSlot.Offhand) && (null == this.Const.ItemSlot.Offhand))
    {
        return ((null == this.Const.ItemSlot.Offhand) && (null == this.Const.ItemSlot.Offhand));
    }
    if (_owner != null)
    {
        if (_owner == this.Const.UI.ItemOwner.Stash)
        {
            {}.price = _item.getSellPrice();
        }
        else
        {
            if (_owner == this.Const.UI.ItemOwner.Shop)
            {
                {}.price = _item.getBuyPrice();
            }
        }
    }
    return _item;
}

function convertItemsToUIData(this, _items, _target, _owner, _filter)
{
    if (_filter == 0)
    {
    }
    if ((r6 == 0) && (r6 == 0))
    {
        return ((r6 == 0) && (r6 == 0));
    }
    if (0 < _items.len())
    {
        if ((_items[0] != 0) && (_items[0] != 0))
        {
            return ((_items[0] != 0) && (_items[0] != 0));
            _target.push(this.convertItemToUIData(_items["0"], true, _owner));
        }
        _target.push(null);
    }
    return;
}

function convertPaperdollEquipmentToUIData(this, _items, _target)
{
    if (_items == null)
    {
        return;
    }
    if (_items.getItemAtSlot(this.Const.ItemSlot.Body) != null)
    {
        _target.body <- this.convertItemToUIData(_items.getItemAtSlot(this.Const.ItemSlot.Body), false);
    }
    if (_items.getItemAtSlot(this.Const.ItemSlot.Head) != null)
    {
        _target.head <- this.convertItemToUIData(_items.getItemAtSlot(this.Const.ItemSlot.Head), false);
    }
    if (_items.getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
    {
        _target.mainhand <- this.convertItemToUIData(_items.getItemAtSlot(this.Const.ItemSlot.Mainhand), false);
    }
    if (_items.getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
    {
        _target.offhand <- this.convertItemToUIData(_items.getItemAtSlot(this.Const.ItemSlot.Offhand), false);
    }
    if (_items.getItemAtSlot(this.Const.ItemSlot.Accessory) != null)
    {
        _target.accessory <- this.convertItemToUIData(_items.getItemAtSlot(this.Const.ItemSlot.Accessory), false);
    }
    if (_items.getItemAtSlot(this.Const.ItemSlot.Ammo) != null)
    {
        _target.ammo <- this.convertItemToUIData(_items.getItemAtSlot(this.Const.ItemSlot.Ammo), true);
    }
    return;
}

function convertPerkToUIData(this, _perkId)
{
    if (this.Const.Perks.findById(_perkId) != null)
    {
        return _perkId;
    }
    return _perkId;
}

function convertPerksToUIData(this)
{
    return this.Const.Perks.Perks;
}

function convertSkillToUIData(this, _skill)
{
    return _skill;
}

function convertSkillsToUIData(this, _skills)
{
    foreach (local key, value in r38)
    {
        if (null == null)
        {
        }
        if (this.Stash.isLocked() == false)
        {
            if (null.isType(this.Const.SkillType.Terrain) != true)
            {
                [].push(this.convertSkillToUIData(null));
            }
        }
        [].push(this.convertSkillToUIData(null));
        return _skills;
    }
}

function convertStashAndEntityToUIData(this, _entity, _activeEntity, _withoutStash, _filter)
{
    if (_withoutStash == false)
    {
    }
    if (_entity != null)
    {
    }
    return _entity;
}

function convertStashToUIData(this, _ignoreLocked, _filter)
{
    if (this.Stash && this.Stash)
    {
        return (this.Stash && this.Stash);
        return _ignoreLocked;
    }
    if (_filter == 0)
    {
    }
    if (this.Stash.getItems() != null)
    {
        foreach (local key, value in r29)
        {
            if ((r9 != 0) && (r9 != 0))
            {
                return ((r9 != 0) && (r9 != 0));
                [].push(this.convertItemToUIData(null, true, this.Const.UI.ItemOwner.Stash));
            }
            [].push(null);
            return _ignoreLocked;
            return _ignoreLocked;
        }
    }
}

function convertStatisticsEntityToUIData(this, _entity)
{
    if (this.hasFreshPermanentInjury(_entity))
    {
        if (this.hasFreshPermanentInjury(_entity))
        {
        }
    }
    return _entity;
}

function create(this)
{
    return;
}

function destroy(this)
{
    return;
}

function hasFreshPermanentInjury(this, _entity)
{
    foreach (local key, value in r9)
    {
        if (null.isFresh())
        {
            return _entity;
        }
        return _entity;
    }
}

function queryFreshInjuries(this, _entity)
{
    foreach (local key, value in r18)
    {
        if (null.isFresh())
        {
            [].push({});
        }
        return _entity;
    }
}
