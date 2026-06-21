// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/intercept_raiding_parties_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "intercept_raiding_parties_action";
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
    this.new("scripts/contracts/contracts/intercept_raiding_parties_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/intercept_raiding_parties_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/intercept_raiding_parties_contract"));
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
    if ((!this.World.FactionManager.isHolyWar) && (!this.World.FactionManager.isHolyWar))
    {
        return ((!this.World.FactionManager.isHolyWar) && (!this.World.FactionManager.isHolyWar));
    }
    if (this.Math.rand(1, 100) > 30)
    {
        return;
    }
    if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
    {
        return;
    }
    foreach (local key, value in r56)
    {
        if ((null.getActiveAttachedLocations().len() < 2) || (null.getActiveAttachedLocations().len() < 2) || (null.getActiveAttachedLocations().len() < 2) || (null.getActiveAttachedLocations().len() < 2))
        {
            return ((null.getActiveAttachedLocations().len() < 2) || (null.getActiveAttachedLocations().len() < 2) || (null.getActiveAttachedLocations().len() < 2) || (null.getActiveAttachedLocations().len() < 2));
        }
        if (this.World.getTileSquare(null.getTile().SquareCoords.X, (null.getTile().SquareCoords.Y - 12).Type == this.Const.World.TerrainType.Ocean))
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
