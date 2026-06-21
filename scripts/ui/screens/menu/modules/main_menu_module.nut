// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/menu/modules/main_menu_module.nut
// Functions: 25

function clearEventListener(this)
{
    this.m.OnResumePressedListener = null;
    this.m.OnNewCampaignPressedListener = null;
    this.m.OnLoadCampaignPressedListener = null;
    this.m.OnSaveCampaignPressedListener = null;
    this.m.OnScenariosPressedListener = null;
    this.m.OnOptionsPressedListener = null;
    this.m.OnCreditsPressedListener = null;
    this.m.OnQuitPressedListener = null;
    this.m.OnFleePressedListener = null;
    this.m.OnRetirePressedListener = null;
    return;
}

function create(this)
{
    this.m.ID = "MainMenuModule";
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

function onCreditsButtonPressed(this)
{
    if (this.m.OnCreditsPressedListener != null)
    {
        this.m.OnCreditsPressedListener();
    }
    return;
}

function onFleeButtonPressed(this)
{
    if (this.m.OnFleePressedListener != null)
    {
        this.m.OnFleePressedListener();
    }
    return;
}

function onLoadCampaignButtonPressed(this)
{
    if (this.m.OnLoadCampaignPressedListener != null)
    {
        this.m.OnLoadCampaignPressedListener();
    }
    return;
}

function onNewCampaignButtonPressed(this)
{
    if (this.m.OnNewCampaignPressedListener != null)
    {
        this.m.OnNewCampaignPressedListener();
    }
    return;
}

function onOptionsButtonPressed(this)
{
    if (this.m.OnOptionsPressedListener != null)
    {
        this.m.OnOptionsPressedListener();
    }
    return;
}

function onQuitButtonPressed(this)
{
    if (this.m.OnQuitPressedListener != null)
    {
        this.m.OnQuitPressedListener();
    }
    return;
}

function onResumeButtonPressed(this)
{
    if (this.m.OnResumePressedListener != null)
    {
        this.m.OnResumePressedListener();
    }
    return;
}

function onRetireButtonPressed(this)
{
    if (this.m.OnRetirePressedListener != null)
    {
        this.m.OnRetirePressedListener();
    }
    return;
}

function onSaveCampaignButtonPressed(this)
{
    if (this.m.OnSaveCampaignPressedListener != null)
    {
        this.m.OnSaveCampaignPressedListener();
    }
    return;
}

function onScenariosButtonPressed(this)
{
    if (this.m.OnScenariosPressedListener != null)
    {
        this.m.OnScenariosPressedListener();
    }
    return;
}

function setOnCreditsPressedListener(this, _listener)
{
    this.m.OnCreditsPressedListener = _listener;
    return;
}

function setOnFleePressedListener(this, _listener)
{
    this.m.OnFleePressedListener = _listener;
    return;
}

function setOnLoadCampaignPressedListener(this, _listener)
{
    this.m.OnLoadCampaignPressedListener = _listener;
    return;
}

function setOnNewCampaignPressedListener(this, _listener)
{
    this.m.OnNewCampaignPressedListener = _listener;
    return;
}

function setOnOptionsPressedListener(this, _listener)
{
    this.m.OnOptionsPressedListener = _listener;
    return;
}

function setOnQuitPressedListener(this, _listener)
{
    this.m.OnQuitPressedListener = _listener;
    return;
}

function setOnResumePressedListener(this, _listener)
{
    this.m.OnResumePressedListener = _listener;
    return;
}

function setOnRetirePressedListener(this, _listener)
{
    this.m.OnRetirePressedListener = _listener;
    return;
}

function setOnSaveCampaignPressedListener(this, _listener)
{
    this.m.OnSaveCampaignPressedListener = _listener;
    return;
}

function setOnScenariosPressedListener(this, _listener)
{
    this.m.OnScenariosPressedListener = _listener;
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
