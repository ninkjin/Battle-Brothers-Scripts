this.huge_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.huge";
		this.m.Name = "巨大";
		this.m.Icon = "ui/traits/trait_icon_61.png";
		this.m.Description = "这个角色特别高大魁梧，他的打击伤害很大，但他同时也是比其他人更大的目标。";
		this.m.Titles = [
			"大山",
			"壮牛",
			"熊",
			"巨人",
			"高塔",
			"公牛"
		];
		this.m.Excluded = [
			"trait.tiny",
			"trait.quick",
			"trait.fragile"
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
				id = 12,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color]近战伤害"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]近战防御"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]远程防御"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDamageMult *= 1.1;
		_properties.MeleeDefense -= 5;
		_properties.RangedDefense -= 5;
	}

});

