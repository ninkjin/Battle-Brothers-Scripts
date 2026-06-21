// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/templates/tactical/tactical_forest_leaves.nut
// Functions: 3

function campify(this, _rect, _properties)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        if (_rect.Y < (_rect.Y + _rect.H))
        {
            if ((this.Math.rand(1, 100) <= 20) && (this.Math.rand(1, 100) <= 20))
            {
                return ((this.Math.rand(1, 100) <= 20) && (this.Math.rand(1, 100) <= 20));
                this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
                this.Tactical.getTileSquare(_rect.X, _rect.Y).spawnObject("entity/tactical/objects/tree_stump1");
            }
            if (this.Tactical.getTileSquare(((_rect.X + (_rect.W / 2) + _properties.ShiftX), ((_rect.Y + (_rect.H / 2)) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y)) <= ((this.Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius) + 3)))
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 0;
                if (this.Math.rand(1, 100) <= (80 + ((7 - this.Tactical.getTileSquare(((_rect.X + (_rect.W / 2) + _properties.ShiftX), ((_rect.Y + (_rect.H / 2)) + _properties.ShiftY)).getDistanceTo(this.Tactical.getTileSquare(_rect.X, _rect.Y))) * 7))))
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).Type = 0;
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                    this.MapGen.get("tactical.tile.moss2").fill({}, null);
                }
                if (this.Tactical.getTileSquare(_rect.X, _rect.Y).IsHidingEntity)
                {
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).clear();
                }
                if ((this.Math <= 66) && (this.Math <= 66))
                {
                    return ((this.Math <= 66) && (this.Math <= 66));
                    this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
                }
            }
            if ((this.Math.rand(1, 100) <= 66) && (this.Math.rand(1, 100) <= 66) && (this.Math.rand(1, 100) <= 66) && (this.Math.rand(1, 100) <= 66) && (this.Math.rand(1, 100) <= 66))
            {
                return ((this.Math.rand(1, 100) <= 66) && (this.Math.rand(1, 100) <= 66) && (this.Math.rand(1, 100) <= 66) && (this.Math.rand(1, 100) <= 66) && (this.Math.rand(1, 100) <= 66));
                this.Tactical.getTileSquare(_rect.X, _rect.Y).removeObject();
            }
        }
    }
    return;
}

function fill(this, _rect, _properties, _pass)
{
    this.addRoads(_rect, _properties);
    [].push(this.MapGen.get("tactical.patch.forest_leaves"));
    [].push(this.MapGen.get("tactical.patch.forest_leaves"));
    [].push(this.MapGen.get("tactical.patch.forest_leaves"));
    [].push(this.MapGen.get("tactical.patch.forest_leaves"));
    [].push(this.MapGen.get("tactical.patch.forest_leaves"));
    if ((0 < 5000) && (0 < 5000))
    {
        return ((0 < 5000) && (0 < 5000));
        {}.X = this.Math.rand(1, (_rect.W - this.Math.rand(2, 5)));
        {}.Y = this.Math.rand(1, (_rect.H - this.Math.rand(2, 5)));
        if (({}.X - 1) != (({}.X + this.Math.rand(2, 5) + 1)))
        {
            if (({}.Y - 1) != (({}.Y + this.Math.rand(2, 5) + 1)))
            {
                if (!this.Tactical.isValidTileSquare(({}.X - 1), ({}.Y - 1)))
                {
                }
                else
                {
                    if (this.Tactical.getTileSquare(({}.X - 1), ({}.Y - 1)).IsSpecialTerrain)
                    {
                    }
                }
            }
            if (true)
            {
            }
        }
        if (true)
        {
        }
        this.MapGen.get("tactical.patch.forest_leaves_thick").fill({}, _properties);
    }
    if (20 != 0)
    {
        {}.X = this.Math.rand(1, (_rect.W - this.Math.rand(this.Math.max([]["this.Math.rand(0, ([].len() - 1))"].getMinX(), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxX(), 6)), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxX(), 12))));
        {}.Y = this.Math.rand(1, (_rect.H - this.Math.rand(this.Math.max([]["this.Math.rand(0, ([].len() - 1))"].getMinY(), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxY(), 6)), this.Math.min([]["this.Math.rand(0, ([].len() - 1))"].getMaxY(), 12))));
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
            if (this.Math.rand(1, 100) > (100 - ((((0 + 15) + 15) + 15) * 25)))
            {
                this.Tactical.getTileSquare(_rect.X, _rect.Y).Level = 1;
            }
            this.MapGen.get("tactical.tile.moss2").fill({}, _properties);
        }
    }
    this.makeBordersImpassable(_rect);
    return;
}

function init(this)
{
    this.m.Name = "tactical.forest_leaves";
    this.m.MinX = 32;
    this.m.MinY = 32;
    return;
}
