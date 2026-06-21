// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/hunting_serpents_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "hunting_serpents_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 12);
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
    this.new("scripts/contracts/contracts/hunting_serpents_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/hunting_serpents_contract").setHome(_faction.getSettlements()["0"]);
    this.new("scripts/contracts/contracts/hunting_serpents_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/hunting_serpents_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (!this.Const.DLC.Desert)
    {
        return;
    }
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (this.World.Assets.getBusinessReputation() < 450)
    {
        return;
    }
    if ((this.Math > 30) && (this.Math > 30))
    {
        return ((this.Math > 30) && (this.Math > 30));
    }
    if (!this.isKindOf(_faction.getSettlements()["0"], "city_state"))
    {
        return;
    }
    if (this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.X - 12) <= this.Math.min((this.World.getMapSize().X - 3), (_faction.getSettlements()["0"].getTile().SquareCoords.X + 12))))
    {
        if (this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.Y - 12) <= this.Math.min((this.World.getMapSize().Y - 3), (_faction.getSettlements()["0"].getTile().SquareCoords.Y + 12))))
        {
            if ((this.World.getTileSquare(this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.X - 12), this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.Y - 12))).Type == this.Const.World.TerrainType.Oasis) && (this.World.getTileSquare(this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.X - 12)), this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.Y - 12))).Type == this.Const.World.TerrainType.Oasis)))
            {
                return ((this.World.getTileSquare(this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.X - 12)), this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.Y - 12))).Type == this.Const.World.TerrainType.Oasis) && (this.World.getTileSquare(this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.X - 12)), this.Math.max(3, (_faction.getSettlements()["0"].getTile().SquareCoords.Y - 12))).Type == this.Const.World.TerrainType.Oasis));
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
