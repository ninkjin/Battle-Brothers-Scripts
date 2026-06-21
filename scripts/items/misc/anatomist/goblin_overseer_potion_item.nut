this.goblin_overseer_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.goblin_overseer_potion";
		this.m.Name = "死神之眼药剂";
		this.m.Description = "一个既可怕又恼人的事情是，上层哥布林那诡异的射术被认为根本不是任何自尊自爱的人类能学会的。然而饮用了这瓶药剂之后，敏锐的战士可以掌控一部分这种潜能，而代价只不过是变丑一点儿！";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_13.png";
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
			text = "使用弓或弩时有额外[color=" + this.Const.UI.Color.PositiveValue + "]5%[/color]穿甲伤害"
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
		_actor.getSkills().add(this.new("scripts/skills/effects/goblin_overseer_potion_effect"));
		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});

