// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/patches/patch_stone_circle.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (this.Tactical.getTileSquare((_rect.X + 2), _rect.Y).Level != 0)
    {
        return;
    }
    if (this.Tactical.getTileSquare((_rect.X + 1), (_rect.Y + 1).Level != 0))
    {
        return;
    }
    if (this.Tactical.getTileSquare((_rect.X + 3), (_rect.Y + 1).Level != 0))
    {
        return;
    }
    if (this.Tactical.getTileSquare(_rect.X, (_rect.Y + 2).Level != 0))
    {
        return;
    }
    if (this.Tactical.getTileSquare((_rect.X + 4), (_rect.Y + 2).Level != 0))
    {
        return;
    }
    if (this.Tactical.getTileSquare((_rect.X + 1), (_rect.Y + 3).Level != 0))
    {
        return;
    }
    if (this.Tactical.getTileSquare((_rect.X + 3), (_rect.Y + 3).Level != 0))
    {
        return;
    }
    if (this.Tactical.getTileSquare((_rect.X + 2), (_rect.Y + 4).Level != 0))
    {
        return;
    }
    null.IsHidingEntity = false;
    this.Tactical.getTileSquare((_rect.X + 2), _rect.Y).clear();
    this.Tactical.getTileSquare((_rect.X + 2), _rect.Y).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 2), _rect.Y).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 2), _rect.Y).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 1), (_rect.Y + 1)).clear();
    this.Tactical.getTileSquare((_rect.X + 1), (_rect.Y + 1)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 1), (_rect.Y + 1)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 1), (_rect.Y + 1)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 3), (_rect.Y + 1)).clear();
    this.Tactical.getTileSquare((_rect.X + 3), (_rect.Y + 1)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 3), (_rect.Y + 1)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 3), (_rect.Y + 1)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare(_rect.X, (_rect.Y + 2)).clear();
    this.Tactical.getTileSquare(_rect.X, (_rect.Y + 2)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare(_rect.X, (_rect.Y + 2)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare(_rect.X, (_rect.Y + 2)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 4), (_rect.Y + 2)).clear();
    this.Tactical.getTileSquare((_rect.X + 4), (_rect.Y + 2)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 4), (_rect.Y + 2)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 4), (_rect.Y + 2)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 1), (_rect.Y + 3)).clear();
    this.Tactical.getTileSquare((_rect.X + 1), (_rect.Y + 3)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 1), (_rect.Y + 3)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 1), (_rect.Y + 3)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 3), (_rect.Y + 3)).clear();
    this.Tactical.getTileSquare((_rect.X + 3), (_rect.Y + 3)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 3), (_rect.Y + 3)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 3), (_rect.Y + 3)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 2), (_rect.Y + 4)).clear();
    this.Tactical.getTileSquare((_rect.X + 2), (_rect.Y + 4)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 2), (_rect.Y + 4)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    this.Tactical.getTileSquare((_rect.X + 2), (_rect.Y + 4)).spawnDetail([]["this.Math.rand(0, ([].len() - 1))"]);
    return;
}

function init(this)
{
    this.m.Name = "tactical.patch.stone_circle";
    this.m.MinX = 5;
    this.m.MaxX = 5;
    this.m.MinY = 5;
    this.m.MaxY = 5;
    return;
}
