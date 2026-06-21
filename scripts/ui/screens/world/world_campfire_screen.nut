// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/world/world_campfire_screen.nut
// Functions: 28

function clear(this)
{
    this.m.Town = null;
    this.m.HireDialogModule.clear();
    this.m.MainDialogModule.clear();
    return;
}

function clearEventListener(this)
{
    this.m.OnConnectedListener = null;
    this.m.OnDisconnectedListener = null;
    this.m.OnModuleClosedListener = null;
    return;
}

function create(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    this.m.JSHandle = this.UI.connect("WorldCampfireScreen", this);
    this.m.MainDialogModule = this.new("scripts/ui/screens/world/modules/world_campfire_screen/campfire_main_dialog_module");
    this.m.MainDialogModule.setParent(this);
    this.m.MainDialogModule.connectUI(this.m.JSHandle);
    this.m.HireDialogModule = this.new("scripts/ui/screens/world/modules/world_campfire_screen/campfire_hire_dialog_module");
    this.m.HireDialogModule.setParent(this);
    this.m.HireDialogModule.connectUI(this.m.JSHandle);
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.m.HireDialogModule.destroy();
    this.m.HireDialogModule = null;
    this.m.MainDialogModule.destroy();
    this.m.MainDialogModule = null;
    this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
    return;
}

function getHireDialogModule(this)
{
    return this.m.HireDialogModule;
}

function getMainDialogModule(this)
{
    return this.m.MainDialogModule;
}

function hide(this)
{
    if (this.m.JSHandle != null)
    {
        this.m.LastActiveModule = null;
        this.m.JSHandle.asyncCall("hide", null);
        this.Tooltip.hide();
    }
    return;
}

function hideAllDialogs(this)
{
    if (this.m.JSHandle != null)
    {
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("hideAllDialogs", null);
    }
    return;
}

function isAnimating(this)
{
    if ((this.m.HireDialogModule != null) && (this.m.HireDialogModule != null))
    {
        return ((this.m.HireDialogModule != null) && (this.m.HireDialogModule != null));
    }
    return false;
}

function isVisible(this)
{
    return;
}

function onModuleClosed(this)
{
    if (this.m.LastActiveModule == this.m.HireDialogModule)
    {
        this.showMainDialog();
    }
    else
    {
        if (this.m.OnModuleClosedListener != null)
        {
            this.m.OnModuleClosedListener();
        }
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
    return;
}

function onScreenShown(this)
{
    this.m.Visible = true;
    this.m.Animating = false;
    return;
}

function onSlotClicked(this, _data)
{
    if (this.isAnimating())
    {
        return;
    }
    this.m.HireDialogModule.setCurrentSlot(_data);
    this.showHireDialog();
    return;
}

function queryAssetsInformation(this)
{
    return this.UIDataHelper.convertAssetsInformationToUIData();
    return this.UIDataHelper.convertAssetsInformationToUIData;
}

function queryTownInformation(this)
{
    if (this.m.Town == null)
    {
        return;
    }
    return this.m.Town.getUIInformation();
    return this.m.Town.getUIInformation;
}

function refresh(this)
{
    if (this.m.JSHandle != null)
    {
        this.m.LastActiveModule = null;
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("refresh", this.m.MainDialogModule.queryData());
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

function setOnModuleClosedListener(this, _listener)
{
    this.m.OnModuleClosedListener = _listener;
    return;
}

function show(this)
{
    if (this.m.JSHandle != null)
    {
        this.m.LastActiveModule = null;
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("show", this.m.MainDialogModule.queryData());
    }
    return;
}

function showHireDialog(this)
{
    if (null && null)
    {
        return (null && null);
        this.m.LastActiveModule = this.m.HireDialogModule;
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("showHireDialog", this.m.HireDialogModule.queryHireInformation());
    }
    return;
}

function showLastActiveDialog(this)
{
    if (this.m.LastActiveModule == this.m.HireDialogModule)
    {
        this.showHireDialog();
    }
    this.showMainDialog();
    return;
}

function showMainDialog(this)
{
    if (null && null)
    {
        return (null && null);
        this.m.LastActiveModule = null;
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("showMainDialog", this.m.MainDialogModule.queryData());
    }
    return;
}

function updateAssets(this)
{
    this.m.JSHandle.asyncCall("loadAssetData", this.queryAssetsInformation());
    return;
}
