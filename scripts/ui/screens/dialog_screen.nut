// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/dialog_screen.nut
// Functions: 16

function clearEventListener(this)
{
    this.m.OnConnectedListener = null;
    this.m.OnDisconnectedListener = null;
    this.m.OnScreenHiddenListener = null;
    this.m.OnScreenShownListener = null;
    this.m.OnFleePressedListener = null;
    this.m.OnCancelPressedListener = null;
    return;
}

function create(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    this.m.JSHandle = this.UI.connect("DialogScreen", this);
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

function onCancelPressed(this)
{
    this.hide();
    if (this.m.OnCancelPressedListener != null)
    {
        this.m.OnCancelPressedListener();
        this.m.OnCancelPressedListener = null;
    }
    return;
}

function onOkPressed(this)
{
    this.hide();
    if (this.m.OnOkPressedListener != null)
    {
        this.m.OnOkPressedListener();
        this.m.OnOkPressedListener = null;
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
    this.Tooltip.hide();
    if (this.m.OnScreenShownListener != null)
    {
        this.m.OnScreenShownListener();
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

function show(this, _title, _text, _doneCallback, _okCallback, _cancelCallback, _isMonologue)
{
    if ((!null) && (!null))
    {
        return ((!null) && (!null));
        this.m.OnScreenHiddenListener = _doneCallback;
        if (_okCallback != null)
        {
            this.m.OnOkPressedListener = _okCallback;
        }
        if (_cancelCallback != null)
        {
            this.m.OnCancelPressedListener = _cancelCallback;
        }
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("show", {});
    }
    return;
}
