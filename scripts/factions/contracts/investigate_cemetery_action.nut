// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/investigate_cemetery_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "investigate_cemetery_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 9);
    this.m.IsStartingOnCooldown = false;
    this.m.IsSettlementsRequired = true;
    this.faction_action.create();
    return;
}

function onClear(this)
{
    this.m.Target = null;
    return;
}

function onExecute(this, _faction)
{
    this.new("scripts/contracts/contracts/investigate_cemetery_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/investigate_cemetery_contract").setHome(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/investigate_cemetery_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.new("scripts/contracts/contracts/investigate_cemetery_contract").setDestination(this.m.Target);
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/investigate_cemetery_contract"));
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
    if ((this.Math.rand(1, 100) > 75) && (this.Math.rand(1, 100) > 75))
    {
        return ((this.Math.rand(1, 100) > 75) && (this.Math.rand(1, 100) > 75));
    }
    this.m.Target = null;
    foreach (local key, value in r26)
    {
        if ((null.getTile() == r20) && (null.getTile() == r20))
        {
            return ((null.getTile() == r20) && (null.getTile() == r20));
            this.m.Target = null;
        }
        if (this.m.Target == null)
        {
            return;
        }
        this.m.Score = 1;
        return;
    }
}
