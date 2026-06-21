// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/world/modules/topbar/world_screen_topbar_datasource_module.nut
// Functions: 5

function clearEventListener(this)
{
    return;
}

function create(this)
{
    this.m.ID = "TopbarDatasourceModule";
    this.ui_module.create();
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.ui_module.destroy();
    return;
}

function updateAssetsInformation(this)
{
    this.m.JSHandle.asyncCall("loadAssetsInformation", this.UIDataHelper.convertAssetsInformationToUIData());
    return;
}

function updateTimeInformation(this)
{
    if (this.Math.abs((this.World.getTime().Minutes - this.m.LastTimeInformationUpdate) < 2))
    {
        return;
    }
    this.m.LastTimeInformationUpdate = this.World.getTime().Minutes;
    if ((((this.World.getTime().SecondsOfDay / this.World.getTime().SecondsPerDay) * 360.0) + 200.0) > 360.0)
    {
    }
    this.m.JSHandle.asyncCall("loadTimeInformation", {});
    return;
}
