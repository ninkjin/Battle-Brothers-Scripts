// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/config/world_scaling.nut
// Functions: 1

function <anonymous>(this, _days)
{
    if (_days >= this.Const.World.Scaling.Brigands.MarauderSpawnLateDay)
    {
        return _days;
    }
    if (_days >= this.Const.World.Scaling.Brigands.MarauderSpawnMidDay)
    {
        return _days;
    }
    if (_days >= this.Const.World.Scaling.Brigands.MarauderSpawnEarlyDay)
    {
        return _days;
    }
    return _days;
}
