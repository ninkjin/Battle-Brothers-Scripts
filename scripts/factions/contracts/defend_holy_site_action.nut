// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/defend_holy_site_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "defend_holy_site_action";
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
    if (_faction.getType() == this.Const.FactionType.OrientalCityState)
    {
    }
    this.new("scripts/contracts/contracts/defend_holy_site_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/defend_holy_site_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/defend_holy_site_contract"));
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
    if (!this.World.FactionManager.isHolyWar())
    {
        return;
    }
    if ((!this.Const.FactionType.OrientalCityState) && (!this.Const.FactionType.OrientalCityState))
    {
        return ((!this.Const.FactionType.OrientalCityState) && (!this.Const.FactionType.OrientalCityState));
    }
    if (this.Math.rand(1, 100) > 30)
    {
        return;
    }
    if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
    {
        return;
    }
    foreach (local key, value in r32)
    {
        foreach (local key, value in r27)
        {
            if (this.World.FactionManager.isAllied(_faction.getID(), null.getFaction() && this.World.FactionManager.isAllied(_faction.getID(), null.getFaction())))
            {
                return (this.World.FactionManager.isAllied(_faction.getID(), null.getFaction()) && this.World.FactionManager.isAllied(_faction.getID(), null.getFaction()));
            }
            if (false)
            {
                return;
            }
            this.m.Score = 1;
            return;
        }
    }
}
