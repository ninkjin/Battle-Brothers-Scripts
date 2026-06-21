// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/patches/patch_bones.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty)
            {
                if (this.Math.rand(1, 100) < 10)
                {
                    if (this.Math.rand(0, 1) == 0)
                    {
                    }
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail((("bust_skeleton_head_0" + "3") + "_dead"));
                }
                if (this.Math.rand(1, 100) < 30)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.Const.BloodDecals["this.Const.BloodType.Bones"]["this.Math.rand(0, (this.Const.BloodDecals["this.Const.BloodType.Bones"].len() - 1))"]);
                }
                if (this.Math.rand(1, 100) < 60)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.Const.BloodDecals["this.Const.BloodType.Bones"]["this.Math.rand(0, (this.Const.BloodDecals["this.Const.BloodType.Bones"].len() - 1))"]);
                }
                if (this.Math.rand(1, 100) < 80)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.Const.BloodDecals["this.Const.BloodType.Bones"]["this.Math.rand(0, (this.Const.BloodDecals["this.Const.BloodType.Bones"].len() - 1))"]);
                }
                this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity = false;
            }
        }
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.patch.bones";
    this.m.MinX = 4;
    this.m.MaxX = 6;
    this.m.MinY = 4;
    this.m.MaxY = 6;
    return;
}
