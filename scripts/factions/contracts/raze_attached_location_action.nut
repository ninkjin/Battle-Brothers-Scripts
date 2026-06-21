// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/raze_attached_location_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "raze_attached_location_action";
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
    foreach (local key, value in r72)
    {
        if ((null.getAttachedLocations().len() == 0) || (null.getAttachedLocations().len() == 0))
        {
            return ((null.getAttachedLocations().len() == 0) || (null.getAttachedLocations().len() == 0));
        }
        foreach (local key, value in r19)
        {
            if ((!null.isMilitary() && (!null.isMilitary())))
            {
                return ((!null.isMilitary()) && (!null.isMilitary()));
            }
            if (!true)
            {
            }
            foreach (local key, value in (!null.isMilitary()))
            {
                if (null.getTile().getDistanceTo(null.getTile() < 9000))
                {
                }
                if (null == null)
                {
                    return;
                }
                foreach (local key, value in r31)
                {
                    if (null.isMilitary() || null.isMilitary())
                    {
                        return (null.isMilitary() || null.isMilitary());
                    }
                    if (null.getTile().getDistanceTo(null.getTile() > 0))
                    {
                    }
                    if (null == null)
                    {
                        return;
                    }
                    this.new("scripts/contracts/contracts/raze_attached_location_contract").setFaction(_faction.getID());
                    this.new("scripts/contracts/contracts/raze_attached_location_contract").setEmployerID(_faction.getRandomCharacter().getID());
                    this.new("scripts/contracts/contracts/raze_attached_location_contract").setOrigin(null);
                    this.new("scripts/contracts/contracts/raze_attached_location_contract").setSettlement(null);
                    this.new("scripts/contracts/contracts/raze_attached_location_contract").setLocation(null);
                    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/raze_attached_location_contract"));
                    return;
                }
            }
        }
    }
}

function onUpdate(this, _faction)
{
    if (this.World.FactionManager.isGreaterEvil())
    {
        return;
    }
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (_faction.getSettlements().len() < 2)
    {
        return;
    }
    if (_faction.getPlayerRelation() <= 70)
    {
        return;
    }
    if (this.World.Assets.getMoralReputation() >= 80)
    {
        return;
    }
    if (this.Math.rand(1, 100) > 8)
    {
        return;
    }
    if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
    {
        return;
    }
    foreach (local key, value in r49)
    {
        if ((!null.isDiscovered() || (!null.isDiscovered())))
        {
            return ((!null.isDiscovered()) || (!null.isDiscovered()));
        }
        foreach (local key, value in r19)
        {
            if ((!null.isMilitary() && (!null.isMilitary())))
            {
                return ((!null.isMilitary()) && (!null.isMilitary()));
            }
            if (true)
            {
            }
            if (!true)
            {
                return;
            }
            this.m.Score = 1;
            return;
        }
    }
}
