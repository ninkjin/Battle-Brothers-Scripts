// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tiles/earth1.nut
// Functions: 2

function init(this)
{
    this.m.Name = "tactical.tile.earth1";
    this.m.MinX = 1;
    this.m.MinY = 1;
    this.createTileTransition().setBlendIntoSockets(true);
    this.createTileTransition().setBrush(this.Const.Direction.S, "transition_earth_01_S");
    this.createTileTransition().setBrush(this.Const.Direction.SW, "transition_earth_01_SW");
    this.createTileTransition().setBrush(this.Const.Direction.SE, "transition_earth_01_SE");
    this.createTileTransition().setSocket("socket_earth");
    this.Tactical.setTransitions("tile_earth_01", this.createTileTransition());
    return;
}

function onFirstPass(this, _rect)
{
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
    {
        return;
    }
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = this.Const.Tactical.TerrainType.FlatGround;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).Subtype = this.Const.Tactical.TerrainSubtype.Dirt;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).BlendPriority = this.Const.Tactical.TileBlendPriority.Earth;
    this.Tactical.getTileSquare(_rect.X, _rect.Y).setBrush("tile_earth_01");
    if ((this.m.Objects != 0) && (this.m.Objects != 0))
    {
        return ((this.m.Objects != 0) && (this.m.Objects != 0));
        this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject(this.m.Objects["this.Math.rand(0, (this.m.Objects.len() - 1))"]);
    }
    else
    {
        if ((this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails) && (this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails))
        {
            return ((this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails) && (this.m.ChanceToSpawnDetails < this.m.LimitOfSpawnedDetails));
            if (this.Math.rand(0, 100) < this.m.ChanceToSpawnAltDetails)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.AltDetails["this.Math.rand(0, (this.m.AltDetails.len() - 1))"]);
            }
            this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Details["this.Math.rand(0, (this.m.Details.len() - 1))"]);
        }
        if ((this.Math < this.m.ChanceToSpawnBugs) && (this.Math < this.m.ChanceToSpawnBugs))
        {
            return ((this.Math < this.m.ChanceToSpawnBugs) && (this.Math < this.m.ChanceToSpawnBugs));
            if (0 < this.m.Bugs.len())
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Bugs["0"]);
            }
        }
    }
    return;
}
