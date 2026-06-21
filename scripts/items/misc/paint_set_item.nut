this.paint_set_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.paint_set_shields";
		this.m.Name = "油漆套装";
		this.m.Description = "由几种鲜艳的颜料和一套刷子组成的调色板，可用来给普通盾牌涂上你战队的颜色。";
		this.m.Icon = "consumables/paint_set_shields.png";
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
			text = "右键单击或拖动到当前所选角色携带的盾牌上，对其进行喷涂。 此物品会在使用过程中消耗掉。"
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		local shield = _item == null ? _actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) : _item;

		if (shield == null)
		{
			return false;
		}

		local newShield;

		if (_item == null)
		{
			if (shield.getID() == "shield.faction_heater_shield")
			{
				newShield = this.new("scripts/items/shields/heater_shield");
				newShield.setCondition(shield.getCondition());
			}
			else if (shield.getID() == "shield.faction_kite_shield")
			{
				newShield = this.new("scripts/items/shields/kite_shield");
				newShield.setCondition(shield.getCondition());
			}
			else if (shield.getID() == "shield.faction_wooden_shield")
			{
				newShield = this.new("scripts/items/shields/wooden_shield");
				newShield.setCondition(shield.getCondition());
			}

			if (newShield != null)
			{
				_actor.getItems().unequip(shield);
				_actor.getItems().equip(newShield);
				shield = newShield;
			}
		}

		if (!("onPaintInCompanyColors" in shield))
		{
			return false;
		}

		this.Sound.play("sounds/inventory/paint_set_use_01.wav", this.Const.Sound.Volume.Inventory);
		shield.onPaintInCompanyColors();
		this.updateAchievement("AColorfulBand", 1, 1);
		return true;
	}

});

