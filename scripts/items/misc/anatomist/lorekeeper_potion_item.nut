this.lorekeeper_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.lorekeeper_potion";
		this.m.Name = "内部庇护药剂";
		this.m.Description = "这个瓶子中装着一种强大的镇静剂，用来引入无法被疼痛唤醒的深度睡眠。为了让受试者能麻醉足够长的时间以便移植一排肋骨，这瓶药是必须的，而移植的肋骨则是从博学者那些命匣的其中一个里发现的。";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_38.png";
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
			icon = "ui/icons/special.png",
			text = "每场战斗有一次机会在本来将被杀死时会幸存并完全恢复生命值"
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
		_actor.getSkills().add(this.new("scripts/skills/effects/lorekeeper_potion_effect"));
		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});

