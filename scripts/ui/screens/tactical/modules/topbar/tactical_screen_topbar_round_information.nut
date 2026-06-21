// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/tactical/modules/topbar/tactical_screen_topbar_round_information.nut
// Functions: 6

function clearEventListener(this)
{
    this.m.OnQueryRoundInformationListener = null;
    return;
}

function create(this)
{
    this.m.ID = "TopbarRoundInformationModule";
    this.ui_module.create();
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.ui_module.destroy();
    return;
}

function onQueryRoundInformation(this)
{
    if (this.m.OnQueryRoundInformationListener != null)
    {
        return this.m.OnQueryRoundInformationListener();
        return this.m.OnQueryRoundInformationListener;
    }
    return null;
}

function setOnQueryRoundInformationListener(this, _listener)
{
    this.m.OnQueryRoundInformationListener = _listener;
    return;
}

function update(this)
{
    this.m.JSHandle.asyncCall("update", this.onQueryRoundInformation());
    return;
}
