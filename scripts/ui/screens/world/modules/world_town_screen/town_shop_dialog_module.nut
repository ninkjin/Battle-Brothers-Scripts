// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/world/modules/world_town_screen/town_shop_dialog_module.nut
// Functions: 17

function clear(this)
{
    this.m.Shop = null;
    return;
}

function create(this)
{
    this.m.ID = "ShopDialogModule";
    this.ui_module.create();
    return;
}

function destroy(this)
{
    this.ui_module.destroy();
    return;
}

function getShop(this)
{
    return this.m.Shop;
}

function loadStashList(this)
{
    this.m.JSHandle.asyncCall("loadFromData", {});
    return;
}

function onCanSwapItem(this, _data)
{
    if (_data["3"] == null)
    {
        this.logError("onSwapItem #1");
        return _data;
    }
    if (_data["1"] == "world-town-screen-shop-dialog-module.stash")
    {
        if (this.Stash.getItemAtIndex(_data["0"]) == null)
        {
            this.logError("onSwapItem(stash) #2");
            return _data;
        }
        if ((_data["1"] != _data["3"]) && (_data["1"] != _data["3"]))
        {
            return ((_data["1"] != _data["3"]) && (_data["1"] != _data["3"]));
            if (!this.Stash.getItemAtIndex(_data["0"]).item.isSellable())
            {
                {}.Result = this.Const.UI.Swap.DoNotSwap;
            }
            else
            {
                if (this.Stash.getItemAtIndex(_data["0"]).item.isUnique())
                {
                    {}.Result = this.Const.UI.Swap.ConfirmNoReplaceSwap;
                }
                else
                {
                    if (this.Stash.getItemAtIndex(_data["0"]).item.isPrecious())
                    {
                        {}.Result = this.Const.UI.Swap.ConfirmReplaceSwap;
                    }
                }
            }
            {}.Item = {Name = this.Stash.getItemAtIndex(_data["0"]).item.getName(), Icon = this.Stash.getItemAtIndex(_data["0"]).item.getIcon()};
        }
    }
    return _data;
}

function onFilterAll(this)
{
    if (this.m.InventoryFilter != this.Const.Items.ItemFilter.All)
    {
        this.m.InventoryFilter = this.Const.Items.ItemFilter.All;
        this.loadStashList();
    }
    return;
}

function onFilterArmor(this)
{
    if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Armor)
    {
        this.m.InventoryFilter = this.Const.Items.ItemFilter.Armor;
        this.loadStashList();
    }
    return;
}

function onFilterMisc(this)
{
    if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Misc)
    {
        this.m.InventoryFilter = this.Const.Items.ItemFilter.Misc;
        this.loadStashList();
    }
    return;
}

function onFilterUsable(this)
{
    if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Usable)
    {
        this.m.InventoryFilter = this.Const.Items.ItemFilter.Usable;
        this.loadStashList();
    }
    return;
}

function onFilterWeapons(this)
{
    if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Weapons)
    {
        this.m.InventoryFilter = this.Const.Items.ItemFilter.Weapons;
        this.loadStashList();
    }
    return;
}

function onLeaveButtonPressed(this)
{
    this.m.Parent.onModuleClosed();
    return;
}

function onRepairItem(this, _itemIndex)
{
    if (!this.m.Shop.isRepairOffered())
    {
        return _itemIndex;
    }
    if ((1 >= r5) && (1 >= r5))
    {
        return ((1 >= r5) && (1 >= r5));
        return _itemIndex;
    }
    if (this.World.Assets.getMoney() < this.Math.max(((this.Stash.getItemAtIndex(_itemIndex).item.getConditionMax() - this.Stash.getItemAtIndex(_itemIndex).item.getCondition() * this.Const.World.Assets.CostToRepairPerPoint), ((((this.Stash.getItemAtIndex(_itemIndex).item.m.Value * (1.0 - (this.Stash.getItemAtIndex(_itemIndex).item.getCondition() / this.Stash.getItemAtIndex(_itemIndex).item.getConditionMax()))) * 0.20000000298023224) * this.World.State.getCurrentTown().getPriceMult()) * this.Const.Difficulty.SellPriceMult["this.World.Assets.getEconomicDifficulty()"]))))
    {
        return _itemIndex;
    }
    this.World.Assets.addMoney((-this));
    this.Stash.getItemAtIndex(_itemIndex).item.setCondition(this.Stash.getItemAtIndex(_itemIndex).item.getConditionMax());
    this.Stash.getItemAtIndex(_itemIndex).item.setToBeRepaired(false);
    this.Sound.play((("sounds/ambience/buildings/blacksmith_hammering_0" + this.Math.rand(0, 6)) + ".wav"), 1.0);
    this.World.Statistics.getFlags().increment("ItemsRepaired");
    return _itemIndex;
}

function onSortButtonClicked(this)
{
    if (this.Tactical.isActive())
    {
        this.getroottable().Stash.sort();
    }
    this.World.Assets.getStash().sort();
    this.loadStashList();
    return;
}

