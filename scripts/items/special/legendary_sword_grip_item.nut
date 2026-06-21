this.legendary_sword_grip_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legendary_sword_grip";
		this.m.Name = "剑柄";
		this.m.Description = "一把由神秘蓝色石头覆盖的精制剑柄。石头的深处似乎有一道光在闪烁。或许它可以被重新铸造，如果你能拥有它的两个部分的话。";
		this.m.Icon = "misc/inventory_sword_hilt_01.png";
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

