// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/menu/modules/new_campaign_menu_module.nut
// Functions: 13

function clearEventListener(this)
{
    this.m.OnStartButtonPressedListener = null;
    this.m.OnCancelButtonPressedListener = null;
    return;
}

function create(this)
{
    this.m.ID = "NewCampaignModule";
    this.ui_module.create();
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.ui_module.destroy();
    return;
}

function hide(this)
{
    if ((!this) && (!this))
    {
        return ((!this) && (!this));
        this.m.JSHandle.asyncCall("hide", null);
    }
    return;
}

function onCancelButtonPressed(this)
{
    if (this.m.OnCancelButtonPressedListener != null)
    {
        this.m.OnCancelButtonPressedListener();
    }
    return;
}

function onStartButtonPressed(this, _settings)
{
    if (this.m.OnStartButtonPressedListener != null)
    {
        this.m.OnStartButtonPressedListener(this.parseSettingsFromJS(_settings));
    }
    return;
}

function parseSettingsFromJS(this, _settings)
{
    return _settings;
}

function setBanners(this, _banners)
{
    this.m.JSHandle.asyncCall("setBanners", _banners);
    return;
}

function setCrusadeCampaignAvailable(this, _available)
{
    this.m.JSHandle.asyncCall("setCrusadeCampaignVisible", _available);
    return;
}

function setOnCancelButtonPressedListener(this, _listener)
{
    this.m.OnCancelButtonPressedListener = _listener;
    return;
}

function setOnStartButtonPressedListener(this, _listener)
{
    this.m.OnStartButtonPressedListener = _listener;
    return;
}

function setStartingScenarios(this, _scenarios)
{
    this.m.JSHandle.asyncCall("setStartingScenarios", _scenarios);
    return;
}

function show(this)
{
    if ((!this) && (!this))
    {
        return ((!this) && (!this));
        this.m.JSHandle.asyncCall("show", null);
    }
    return;
}
