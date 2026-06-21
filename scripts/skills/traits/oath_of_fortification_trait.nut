this.oath_of_fortification_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.oath_of_fortification";
		this.m.Name = "壁垒誓言";
		this.m.Icon = "ui/traits/trait_icon_86.png";
		this.m.Description = "这个角色已经立下壁垒誓言，发誓对他的盾牌寄予无上的信任。";
		this.m.Order = this.Const.SkillOrder.Trait - 1;
		this.m.Excluded = [];
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "盾牌技能减少[color=" + this.Const.UI.Color.NegativeValue + "]25%[/color]疲劳度积累"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "‘盾墙’技能将会额外赋予[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color]近战防御和[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color]远程防御"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "‘击退’技能有[color=" + this.Const.UI.Color.PositiveValue + "]100%[/color]几率命中时造成趔趄。"
			},
			{
				id = 14,
				type = "hint",
				icon = "ui/icons/warning.png",
				text = "专注于防御，在战斗的第一回合无法移动"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsProficientWithShieldSkills = true;
	}

});

