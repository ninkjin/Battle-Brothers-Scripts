this.cocky_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.cocky";
		this.m.Name = "自大";
		this.m.Icon = "ui/traits/trait_icon_24.png";
		this.m.Description = "全都小菜一碟！这个角色恐怕有点自大过头了，不利于他的身心健康。";
		this.m.Titles = [
			"勇士",
			"吹牛者"
		];
		this.m.Excluded = [
			"trait.weasel",
			"trait.hesitant",
			"trait.pessimist",
			"trait.dastard",
			"trait.insecure",
			"trait.craven",
			"trait.fainthearted",
			"trait.paranoid",
			"trait.fear_beasts",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.teamplayer"
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
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color]决心"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]近战防御"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]远程防御"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += 5;
		_properties.MeleeDefense += -5;
		_properties.RangedDefense += -5;
	}

});

