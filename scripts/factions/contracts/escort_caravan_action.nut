// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/escort_caravan_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "escort_caravan_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 7);
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
    this.new("scripts/contracts/contracts/escort_caravan_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/escort_caravan_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.new("scripts/contracts/contracts/escort_caravan_contract").setHome(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/escort_caravan_contract").setOrigin(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/escort_caravan_contract").setup();
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/escort_caravan_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if ((this.Math > 15) && (this.Math > 15) && (this.Math > 15))
    {
        return ((this.Math > 15) && (this.Math > 15) && (this.Math > 15));
    }
    foreach (local key, value in r65)
    {
        if (null.getID() == _faction.getSettlements()["0"].getID())
        {
        }
        else
        {
            if (!null.isAlliedWith(_faction.getID()))
            {
            }
            else
            {
                if (null.isCoastal() || null.isCoastal() || null.isCoastal())
                {
                    return (null.isCoastal() || null.isCoastal() || null.isCoastal());
                }
                if ((null.getTile().getDistanceTo(_faction.getSettlements()["0"].getTile() > 100) && (null.getTile().getDistanceTo(_faction.getSettlements()["0"].getTile()) > 100)))
                {
                    return ((null.getTile().getDistanceTo(_faction.getSettlements()["0"].getTile()) > 100) && (null.getTile().getDistanceTo(_faction.getSettlements()["0"].getTile()) > 100));
                }
                if ((0 + 4) == 0)
                {
                    return;
                }
                this.m.Score = 1;
                return;
            }
        }
    }
}
