// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/tactical/tactical_dialog_screen.nut
// Functions: 18

function clearEventListener(this)
{
    this.m.OnConnectedListener = null;
    this.m.OnDisconnectedListener = null;
    this.m.OnScreenHiddenListener = null;
    this.m.OnScreenShownListener = null;
    this.m.OnYesPressedListener = null;
    this.m.OnNoPressedListener = null;
    return;
}

function create(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    this.m.JSHandle = this.UI.connect("TacticalDialogScreen", this);
    return;
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

function onNoPressed(this)
{
    if (this.m.OnNoPressedListener != null)
    {
        this.m.OnNoPressedListener();
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

function onYesPressed(this)
{
    if (this.m.OnYesPressedListener != null)
    {
        this.m.OnYesPressedListener();
    }
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

function show(this, _title, _subTitle, _text, _yesButton, _noButton, _yesCallback, _noCallback)
{
    this.m.OnYesPressedListener = _yesCallback;
    this.m.OnNoPressedListener = _noCallback;
    if ((!null) && (!null))
    {
        return ((!null) && (!null));
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("show", {});
    }
    return;
}
