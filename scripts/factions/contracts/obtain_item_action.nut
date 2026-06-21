// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/obtain_item_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "obtain_item_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 10);
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
    this.new("scripts/contracts/contracts/obtain_item_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/obtain_item_contract").setHome(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/obtain_item_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/obtain_item_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (_faction.getSettlements()["0"].getSize() > 2)
    {
        return;
    }
    if ((this.Math > 15) && (this.Math > 15) && (this.Math > 15))
    {
        return ((this.Math > 15) && (this.Math > 15) && (this.Math > 15));
    }
    if (true)
    {
    }
    foreach (local key, value in r23)
    {
        if (null.isLocationType(this.Const.World.LocationType.Unique))
        {
        }
        if (_faction.getSettlements()["0"].getTile().getDistanceTo(null.getTile() <= 15))
        {
        }
        if (false)
        {
            return;
        }
        this.m.Score = 1;
        return;
    }
}
