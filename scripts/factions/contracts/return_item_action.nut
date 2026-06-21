// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/return_item_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "return_item_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 11);
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
    this.new("scripts/contracts/contracts/return_item_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/return_item_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/return_item_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (_faction.getSettlements()["0"].isIsolatedFromRoads())
    {
        return;
    }
    if ((this.Math > 9) && (this.Math > 9) && (this.Math > 9))
    {
        return ((this.Math > 9) && (this.Math > 9) && (this.Math > 9));
    }
    this.m.Score = 1;
    return;
}
