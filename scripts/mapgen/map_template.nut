// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/map_template.nut
// Functions: 12

function fill(this, _rect, _properties, _pass)
{
    if (_pass == 1)
    {
        this.onFirstPass(_rect);
    }
    else
    {
        if (_pass == 2)
        {
            this.onSecondPass(_rect);
        }
        else
        {
            if (_pass == 3)
            {
                this.onThirdPass(_rect);
            }
        }
    }
    return;
}

function getMaxX(this)
{
    return this.m.MaxX;
}

function getMaxY(this)
{
    return this.m.MaxY;
}

function getMinX(this)
{
    return this.m.MinX;
}

function getMinY(this)
{
    return this.m.MinY;
}

function getName(this)
{
    return this.m.Name;
}

function init(this)
{
    return;
}

function makeTacticalBordersImpassable(this, _rect)
{
    return;
}

function makeWorldBordersImpassable(this, _rect)
{
    if (_rect.X < (_rect.X + _rect.W))
    {
        this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Impassable;
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        this.World.getTileSquare(_rect.X, ((_rect.Y + _rect.H) - 1)).Type = this.Const.World.TerrainType.Impassable;
    }
    if (_rect.X < (_rect.X + _rect.W))
    {
        this.World.getTileSquare(_rect.X, ((_rect.Y + _rect.H) - 2)).Type = this.Const.World.TerrainType.Impassable;
    }
    if (_rect.Y < (_rect.Y + _rect.H))
    {
        this.World.getTileSquare(_rect.X, _rect.Y).Type = this.Const.World.TerrainType.Impassable;
    }
    if (_rect.Y < (_rect.Y + _rect.H))
    {
        this.World.getTileSquare(((_rect.X + _rect.W) - 1), _rect.Y).Type = this.Const.World.TerrainType.Impassable;
    }
    return;
}

function onFirstPass(this, _rect)
{
    return;
}

function onSecondPass(this, _rect)
{
    return;
}

function onThirdPass(this, _rect)
{
    return;
}
