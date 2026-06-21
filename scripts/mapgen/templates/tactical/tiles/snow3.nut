// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tiles/snow3.nut
// Functions: 2

function init(this)
{
    this.m.Name = "tactical.tile.snow3";
    this.m.MinX = 1;
    this.m.MinY = 1;
    this.createTileTransition().setBlendIntoSockets(false);
    this.createTileTransition().setBrush(this.Const.Direction.N, "transition_snow_03_N");
    this.createTileTransition().setBrush(this.Const.Direction.NE, "transition_snow_03_NE");
    this.createTileTransition().setBrush(this.Const.Direction.SE, "transition_snow_03_SE");
    this.createTileTransition().setBrush(this.Const.Direction.S, "transition_snow_03_S");
    this.createTileTransition().setBrush(this.Const.Direction.SW, "transition_snow_03_SW");
    this.createTileTransition().setBrush(this.Const.Direction.NW, "transition_snow_03_NW");
    this.createTileTransition().setSocket("socket_snow");
    this.Tactical.setTransitions("tile_snow_03", this.createTileTransition());
    return;
}

function onFirstPass(this, _rect, _objectSpawnChanceMult)
{
    if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
    {
        return;
    }
    if (_rect.SpawnObjects)
    {
        if ((this.Math < (this.m.ChanceToSpawnObject * _objectSpawnChanceMult) && (this.Math < (this.m.ChanceToSpawnObject * _objectSpawnChanceMult))))
        {
            return ((this.Math < (this.m.ChanceToSpawnObject * _objectSpawnChanceMult)) && (this.Math < (this.m.ChanceToSpawnObject * _objectSpawnChanceMult)));
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty)
            {
                return (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty && this.Tactical.getTileSquare(_rect.X, _rect.Y).IsEmpty);
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject(this.m.Objects["this.Math.rand(0, (this.m.Objects.len() - 1))"]);
            }
        }
        else
        {
            if (this.Math.rand(1, 100) <= this.m.ChanceToSpawnDetails)
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnDetail(this.m.Details["this.Math.rand(0, (this.m.Details.len() - 1))"]);
            }
        }
        return;
    }
}
