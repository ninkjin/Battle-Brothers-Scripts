// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/world/modules/world_town_screen/town_hire_dialog_module.nut
// Functions: 9

function clear(this)
{
    this.m.RosterID = 0;
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

function findEntityWithinRoster(this, _entryID)
{
    if (this.World.getRoster(this.m.RosterID).getAll() == null)
    {
        return _entryID;
    }
    foreach (local key, value in r9)
    {
        if (null.getID() == _entryID)
        {
            return _entryID;
        }
        return _entryID;
    }
}

function onHireRosterEntry(this, _entityID)
{
    if (this.findEntityWithinRoster(_entityID) != null)
    {
        if (this.World.Assets.getMoney() < this.Math.ceil((this.findEntityWithinRoster(_entityID).getHiringCost() * this.World.Assets.m.HiringCostMult)))
        {
            return _entityID;
        }
        if ((this.World.getPlayerRoster().getAll().len() + 1) > this.World.Assets.getBrothersMax())
        {
            return _entityID;
        }
        this.World.getPlayerRoster().add(this.findEntityWithinRoster(_entityID));
        this.World.getRoster(this.m.RosterID).remove(this.findEntityWithinRoster(_entityID));
        this.findEntityWithinRoster(_entityID).onHired();
        this.World.Assets.addMoney((-this));
        this.World.Statistics.getFlags().increment("BrosHired");
        if (this.World.getRoster(this.m.RosterID).getSize() == 0)
        {
            this.m.Parent.getMainDialogModule().reload();
        }
        return _entityID;
    }
    return _entityID;
}

function onLeaveButtonPressed(this)
{
    this.m.Parent.onModuleClosed();
    return;
}

function onTryoutRosterEntry(this, _entityID)
{
    if (this.findEntityWithinRoster(_entityID) != null)
    {
        if (this.World.Assets.getMoney() < this.findEntityWithinRoster(_entityID).getTryoutCost())
        {
            return _entityID;
        }
        this.findEntityWithinRoster(_entityID).setTryoutDone(true);
        this.World.Assets.addMoney((-this));
        return _entityID;
    }
    return _entityID;
}

function queryHireInformation(this)
{
    return {Roster = this.UIDataHelper.convertHireRosterToUIData(this.m.RosterID), Assets = this.m.Parent.queryAssetsInformation()};
}

function setRosterID(this, _id)
{
    this.m.RosterID = _id;
    return;
}
