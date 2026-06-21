this.paranoid_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.paranoid";
		this.m.Name = "多疑";
		this.m.Icon = "ui/traits/trait_icon_55.png";
		this.m.Description = "我发誓那边的灌木在动！这个角色格外谨慎，不愿意前进。";
		this.m.Titles = [
			"怪胎",
			"疑心病"
		];
		this.m.Excluded = [
			"trait.optimist",
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.cocky",
			"trait.bloodthirsty"
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
				icon = "ui/icons/melee_defense.png",
				text = "有[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color]近战防御"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "有[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color]远程防御"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "有[color=" + this.Const.UI.Color.NegativeValue + "]-30[/color]主动性"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += 5;
		_properties.RangedDefense += 5;
		_properties.Initiative += -30;
	}

});

