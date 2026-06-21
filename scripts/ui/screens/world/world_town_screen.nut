// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/world/world_town_screen.nut
// Functions: 48

function clear(this)
{
    this.m.Town = null;
    this.m.ShopDialogModule.clear();
    this.m.HireDialogModule.clear();
    this.m.TravelDialogModule.clear();
    this.m.BarberDialogModule.clear();
    this.m.TavernDialogModule.clear();
    this.m.TempleDialogModule.clear();
    this.m.TrainingDialogModule.clear();
    this.m.TaxidermistDialogModule.clear();
    this.m.MainDialogModule.clear();
    return;
}

function clearEventListener(this)
{
    this.m.OnConnectedListener = null;
    this.m.OnDisconnectedListener = null;
    this.m.OnBrothersButtonPressedListener = null;
    this.m.OnModuleClosedListener = null;
    return;
}

function create(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    this.m.JSHandle = this.UI.connect("WorldTownScreen", this);
    this.m.MainDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_main_dialog_module");
    this.m.MainDialogModule.setParent(this);
    this.m.MainDialogModule.connectUI(this.m.JSHandle);
    this.m.HireDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_hire_dialog_module");
    this.m.HireDialogModule.setParent(this);
    this.m.HireDialogModule.connectUI(this.m.JSHandle);
    this.m.ShopDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_shop_dialog_module");
    this.m.ShopDialogModule.setParent(this);
    this.m.ShopDialogModule.connectUI(this.m.JSHandle);
    this.m.TravelDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_travel_dialog_module");
    this.m.TravelDialogModule.setParent(this);
    this.m.TravelDialogModule.connectUI(this.m.JSHandle);
    this.m.BarberDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_barber_dialog_module");
    this.m.BarberDialogModule.setParent(this);
    this.m.BarberDialogModule.connectUI(this.m.JSHandle);
    this.m.TavernDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_tavern_dialog_module");
    this.m.TavernDialogModule.setParent(this);
    this.m.TavernDialogModule.connectUI(this.m.JSHandle);
    this.m.TempleDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_temple_dialog_module");
    this.m.TempleDialogModule.setParent(this);
    this.m.TempleDialogModule.connectUI(this.m.JSHandle);
    this.m.TrainingDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_training_dialog_module");
    this.m.TrainingDialogModule.setParent(this);
    this.m.TrainingDialogModule.connectUI(this.m.JSHandle);
    this.m.TaxidermistDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_taxidermist_dialog_module");
    this.m.TaxidermistDialogModule.setParent(this);
    this.m.TaxidermistDialogModule.connectUI(this.m.JSHandle);
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.m.ShopDialogModule.destroy();
    this.m.ShopDialogModule = null;
    this.m.HireDialogModule.destroy();
    this.m.HireDialogModule = null;
    this.m.TravelDialogModule.destroy();
    this.m.TravelDialogModule = null;
    this.m.BarberDialogModule.destroy();
    this.m.BarberDialogModule = null;
    this.m.TavernDialogModule.destroy();
    this.m.TavernDialogModule = null;
    this.m.TempleDialogModule.destroy();
    this.m.TempleDialogModule = null;
    this.m.TrainingDialogModule.destroy();
    this.m.TrainingDialogModule = null;
    this.m.TaxidermistDialogModule.destroy();
    this.m.TaxidermistDialogModule = null;
    this.m.MainDialogModule.destroy();
    this.m.MainDialogModule = null;
    this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
    return;
}

function getBarberDialogModule(this)
{
    return this.m.BarberDialogModule;
}

function getHireDialogModule(this)
{
    return this.m.HireDialogModule;
}

function getMainDialogModule(this)
{
    return this.m.MainDialogModule;
}

function getShopDialogModule(this)
{
    return this.m.ShopDialogModule;
}

function getTavernDialogModule(this)
{
    return this.m.TavernDialogModule;
}

function getTaxidermistDialogModule(this)
{
    return this.m.TaxidermistDialogModule;
}

function getTempleDialogModule(this)
{
    return this.m.TempleDialogModule;
}

function getTown(this)
{
    return this.m.Town;
}

function getTrainingDialogModule(this)
{
    return this.m.TrainingDialogModule;
}

function getTravelDialogModule(this)
{
    return this.m.TravelDialogModule;
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
    if ((this.m.ShopDialogModule != null) && (this.m.ShopDialogModule != null) && (this.m.ShopDialogModule != null))
    {
        return ((this.m.ShopDialogModule != null) && (this.m.ShopDialogModule != null) && (this.m.ShopDialogModule != null));
    }
    return false;
}

function isVisible(this)
{
    return;
}

