// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/world/modules/world_town_screen/town_main_dialog_module.nut
// Functions: 6

function clear(this)
{
    return;
}

function create(this)
{
    this.m.ID = "MainDialogModule";
    this.ui_module.create();
    return;
}

function destroy(this)
{
    this.ui_module.destroy();
    return;
}

function onLeaveButtonPressed(this)
{
    this.m.Parent.onModuleClosed();
    return;
}

function preload(this, _settlement)
{
    if ((!0) && (!0))
    {
        return ((!0) && (!0));
    }
    this.m.JSHandle.asyncCall("loadFromData", _settlement.getUIPreloadInformation());
    return;
}

function reload(this)
{
    this.m.JSHandle.asyncCall("loadFromData", this.m.Parent.queryTownInformation());
    return;
}
