this.witch_hair_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.witch_hair";
		this.m.Name = "女巫头发";
		this.m.Description = "来自女巫身上的长而易碎的灰白头发。 据说她们的头发在制造药剂和炼金方面有强大的功能。 话说回来，也有人说女巫喜欢收集受害者的生殖器来把玩，所以说从农夫那里得到的消息不太靠谱。";
		this.m.Icon = "misc/inventory_hexe_hair.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 2000;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/cloth_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function getSellPriceMult()
	{
		return this.World.State.getCurrentTown().getBeastPartsPriceMult();
	}

	function getBuyPriceMult()
	{
		return this.World.State.getCurrentTown().getBeastPartsPriceMult();
	}

});

