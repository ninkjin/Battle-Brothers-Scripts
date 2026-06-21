// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/patches/patch_ritual_site.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (this.MapGen.get("tactical.tile.forest1") == this.MapGen.get("tactical.tile.earth1"))
    {
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
            {
            }
            else
            {
                if ((_rect.Y == ((_rect.Y + _rect.H) - 1) || (_rect.Y == ((_rect.Y + _rect.H) - 1)) || (_rect.Y == ((_rect.Y + _rect.H) - 1))))
                {
                    return ((_rect.Y == ((_rect.Y + _rect.H) - 1)) || (_rect.Y == ((_rect.Y + _rect.H) - 1)) || (_rect.Y == ((_rect.Y + _rect.H) - 1)));
                    if (this.Math.rand(0, 100) < 25)
                    {
                    }
                    else
                    {
                        if (this.Math.rand(0, 100) < (this.Math.rand(5, 10) + 20))
                        {
                        }
                        this.MapGen.get("tactical.tile.forest1").fill({}, _properties);
                        if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty)
                        {
                            if ((this.Math < 33) && (this.Math < 33))
                            {
                                return ((this.Math < 33) && (this.Math < 33));
                                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/boulder_bloody");
                            }
                            if (this.Math.rand(1, 100) < 60)
                            {
                                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(("corpse_part_0" + this.Math.rand(1, 5)));
                            }
                            if (this.Math.rand(1, 100) < 60)
                            {
                                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.Const.BloodDecals["this.Const.BloodType.Red"]["this.Math.rand(0, (this.Const.BloodDecals["this.Const.BloodType.Red"].len() - 1))"]);
                            }
                        }
                    }
                    return;
                }
            }
        }
    }
}

function init(this)
{
    this.m.Name = "tactical.patch.ritual_site";
    this.m.MinX = 3;
    this.m.MaxX = 3;
    this.m.MinY = 3;
    this.m.MaxY = 3;
    return;
}
