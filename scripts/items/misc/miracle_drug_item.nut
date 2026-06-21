this.miracle_drug_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.miracle_drug";
		this.m.Name = "药剂师的奇迹";
		this.m.Description = "治疗诸多普通小病和恶疾的良药，减少炎症和提升身体自愈能力。\n\n用此药品治疗的角色受伤后康复得更快，就像在神殿里治疗一样。";
		this.m.Icon = "consumables/pills_01.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 450;
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
			text = "右键单击或拖动到当前选定的角色上进行吞服。 此物品会在使用过程中消耗掉。"
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		this.Sound.play("sounds/inventory/pills_swallow_01.wav", this.Const.Sound.Volume.Inventory);
		local allInjuries = _actor.getSkills().query(this.Const.SkillType.TemporaryInjury);

		foreach( injury in allInjuries )
		{
			injury.setTreated(true);
		}

		_actor.getSkills().removeByID("effects.hangover");
		_actor.updateInjuryVisuals();
		return true;
	}

});

