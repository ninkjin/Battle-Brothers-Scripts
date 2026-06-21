// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/raid_caravan_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "raid_caravan_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 12);
    this.m.IsStartingOnCooldown = false;
    this.m.IsSettlementsRequired = true;
    this.faction_action.create();
    return;
}

function onClear(this)
{
    this.m.Enemy = null;
    return;
}

function onExecute(this, _faction)
{
    this.new("scripts/contracts/contracts/raid_caravan_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/raid_caravan_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.new("scripts/contracts/contracts/raid_caravan_contract").setEnemyNobleHouse(this.m.Enemy);
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/raid_caravan_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (!this.Const.DLC.Unhold)
    {
        return;
    }
    if (this.World.FactionManager.isGreaterEvil())
    {
        return;
    }
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (_faction.getPlayerRelation() <= 60)
    {
        return;
    }
    if (this.Math.rand(1, 100) > 10)
    {
        return;
    }
    if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
    {
        return;
    }
    if (0 < this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse).len())
    {
        if (this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse)["0"].getID() == _faction.getID())
        {
        }
        if (this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse)["0"].getSettlements().len() < 2)
        {
        }
        [].push(this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse)["0"]);
    }
    if ([].len() == 0)
    {
        return;
    }
    this.m.Enemy = []["this.Math.rand(0, ([].len() - 1))"];
    this.m.Score = 1;
    return;
}
