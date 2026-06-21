// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/destroy_orc_camp_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "destroy_orc_camp_action";
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
    this.new("scripts/contracts/contracts/destroy_orc_camp_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/destroy_orc_camp_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.new("scripts/contracts/contracts/destroy_orc_camp_contract").setOrigin(this.m.Origin);
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/destroy_orc_camp_contract"));
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
    if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
    {
        return;
    }
    if ((this.Math > 10) && (this.Math > 10))
    {
        return ((this.Math > 10) && (this.Math > 10));
    }
    foreach (local key, value in r35)
    {
        foreach (local key, value in r30)
        {
            if (null.isLocationType(this.Const.World.LocationType.Unique))
            {
            }
            if ((null.getTile().getDistanceTo(null.getTile() < 9999) && (null.getTile().getDistanceTo(null.getTile()) < 9999)))
            {
                return ((null.getTile().getDistanceTo(null.getTile()) < 9999) && (null.getTile().getDistanceTo(null.getTile()) < 9999));
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
