// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/menu/world_menu_screen.nut
// Functions: 29

function <anonymous>(this, _t)
{
    this.Tooltip.hide();
    return;
}

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
    this.m.JSHandle = this.UI.connect("WorldMenuScreen", this);
    this.m.MainMenuModule = this.new("scripts/ui/screens/menu/modules/main_menu_module");
    this.m.MainMenuModule.connectUI(this.m.JSHandle);
    this.m.LoadCampaignModule = this.new("scripts/ui/screens/menu/modules/load_campaign_menu_module");
    this.m.LoadCampaignModule.connectUI(this.m.JSHandle);
    this.m.SaveCampaignModule = this.new("scripts/ui/screens/menu/modules/save_campaign_menu_module");
    this.m.SaveCampaignModule.connectUI(this.m.JSHandle);
    this.m.OptionsMenuModule = this.new("scripts/ui/screens/menu/modules/options_menu_module");
    this.m.OptionsMenuModule.connectUI(this.m.JSHandle);
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.m.MainMenuModule.destroy();
    this.m.MainMenuModule = null;
    this.m.LoadCampaignModule.destroy();
    this.m.LoadCampaignModule = null;
    this.m.SaveCampaignModule.destroy();
    this.m.SaveCampaignModule = null;
    this.m.OptionsMenuModule.destroy();
    this.m.OptionsMenuModule = null;
    this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
    return;
}

function getLoadCampaignMenuModule(this)
{
    return this.m.LoadCampaignModule;
}

function getMainMenuModule(this)
{
    return this.m.MainMenuModule;
}

function getOptionsMenuModule(this)
{
    return this.m.OptionsMenuModule;
}

function getSaveCampaignMenuModule(this)
{
    return this.m.SaveCampaignModule;
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

function hideLoadCampaignMenu(this)
{
    if (null && null)
    {
        return (null && null);
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("hideLoadCampaignMenu", null);
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

function hideSaveCampaignMenu(this)
{
    if (null && null)
    {
        return (null && null);
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("hideSaveCampaignMenu", null);
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

function show(this, _allowSaving, _seed)
{
    if ((!null) && (!null))
    {
        return ((!null) && (!null));
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("show", {});
    }
    this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function() /* closure #0 */, null);
    return;
}

function showLoadCampaignMenu(this)
{
    if (null && null)
    {
        return (null && null);
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("showLoadCampaignMenu", this.UIDataHelper.convertCampaignStoragesToUIData());
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

function showSaveCampaignMenu(this)
{
    if (null && null)
    {
        return (null && null);
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("showSaveCampaignMenu", this.UIDataHelper.convertCampaignStoragesToUIData());
    }
    return;
}
