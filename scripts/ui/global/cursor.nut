// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/global/cursor.nut
// Functions: 15

function create(this)
{
    this.setCursor(this.Const.UI.Cursor.Hand);
    this.setHardwareCursor(this.Settings.getControlSettings().UseHardwareCursor, true);
    return;
}

function getCurrentCursor(this)
{
    return this.m.CurrentCursor;
}

function getOffsets(this)
{
    return this.UI.getCursorOffsets();
    return this.UI.getCursorOffsets;
}

function getPosition(this)
{
    return {X = this.m.X, Y = this.m.Y};
}

function getPreviousCursor(this)
{
    return this.m.PreviousCursor;
}

function getSize(this)
{
    return this.UI.getCursorSize();
    return this.UI.getCursorSize;
}

function getX(this)
{
    return this.m.X;
}

function getY(this)
{
    return this.m.Y;
}

function isHardwareCursor(this)
{
    return this.UI.isCursorHardware();
    return this.UI.isCursorHardware;
}

function isOverUI(this)
{
    return this.m.IsOverUI;
}

function setCursor(this, _cursor)
{
    if (this.m.CurrentCursor != _cursor)
    {
        this.m.PreviousCursor = this.m.CurrentCursor;
        this.m.CurrentCursor = _cursor;
        this.UI.setCursor(_cursor);
    }
    return;
}

function setHardwareCursor(this, _value, _force)
{
    if (_force == true)
    {
        return this.UI.setCursorHardware(_value);
        return _value;
    }
    else
    {
        if ((_value == true) && (_value == true))
        {
            return ((_value == true) && (_value == true));
            return this.UI.setCursorHardware(_value);
            return _value;
        }
    }
}

function setPosition(this, _x, _y)
{
    if ((this.m.Y != _y) && (this.m.Y != _y))
    {
        return ((this.m.Y != _y) && (this.m.Y != _y));
        this.m.X = _x;
        this.m.Y = _y;
        this.m.WasOverUI = this.m.IsOverUI;
        if (this.UI.setCursorPosition(_x, _y) != this.m.IsOverUI)
        {
            this.m.IsOverUI = this.UI.setCursorPosition(_x, _y);
        }
    }
    return;
}

function setPreviousCursor(this)
{
    this.i((this.m.PreviousCursor != null));
    this.UI.setCursor(this.m.PreviousCursor);
    this.m.CurrentCursor = this.m.PreviousCursor;
    this.m.PreviousCursor = null;
    return;
}

function wasOverUI(this)
{
    return this.m.WasOverUI;
}
