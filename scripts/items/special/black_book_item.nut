this.black_book_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.black_book";
		this.m.Name = "黑书";
		this.m.Description = "一本老旧而古怪的大书本，有着血肉封皮。它的书页中充满了神秘莫测的文字和图画，使你压根摸不着头脑。你看着这本书越久，它就越让你心乱。或许对古代语言有着更多知识的人能搞明白它。";
		this.m.Icon = "misc/inventory_necronomicon.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1000;
	}

});

