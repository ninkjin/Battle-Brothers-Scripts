// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/patches/patch_oasis.nut
// Functions: 2

function fill(this, _rect, _properties, _pass)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
            {
            }
            else
            {
                if ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1)) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2)))
                {
                    return ((this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2) || (this.Math.abs((_rect.Y - ((_rect.Y + _rect.H) - 1))) <= 2));
                    if (this.Math.rand(0, 100) < 33)
                    {
                    }
                }
                if ((this.Tactical.Subtype == this.Const.Tactical.TerrainSubtype.PlashyGrass) && (this.Tactical.Subtype == this.Const.Tactical.TerrainSubtype.PlashyGrass))
                {
                    return ((this.Tactical.Subtype == this.Const.Tactical.TerrainSubtype.PlashyGrass) && (this.Tactical.Subtype == this.Const.Tactical.TerrainSubtype.PlashyGrass));
                }
                if ((this.Tactical.Subtype == this.Const.Tactical.TerrainSubtype.PlashyGrass) && (this.Tactical.Subtype == this.Const.Tactical.TerrainSubtype.PlashyGrass))
                {
                    return ((this.Tactical.Subtype == this.Const.Tactical.TerrainSubtype.PlashyGrass) && (this.Tactical.Subtype == this.Const.Tactical.TerrainSubtype.PlashyGrass));
                }
                if ((this.Tactical.Subtype == this.Const.Tactical.TerrainSubtype.PlashyGrass) && (this.Tactical.Subtype == this.Const.Tactical.TerrainSubtype.PlashyGrass))
                {
                    return ((this.Tactical.Subtype == this.Const.Tactical.TerrainSubtype.PlashyGrass) && (this.Tactical.Subtype == this.Const.Tactical.TerrainSubtype.PlashyGrass));
                }
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
                if (this.Math.rand(0, 100) >= (50 - ((((0 + 10) + 10) + 10) * 10)))
                {
                    this.MapGen.get("tactical.tile.desert4").fill({}, _properties);
                }
                this.MapGen.get("tactical.tile.desert7_oasis").fill({}, _properties);
            }
        }
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Level != 0)
            {
            }
            else
            {
                if (0 < 6)
                {
                    if (!this.Tactical.getTileSquare(_rect.X, _rect.Y).hasNextTile(0))
                    {
                    }
                    else
                    {
                        if ((this.Const.Tactical.TerrainSubtype.PlashyGrass.Subtype == this.Const.Tactical.TerrainSubtype.ShallowWater) && (this.Const.Tactical.TerrainSubtype.PlashyGrass.Subtype == this.Const.Tactical.TerrainSubtype.ShallowWater))
                        {
                            return ((this.Const.Tactical.TerrainSubtype.PlashyGrass.Subtype == this.Const.Tactical.TerrainSubtype.ShallowWater) && (this.Const.Tactical.TerrainSubtype.PlashyGrass.Subtype == this.Const.Tactical.TerrainSubtype.ShallowWater));
                        }
                    }
                }
                if ((0 + 10) >= 5)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = 0;
                    if (this.Math.rand(0, 100) < 33)
                    {
                    }
                }
                else
                {
                    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
                    {
                        if (this.Tactical.getTileSquare(_rect.X, _rect.Y).BlendPriority == this.Const.Tactical.TileBlendPriority.Desert7)
                        {
                            this.MapGen.get("tactical.tile.desert7_oasis").fill({}, _properties, 2);
                        }
                    }
                }
            }
        }
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.patch.oasis";
    this.m.MinX = 10;
    this.m.MinY = 10;
    return;
}
