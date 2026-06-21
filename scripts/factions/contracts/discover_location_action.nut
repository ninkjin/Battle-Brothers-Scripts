// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/discover_location_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "discover_location_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 12);
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
    this.new("scripts/contracts/contracts/discover_location_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/discover_location_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.new("scripts/contracts/contracts/discover_location_contract").setHome(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/discover_location_contract").setOrigin(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/discover_location_contract").setup();
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/discover_location_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (this.World.State.getRegions().len() == 0)
    {
        return;
    }
    if (!this.Const.DLC.Unhold)
    {
        return;
    }
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if ((this.Math > 10) && (this.Math > 10) && (this.Math > 10))
    {
        return ((this.Math > 10) && (this.Math > 10) && (this.Math > 10));
    }
    clone this.extend(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getSettlements());
    foreach (local key, value in r70)
    {
        if (null && null)
        {
            return (null && null);
        }
        else
        {
            if (!this.World.State.getRegion(null.getTile().Region).Center.IsDiscovered)
            {
            }
            else
            {
                if (!this.World.State.getRegion(null.getTile().Region).Center.IsDiscovered)
                {
                }
                if (this.World.State.getRegion(null.getTile().Region).Discovered < 0.25)
                {
                    this.World.State.updateRegionDiscovery(this.World.State.getRegion(null.getTile().Region));
                }
                if (this.World.State.getRegion(null.getTile().Region).Discovered < 0.25)
                {
                }
                if (_faction.getSettlements()["0"].getTile().getDistanceTo(null.getTile() < 9000))
                {
                }
                if (_faction.getSettlements()["0"].getTile().getDistanceTo(null.getTile() >= 20))
                {
                    return;
                }
                this.m.Score = 1;
                return;
            }
        }
    }
}
