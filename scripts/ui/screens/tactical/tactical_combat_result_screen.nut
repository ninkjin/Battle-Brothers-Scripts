// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/tactical/tactical_combat_result_screen.nut
// Functions: 28

function clearEventListener(this)
{
    this.m.OnConnectedListener = null;
    this.m.OnDisconnectedListener = null;
    this.m.OnLeaveButtonPressedListener = null;
    this.m.OnQueryCombatInformationListener = null;
    return;
}

function create(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    this.m.JSHandle = this.UI.connect("TacticalCombatResultScreen", this);
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
    return;
}

function hide(this)
{
    if (null && null)
    {
        return (null && null);
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("hide", null);
    }
    return;
}

function isAnimating(this)
{
    return;
}

function isVisible(this)
{
    return;
}

function loadCombatInformation(this)
{
    if (this.m.JSHandle != null)
    {
        this.m.JSHandle.asyncCall("loadCombatInformation", null);
    }
    return;
}

function loadFoundLootList(this)
{
    if (this.m.JSHandle != null)
    {
        this.m.JSHandle.asyncCall("loadFoundLootList", null);
    }
    return;
}

function loadItemLists(this)
{
    if (this.m.JSHandle != null)
    {
        this.m.JSHandle.asyncCall("loadItemLists", null);
    }
    return;
}

function loadStashList(this)
{
    if (this.m.JSHandle != null)
    {
        this.m.JSHandle.asyncCall("loadStashList", null);
    }
    return;
}

function onDestroyItem(this, _data)
{
    if (_data["1"] == "tactical-combat-result-screen.stash")
    {
        if (this.Stash.removeByIndex(_data["0"]) != null)
        {
            return _data;
        }
    }
    else
    {
        if (_data["1"] == "tactical-combat-result-screen.found-loot")
        {
            if (this.Tactical.CombatResultLoot.removeByIndex(_data["0"]) != null)
            {
                return _data;
            }
        }
    }
    return _data;
}

function onLeaveButtonPressed(this)
{
    if (this.m.OnLeaveButtonPressedListener != null)
    {
        this.m.OnLeaveButtonPressedListener();
    }
    return;
}

function onLootAllItemsButtonPressed(this)
{
    if (this.Tactical.CombatResultLoot.isEmpty())
    {
        return this.Const.UI.convertErrorToUIData(this.Const.UI.Error.FoundLootListIsEmpty);
        return this.Const.UI.convertErrorToUIData;
    }
    if (!this.Stash.hasEmptySlot())
    {
        return this.Const.UI.convertErrorToUIData(this.Const.UI.Error.NotEnoughStashSpace);
        return this.Const.UI.convertErrorToUIData;
    }
    if (0 < this.Tactical.CombatResultLoot.getItems().len())
    {
        if (this.Tactical.CombatResultLoot.getItems()["0"] != null)
        {
            if (0 < this.Stash.getItems().len())
            {
                if (this.Stash.getItems()["0"] == null)
                {
                    this.Stash.getItems()["0"] = this.Tactical.CombatResultLoot.getItems()["0"];
                    this.Tactical.CombatResultLoot.getItems()["0"] = null;
                    this.Stash.getItems()["0"].onAddedToStash(this.Stash.getID());
                    if (!false)
                    {
                        this.Stash.getItems()["0"].playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
                    }
                }
            }
        }
    }
    this.Tactical.CombatResultLoot.shrink();
    if (true == false)
    {
        return this.Const.UI.convertErrorToUIData(this.Const.UI.Error.NotEnoughStashSpace);
        return this.Tactical.CombatResultLoot.getItems();
    }
    return this.Tactical.CombatResultLoot.getItems();
}

function onQueryCombatInformation(this)
{
    if (this.m.OnQueryCombatInformationListener != null)
    {
        return this.m.OnQueryCombatInformationListener();
        return this.m.OnQueryCombatInformationListener;
    }
    return null;
}

function onQueryItemList(this, _data)
{
    if (_data == "tactical-combat-result-screen.stash")
    {
        return this.UIDataHelper.convertStashToUIData(true);
        return _data;
    }
    if (_data == "tactical-combat-result-screen.found-loot")
    {
        return this.UIDataHelper.convertCombatResultLootToUIData();
        return _data;
    }
    return _data;
}

function onQueryStatistics(this)
{
    return this.UIDataHelper.convertCombatResultRosterToUIData();
    return this.UIDataHelper.convertCombatResultRosterToUIData;
}

function onScreenAnimating(this)
{
    this.m.Animating = true;
    return;
}

function onScreenConnected(this)
{
    if (this.m.OnConnectedListener != null)
    {
        this.m.OnConnectedListener();
    }
    return;
}

