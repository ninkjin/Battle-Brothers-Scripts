// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/loading/loading_screen.nut
// Functions: 14

function clearEventListener(this)
{
    this.m.OnScreenShownListener = null;
    this.m.OnScreenHiddenListener = null;
    this.m.OnQueryDataListener = null;
    return;
}

function create(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    this.m.JSHandle = this.UI.connect("LoadingScreen", this);
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
    if ((!this) && (!this))
    {
        return ((!this) && (!this));
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

function onQueryData(this)
{
    if (this.m.OnQueryDataListener != null)
    {
        return this.m.OnQueryDataListener();
        return this.m.OnQueryDataListener;
    }
    return null;
}

function onScreenAnimating(this)
{
    this.m.Animating = true;
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

function setOnQueryDataListener(this, _listener)
{
    this.m.OnQueryDataListener = _listener;
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
    if ((!this) && (!this))
    {
        return ((!this) && (!this));
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("show", this.onQueryData());
    }
    return;
}
