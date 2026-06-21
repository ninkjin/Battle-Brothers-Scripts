this.ghoul_teeth_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.ghoul_teeth";
		this.m.Name = "锯齿尖牙";
		this.m.Description = "从食尸鬼身上取得的锯齿状的尖牙。 已经感染腐烂了，但坚硬得足以咬碎骨头。 可以从市场上的炼金术士身上换取一些硬币。";
		this.m.Icon = "misc/inventory_ghoul_teeth_01.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 200;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
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

