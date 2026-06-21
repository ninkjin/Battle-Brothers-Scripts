// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/world/world_event_screen.nut
// Functions: 20

function <anonymous>(this, _tag)
{
    _tag.EventScreen.m.JustShown = false;
    return;
}

function <anonymous>(this, _t)
{
    this.Tooltip.hide();
    return;
}

function clearEventListener(this)
{
    this.m.OnConnectedListener = null;
    this.m.OnDisconnectedListener = null;
    return;
}

function convertEventToUIData(this, _event)
{
    if (_event == null)
    {
        return _event;
    }
    if (_event.getUIMiddleOverlay() != null)
    {
    }
    if (_event.getUIList().len() != 0)
    {
        foreach (local key, value in r22)
        {
            {}.content.push({});
            return _event;
        }
    }
}

function create(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    this.m.JSHandle = this.UI.connect("WorldEventScreen", this);
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

function isJustShown(this)
{
    return this.m.JustShown;
}

function isVisible(this)
{
    return;
}

function onButtonPressed(this, _buttonID)
{
    if (this.m.IsContract)
    {
        this.World.Contracts.processInput(_buttonID);
    }
    this.World.Events.processInput(_buttonID);
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
    this.Tooltip.hide();
    this.m.Visible = true;
    this.m.Animating = false;
    this.m.JustShown = true;
    this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function() /* closure #0 */, {});
    return;
}

function setIsContract(this, _c)
{
    this.m.IsContract = _c;
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

function show(this, _event, _withSlideAnimation)
{
    if (this.m.JSHandle != null)
    {
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("show", this.convertEventToUIData(_event));
        this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function() /* closure #0 */, null);
    }
    return;
}
