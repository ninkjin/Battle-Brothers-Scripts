// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/find_artifact_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "find_artifact_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 5);
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
    this.new("scripts/contracts/contracts/find_artifact_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/find_artifact_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/find_artifact_contract"));
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
    if (this.World.Assets.getBusinessReputation() < 1300)
    {
        return;
    }
    if (!this.World.FactionManager.isUndeadScourge())
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
    this.m.Score = 1;
    return;
}