function onScreenDisconnected(this)
{
    if (this.m.OnDisconnectedListener != null)
    {
        this.m.OnDisconnectedListener();
    }
    return;
}

function onScreenHidden(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    return;
}

function onScreenShown(this)
{
    this.m.Visible = true;
    this.m.Animating = false;
    return;
}

function onSwapItem(this, _data)
{
    if (_data["3"] == null)
    {
        this.logError("onSwapItem #1");
        return _data;
    }
    if (_data["1"] == "tactical-combat-result-screen.stash")
    {
        if (this.Stash.getItemAtIndex(_data["0"]) == null)
        {
            this.logError("onSwapItem(stash) #2");
            return _data;
        }
        if (_data["2"] != null)
        {
            if (_data["1"] == _data["3"])
            {
                if (this.Stash.swap(_data["0"], _data["2"]))
                {
                    this.Stash.getItemAtIndex(_data["0"]).item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
                }
                this.logError("onSwapItem(stash) #3");
                return _data;
            }
            this.Stash.insert(this.Tactical.CombatResultLoot.insert(this.Stash.getItemAtIndex(_data["0"]).item, _data["2"]), _data["0"]);
            this.Stash.getItemAtIndex(_data["0"]).item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
        }
        else
        {
            if (_data["1"] == _data["3"])
            {
                if (!this.Stash.isLastTakenSlot(_data["0"]))
                {
                    if (this.Stash.getFirstEmptySlot() != null)
                    {
                        if (this.Stash.swap(_data["0"], this.Stash.getFirstEmptySlot()))
                        {
                            this.Stash.getItemAtIndex(_data["0"]).item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
                        }
                        this.logError("onSwapItem(stash) #4");
                        return _data;
                    }
                }
            }
            else
            {
                if (this.Stash.removeByIndex(_data["0"]) != null)
                {
                    this.Tactical.CombatResultLoot.add(this.Stash.removeByIndex(_data["0"]));
                    this.Stash.getItemAtIndex(_data["0"]).item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
                }
            }
        }
        return _data;
    }
    if (_data["1"] == "tactical-combat-result-screen.found-loot")
    {
        if (this.Tactical.CombatResultLoot.getItemAtIndex(_data["0"]) == null)
        {
            this.logError("onSwapItem(found loot) #2");
            return _data;
        }
        if (_data["2"] != null)
        {
            if (_data["1"] == _data["3"])
            {
                if (this.Tactical.CombatResultLoot.swap(_data["0"], _data["2"]))
                {
                    this.Tactical.CombatResultLoot.getItemAtIndex(_data["0"]).item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
                }
                this.logError("onSwapItem(found loot) #3");
                return _data;
            }
            if (this.Stash.insert(this.Tactical.CombatResultLoot.getItemAtIndex(_data["0"]).item, _data["2"]) != null)
            {
                this.Tactical.CombatResultLoot.insert(this.Stash.insert(this.Tactical.CombatResultLoot.getItemAtIndex(_data["0"]).item, _data["2"]), _data["0"]);
            }
            this.Tactical.CombatResultLoot.removeByIndex(_data["0"]);
            this.Tactical.CombatResultLoot.getItemAtIndex(_data["0"]).item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
        }
        else
        {
            if (_data["1"] != _data["3"])
            {
                if (this.Stash.hasEmptySlot())
                {
                    if (this.Tactical.CombatResultLoot.removeByIndex(_data["0"]) != null)
                    {
                        this.Stash.add(this.Tactical.CombatResultLoot.removeByIndex(_data["0"]));
                        this.Tactical.CombatResultLoot.getItemAtIndex(_data["0"]).item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
                    }
                }
                return this.Const.UI.convertErrorToUIData(this.Const.UI.Error.NotEnoughStashSpace);
                return _data;
            }
        }
        return _data;
    }
    return _data;
}

function queryData(this)
{
    return {combatInformation = this.onQueryCombatInformation(), statistics = this.onQueryStatistics(), stash = this.onQueryItemList("tactical-combat-result-screen.stash"), foundLoot = this.onQueryItemList("tactical-combat-result-screen.found-loot")};
}

function setOnConnectedListener(this, _listener)
{
    this.m.OnConnectedListener = _listener;
    return;
}

function setOnDisconnectedListener(this, _listener)
{
    this.m.OnDisconnectedListener = _listener;
    return;
}

function setOnLeavePressedListener(this, _listener)
{
    this.m.OnLeaveButtonPressedListener = _listener;
    return;
}

function setOnQueryCombatInformationListener(this, _listener)
{
    this.m.OnQueryCombatInformationListener = _listener;
    return;
}

function show(this)
{
    if ((!null) && (!null))
    {
        return ((!null) && (!null));
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("show", this.queryData());
    }
    return;
}
