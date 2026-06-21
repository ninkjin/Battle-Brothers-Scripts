this.reinforced_throwing_net <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "tool.reinforced_throwing_net";
		this.m.Name = "强化投网";
		this.m.Description = "一张用来投向目标的网，用来阻止他们移动或有效的保护自己。使用织网蛛的丝强化以后，它更加难以挣脱。";
		this.m.IconLarge = "tools/inventory_throwing_net_02.png";
		this.m.Icon = "tools/throwing_net_02_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Tool | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_throwing_net_02";
		this.m.Value = 150;
		this.m.RangeMax = 3;
		this.m.StaminaModifier = -2;
		this.m.IsDroppedAsLoot = true;
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
			id = 66,
			type = "text",
			text = this.getValueString()
		});
		result.push({
			id = 64,
			type = "text",
			text = "副手持用"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "使用范围为[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RangeMax + "[/color]格"
		});

		if (this.m.StaminaModifier < 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "最大疲劳[color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.StaminaModifier + "[/color]"
			});
		}

		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "会使目标定身并减少他们的防御"
		});
		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "使用时摧毁"
		});
		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "挣脱的几率降低[color=" + this.Const.UI.Color.NegativeValue + "]-15[/color]"
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/cloth_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill = this.new("scripts/skills/actives/throw_net");
		skill.setReinforced(true);
		this.addSkill(skill);
	}

});

