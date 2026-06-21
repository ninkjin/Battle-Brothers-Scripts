// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/break_siege_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "break_siege_action";
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
    this.new("scripts/contracts/contracts/break_greenskin_siege_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/break_greenskin_siege_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.new("scripts/contracts/contracts/break_greenskin_siege_contract").setOrigin(this.m.Origin);
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/break_greenskin_siege_contract"));
    return;
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
    if (!this.World.FactionManager.isGreenskinInvasion())
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
    foreach (local key, value in r90)
    {
        if ((!null) && (!null))
        {
            return ((!null) && (!null));
        }
        if (!null.isMilitary())
        {
        }
        foreach (local key, value in null)
        {
            if (null && null)
            {
                return (null && null);
            }
            if ((0 + 10) < 2)
            {
            }
            foreach (local key, value in r20)
            {
                if ((null.getTile().getDistanceTo(null.getTile() < 9999) && (null.getTile().getDistanceTo(null.getTile()) < 9999)))
                {
                    return ((null.getTile().getDistanceTo(null.getTile()) < 9999) && (null.getTile().getDistanceTo(null.getTile()) < 9999));
                }
                foreach (local key, value in r20)
                {
                    if ((null.getTile().getDistanceTo(null.getTile() < null.getTile().getDistanceTo(null.getTile())) && (null.getTile().getDistanceTo(null.getTile()) < null.getTile().getDistanceTo(null.getTile()))))
                    {
                        return ((null.getTile().getDistanceTo(null.getTile()) < null.getTile().getDistanceTo(null.getTile())) && (null.getTile().getDistanceTo(null.getTile()) < null.getTile().getDistanceTo(null.getTile())));
                    }
                    if (null == null)
                    {
                        return;
                    }
                    this.m.Origin = null;
                    this.m.Score = 1;
                    return;
                }
            }
        }
    }
}
