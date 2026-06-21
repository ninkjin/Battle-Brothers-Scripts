// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/world/world_relations_screen.nut
// Functions: 18

function clearEventListener(this)
{
    this.m.OnConnectedListener = null;
    this.m.OnDisconnectedListener = null;
    this.m.OnClosePressedListener = null;
    return;
}

function convertFactionsToUIData(this)
{
    clone this.sort(this.onSortFactions);
    foreach (local key, value in r97)
    {
        if ((null.getSettlements().len() == 0) || (null.getSettlements().len() == 0) || (null.getSettlements().len() == 0))
        {
            return ((null.getSettlements().len() == 0) || (null.getSettlements().len() == 0) || (null.getSettlements().len() == 0));
        }
        foreach (local key, value in r15)
        {
            {}.Characters.push({});
            {}.Factions.push({});
            return {};
        }
    }
}

function create(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    this.m.JSHandle = this.UI.connect("WorldRelationsScreen", this);
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
    return;
}

function hide(this, _withSlideAnimation)
{
    if (this.m.JSHandle != null)
    {
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("hide", _withSlideAnimation);
    }
    return;
}

function isAnimating(this)
{
    if (this.m.Animating != null)
    {
        return (this.m.Animating == true);
    }
    return false;
}

function isVisible(this)
{
    return;
}

function onClose(this)
{
    if (this.m.OnClosePressedListener != null)
    {
        this.m.OnClosePressedListener();
    }
    return;
}

function onScreenAnimating(this)
{
    this.m.Animating = true;
    return;
}

function onScreenConnected(this)
{
    if (this.m.OnConnectedListener != null)
    {
        this.m.OnConnectedListener();
    }
    return;
}

function onScreenDisconnected(this)
{
    if (this.m.OnDisconnectedListener != null)
    {
        this.m.OnDisconnectedListener();
    }
    return;
}

function onScreenHidden(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    return;
}

function onScreenShown(this)
{
    this.m.Visible = true;
    this.m.Animating = false;
    return;
}

function onSortFactions(this, _f1, _f2)
{
    if ((_f2 == null) && (_f2 == null))
    {
        return ((_f2 == null) && (_f2 == null));
        return _f1;
    }
    if (_f1 == null)
    {
        return _f1;
    }
    else
    {
        if (_f2 == null)
        {
            return _f1;
        }
    }
    if (_f1.getType() < _f2.getType())
    {
        return _f1;
    }
    if (_f1.getType() > _f2.getType())
    {
        return _f1;
    }
    if (_f1.getName() < _f2.getName())
    {
        return _f1;
    }
    else
    {
        if (_f1.getName() > _f2.getName())
        {
            return _f1;
        }
    }
    return _f1;
}

function setOnClosePressedListener(this, _listener)
{
    this.m.OnClosePressedListener = _listener;
    return;
}

function setOnConnectedListener(this, _listener)
{
    this.m.OnConnectedListener = _listener;
    return;
}

function setOnDisconnectedListener(this, _listener)
{
    this.m.OnDisconnectedListener = _listener;
    return;
}

function show(this, _withSlideAnimation)
{
    if (this.m.JSHandle != null)
    {
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("show", this.convertFactionsToUIData());
    }
    return;
}
