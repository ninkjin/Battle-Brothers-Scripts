// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/world/modules/topbar/world_screen_topbar_options_module.nut
// Functions: 21

function clearEventListener(this)
{
    this.m.OnBrothersPressedListener = null;
    this.m.OnActiveContractPressedListener = null;
    this.m.OnRelationsPressedListener = null;
    this.m.OnPerksPressedListener = null;
    this.m.OnObituaryPressedListener = null;
    this.m.OnQuitPressedListener = null;
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

function enableCampButton(this, _enabled)
{
    this.m.JSHandle.asyncCall("enableCampButton", _enabled);
    return;
}

function enablePerksButton(this, _enabled)
{
    this.m.JSHandle.asyncCall("enablePerksButton", _enabled);
    return;
}

function onActiveContractButtonPressed(this)
{
    if (this.m.OnActiveContractPressedListener != null)
    {
        this.m.OnActiveContractPressedListener();
    }
    return;
}

function onBrothersButtonPressed(this)
{
    if (this.m.OnBrothersPressedListener != null)
    {
        this.m.OnBrothersPressedListener();
    }
    return;
}

function onCameraLockButtonPressed(this)
{
    this.Settings.getTempGameplaySettings().CameraLocked = (!this.Settings.getTempGameplaySettings().CameraLocked);
    this.m.JSHandle.asyncCall("updateCameraLockButton", this.Settings.getTempGameplaySettings().CameraLocked);
    return;
}

function onCampButtonPressed(this)
{
    this.World.State.onCamp();
    return;
}

function onCenterButtonPressed(this)
{
    this.World.getCamera().Zoom = 1.0;
    this.World.getCamera().setPos(this.World.State.getPlayer().getPos());
    return;
}

function onObituaryButtonPressed(this)
{
    if (this.m.OnObituaryPressedListener != null)
    {
        this.m.OnObituaryPressedListener();
    }
    return;
}

function onPerksButtonPressed(this)
{
    if (this.m.OnPerksPressedListener != null)
    {
        this.m.OnPerksPressedListener();
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

function onRelationsButtonPressed(this)
{
    if (this.m.OnRelationsPressedListener != null)
    {
        this.m.OnRelationsPressedListener();
    }
    return;
}

function onTrackingButtonPressed(this)
{
    this.Settings.getTempGameplaySettings().ShowTracking = (!this.Settings.getTempGameplaySettings().ShowTracking);
    this.m.JSHandle.asyncCall("updateTrackingButton", this.Settings.getTempGameplaySettings().ShowTracking);
    return;
}

function setOnActiveContractPressedListener(this, _listener)
{
    this.m.OnActiveContractPressedListener = _listener;
    return;
}

function setOnBrothersPressedListener(this, _listener)
{
    this.m.OnBrothersPressedListener = _listener;
    return;
}

function setOnObituaryPressedListener(this, _listener)
{
    this.m.OnObituaryPressedListener = _listener;
    return;
}

function setOnPerksPressedListener(this, _listener)
{
    this.m.OnPerksPressedListener = _listener;
    return;
}

function setOnQuitPressedListener(this, _listener)
{
    this.m.OnQuitPressedListener = _listener;
    return;
}

function setOnRelationsPressedListener(this, _listener)
{
    this.m.OnRelationsPressedListener = _listener;
    return;
}
