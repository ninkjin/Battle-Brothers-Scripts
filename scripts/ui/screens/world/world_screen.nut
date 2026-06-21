// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/world/world_screen.nut
// Functions: 24

function clearContract(this)
{
    this.m.ActiveContractPanelModule.clearContract();
    return;
}

function clearEventListener(this)
{
    this.m.OnConnectedListener = null;
    this.m.OnDisconnectedListener = null;
    return;
}

function create(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    this.m.JSHandle = this.UI.connect("WorldScreen", this);
    this.m.TopbarDayTimeModule = this.new("scripts/ui/screens/world/modules/topbar/world_screen_topbar_daytime_module");
    this.m.TopbarDayTimeModule.connectUI(this.m.JSHandle);
    this.World.TopbarDayTimeModule <- this.WeakTableRef(this.m.TopbarDayTimeModule);
    this.m.TopbarOptionsModule = this.new("scripts/ui/screens/world/modules/topbar/world_screen_topbar_options_module");
    this.m.TopbarOptionsModule.connectUI(this.m.JSHandle);
    this.World.TopbarOptionsModule <- this.WeakTableRef(this.m.TopbarOptionsModule);
    this.m.TopbarAssetsModule = this.new("scripts/ui/screens/world/modules/topbar/world_screen_topbar_assets_module");
    this.m.TopbarAssetsModule.connectUI(this.m.JSHandle);
    this.World.TopbarAssetsModule <- this.WeakTableRef(this.m.TopbarAssetsModule);
    this.m.TopbarAmbitionModule = this.new("scripts/ui/screens/world/modules/topbar/world_screen_topbar_ambition_module");
    this.m.TopbarAmbitionModule.connectUI(this.m.JSHandle);
    this.World.TopbarAmbitionModule <- this.WeakTableRef(this.m.TopbarAmbitionModule);
    this.m.TopbarDatasourceModule = this.new("scripts/ui/screens/world/modules/topbar/world_screen_topbar_datasource_module");
    this.m.TopbarDatasourceModule.connectUI(this.m.JSHandle);
    this.m.ActiveContractPanelModule = this.new("scripts/ui/screens/world/modules/world_contract_screen/world_active_contract_panel_module");
    this.m.ActiveContractPanelModule.connectUI(this.m.JSHandle);
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.m.TopbarDayTimeModule.destroy();
    this.m.TopbarOptionsModule.destroy();
    this.m.TopbarAssetsModule.destroy();
    this.m.TopbarAmbitionModule.destroy();
    this.m.TopbarDatasourceModule.destroy();
    this.m.ActiveContractPanelModule.destroy();
    this.m.TopbarDayTimeModule = null;
    this.World.TopbarDayTimeModule = null;
    this.m.TopbarOptionsModule = null;
    this.World.TopbarOptionsModule = null;
    this.m.TopbarAssetsModule = null;
    this.World.TopbarAssetsModule = null;
    this.m.TopbarAmbitionModule = null;
    this.World.TopbarAmbitionModule = null;
    this.m.TopbarDatasourceModule = null;
    this.m.ActiveContractPanelModule = null;
    this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
    return;
}

function getActiveContractPanelModule(this)
{
    return this.m.ActiveContractPanelModule;
}

function getTopbarAmbitionModule(this)
{
    return this.m.TopbarAmbitionModule;
}

function getTopbarAssetsModule(this)
{
    return this.m.TopbarAssetsModule;
}

function getTopbarDatasourceModule(this)
{
    return this.m.TopbarDatasourceModule;
}

function getTopbarDayTimeModule(this)
{
    return this.m.TopbarDayTimeModule;
}

function getTopbarOptionsModule(this)
{
    return this.m.TopbarOptionsModule;
}

function hide(this, _immediately)
{
    if (this.m.JSHandle != null)
    {
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("hide", _immediately);
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

function show(this, _immediately)
{
    if (this.m.JSHandle != null)
    {
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("show", _immediately);
    }
    return;
}

function updateAssetsInformation(this)
{
    this.m.TopbarDatasourceModule.updateAssetsInformation();
    return;
}

function updateContract(this, _contract)
{
    this.m.ActiveContractPanelModule.updateContract(_contract);
    return;
}

function updateTimeInformation(this)
{
    this.m.TopbarDatasourceModule.updateTimeInformation();
    return;
}
