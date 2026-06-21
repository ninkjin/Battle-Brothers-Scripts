this.paint_white_green_yellow_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.paint_white_green_yellow";
		this.m.Name = "白绿黄油漆";
		this.m.Description = "一桶白绿黄色的油漆。 可以喷涂许多普通的头盔。";
		this.m.Icon = "consumables/paint_green_white_yellow.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 75;
	}

	function getTooltip()
	{
		local result = [
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
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 65,
			type = "text",
			text = "右键单击或拖动到当前所选角色携带的头盔上，对其进行喷涂。 此物品会在使用过程中消耗掉。"
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		local helmet = _item == null ? _actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head) : _item;

		if (helmet == null || !("onPaint" in helmet))
		{
			return false;
		}

		this.Sound.play("sounds/inventory/paint_set_use_01.wav", this.Const.Sound.Volume.Inventory);
		helmet.onPaint(this.Const.Items.Paint.WhiteGreenYellow);
		return true;
	}

});

