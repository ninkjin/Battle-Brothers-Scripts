// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/world/modules/topbar/world_screen_topbar_assets_module.nut
// Functions: 6

function clearEventListener(this)
{
    this.m.OnBrothersPressedListener = null;
    return;
}

function create(this)
{
    this.m.ID = "TopbarAssetsModule";
    this.ui_module.create();
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.ui_module.destroy();
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

function setOnBrothersPressedListener(this, _listener)
{
    this.m.OnBrothersPressedListener = _listener;
    return;
}

function update(this, _data)
{
    this.m.JSHandle.asyncCall("update", _data);
    return;
}
