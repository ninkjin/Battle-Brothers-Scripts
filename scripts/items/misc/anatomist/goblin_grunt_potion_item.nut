this.goblin_grunt_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.goblin_grunt_potion";
		this.m.Name = "神行如飞药剂";
		this.m.Description = "这瓶混合物由哥布林前线士兵携带的药物制成，可以让人获得通常只有小体型绿皮才有的那种敏捷。可能会导致皮肤轻微变色。";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_11.png";
		this.m.Value = 0;
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
			id = 11,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = "换位和步法技能的行动点消耗降低至[color=" + this.Const.UI.Color.PositiveValue + "]2[/color]"
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "换位和步法技能产生的疲劳降低[color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]"
		});
		result.push({
			id = 65,
			type = "text",
			text = "右键单击或拖动到当前选定的角色上进行饮用。此物品会在使用过程中消耗掉。"
		});
		result.push({
			id = 65,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "会使身体发生突变并导致疾病"
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		_actor.getSkills().add(this.new("scripts/skills/effects/goblin_grunt_potion_effect"));
		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});