function onSwapItem(this, _data)
{
    if (_data["3"] == null)
    {
        this.logError("onSwapItem #1");
        return _data;
    }
    if (_data["1"] == "world-town-screen-shop-dialog-module.stash")
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
            this.logError("onSwapItem(stash) #3.1");
            return _data;
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
                            if (this.Stash.getItemAtIndex(_data["0"]).item.isItemType(this.Const.Items.ItemType.TradeGood))
                            {
                                this.World.Statistics.getFlags().increment("TradeGoodsSold");
                            }
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
                    this.World.Assets.addMoney(this.Stash.removeByIndex(_data["0"]).getSellPrice());
                    this.m.Shop.getStash().add(this.Stash.removeByIndex(_data["0"]));
                    this.Stash.removeByIndex(_data["0"]).setSold(true);
                    if (this.Stash.removeByIndex(_data["0"]).isItemType(this.Const.Items.ItemType.TradeGood))
                    {
                        this.World.Statistics.getFlags().increment("TradeGoodsSold");
                    }
                }
            }
        }
        this.UIDataHelper.convertItemsToUIData(this.m.Shop.getStash().getItems(), {}.Shop, this.Const.UI.ItemOwner.Shop);
        {}.Stash = [];
        if ((this.World.Statistics >= 10) && (this.World.Statistics >= 10))
        {
            return ((this.World.Statistics >= 10) && (this.World.Statistics >= 10));
            this.updateAchievement("Trader", 1, 1);
        }
        if ((this.World.Statistics >= 50) && (this.World.Statistics >= 50))
        {
            return ((this.World.Statistics >= 50) && (this.World.Statistics >= 50));
            this.updateAchievement("MasterTrader", 1, 1);
        }
        return _data;
    }
    if (_data["1"] == "world-town-screen-shop-dialog-module.shop")
    {
        if (this.m.Shop.getStash().getItemAtIndex(_data["0"]) == null)
        {
            this.logError("onSwapItem(found loot) #2");
            return _data;
        }
        if (this.World.Assets.getMoney() < this.m.Shop.getStash().getItemAtIndex(_data["0"]).item.getBuyPrice())
        {
            return _data;
        }
        if (_data["2"] != null)
        {
            if (_data["1"] == _data["3"])
            {
                return _data;
            }
            else
            {
                if ((this.Stash.getItemAtIndex(_data["2"]).item == null) && (this.Stash.getItemAtIndex(_data["2"]).item == null))
                {
                    return ((this.Stash.getItemAtIndex(_data["2"]).item == null) && (this.Stash.getItemAtIndex(_data["2"]).item == null));
                    this.World.Assets.addMoney((-this));
                    this.Stash.insert(this.m.Shop.getStash().getItemAtIndex(_data["0"]).item, _data["2"]);
                    this.m.Shop.getStash().removeByIndex(_data["0"]);
                    this.m.Shop.getStash().getItemAtIndex(_data["0"]).item.setBought(true);
                    if (this.m.Shop.getStash().getItemAtIndex(_data["0"]).item.isItemType(this.Const.Items.ItemType.TradeGood))
                    {
                        this.World.Statistics.getFlags().increment("TradeGoodsBought");
                    }
                }
                if (this.Stash.hasEmptySlot())
                {
                    this.World.Assets.addMoney((-this));
                    this.Stash.add(this.m.Shop.getStash().getItemAtIndex(_data["0"]).item);
                    this.m.Shop.getStash().removeByIndex(_data["0"]);
                    this.m.Shop.getStash().getItemAtIndex(_data["0"]).item.setBought(true);
                    if (this.m.Shop.getStash().getItemAtIndex(_data["0"]).item.isItemType(this.Const.Items.ItemType.TradeGood))
                    {
                        this.World.Statistics.getFlags().increment("TradeGoodsBought");
                    }
                }
                return _data;
            }
        }
        else
        {
            if (_data["1"] != _data["3"])
            {
                if (this.Stash.hasEmptySlot())
                {
                    this.World.Assets.addMoney((-this));
                    this.Stash.add(this.m.Shop.getStash().getItemAtIndex(_data["0"]).item);
                    this.m.Shop.getStash().removeByIndex(_data["0"]);
                    this.m.Shop.getStash().getItemAtIndex(_data["0"]).item.setBought(true);
                    if (this.m.Shop.getStash().getItemAtIndex(_data["0"]).item.isItemType(this.Const.Items.ItemType.TradeGood))
                    {
                        this.World.Statistics.getFlags().increment("TradeGoodsBought");
                    }
                }
                return _data;
            }
        }
        this.UIDataHelper.convertItemsToUIData(this.m.Shop.getStash().getItems(), {}.Shop, this.Const.UI.ItemOwner.Shop);
        {}.Stash = [];
        return _data;
    }
    return _data;
}

function queryShopInformation(this)
{
    this.UIDataHelper.convertItemsToUIData(this.m.Shop.getStash().getItems(), {}.Shop, this.Const.UI.ItemOwner.Shop);
    this.UIDataHelper.convertItemsToUIData(this.World.Assets.getStash().getItems(), {}.Stash, this.Const.UI.ItemOwner.Stash, this.m.InventoryFilter);
    return {Title = this.m.Shop.getName(), SubTitle = this.m.Shop.getDescription(), Assets = this.m.Parent.queryAssetsInformation(), Shop = [], Stash = [], StashSpaceUsed = this.Stash.getNumberOfFilledSlots(), StashSpaceMax = this.Stash.getCapacity(), IsRepairOffered = this.m.Shop.isRepairOffered()};
}

function setShop(this, _s)
{
    this.m.Shop = _s;
    return;
}
