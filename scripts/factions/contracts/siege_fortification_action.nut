// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/siege_fortification_action.nut
// Functions: 5

function create(this)
{
    this.m.ID = "siege_fortification_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 7);
    this.m.IsStartingOnCooldown = false;
    this.m.IsSettlementsRequired = true;
    this.faction_action.create();
    return;
}

function onClear(this)
{
    this.m.Origin = null;
    return;
}

function onExecute(this, _faction)
{
    this.new("scripts/contracts/contracts/siege_fortification_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/siege_fortification_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.new("scripts/contracts/contracts/siege_fortification_contract").setOrigin(this.m.Origin);
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/siege_fortification_contract"));
    return;
}

function onSortBySettlements(this, _a, _b)
{
    if (_a.getSettlements().len() > _b.getSettlements().len())
    {
        return _a;
    }
    else
    {
        if (_a.getSettlements().len() < _b.getSettlements().len())
        {
            return _a;
        }
    }
    return _a;
}

function onUpdate(this, _faction)
{
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (_faction.getPlayerRelation() <= 25)
    {
        return;
    }
    if (this.World.Assets.getBusinessReputation() < 1500)
    {
        return;
    }
    if (!this.World.FactionManager.isCivilWar())
    {
        return;
    }
    if (this.Math.rand(1, 100) > 30)
    {
        return;
    }
    if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
    {
        return;
    }
    foreach (local key, value in r22)
    {
        if ((!null.isDiscovered() || (!null.isDiscovered())))
        {
            return ((!null.isDiscovered()) || (!null.isDiscovered()));
        }
        if (!true)
        {
            return;
        }
        foreach (local key, value in r15)
        {
            if (null.getID() == this.m.Faction)
            {
                this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse).remove(null);
            }
            this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse).sort(this.onSortBySettlements);
            foreach (local key, value in r43)
            {
                if (null.isIsolated())
                {
                }
                else
                {
                    if (!null.isMilitary())
                    {
                    }
                    else
                    {
                        if (null.getSize() == 3)
                        {
                        }
                        foreach (local key, value in r15)
                        {
                            if (null.getTile().getDistanceTo(null.getTile() < 9999))
                            {
                            }
                            if (((0 + 7) <= 1) && ((0 + 7) <= 1))
                            {
                                return (((0 + 7) <= 1) && ((0 + 7) <= 1));
                            }
                            this.m.Origin = null;
                            this.m.Score = 1;
                            return;
                        }
                    }
                }
            }
        }
    }
}
