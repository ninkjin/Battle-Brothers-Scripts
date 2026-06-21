// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/menu/tactical_menu_screen.nut
// Functions: 22

function clearEventListener(this)
{
    this.m.OnConnectedListener = null;
    this.m.OnDisconnectedListener = null;
    this.m.OnScreenShownListener = null;
    this.m.OnScreenHiddenListener = null;
    return;
}

function create(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    this.m.JSHandle = this.UI.connect("TacticalMenuScreen", this);
    this.m.MainMenuModule = this.new("scripts/ui/screens/menu/modules/main_menu_module");
    this.m.MainMenuModule.connectUI(this.m.JSHandle);
    this.m.OptionsMenuModule = this.new("scripts/ui/screens/menu/modules/options_menu_module");
    this.m.OptionsMenuModule.connectUI(this.m.JSHandle);
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.m.MainMenuModule.destroy();
    this.m.MainMenuModule = null;
    this.m.OptionsMenuModule.destroy();
    this.m.OptionsMenuModule = null;
    this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
    return;
}

function getMainMenuModule(this)
{
    return this.m.MainMenuModule;
}

function getOptionsMenuModule(this)
{
    return this.m.OptionsMenuModule;
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

function hideOptionsMenu(this)
{
    if (null && null)
    {
        return (null && null);
        this.m.JSHandle.asyncCall("hideOptionsMenu", null);
    }
    return;
}

function isAnimating(this)
{
    if ((this.m.OptionsMenuModule != null) && (this.m.OptionsMenuModule != null))
    {
        return ((this.m.OptionsMenuModule != null) && (this.m.OptionsMenuModule != null));
    }
    return false;
}

function isMainMenuVisible(this)
{
    return this.m.MainMenuModule.isVisible();
    return this.m.MainMenuModule.isVisible;
}

function isOptionsMenuVisible(this)
{
    return this.m.OptionsMenuModule.isVisible();
    return this.m.OptionsMenuModule.isVisible;
}

function isVisible(this)
{
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

function show(this, _isRetreatAllowed, _isQuitAllowed, _quitText)
{
    if ((!null) && (!null))
    {
        return ((!null) && (!null));
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("show", {});
    }
    return;
}

function showOptionsMenu(this)
{
    if (null && null)
    {
        return (null && null);
        this.m.JSHandle.asyncCall("showOptionsMenu", this.m.OptionsMenuModule.onQueryData());
    }
    return;
}
