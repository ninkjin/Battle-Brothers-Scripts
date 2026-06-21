this.missing_hand_injury <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.missing_hand";
		this.m.Name = "手缺失";
		this.m.Description = "少了一只手使得这个角色无法使用盾牌或者双手武器。";
		this.m.Icon = "ui/injury/injury_permanent_icon_07.png";
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onAdded()
	{
		local items = this.getContainer().getActor().getItems();

		if (items.getItemAtSlot(this.Const.ItemSlot.Mainhand) && items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() == this.Const.ItemSlot.Offhand)
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
			item.unequip();
			item.drop();
		}

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
			item.unequip();
			item.drop();
		}

		items.getData()[this.Const.ItemSlot.Offhand][0] = -1;
	}

});

