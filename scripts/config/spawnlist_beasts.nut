// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/config/spawnlist_beasts.nut
// Functions: 2

function calculateCosts(this, _p)
{
    foreach (local key, value in r46)
    {
        null.Cost <- 0;
        foreach (local key, value in r9)
        {
            null.Cost = null.Cost op43 (null.Type.Cost * null.Num);
            if (!("Num" in "MovementSpeedMult"))
            {
                null.MovementSpeedMult <- 1.0;
            }
            if (!("Num" in "VisibilityMult"))
            {
                null.VisibilityMult <- 1.0;
            }
            if (!("Num" in "VisionMult"))
            {
                null.VisionMult <- 1.0;
            }
            _p.sort(this.onCostCompare);
            return;
        }
    }
}

function onCostCompare(this, _t1, _t2)
{
    if (_t1.Cost < _t2.Cost)
    {
        return _t1;
    }
    else
    {
        if (_t1.Cost > _t2.Cost)
        {
            return _t1;
        }
    }
    return _t1;
}
