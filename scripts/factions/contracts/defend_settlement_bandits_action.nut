// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/defend_settlement_bandits_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "defend_settlements_bandits_action";
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
    this.new("scripts/contracts/contracts/defend_settlement_bandits_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/defend_settlement_bandits_contract").setHome(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/defend_settlement_bandits_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/defend_settlement_bandits_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (_faction.getSettlements()["0"].isIsolated())
    {
        return;
    }
    if (this.World.Assets.getBusinessReputation() < 500)
    {
        return;
    }
    if (this.Math.rand(1, 100) > 10)
    {
        return;
    }
    foreach (local key, value in r18)
    {
        if (null && null)
        {
            return (null && null);
        }
        if (null.isUsable())
        {
        }
        if ((0 + 3) < 2)
        {
            return;
        }
        if (true)
        {
            foreach (local key, value in r13)
            {
                if (_faction.getSettlements()["0"].getTile().getDistanceTo(null.getTile() <= 20))
                {
                }
                if (false)
                {
                    foreach (local key, value in null)
                    {
                        if (_faction.getSettlements()["0"].getTile().getDistanceTo(null.getTile() <= 20))
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
            }
        }
    }
}
