// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/escort_envoy_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "escort_envoy_action";
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
    this.new("scripts/contracts/contracts/escort_envoy_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/escort_envoy_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/escort_envoy_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (this.World.FactionManager.isCivilWar())
    {
        return;
    }
    if (_faction.getPlayerRelation() <= 60)
    {
        return;
    }
    if (this.Math.rand(1, 100) > 10)
    {
        return;
    }
    if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
    {
        return;
    }
    foreach (local key, value in r38)
    {
        if (null.isIsolated() || null.isIsolated())
        {
            return (null.isIsolated() || null.isIsolated());
        }
        if ((null == null.isIsolated() && (null == null.isIsolated())))
        {
            return ((null == null.isIsolated()) && (null == null.isIsolated()));
        }
        if (!true)
        {
            return;
        }
        this.m.Score = 1;
        return;
    }
}
