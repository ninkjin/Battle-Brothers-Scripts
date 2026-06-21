this.wardog_armor_upgrade_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.wardog_armor_upgrade";
		this.m.Name = "战犬盔甲";
		this.m.Description = "简单的皮革外套，可披在任何战犬身上，以在战斗时提供一些保护。";
		this.m.Icon = "armor_upgrades/upgrade_21.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 200;
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
			text = "右键单击或拖动到当前选定的角色装备的战犬上进行使用。 此物品会在使用过程中消耗掉。"
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		local dog = _item == null ? _actor.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory) : _item;

		if (dog == null || dog.getID() != "accessory.wardog" && dog.getID() != "accessory.warhound")
		{
			return false;
		}

		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
		local new_dog;

		if (dog.getID() == "accessory.wardog")
		{
			new_dog = this.new("scripts/items/accessory/armored_wardog_item");
		}
		else
		{
			new_dog = this.new("scripts/items/accessory/armored_warhound_item");
		}

		new_dog.setName(dog.getName());
		new_dog.setVariant(dog.getVariant());
		_actor.getItems().unequip(dog);
		_actor.getItems().equip(new_dog);
		return true;
	}

});

