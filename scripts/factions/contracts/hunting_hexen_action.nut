// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/hunting_hexen_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "hunting_hexen_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 14);
    this.m.IsStartingOnCooldown = false;
    this.m.IsSettlementsRequired = true;
    this.faction_action.create();
    return;
}

function onClear(this)
{
    return;
}

function onExecute(this, _faction)
{
    this.new("scripts/contracts/contracts/hunting_hexen_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/hunting_hexen_contract").setHome(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/hunting_hexen_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/hunting_hexen_contract"));
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
    if (this.World.Assets.getBusinessReputation() < 900)
    {
        return;
    }
    if (this.Math.rand(1, 100) > 6)
    {
        return;
    }
    if ((_faction.getSettlements()["0"].isIsolated[0] > 2) && (_faction.getSettlements()["0"].isIsolated[0] > 2))
    {
        return ((_faction.getSettlements()["0"].isIsolated[0] > 2) && (_faction.getSettlements()["0"].isIsolated[0] > 2));
    }
    if (this && this)
    {
        return (this && this);
    }
    this.m.Score = 1;
    return;
}
