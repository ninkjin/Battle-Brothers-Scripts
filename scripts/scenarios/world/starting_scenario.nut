// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/scenarios/world/starting_scenario.nut
// Functions: 22

function getDescription(this)
{
    return this.m.Description;
}

function getDifficulty(this)
{
    return this.m.Difficulty;
}

function getDifficultyForUI(this)
{
    if (this.m.Difficulty == 1)
    {
        return this.m.Difficulty;
    }
    if (this.m.Difficulty == 2)
    {
        return this.m.Difficulty;
    }
    if (this.m.Difficulty == 3)
    {
        return this.m.Difficulty;
    }
    return this.m.Difficulty;
}

function getID(this)
{
    return this.m.ID;
}

function getName(this)
{
    return this.m.Name;
}

function getOrder(this)
{
    return this.m.Order;
}

function isDroppedAsLoot(this, _item)
{
    return _item;
}

function isFixedLook(this)
{
    return this.m.IsFixedLook;
}

function isValid(this)
{
    return true;
}

function onActorKilled(this, _actor, _killer, _combatID)
{
    return;
}

function onBattleWon(this, _combatLoot)
{
    return;
}

function onCombatFinished(this)
{
    return true;
}

function onContractFinished(this, _contractType, _cancelled)
{
    return;
}

function onGetBackgroundTooltip(this, _background, _tooltip)
{
    return;
}

function onHired(this, _bro)
{
    return;
}

function onInit(this)
{
    return;
}

function onSpawnAssets(this)
{
    return;
}

function onSpawnPlayer(this)
{
    return;
}

function onUnlockPerk(this, _bro, _perkID)
{
    return;
}

function onUpdateDraftList(this, _list)
{
    return;
}

function onUpdateHiringRoster(this, _roster)
{
    return;
}

function onUpdateLevel(this, _bro)
{
    return;
}
