// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/actions/burn_location_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "burn_location_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 20);
    this.m.IsSettlementsRequired = true;
    this.faction_action.create();
    return;
}

function onClear(this)
{
    this.m.Settlement = null;
    return;
}

function onExecute(this, _faction)
{
    foreach (local key, value in r18)
    {
        if ((!null) && (!null))
        {
            return ((!null) && (!null));
        }
        [].push(null);
        []["this.Math.rand(0, ([].len() - 1))"].setActive(false);
        []["this.Math.rand(0, ([].len() - 1))"].spawnFireAndSmoke();
        if (this.m.Settlement.getSize() <= 2)
        {
            this.new("scripts/entity/world/settlements/situations/raided_situation").setValidForDays(3);
            this.m.Settlement.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"));
        }
        if (this.m.Settlement.getOwner() != null)
        {
        }
        if ((this.m.Settlement.getTile() <= 20) && (this.m.Settlement.getTile() <= 20))
        {
            return ((this.m.Settlement.getTile() <= 20) && (this.m.Settlement.getTile() <= 20));
        }
        if ((this.m.Settlement.getTile() <= 20) && (this.m.Settlement.getTile() <= 20))
        {
            return ((this.m.Settlement.getTile() <= 20) && (this.m.Settlement.getTile() <= 20));
        }
        this.m.Cooldown = ((((this.World.getTime().SecondsPerDay * this.Math.rand(15, 25)) * 1.5) * 0.75) * 0.75);
        return;
    }
}

function onUpdate(this, _faction)
{
    if (this.Math.rand(1, 100) > 1)
    {
        return;
    }
    if (this.World.FactionManager.isGreaterEvil())
    {
        return;
    }
    if ((this.World.Contracts == r8) && (this.World.Contracts == r8))
    {
        return ((this.World.Contracts == r8) && (this.World.Contracts == r8));
    }
    this.m.Settlement = _faction.getSettlements()["this.Math.rand(0, (_faction.getSettlements().len() - 1))"];
    if ((!this.m.Settlement) && (!this.m.Settlement))
    {
        return ((!this.m.Settlement) && (!this.m.Settlement));
    }
    if (this.m.Settlement.getTile().getDistanceTo(this.World.State.getPlayer().getTile() <= 20))
    {
        return;
    }
    foreach (local key, value in r16)
    {
        if ((!null) && (!null))
        {
            return ((!null) && (!null));
        }
        if ((0 + 2) <= this.m.Settlement.getSize())
        {
            return;
        }
        this.m.Score = 1;
        return;
    }
}
