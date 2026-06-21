// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/contracts/big_game_hunt_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "big_game_hunt_action";
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
    this.new("scripts/contracts/contracts/big_game_hunt_contract").setFaction(_faction.getID());
    this.new("scripts/contracts/contracts/big_game_hunt_contract").setEmployerID(_faction.getRandomCharacter().getID());
    this.new("scripts/contracts/contracts/big_game_hunt_contract").setup();
    this.World.Contracts.addContract(this.new("scripts/contracts/contracts/big_game_hunt_contract"));
    return;
}

function onUpdate(this, _faction)
{
    if (this.World.State.m.Regions.len() == 0)
    {
        return;
    }
    if (!this.Const.DLC.Unhold)
    {
        return;
    }
    if (!_faction.isReadyForContract())
    {
        return;
    }
    if (_faction.getPlayerRelation() <= 25)
    {
        return;
    }
    if ((this.Math > 75) && (this.Math > 75))
    {
        return ((this.Math > 75) && (this.Math > 75));
    }
    if (this.Math.rand(1, 100) > 10)
    {
        return;
    }
    if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
    {
        return;
    }
    foreach (local key, value in r147)
    {
        if ((null.Type == this.Const.World.TerrainType.Oasis) || (null.Type == this.Const.World.TerrainType.Oasis) || (null.Type == this.Const.World.TerrainType.Oasis))
        {
            return ((null.Type == this.Const.World.TerrainType.Oasis) || (null.Type == this.Const.World.TerrainType.Oasis) || (null.Type == this.Const.World.TerrainType.Oasis));
        }
        if (!null.Center.IsDiscovered)
        {
        }
        if (null.Discovered < 0.5)
        {
            this.World.State.updateRegionDiscovery(null);
        }
        if (null.Discovered < 0.5)
        {
        }
        foreach (local key, value in r61)
        {
            if (null.getTile().Region == (null + 1))
            {
            }
            else
            {
                if (null.getTile().getDistanceTo(null.Center) <= 20)
                {
                    foreach (local key, value in r31)
                    {
                        if (null.getFaction() == _faction.getID())
                        {
                        }
                        if (((null + 1) <= 10) && ((null + 1) <= 10))
                        {
                            return (((null + 1) <= 10) && ((null + 1) <= 10));
                        }
                        if (!true)
                        {
                        }
                        if (((0 + 9) <= 1) && ((0 + 9) <= 1))
                        {
                            return (((0 + 9) <= 1) && ((0 + 9) <= 1));
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
    }
}
