// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/world/modules/world_campfire_screen/campfire_hire_dialog_module.nut
// Functions: 7

function clear(this)
{
    return;
}

function create(this)
{
    this.m.ID = "HireDialogModule";
    this.ui_module.create();
    return;
}

function destroy(this)
{
    this.ui_module.destroy();
    return;
}

function onHireFollower(this, _followerID)
{
    if ((!this.World.Retinue) && (!this.World.Retinue))
    {
        return ((!this.World.Retinue) && (!this.World.Retinue));
        if (this.World.Assets.getMoney() < this.World.Retinue.getFollower(_followerID).getCost())
        {
            return _followerID;
        }
        this.World.Retinue.setFollower(this.m.CurrentSlot, this.World.Retinue.getFollower(_followerID));
        this.World.Assets.addMoney((-this));
        this.World.State.updateTopbarAssets();
        return _followerID;
    }
    return _followerID;
}

function onLeaveButtonPressed(this)
{
    this.m.Parent.onModuleClosed();
    return;
}

function queryHireInformation(this)
{
    return {Roster = this.World.Retinue.getFollowersForUI(), Assets = this.m.Parent.queryAssetsInformation()};
}

function setCurrentSlot(this, _s)
{
    this.m.CurrentSlot = _s;
    return;
}
