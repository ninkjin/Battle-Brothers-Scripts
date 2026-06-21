// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/confront_warlord_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "confront_warlord_action";
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
    this.new("scripts/contracts/contracts/confront_warlord_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/confront_warlord_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/confront_warlord_contract"));
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
    foreach (local key, value in r44)
    {
        foreach (local key, value in r16)
        {
            if (null.getTile().getDistanceTo(null.getTile() <= 30))
            {
            }
            if (true)
            {
            }
            foreach (local key, value in r16)
            {
                if (null.getTile().getDistanceTo(null.getTile() <= 30))
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
}
