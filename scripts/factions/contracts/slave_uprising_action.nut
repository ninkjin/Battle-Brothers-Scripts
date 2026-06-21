// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/slave_uprising_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "slave_uprising_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 14);
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
    this.new("scripts/contracts/contracts/slave_uprising_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/slave_uprising_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.new("scripts/contracts/contracts/slave_uprising_contract").setLocation(this.m.Location);
    this.new("scripts/contracts/contracts/slave_uprising_contract").setHome(_faction.getSettlements()["0"]);
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/slave_uprising_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (!this.Const.DLC.Desert)
    {
        return;
    }
    if ((this.World.Days < 2) && (this.World.Days < 2))
    {
        return ((this.World.Days < 2) && (this.World.Days < 2));
    }
    if ((this.Math > 1) && (this.Math > 1))
    {
        return ((this.Math > 1) && (this.Math > 1));
    }
    this.m.Location = null;
    foreach (local key, value in r31)
    {
        if ((null.getTile().getDistanceTo(_faction.getSettlements()["0"].getTile() >= 3) && (null.getTile().getDistanceTo(_faction.getSettlements()["0"].getTile()) >= 3)))
        {
            return ((null.getTile().getDistanceTo(_faction.getSettlements()["0"].getTile()) >= 3) && (null.getTile().getDistanceTo(_faction.getSettlements()["0"].getTile()) >= 3));
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
