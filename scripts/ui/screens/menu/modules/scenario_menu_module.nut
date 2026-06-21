// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/menu/modules/scenario_menu_module.nut
// Functions: 11

function clearEventListener(this)
{
    this.m.OnPlayButtonPressedListener = null;
    this.m.OnCancelButtonPressedListener = null;
    this.m.OnQueryDataListener = null;
    return;
}

function create(this)
{
    this.m.ID = "ScenarioMenuModule";
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

function onPlayButtonPressed(this, _scenarioId)
{
    if (this.m.OnPlayButtonPressedListener != null)
    {
        this.m.OnPlayButtonPressedListener(_scenarioId);
    }
    return;
}

function onQueryData(this)
{
    if (this.m.OnQueryDataListener != null)
    {
        return this.m.OnQueryDataListener();
        return this.m.OnQueryDataListener;
    }
    return null;
}

function setOnCancelButtonPressedListener(this, _listener)
{
    this.m.OnCancelButtonPressedListener = _listener;
    return;
}

function setOnPlayButtonPressedListener(this, _listener)
{
    this.m.OnPlayButtonPressedListener = _listener;
    return;
}

function setOnQueryDataListener(this, _listener)
{
    this.m.OnQueryDataListener = _listener;
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
