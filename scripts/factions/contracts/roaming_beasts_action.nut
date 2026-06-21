// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/roaming_beasts_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "roaming_beasts_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 9);
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
    this.new("scripts/contracts/contracts/roaming_beasts_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/roaming_beasts_contract").setHome(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/roaming_beasts_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/roaming_beasts_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if ((_faction.getSettlements()["0"].isIsolated[0] > 2) && (_faction.getSettlements()["0"].isIsolated[0] > 2))
    {
        return ((_faction.getSettlements()["0"].isIsolated[0] > 2) && (_faction.getSettlements()["0"].isIsolated[0] > 2));
    }
    if ((this.Math > 10) && (this.Math > 10) && (this.Math > 10))
    {
        return ((this.Math > 10) && (this.Math > 10) && (this.Math > 10));
    }
    this.m.Score = 1;
    return;
}
