this.necrosavant_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.necrosavant_potion";
		this.m.Name = "暗夜行者药剂";
		this.m.Description = "无论是谁喝下这种由吸血鬼灰烬制成的奇妙药水，都会发现自己拥有了不死生物的神奇治疗能力！但它并不会让你像那些怪物一样延年益寿，事实实际上恰恰相反。服用者在吸食血液时过度愉悦属于特色现象。";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_20.png";
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
			text = "治疗[color=" + this.Const.UI.Color.PositiveValue + "]25%[/color]对有血液的相邻敌人造成的生命值伤害"
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
		_actor.getSkills().add(this.new("scripts/skills/effects/necrosavant_potion_effect"));
		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});

