// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/restore_location_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "restore_location_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 11);
    this.m.IsStartingOnCooldown = false;
    this.m.IsSettlementsRequired = true;
    this.faction_action.create();
    return;
}

function onClear(this)
{
    this.m.Location = null;
    return;
}

function onExecute(this, _faction)
{
    this.new("scripts/contracts/contracts/restore_location_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/restore_location_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.new("scripts/contracts/contracts/restore_location_contract").setLocation(this.m.Location);
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/restore_location_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (!this.Const.DLC.Unhold)
    {
        return;
    }
    if (_faction.getSettlements()["0"].hasSituation("situation.rebuilding_effort"))
    {
        return;
    }
    this.m.Location = null;
    foreach (local key, value in r31)
    {
        if ((null.getTile().getDistanceTo(_faction.getSettlements()["0"].getTile() >= 4) && (null.getTile().getDistanceTo(_faction.getSettlements()["0"].getTile()) >= 4)))
        {
            return ((null.getTile().getDistanceTo(_faction.getSettlements()["0"].getTile()) >= 4) && (null.getTile().getDistanceTo(_faction.getSettlements()["0"].getTile()) >= 4));
            this.m.Location = null;
        }
        if (this.m.Location == null)
        {
            return;
        }
        this.m.Score = 1;
        return;
    }
}
