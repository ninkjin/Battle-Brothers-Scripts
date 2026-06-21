// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/menu/modules/credits_module.nut
// Functions: 7

function clearEventListener(this)
{
    this.m.OnDoneListener = null;
    return;
}

function create(this)
{
    this.m.ID = "CreditsModule";
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

function onDone(this)
{
    if (this.m.OnDoneListener != null)
    {
        this.m.OnDoneListener();
    }
    return;
}

function setOnDoneListener(this, _listener)
{
    this.m.OnDoneListener = _listener;
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
