// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/menu/modules/load_campaign_menu_module.nut
// Functions: 12

function clearEventListener(this)
{
    this.m.OnLoadButtonPressedListener = null;
    this.m.OnCancelButtonPressedListener = null;
    this.m.OnDeleteButtonPressedListener = null;
    return;
}

function create(this)
{
    this.m.ID = "LoadCampaignModule";
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
    if (!this.isAnimating())
    {
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

function onDeleteButtonPressed(this, _campaignFileName)
{
    this.PersistenceManager.deleteStorage(_campaignFileName);
    this.m.JSHandle.asyncCall("addCampaignsToList", this.onQueryCampaigns());
    if (this.m.OnDeleteButtonPressedListener != null)
    {
        this.m.OnDeleteButtonPressedListener();
    }
    return;
}

function onLoadButtonPressed(this, _campaignFileName)
{
    if (this.m.OnLoadButtonPressedListener != null)
    {
        this.m.OnLoadButtonPressedListener(_campaignFileName);
    }
    return;
}

function onQueryCampaigns(this)
{
    return this.UIDataHelper.convertCampaignStoragesToUIData();
    return this.UIDataHelper.convertCampaignStoragesToUIData;
}

function setOnCancelButtonPressedListener(this, _listener)
{
    this.m.OnCancelButtonPressedListener = _listener;
    return;
}

function setOnDeleteButtonPressedListener(this, _listener)
{
    this.m.OnDeleteButtonPressedListener = _listener;
    return;
}

function setOnLoadButtonPressedListener(this, _listener)
{
    this.m.OnLoadButtonPressedListener = _listener;
    return;
}

function show(this)
{
    if (!this.isAnimating())
    {
        this.m.JSHandle.asyncCall("show", null);
    }
    return;
}
