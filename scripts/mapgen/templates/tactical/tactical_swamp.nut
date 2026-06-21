// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tactical_swamp.nut
// Functions: 3

function campify(this, _rect, _properties)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(((_rect.X + (_rect.W / 2) + _properties.ShiftX), ((_rect.Y + (_rect.H / 2)) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) <= ((this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius) + 1)))
            {
                if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                }
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = 0;
                if (this.Math.rand(1, 3) == 1)
                {
                    this.MapGen.get("tactical.tile.swamp1").fill({}, null);
                }
                else
                {
                    if (this.Math.rand(1, 3) == 2)
                    {
                        this.MapGen.get("tactical.tile.swamp2").fill({}, null);
                    }
                    else
                    {
                        if (this.Math.rand(1, 3) == 3)
                        {
                            this.MapGen.get("tactical.tile.swamp3").fill({}, null);
                        }
                    }
                }
            }
        }
    }
    return;
}

function fill(this, _rect, _properties, _pass)
{
    this.addRoads(_rect, _properties);
    [].push(this.MapGen.get("tactical.patch.swamp"));
    [].push(this.MapGen.get("tactical.patch.swamp"));
    [].push(this.MapGen.get("tactical.patch.swamp"));
    [].push(this.MapGen.get("tactical.patch.swamp"));
    [].push(this.MapGen.get("tactical.patch.swamp"));
    [].push(this.MapGen.get("tactical.patch.swamp"));
    [].push(this.MapGen.get("tactical.patch.swamp"));
    [].push(this.MapGen.get("tactical.patch.swamp"));
    [].push(this.MapGen.get("tactical.patch.swamp_pond"));
    if ((0 < 3000) && (0 < 3000))
    {
        return ((0 < 3000) && (0 < 3000));
        {}.X = this.Math.rand(1, (_rect.W - this.Math.rand(4, 8)));
        {}.Y = this.Math.rand(1, (_rect.H - this.Math.rand(4, 8)));
        this.MapGen.get("tactical.patch.swamp_pond").fill({}, _properties);
    }
    if (12 != 0)
    {
        {}.X = this.Math.rand(1, (_rect.W - this.Math.rand(this.Math.max([]["this.Math.rand(0, ([].len() - 1))"].getMinX(), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxX(), 8)), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxX(), 20))));
        {}.Y = this.Math.rand(1, (_rect.H - this.Math.rand(this.Math.max([]["this.Math.rand(0, ([].len() - 1))"].getMinY(), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxY(), 8)), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxY(), 20))));
        []["this.Math.rand(0, ([].len() - 1))"].fill({}, _properties);
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
            {
                if (this.Tactical.getTileSquare(_rect.X, _rect.Y).BlendPriority == this.Const.Tactical.TileBlendPriority.Swamp4)
                {
                    this.MapGen.get("tactical.tile.swamp4").fill({}, _properties, 2);
                }
                this.MapGen.get("tactical.tile.swamp3").fill({}, _properties, 2);
            }
            this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
            if (this.Math.rand(1, 100) < 50)
            {
                this.MapGen.get("tactical.tile.swamp3").fill({}, _properties);
            }
            if (this.Math.rand(1, 100) < 70)
            {
                this.MapGen.get("tactical.tile.swamp2").fill({}, _properties);
            }
            if (this.Math.rand(1, 100) < 90)
            {
                this.MapGen.get("tactical.tile.swamp1").fill({}, _properties);
            }
            this.MapGen.get("tactical.tile.swamp5").fill({}, _properties);
        }
    }
    this.makeBordersImpassable(_rect);
    return;
}

function init(this)
{
    this.m.Name = "tactical.swamp";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
