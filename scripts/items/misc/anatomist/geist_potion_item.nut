this.geist_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.geist_potion";
		this.m.Name = "亡者之饮药剂";
		this.m.Description = "这瓶药剂是由一个'被杀'的幽灵残存的模糊灵质合成的，它会使服用者的身体变得具备鬼魂式的特征。这样的战士不管用什么武器都肯定会得到一点幽灵那样穿透盔甲的能力！服用此药剂后幻听属于正常现象，应该会在一段时间后停止。希望如此吧。";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_24.png";
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
			text = "使用近战武器时有额外[color=" + this.Const.UI.Color.PositiveValue + "]5%[/color]穿甲伤害"
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
		_actor.getSkills().add(this.new("scripts/skills/effects/geist_potion_effect"));
		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});

