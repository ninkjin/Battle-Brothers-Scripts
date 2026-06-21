// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/tactical/modules/topbar/tactical_screen_topbar_options.nut
// Functions: 23

function clearEventListener(this)
{
    this.m.OnToggleHighlightBlockedTilesListener = null;
    this.m.OnSwitchMapLevelUpListener = null;
    this.m.OnSwitchMapLevelDownListener = null;
    this.m.OnToggleStatsOverlaysListener = null;
    this.m.OnFleePressedListener = null;
    this.m.OnQuitPressedListener = null;
    this.m.OnCenterPressedListener = null;
    this.m.OnToggleTreesPressedListener = null;
    return;
}

function create(this)
{
    this.m.ID = "TopbarOptionsModule";
    this.ui_module.create();
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.ui_module.destroy();
    return;
}

function onCenterButtonPressed(this)
{
    if (this.m.OnCenterPressedListener != null)
    {
        this.m.OnCenterPressedListener();
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

function onQuitButtonPressed(this)
{
    if (this.m.OnQuitPressedListener != null)
    {
        this.m.OnQuitPressedListener();
    }
    return;
}

function onSwitchMapLevelDownButtonPressed(this)
{
    if (this.m.OnSwitchMapLevelDownListener != null)
    {
        this.m.OnSwitchMapLevelDownListener();
    }
    return;
}

function onSwitchMapLevelUpButtonPressed(this)
{
    if (this.m.OnSwitchMapLevelUpListener != null)
    {
        this.m.OnSwitchMapLevelUpListener();
    }
    return;
}

function onToggleHighlightBlockedTilesListenerButtonPressed(this)
{
    if (this.m.OnToggleHighlightBlockedTilesListener != null)
    {
        this.m.OnToggleHighlightBlockedTilesListener();
    }
    return;
}

function onToggleStatsOverlaysButtonPressed(this)
{
    if (this.m.OnToggleStatsOverlaysListener != null)
    {
        this.m.OnToggleStatsOverlaysListener();
    }
    return;
}

function onToggleTreesButtonPressed(this)
{
    if (this.m.OnToggleTreesPressedListener != null)
    {
        this.m.OnToggleTreesPressedListener();
    }
    return;
}

function setFleeButtonEnabled(this, _enabled)
{
    this.m.JSHandle.asyncCall("setFleeButtonEnabled", _enabled);
    return;
}

function setOnCenterPressedListener(this, _listener)
{
    this.m.OnCenterPressedListener = _listener;
    return;
}

function setOnFleePressedListener(this, _listener)
{
    this.m.OnFleePressedListener = _listener;
    return;
}

function setOnQuitPressedListener(this, _listener)
{
    this.m.OnQuitPressedListener = _listener;
    return;
}

function setOnSwitchMapLevelDownListener(this, _listener)
{
    this.m.OnSwitchMapLevelDownListener = _listener;
    return;
}

function setOnSwitchMapLevelUpListener(this, _listener)
{
    this.m.OnSwitchMapLevelUpListener = _listener;
    return;
}

function setOnToggleHighlightBlockedTilesListener(this, _listener)
{
    this.m.OnToggleHighlightBlockedTilesListener = _listener;
    return;
}

function setOnToggleStatsOverlaysListener(this, _listener)
{
    this.m.OnToggleStatsOverlaysListener = _listener;
    return;
}

function setOnToggleTreesListener(this, _listener)
{
    this.m.OnToggleTreesPressedListener = _listener;
    return;
}

function setToggleHighlightBlockedTilesListenerButtonState(this, _enable)
{
    this.m.JSHandle.asyncCall("setHighlightBlockedTilesButtonState", _enable);
    return;
}

function setToggleStatsOverlaysButtonState(this, _enable)
{
    this.m.JSHandle.asyncCall("setToggleStatsOverlaysButtonState", _enable);
    return;
}

function setToggleTreesButtonState(this, _enable)
{
    this.m.JSHandle.asyncCall("setToggleTreesButtonState", _enable);
    return;
}
