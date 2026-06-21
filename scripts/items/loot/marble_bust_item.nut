// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/loot/marble_bust_item.nut
// Functions: 5

function create(this)
{
    this.item.create();
    this.m.ID = "misc.marble_bust";
    this.m.Name = "Marble Bust";
    this.m.Description = "A beautiful marble bust of some unknown figure. The craftsmanship is superb.";
    this.m.Icon = "loot/inventory_golems_01.png";
    this.m.SlotType = this.Const.ItemSlot.None;
    this.m.ItemType = (this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Loot);
    this.m.IsDroppedAsLoot = true;
    this.m.Value = 600;
    return;
}

function getBuyPrice(this)
{
    if (this.m.IsSold)
    {
        return this.getSellPrice();
        return this.getSellPrice;
    }
    if ((this.World.State.getCurrentTown() != null) && (this.World.State.getCurrentTown() != null))
    {
        return ((this.World.State.getCurrentTown() != null) && (this.World.State.getCurrentTown() != null));
        return this.Math.max(this.getSellPrice(), this.Math.ceil(((this.getValue() * 1.5) * this.World.State.getCurrentTown().getBuyPriceMult())));
        return this.Math.max;
    }
    return this.Math.ceil(this.getValue());
    return this.Math.ceil;
}

function getSellPrice(this)
{
    if (this.m.IsBought)
    {
        return this.getBuyPrice();
        return this.getBuyPrice;
    }
    if ((this.World.State.getCurrentTown() != null) && (this.World.State.getCurrentTown() != null))
    {
        return ((this.World.State.getCurrentTown() != null) && (this.World.State.getCurrentTown() != null));
        return this.Math.floor((((this.getValue() * this.Const.World.Assets.BaseLootSellPrice) * this.World.State.getCurrentTown().getSellPriceMult()) * this.Const.Difficulty.SellPriceMult["this.World.Assets.getEconomicDifficulty()"]));
        return this.Math.floor;
    }
    return this.Math.floor(this.getValue());
    return this.Math.floor;
}

function getTooltip(this)
{
    [].push({});
    return [{id = 1, type = "title", text = this.getName()}, {id = 2, type = "description", text = this.getDescription()}];
}

function playInventorySound(this, _eventType)
{
    this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
    return;
}
