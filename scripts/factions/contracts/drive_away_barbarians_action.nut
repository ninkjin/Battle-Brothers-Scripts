// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/drive_away_barbarians_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "drive_away_barbarians_action";
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
    this.new("scripts/contracts/contracts/drive_away_barbarians_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/drive_away_barbarians_contract").setHome(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/drive_away_barbarians_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/drive_away_barbarians_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if ((this.World.FactionManager == null) && (this.World.FactionManager == null))
    {
        return ((this.World.FactionManager == null) && (this.World.FactionManager == null));
    }
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (_faction.getSettlements()["0"].isIsolated())
    {
        return;
    }
    if ((this.Math > 25) && (this.Math > 25) && (this.Math > 25))
    {
        return ((this.Math > 25) && (this.Math > 25) && (this.Math > 25));
    }
    if (true)
    {
        foreach (local key, value in r13)
        {
            if (_faction.getSettlements()["0"].getTile().getDistanceTo(null.getTile() <= 12))
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
