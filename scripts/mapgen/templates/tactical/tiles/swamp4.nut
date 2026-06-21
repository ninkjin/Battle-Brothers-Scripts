// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tiles/swamp4.nut
// Functions: 3

function init(this)
{
    this.m.Name = "tactical.tile.swamp4";
    this.m.MinX = 1;
    this.m.MinY = 1;
    return;
}

function onFirstPass(this, _rect)
{
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
    {
        return;
    }
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = this.Const.Tactical.TerrainType.Swamp;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Subtype = this.Const.Tactical.TerrainSubtype.MurkyWater;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).BlendPriority = this.Const.Tactical.TileBlendPriority.Swamp4;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).IsBadTerrain = true;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).setBrush("tile_swamp_04");
    if (this.Math.rand(0, 100) < this.m.ChanceToSpawnObject)
    {
        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject(this.m.Objects["this.Math.rand(0, (this.m.Objects.len() - 1))"]);
    }
    else
    {
        if (this.Tactical.IsHidingEntity && this.Tactical.IsHidingEntity)
        {
            return (this.Tactical.IsHidingEntity && this.Tactical.IsHidingEntity);
        }
        if (this.Tactical.IsHidingEntity && this.Tactical.IsHidingEntity)
        {
            return (this.Tactical.IsHidingEntity && this.Tactical.IsHidingEntity);
        }
        if (this.Tactical.IsHidingEntity && this.Tactical.IsHidingEntity)
        {
            return (this.Tactical.IsHidingEntity && this.Tactical.IsHidingEntity);
        }
        if ((this.Math < (this.m.ChanceToSpawnHiding + ((((0 + 4) + 4) + 4) * this.m.ChanceToSpawnHidingVicinityBonus)) && (this.Math < (this.m.ChanceToSpawnHiding + ((((0 + 4) + 4) + 4) * this.m.ChanceToSpawnHidingVicinityBonus)))))
        {
            return ((this.Math < (this.m.ChanceToSpawnHiding + ((((0 + 4) + 4) + 4) * this.m.ChanceToSpawnHidingVicinityBonus))) && (this.Math < (this.m.ChanceToSpawnHiding + ((((0 + 4) + 4) + 4) * this.m.ChanceToSpawnHidingVicinityBonus))));
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingBack);
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingFront);
            if (this.Math.rand(1, 100) < this.m.ChanceToSpawnHidingExtra)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingExtras["this.Math.rand(0, (this.m.HidingExtras.len() - 1))"]);
            }
            this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity = true;
        }
        else
        {
            if (this.Math.rand(1, 100) <= 10)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsAlt["this.Math.rand(0, (this.m.DetailsAlt.len() - 1))"]);
            }
            else
            {
                if (((this.m.ChanceToSpawnDetails + (0 * 10) < this.m.LimitOfSpawnedDetails) && ((this.m.ChanceToSpawnDetails + (0 * 10)) < this.m.LimitOfSpawnedDetails)))
                {
                    return (((this.m.ChanceToSpawnDetails + (0 * 10)) < this.m.LimitOfSpawnedDetails) && ((this.m.ChanceToSpawnDetails + (0 * 10)) < this.m.LimitOfSpawnedDetails));
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Details["this.Math.rand(0, (this.m.Details.len() - 1))"]);
                }
            }
        }
        if (this.Math.rand(0, 100) < this.m.ChanceToSpawnFog)
        {
            if (this.Math.rand(0, 100) < this.m.ChanceToSpawnFogFiller)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.FogFiller).Color = this.m.FogColor;
            }
            if (this.Math.rand(0, 100) < this.m.ChanceToSpawnFogAnimation)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.FogRotator["this.Math.rand(0, (this.m.FogRotator.len() - 1))"]).Color = this.m.FogColor;
            }
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.FogCover["this.Math.rand(0, (this.m.FogCover.len() - 1))"]).Color = this.m.FogColor;
        }
    }
    return;
}

function onSecondPass(this, _rect)
{
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
    {
        return;
    }
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
    {
        return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity);
    }
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
    {
        return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity);
    }
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
    {
        return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity);
    }
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
    {
        return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity);
    }
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
    {
        return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity);
    }
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
    {
        return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity);
    }
    if (((((((0 + 3) + 3) + 3) + 3) + 3) + 3) != 0)
    {
        this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
        if (((((((((0 + 3) + 3) + 3) + 3) + 3) + 3) * this.m.ChanceToSpawnHidingVicinityBonus) >= 100) && ((((((((0 + 3) + 3) + 3) + 3) + 3) + 3) * this.m.ChanceToSpawnHidingVicinityBonus) >= 100))
        {
            return (((((((((0 + 3) + 3) + 3) + 3) + 3) + 3) * this.m.ChanceToSpawnHidingVicinityBonus) >= 100) && ((((((((0 + 3) + 3) + 3) + 3) + 3) + 3) * this.m.ChanceToSpawnHidingVicinityBonus) >= 100));
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingBack);
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingFront);
            this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity = true;
        }
        else
        {
            if (0 < this.Math.rand(2, this.Math.min(this.Math.max(2, ((((((0 + 3) + 3) + 3) + 3) + 3) + 3), 4))))
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingExtras["this.Math.rand(0, (this.m.HidingExtras.len() - 1))"]);
            }
        }
    }
    return;
}
