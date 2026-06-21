// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/hunting_unholds_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "hunting_unholds_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 14);
    this.m.IsStartingOnCooldown = false;
    this.m.IsSettlementsRequired = true;
    this.faction_action.create();
    return;
}

function onClear(this)
{
    this.m.EnemyType = 0;
    return;
}

function onExecute(this, _faction)
{
    this.new("scripts/contracts/contracts/hunting_unholds_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/hunting_unholds_contract").setHome(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/hunting_unholds_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.new("scripts/contracts/contracts/hunting_unholds_contract").setEnemyType(this.m.EnemyType);
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/hunting_unholds_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (!this.Const.DLC.Unhold)
    {
        return;
    }
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (this.World.Assets.getBusinessReputation() < 700)
    {
        return;
    }
    if (this.Math.rand(1, 100) > 15)
    {
        return;
    }
    if ((_faction.getSettlements()["0"].isIsolated[0] > 2) && (_faction.getSettlements()["0"].isIsolated[0] > 2))
    {
        return ((_faction.getSettlements()["0"].isIsolated[0] > 2) && (_faction.getSettlements()["0"].isIsolated[0] > 2));
    }
    if (this.isKindOf(_faction.getSettlements()["0"], "medium_swamp_village") || this.isKindOf(_faction.getSettlements()["0"], "medium_swamp_village") || this.isKindOf(_faction.getSettlements()["0"], "medium_swamp_village"))
    {
        return (this.isKindOf(_faction.getSettlements()["0"], "medium_swamp_village") || this.isKindOf(_faction.getSettlements()["0"], "medium_swamp_village") || this.isKindOf(_faction.getSettlements()["0"], "medium_swamp_village"));
        this.m.EnemyType = 0;
    }
    else
    {
        if (this && this)
        {
            return (this && this);
            this.m.EnemyType = 1;
        }
        if (this.isKindOf(_faction.getSettlements()["0"], "small_mining_village") || this.isKindOf(_faction.getSettlements()["0"], "small_mining_village"))
        {
            return (this.isKindOf(_faction.getSettlements()["0"], "small_mining_village") || this.isKindOf(_faction.getSettlements()["0"], "small_mining_village"));
            this.m.EnemyType = 2;
        }
        return;
    }
    this.m.Score = 1;
    return;
}
