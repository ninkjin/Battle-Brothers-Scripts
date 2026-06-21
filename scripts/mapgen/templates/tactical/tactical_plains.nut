// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tactical_plains.nut
// Functions: 3

function campify(this, _rect, _properties)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(((_rect.X + (_rect.W / 2) + _properties.ShiftX), ((_rect.Y + (_rect.H / 2)) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) <= this.Const.Tactical.Settings.CampRadius))
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
                if (this.Math.rand(1, 100) <= (50 + ((7 - this.Tactical.getTileSquare(((_rect.X + (_rect.W / 2) + _properties.ShiftX), ((_rect.Y + (_rect.H / 2)) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y))) * 7))))
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = 0;
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                    if (this.Math.rand(1, 2) == 1)
                    {
                        this.MapGen.get("tactical.tile.earth1").fill({}, null);
                    }
                    this.MapGen.get("tactical.tile.grass2").fill({}, null);
                }
                if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                }
                if ((this.Math <= 50) && (this.Math <= 50))
                {
                    return ((this.Math <= 50) && (this.Math <= 50));
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
                }
            }
            if ((this.Math.rand(1, 100) <= 4) && (this.Math.rand(1, 100) <= 4) && (this.Math.rand(1, 100) <= 4))
            {
                return ((this.Math.rand(1, 100) <= 4) && (this.Math.rand(1, 100) <= 4) && (this.Math.rand(1, 100) <= 4));
                if (0 < 6)
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
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/tree_stump1");
                }
            }
        }
    }
    return;
}

function fill(this, _rect, _properties, _pass)
{
    this.addRoads(_rect, _properties);
    [].push(this.MapGen.get("tactical.patch.clearing_leveled"));
    [].push(this.MapGen.get("tactical.patch.clearing_leveled"));
    [].push(this.MapGen.get("tactical.patch.clearing_leveled"));
    [].push(this.MapGen.get("tactical.patch.clearing_leveled"));
    [].push(this.MapGen.get("tactical.patch.clearing_leveled"));
    [].push(this.MapGen.get("tactical.patch.clearing"));
    if (this.Math.rand(1, 100) <= 25)
    {
        [].push(this.MapGen.get("tactical.patch.mound"));
    }
    if (this.Math.rand(1, 100) <= 50)
    {
        [].push(this.MapGen.get("tactical.patch.flower_sea"));
    }
    if (this.Math.rand(1, 100) <= 50)
    {
        [].push(this.MapGen.get("tactical.patch.clover_sea"));
    }
    if (6 != 0)
    {
        {}.X = this.Math.rand(1, (_rect.W - this.Math.rand(this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMinX(), 8), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxX(), 20))));
        {}.Y = this.Math.rand(1, (_rect.H - this.Math.rand(this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMinY(), 8), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxY(), 20))));
        []["this.Math.rand(0, ([].len() - 1))"].fill({}, _properties);
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if (this.Tactical.getTileSquare(_rect.X, _rect.Y).Type != 0)
            {
            }
            if ((this.Tactical.Level == 1) && (this.Tactical.Level == 1))
            {
                return ((this.Tactical.Level == 1) && (this.Tactical.Level == 1));
            }
            if ((this.Tactical.Level == 1) && (this.Tactical.Level == 1))
            {
                return ((this.Tactical.Level == 1) && (this.Tactical.Level == 1));
            }
            if ((this.Tactical.Level == 1) && (this.Tactical.Level == 1))
            {
                return ((this.Tactical.Level == 1) && (this.Tactical.Level == 1));
            }
            this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
            if (this.Math.rand(1, 100) > (this.Math.rand(90, 100) - ((((0 + 15) + 15) + 15) * 25)))
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
            }
            if (this.Math.rand(1, 100) < 50)
            {
                this.MapGen.get("tactical.tile.grass1").fillWithShrubbery({}, _properties);
            }
            if (this.Math.rand(1, 100) < 90)
            {
                this.MapGen.get("tactical.tile.grass2").fill({}, _properties);
            }
            this.MapGen.get("tactical.tile.earth1").fill({}, _properties);
        }
    }
    this.makeBordersImpassable(_rect);
    return;
}

function init(this)
{
    this.m.Name = "tactical.plains";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
