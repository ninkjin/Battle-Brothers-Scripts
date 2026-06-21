// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/hunting_schrats_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "hunting_schrats_action";
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
    this.new("scripts/contracts/contracts/hunting_schrats_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/hunting_schrats_contract").setHome(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/hunting_schrats_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/hunting_schrats_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (!this.Const.DLC.Unhold)
    {
        return;
    }
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (this.World.Assets.getBusinessReputation() < 1500)
    {
        return;
    }
    if (this.Math.rand(1, 100) > 20)
    {
        return;
    }
    if (_faction.getSettlements()["0"].isIsolated())
    {
        return;
    }
    if ((!this.isKindOf(_faction.getSettlements()["0"], "large_lumber_village") && (!this.isKindOf(_faction.getSettlements()["0"], "large_lumber_village"))))
    {
        return ((!this.isKindOf(_faction.getSettlements()["0"], "large_lumber_village")) && (!this.isKindOf(_faction.getSettlements()["0"], "large_lumber_village")));
    }
    if (this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.X - 11) <= this.Math.min((this.World.getMapSize().X - 3), (_faction.getSettlements()["0"].getTile().SquareCoords.X + 11))))
    {
        if (this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.Y - 11) <= this.Math.min((this.World.getMapSize().Y - 3), (_faction.getSettlements()["0"].getTile().SquareCoords.Y + 11))))
        {
            if ((this.World.getTileSquare(this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.X - 11), this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.Y - 11))).Type == this.Const.World.TerrainType.AutumnForest) || (this.World.getTileSquare(this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.X - 11)), this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.Y - 11))).Type == this.Const.World.TerrainType.AutumnForest)))
            {
                return ((this.World.getTileSquare(this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.X - 11)), this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.Y - 11))).Type == this.Const.World.TerrainType.AutumnForest) || (this.World.getTileSquare(this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.X - 11)), this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.Y - 11))).Type == this.Const.World.TerrainType.AutumnForest));
            }
        }
    }
    if ((0 + 9) == 0)
    {
        return;
    }
    this.m.Score = 1;
    return;
}
