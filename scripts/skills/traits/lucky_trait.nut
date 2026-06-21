this.lucky_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.lucky";
		this.m.Name = "幸运";
		this.m.Icon = "ui/traits/trait_icon_54.png";
		this.m.Description = "这个角色生有着在最后一秒躲开伤害的天赋。";
		this.m.Titles = [
			"幸运儿",
			"蒙福者"
		];
		this.m.Excluded = [
			"trait.pessimist",
			"trait.clumsy",
			"trait.ailing",
			"trait.clubfooted"
		];
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
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "有[color=" + this.Const.UI.Color.PositiveValue + "]10%[/color]几率需要攻击者掷攻击骰成功两次才会被命中"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.RerollDefenseChance += 10;
	}

});

