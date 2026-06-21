// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/world/world_event_popup_screen.nut
// Functions: 20

function clearEventListener(this)
{
    this.m.OnConnectedListener = null;
    this.m.OnDisconnectedListener = null;
    this.m.OnScreenHiddenListener = null;
    this.m.OnScreenShownListener = null;
    this.m.OnLeavePressedListener = null;
    return;
}

function create(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    this.m.JSHandle = this.UI.connect("WorldEventPopupScreen", this);
    return;
}

function createContent(this)
{
    return {Title = "SubTitle", Text = "SubTitle", ButtonLabel = "SubTitle", Ok = "Image", Size = "SubTitle", "k[7]" = 0};
}

function destroy(this)
{
    this.clearEventListener();
    this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
    return;
}

function hide(this)
{
    if (null && null)
    {
        return (null && null);
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("hide", null);
    }
    return;
}

function isAnimating(this)
{
    return;
}

function isVisible(this)
{
    return;
}

function onLeavePressed(this)
{
    if (this.m.OnLeavePressedListener != null)
    {
        this.m.OnLeavePressedListener();
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
    if (this.m.OnScreenHiddenListener != null)
    {
        this.m.OnScreenHiddenListener();
    }
    return;
}

function onScreenShown(this)
{
    this.m.Visible = true;
    this.m.Animating = false;
    if (this.m.OnScreenShownListener != null)
    {
        this.m.OnScreenShownListener();
    }
    return;
}

function setContent(this, _content)
{
    this.m.JSHandle.asyncCall("loadFromData", _content);
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

function setOnLeavePressedListener(this, _listener)
{
    this.m.OnLeavePressedListener = _listener;
    return;
}

function setOnScreenHiddenListener(this, _listener)
{
    this.m.OnScreenHiddenListener = _listener;
    return;
}

function setOnScreenShownListener(this, _listener)
{
    this.m.OnScreenShownListener = _listener;
    return;
}

function show(this)
{
    if ((!null) && (!null))
    {
        return ((!null) && (!null));
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("show", null);
    }
    return;
}
