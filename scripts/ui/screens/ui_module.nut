// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/ui_module.nut
// Functions: 11

function clear(this)
{
    return;
}

function connectUI(this, _host)
{
    this.m.JSHandle = _host.connectToModule(this.m.ID, this);
    if (null && null)
    {
        return (null && null);
        this.m.Parent.onModuleConnected(this);
    }
    return;
}

function create(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    return;
}

function destroy(this)
{
    if (this.m.JSHandle != null)
    {
        this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
    }
    return;
}

function isAnimating(this)
{
    return;
}

function isConnected(this)
{
    return (this.m.JSHandle != null);
}

function isVisible(this)
{
    return;
}

function onModuleAnimating(this)
{
    this.m.Animating = true;
    return;
}

function onModuleHidden(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    return;
}

function onModuleShown(this)
{
    this.m.Visible = true;
    this.m.Animating = false;
    return;
}

function setParent(this, _p)
{
    this.m.Parent = _p;
    return;
}
