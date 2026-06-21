// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/hunting_lindwurms_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "hunting_lindwurms_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 14);
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
    this.new("scripts/contracts/contracts/hunting_lindwurms_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/hunting_lindwurms_contract").setHome(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/hunting_lindwurms_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/hunting_lindwurms_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if ((!this.Const.DLC.Lindwurm) && (!this.Const.DLC.Lindwurm))
    {
        return ((!this.Const.DLC.Lindwurm) && (!this.Const.DLC.Lindwurm));
    }
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (this.World.Assets.getBusinessReputation() < 1500)
    {
        return;
    }
    if (this.Math.rand(1, 100) > 10)
    {
        return;
    }
    if (_faction.getSettlements()["0"].isIsolated())
    {
        return;
    }
    if ((!this.isKindOf(_faction.getSettlements()["0"], "large_farming_village") && (!this.isKindOf(_faction.getSettlements()["0"], "large_farming_village")) && (!this.isKindOf(_faction.getSettlements()["0"], "large_farming_village")) && (!this.isKindOf(_faction.getSettlements()["0"], "large_farming_village")) && (!this.isKindOf(_faction.getSettlements()["0"], "large_farming_village"))))
    {
        return ((!this.isKindOf(_faction.getSettlements()["0"], "large_farming_village")) && (!this.isKindOf(_faction.getSettlements()["0"], "large_farming_village")) && (!this.isKindOf(_faction.getSettlements()["0"], "large_farming_village")) && (!this.isKindOf(_faction.getSettlements()["0"], "large_farming_village")) && (!this.isKindOf(_faction.getSettlements()["0"], "large_farming_village")));
    }
    this.m.Score = 1;
    return;
}
