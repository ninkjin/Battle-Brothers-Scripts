// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/actions/rebuild_location_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "rebuild_location_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 14);
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
    this.m.Settlement.addSituation(this.new("scripts/entity/world/settlements/situations/rebuilding_effort_situation"));
    if (this.World.FactionManager.isCivilWar())
    {
    }
    this.m.Cooldown = (((this.World.getTime().SecondsPerDay * this.Math.rand(10, 20)) * (1.0 - (0.20000000298023224 * (this.m.Settlement.getSize() - 1)))) * 0.8999999761581421);
    return;
}

function onUpdate(this, _faction)
{
    if (this.Math.rand(1, 100) > 10)
    {
        return;
    }
    if ((this.World.Contracts == r6) && (this.World.Contracts == r6))
    {
        return ((this.World.Contracts == r6) && (this.World.Contracts == r6));
    }
    this.m.Settlement = _faction.getSettlements()["this.Math.rand(0, (_faction.getSettlements().len() - 1))"];
    if ((!this.m.Settlement) && (!this.m.Settlement))
    {
        return ((!this.m.Settlement) && (!this.m.Settlement));
    }
    if (this.m.Settlement.getTile().getDistanceTo(this.World.State.getPlayer().getTile() <= 15))
    {
        return;
    }
    foreach (local key, value in r10)
    {
        if (null.isActive())
        {
        }
        if ((0 + 3) == 0)
        {
            return;
        }
        this.m.Score = 1;
        return;
    }
}
