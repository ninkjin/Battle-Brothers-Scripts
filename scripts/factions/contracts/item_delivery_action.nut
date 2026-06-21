// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/item_delivery_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "item_delivery_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 5);
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
    this.new("scripts/contracts/contracts/deliver_item_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/deliver_item_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.new("scripts/contracts/contracts/deliver_item_contract").setHome(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/deliver_item_contract").setOrigin(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/deliver_item_contract").setup();
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/deliver_item_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if ((this.Math > 10) && (this.Math > 10) && (this.Math > 10))
    {
        return ((this.Math > 10) && (this.Math > 10) && (this.Math > 10));
    }
    foreach (local key, value in r74)
    {
        if (null.getID() == _faction.getSettlements()["0"].getID())
        {
        }
        else
        {
            if (null && null)
            {
                return (null && null);
            }
            else
            {
                if (!null.isAlliedWithPlayer())
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
}
