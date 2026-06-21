// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tiles/moss1.nut
// Functions: 5

function fillWithFern(this, _rect, _properties, _pass)
{
    this.m.ChanceToSpawnHiding = (this.m.ChanceToSpawnHiding * 5);
    this.fill(_rect, _properties, _pass);
    this.m.ChanceToSpawnHiding = this.m.ChanceToSpawnHiding;
    return;
}

function fillWithMushrooms(this, _rect, _properties, _pass)
{
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
    {
        return;
    }
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = this.Const.Tactical.TerrainType.Forest;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Subtype = this.Const.Tactical.TerrainSubtype.Forest;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).BlendPriority = this.Const.Tactical.TileBlendPriority.Forest;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).setBrush(("tile_moss_0" + this.Math.rand(1, 2)));
    if (this.Math.rand(1, 100) < 20)
    {
        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsB["this.Math.rand(0, (this.m.DetailsB.len() - 1))"]);
    }
    if (this.Math.rand(1, 100) < 40)
    {
        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsB["this.Math.rand(0, (this.m.DetailsB.len() - 1))"]);
    }
    if (this.Math.rand(1, 100) < 60)
    {
        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsB["this.Math.rand(0, (this.m.DetailsB.len() - 1))"]);
    }
    if (this.Math.rand(1, 100) < 80)
    {
        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsB["this.Math.rand(0, (this.m.DetailsB.len() - 1))"]);
    }
    if (this.Math.rand(1, 100) < this.m.ChanceToSpawnLightshaft)
    {
        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Lightshaft);
    }
    return;
}

function init(this)
{
    this.m.Name = "tactical.tile.moss1";
    this.m.MinX = 1;
    this.m.MinY = 1;
    this.createTileTransition().setBlendIntoSockets(false);
    this.createTileTransition().setBrush(this.Const.Direction.N, "transition_moss_01_N");
    this.createTileTransition().setBrush(this.Const.Direction.NE, "transition_moss_01_NE");
    this.createTileTransition().setBrush(this.Const.Direction.SE, "transition_moss_01_SE");
    this.createTileTransition().setBrush(this.Const.Direction.S, "transition_moss_01_S");
    this.createTileTransition().setBrush(this.Const.Direction.SW, "transition_moss_01_SW");
    this.createTileTransition().setBrush(this.Const.Direction.NW, "transition_moss_01_NW");
    this.createTileTransition().setSocket("socket_earth");
    this.Tactical.setTransitions("tile_moss_01", this.createTileTransition());
    return;
}

function onFirstPass(this, _rect, _objectSpawnChanceMult)
{
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
    {
        return;
    }
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = this.Const.Tactical.TerrainType.Forest;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Subtype = this.Const.Tactical.TerrainSubtype.Forest;
    if (this.Math.rand(1, 2) == 1)
    {
    }
    this.Tactical.getTileSquare(_rect.X, _rect.Y).BlendPriority = this.Const.Tactical.TileBlendPriority.Moss2;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).setBrush(("tile_moss_0" + this.Math.rand(1, 2)));
    if ((this.Math < (this.m.ChanceToSpawnObject * _objectSpawnChanceMult) && (this.Math < (this.m.ChanceToSpawnObject * _objectSpawnChanceMult))))
    {
        return ((this.Math < (this.m.ChanceToSpawnObject * _objectSpawnChanceMult)) && (this.Math < (this.m.ChanceToSpawnObject * _objectSpawnChanceMult)));
        if (0 != 6)
        {
            if (!this.Tactical.getTileSquare(_rect.X, _rect.Y).hasNextTile(0))
            {
            }
            else
            {
                if (!this.Tactical.getTileSquare(_rect.X, _rect.Y).getNextTile(0).IsEmpty)
                {
                }
            }
        }
        if (false)
        {
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject(this.m.Objects["this.Math.rand(0, (this.m.Objects.len() - 1))"]);
        }
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
        if (this.Math.rand(1, 100) < (this.m.ChanceToSpawnHiding + ((((0 + 6) + 6) + 6) * this.m.ChanceToSpawnHidingVicinityBonus)))
        {
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
            if (this.Math.rand(1, 100) < 45)
            {
            }
            if (this.Math.rand(1, 100) < this.m.ChanceToSpawnShadow)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Shadows["this.Math.rand(0, (this.m.Shadows.len() - 1))"]);
            }
            if ((this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails) && (this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails))
            {
                return ((this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails) && (this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails));
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsB["this.Math.rand(0, (this.m.DetailsB.len() - 1))"]);
            }
            if ((this.Math < this.m.ChanceToSpawnBugs) && (this.Math < this.m.ChanceToSpawnBugs))
            {
                return ((this.Math < this.m.ChanceToSpawnBugs) && (this.Math < this.m.ChanceToSpawnBugs));
                if (0 < this.m.Bugs.len())
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Bugs["0"]);
                }
            }
            if (this.Tactical.IsSpecialTerrain && this.Tactical.IsSpecialTerrain)
            {
                return (this.Tactical.IsSpecialTerrain && this.Tactical.IsSpecialTerrain);
            }
            if (this.Tactical.IsSpecialTerrain && this.Tactical.IsSpecialTerrain)
            {
                return (this.Tactical.IsSpecialTerrain && this.Tactical.IsSpecialTerrain);
            }
            if (this.Tactical.IsSpecialTerrain && this.Tactical.IsSpecialTerrain)
            {
                return (this.Tactical.IsSpecialTerrain && this.Tactical.IsSpecialTerrain);
            }
            if (this.Math.rand(1, 100) < ((((0 + 9) + 9) + 9) * this.m.ChanceToSpawnLightshaft))
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Lightshaft);
                if (this.Math.rand(1, 100) <= 50)
                {
                    if (0 < this.m.FlowerDetails.len())
                    {
                        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.FlowerDetails["0"]);
                    }
                }
            }
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
        if ((((((((0 + 3) + 3) + 3) + 3) + 3) + 3) * this.m.ChanceToSpawnHidingVicinityBonus) >= 100)
        {
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingBack);
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingFront);
            this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity = true;
        }
        else
        {
            if (0 < 2)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingExtras["this.Math.rand(0, (this.m.HidingExtras.len() - 1))"]);
            }
        }
    }
    return;
}
