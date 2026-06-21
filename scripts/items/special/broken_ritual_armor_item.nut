this.broken_ritual_armor_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.broken_ritual_armor";
		this.m.Name = "破损的仪式盔甲";
		this.m.Description = "一件野蛮人重型盔甲的残骸，覆盖着仪式性的符文。这状态下它无法使用，但你还是觉得它有些特别。也许有什么方法能修好它？";
		this.m.Icon = "misc/inventory_champion_armor_quest.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1000;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_halfplate_impact_01.wav", this.Const.Sound.Volume.Inventory);
	}

});

