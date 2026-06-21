// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/tactical/modules/topbar/tactical_screen_topbar_event_log.nut
// Functions: 6

function clear(this)
{
    this.m.JSHandle.asyncCall("clear", null);
    return;
}

function create(this)
{
    this.m.ID = "TopbarEventLogModule";
    this.ui_module.create();
    return;
}

function destroy(this)
{
    this.ui_module.destroy();
    return;
}

function log(this, _text)
{
    this.m.JSHandle.asyncCall("log", ("
" + _text));
    return;
}

function logEx(this, _text)
{
    this.m.JSHandle.asyncCall("log", _text);
    return;
}

function log_newline(this)
{
    this.m.JSHandle.asyncCall("log", "
");
    return;
}
