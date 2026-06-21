this.legendary_sword_blade_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legendary_sword_blade";
		this.m.Name = "剑刃";
		this.m.Description = "一把断剑的光芒闪闪的剑刃，由你从克拉肯那取回。在你这么多年的战斗中，你从未见过如此精制利刃。或许它可以被重新铸造，如果你能拥有它的两个部分的话。";
		this.m.Icon = "misc/inventory_sword_blade_01.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 2500;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

});

