// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/world/modules/topbar/world_screen_topbar_daytime_module.nut
// Functions: 20

function clearEventListener(this)
{
    this.m.OnPausePressedListener = null;
    this.m.OnTimePausePressedListener = null;
    this.m.OnTimeNormalPressedListener = null;
    this.m.OnTimeFastPressedListener = null;
    this.m.OnTimeVeryFastPressedListener = null;
    return;
}

function create(this)
{
    this.m.ID = "TopbarDayTimeModule";
    this.ui_module.create();
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.ui_module.destroy();
    return;
}

function enableFastTimeButton(this, _enabled)
{
    this.m.JSHandle.asyncCall("enableFastTimeButton", _enabled);
    return;
}

function enableNormalTimeButton(this, _enabled)
{
    this.m.JSHandle.asyncCall("enableNormalTimeButton", _enabled);
    return;
}

function enableVeryFastTimeButton(this, _enabled)
{
    this.m.JSHandle.asyncCall("enableVeryFastTimeButton", _enabled);
    return;
}

function hideMessage(this)
{
    this.m.JSHandle.asyncCall("hideMessage", null);
    return;
}

function onPauseButtonPressed(this)
{
    if (this.m.OnPausePressedListener != null)
    {
        this.m.OnPausePressedListener();
    }
    return;
}

function onTimeFastButtonPressed(this)
{
    if (this.m.OnTimeFastPressedListener != null)
    {
        this.m.OnTimeFastPressedListener();
    }
    return;
}

function onTimeNormalButtonPressed(this)
{
    if (this.m.OnTimeNormalPressedListener != null)
    {
        this.m.OnTimeNormalPressedListener();
    }
    return;
}

function onTimePauseButtonPressed(this)
{
    if (this.m.OnTimePausePressedListener != null)
    {
        this.m.OnTimePausePressedListener();
    }
    return;
}

function onTimeVeryFastButtonPressed(this)
{
    if (this.m.OnTimeVeryFastPressedListener != null)
    {
        this.m.OnTimeVeryFastPressedListener();
    }
    return;
}

function setOnPausePressedListener(this, _listener)
{
    this.m.OnPausePressedListener = _listener;
    return;
}

function setOnTimeFastPressedListener(this, _listener)
{
    this.m.OnTimeFastPressedListener = _listener;
    return;
}

function setOnTimeNormalPressedListener(this, _listener)
{
    this.m.OnTimeNormalPressedListener = _listener;
    return;
}

function setOnTimePausePressedListener(this, _listener)
{
    this.m.OnTimePausePressedListener = _listener;
    return;
}

function setOnTimeVeryFastPressedListener(this, _listener)
{
    this.m.OnTimeVeryFastPressedListener = _listener;
    return;
}

function showMessage(this, _primary, _secondary)
{
    this.m.JSHandle.asyncCall("showMessage", {});
    return;
}

function update(this, _data)
{
    this.m.JSHandle.asyncCall("update", _data);
    return;
}

function updateTimeButtons(this, _state)
{
    this.m.JSHandle.asyncCall("updateButtons", _state);
    return;
}
