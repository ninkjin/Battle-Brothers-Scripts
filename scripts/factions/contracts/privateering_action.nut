// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/privateering_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "privateering_action";
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
    this.new("scripts/contracts/contracts/privateering_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/privateering_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/privateering_contract"));
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
    foreach (local key, value in r48)
    {
        if (null.getID() == _faction.getID())
        {
        }
        foreach (local key, value in r23)
        {
            if ((null.getActiveAttachedLocations().len() == 0) || (null.getActiveAttachedLocations().len() == 0))
            {
                return ((null.getActiveAttachedLocations().len() == 0) || (null.getActiveAttachedLocations().len() == 0));
            }
            if ((0 + 7) >= 3)
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
