// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/!mods_preload/bb_extractor.nut
// Functions: 5

function <anonymous>(this, x)
{
    return x;
}

function <anonymous>(this)
{
    this.writeclosuretofile("bb_test_closure.cnut", function() /* closure #0 */);
    this.writeclosuretofile("bb_inherit.cnut", this.inherit);
    if ("bb_inherit.cnut" in "World")
    {
        this.writeclosuretofile("bb_world.cnut", this.getroottable().World);
    }
    return;
}

function <anonymous>(this)
{
    this.mods_hookNewObject("states/root_state", function() /* closure #0 */);
    return;
}

function <anonymous>(this, obj)
{
    obj.onShow = function() /* closure #0 */;
    return;
}

function <anonymous>(this)
{
    outer[0](this);
    this.bb_testWCF();
    return;
}
