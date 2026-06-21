// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/patrol_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "patrol_action";
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
    this.new("scripts/contracts/contracts/patrol_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/patrol_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/patrol_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (_faction.getSettlements().len() < 3)
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
    if (this.World.FactionManager.isGreaterEvil())
    {
        if (this.Math.rand(1, 100) > 20)
        {
            return;
        }
    }
    else
    {
        if (this.Math.rand(1, 100) > 10)
        {
            return;
        }
    }
    foreach (local key, value in r13)
    {
        if (null && null)
        {
            return (null && null);
        }
        if ((0 + 2) < 3)
        {
            return;
        }
        this.m.Score = 1;
        return;
    }
}