function onBrothersButtonPressed(this)
{
    if (this.m.OnBrothersButtonPressedListener != null)
    {
        this.m.OnBrothersButtonPressedListener();
    }
    return;
}

function onContractClicked(this, _data)
{
    if (this.isAnimating())
    {
        return;
    }
    this.World.Contracts.showContractByID(_data);
    return;
}

function onModuleClosed(this)
{
    if (this.m.OnModuleClosedListener != null)
    {
        this.m.OnModuleClosedListener();
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
    if (this.m.Town != null)
    {
        this.m.Town.onSlotClicked(_data, this);
    }
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
        this.m.JSHandle.asyncCall("refresh", this.queryTownInformation());
    }
    return;
}

function setOnBrothersPressedListener(this, _listener)
{
    this.m.OnBrothersButtonPressedListener = _listener;
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

function setTown(this, _t)
{
    this.m.Town = _t;
    return;
}

function show(this)
{
    if (this.m.JSHandle != null)
    {
        this.m.LastActiveModule = null;
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("show", this.queryTownInformation());
    }
    return;
}

function showBarberDialog(this)
{
    if (null && null)
    {
        return (null && null);
        this.m.LastActiveModule = this.m.BarberDialogModule;
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("showBarberDialog", this.m.BarberDialogModule.queryRosterInformation());
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
    else
    {
        if (this.m.LastActiveModule == this.m.ShopDialogModule)
        {
            this.showShopDialog();
        }
        else
        {
            if (this.m.LastActiveModule == this.m.TravelDialogModule)
            {
                this.showTravelDialog();
            }
            else
            {
                if (this.m.LastActiveModule == this.m.BarberDialogModule)
                {
                    this.showBarberDialog();
                }
                else
                {
                    if (this.m.LastActiveModule == this.m.TavernDialogModule)
                    {
                        this.showTavernDialog();
                    }
                    else
                    {
                        if (this.m.LastActiveModule == this.m.TempleDialogModule)
                        {
                            this.showTempleDialog();
                        }
                        else
                        {
                            if (this.m.LastActiveModule == this.m.TrainingDialogModule)
                            {
                                this.showTrainingDialog();
                            }
                            else
                            {
                                if (this.m.LastActiveModule == this.m.TaxidermistDialogModule)
                                {
                                    this.showTaxidermistDialog();
                                }
                                this.showMainDialog();
                            }
                        }
                    }
                }
            }
        }
    }
    return;
}

function showMainDialog(this)
{
    if (null && null)
    {
        return (null && null);
        this.m.LastActiveModule = null;
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("showMainDialog", this.queryAssetsInformation());
        if (this.World.Assets.isIronman())
        {
            this.World.presave();
        }
    }
    return;
}

function showShopDialog(this)
{
    if (null && null)
    {
        return (null && null);
        this.m.LastActiveModule = this.m.ShopDialogModule;
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("showShopDialog", this.m.ShopDialogModule.queryShopInformation());
    }
    return;
}

function showTavernDialog(this)
{
    if (null && null)
    {
        return (null && null);
        this.m.LastActiveModule = this.m.TavernDialogModule;
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("showTavernDialog", this.m.TavernDialogModule.queryData());
    }
    return;
}

function showTaxidermistDialog(this)
{
    if (null && null)
    {
        return (null && null);
        this.m.LastActiveModule = this.m.TaxidermistDialogModule;
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("showTaxidermistDialog", this.m.TaxidermistDialogModule.queryBlueprints());
    }
    return;
}

function showTempleDialog(this)
{
    if (null && null)
    {
        return (null && null);
        this.m.LastActiveModule = this.m.TempleDialogModule;
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("showTempleDialog", this.m.TempleDialogModule.queryRosterInformation());
    }
    return;
}

function showTrainingDialog(this)
{
    if (null && null)
    {
        return (null && null);
        this.m.LastActiveModule = this.m.TrainingDialogModule;
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("showTrainingDialog", this.m.TrainingDialogModule.queryRosterInformation());
    }
    return;
}

function showTravelDialog(this)
{
    if (null && null)
    {
        return (null && null);
        this.m.LastActiveModule = this.m.TravelDialogModule;
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("showTravelDialog", this.m.TravelDialogModule.queryTravelInformation());
    }
    return;
}

function updateAssets(this)
{
    this.m.JSHandle.asyncCall("loadAssetData", this.queryAssetsInformation());
    return;
}

function updateContracts(this)
{
    if (this.m.Town == null)
    {
        return;
    }
    this.m.JSHandle.asyncCall("updateContracts", this.m.Town.getUIContractInformation());
    return;
}
