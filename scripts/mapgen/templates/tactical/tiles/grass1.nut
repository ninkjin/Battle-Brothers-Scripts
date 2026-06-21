// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tiles/grass1.nut
// Functions: 4

function fillWithShrubbery(this, _rect, _properties, _pass)
{
    this.m.ChanceToSpawnHiding = (this.m.ChanceToSpawnHiding * 15);
    this.fill(_rect, _properties, _pass);
    this.m.ChanceToSpawnHiding = this.m.ChanceToSpawnHiding;
    return;
}

function fillWithTrees(this, _rect, _properties, _pass)
{
    this.m.ChanceToSpawnObject = this.Math.round((this.m.ChanceToSpawnObject * 1.7999999523162842));
    this.fill(_rect, _properties, _pass);
    this.m.ChanceToSpawnObject = this.m.ChanceToSpawnObject;
    return;
}

function init(this)
{
    this.m.Name = "tactical.tile.grass1";
    this.m.MinX = 1;
    this.m.MinY = 1;
    this.createTileTransition().setBlendIntoSockets(true);
    this.createTileTransition().setBrush(this.Const.Direction.N, "transition_grass_01_N");
    this.createTileTransition().setBrush(this.Const.Direction.NE, "transition_grass_01_NE");
    this.createTileTransition().setBrush(this.Const.Direction.SE, "transition_grass_01_SE");
    this.createTileTransition().setBrush(this.Const.Direction.S, "transition_grass_01_S");
    this.createTileTransition().setBrush(this.Const.Direction.SW, "transition_grass_01_SW");
    this.createTileTransition().setBrush(this.Const.Direction.NW, "transition_grass_01_NW");
    this.createTileTransition().setSocket("socket_earth");
    this.Tactical.setTransitions("tile_grass_01", this.createTileTransition());
    return;
}

function onFirstPass(this, _rect)
{
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
    {
        return;
    }
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = this.Const.Tactical.TerrainType.FlatGround;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Subtype = this.Const.Tactical.TerrainSubtype.Grassland;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).BlendPriority = this.Const.Tactical.TileBlendPriority.Grass1;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).setBrush("tile_grass_01");
    if ((this.Math < this.m.ChanceToSpawnObject) && (this.Math < this.m.ChanceToSpawnObject))
    {
        return ((this.Math < this.m.ChanceToSpawnObject) && (this.Math < this.m.ChanceToSpawnObject));
        if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty)
        {
            return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty);
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
        if ((this.Math < (this.m.ChanceToSpawnHiding + ((((0 + 4) + 4) + 4) * this.m.ChanceToSpawnHidingVicinityBonus)) && (this.Math < (this.m.ChanceToSpawnHiding + ((((0 + 4) + 4) + 4) * this.m.ChanceToSpawnHidingVicinityBonus)))))
        {
            return ((this.Math < (this.m.ChanceToSpawnHiding + ((((0 + 4) + 4) + 4) * this.m.ChanceToSpawnHidingVicinityBonus))) && (this.Math < (this.m.ChanceToSpawnHiding + ((((0 + 4) + 4) + 4) * this.m.ChanceToSpawnHidingVicinityBonus))));
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingBack);
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingFront);
            if ((this.Math < this.m.ChanceToSpawnHidingExtra) && (this.Math < this.m.ChanceToSpawnHidingExtra))
            {
                return ((this.Math < this.m.ChanceToSpawnHidingExtra) && (this.Math < this.m.ChanceToSpawnHidingExtra));
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingExtras["this.Math.rand(0, (this.m.HidingExtras.len() - 1))"]);
            }
            this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity = true;
        }
        else
        {
            if ((this.Math.rand(1, 100) < 50) && (this.Math.rand(1, 100) < 50) && (this.Math.rand(1, 100) < 50))
            {
                return ((this.Math.rand(1, 100) < 50) && (this.Math.rand(1, 100) < 50) && (this.Math.rand(1, 100) < 50));
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.HidingExtras["this.Math.rand(0, (this.m.HidingExtras.len() - 1))"]);
            }
            if (this.Math.rand(0, 100) < 50)
            {
            }
            if ((this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails) && (this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails))
            {
                return ((this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails) && (this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails));
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.DetailsB["this.Math.rand(0, (this.m.DetailsB.len() - 1))"]);
                if ((this.m.DetailsB == this.m.DetailsB) && (this.m.DetailsB == this.m.DetailsB))
                {
                    return ((this.m.DetailsB == this.m.DetailsB) && (this.m.DetailsB == this.m.DetailsB));
                }
            }
            if ((this.Math < this.m.ChanceToSpawnFlowerDetails) && (this.Math < this.m.ChanceToSpawnFlowerDetails))
            {
                return ((this.Math < this.m.ChanceToSpawnFlowerDetails) && (this.Math < this.m.ChanceToSpawnFlowerDetails));
                if (0 < this.m.FlowerDetails.len())
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.FlowerDetails["0"]);
                }
            }
        }
    }
    return;
}
