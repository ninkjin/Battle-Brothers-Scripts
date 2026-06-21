this.unhold_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.unhold_potion";
		this.m.Name = "愚者宝藏药剂";
		this.m.Description = "不要在意名字这种小事，这瓶药剂将让任何喝下它的人近乎不朽！没错，就像那些可怕的巨魔一样，不管是哪位喝下它的幸运儿伤口在出现的瞬间就会开始愈合！还不赶紧喝了它！麻溜的！搞快点！少动脑子多动手！";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_32.png";
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
			icon = "ui/icons/health.png",
			text = "每回合回复[color=" + this.Const.UI.Color.PositiveValue + "]10[/color]生命值"
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
		_actor.getSkills().add(this.new("scripts/skills/effects/unhold_potion_effect"));
		return this.anatomist_potion_item.onUse(_actor, _item);
	}

});

