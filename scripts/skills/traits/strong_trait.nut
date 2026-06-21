this.strong_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.strong";
		this.m.Name = "强壮";
		this.m.Icon = "ui/traits/trait_icon_15.png";
		this.m.Description = "营养充足，强壮到家。";
		this.m.Titles = [
			"壮汉",
			"公牛",
			"壮牛",
			"熊",
			"大汉"
		];
		this.m.Excluded = [
			"trait.tiny",
			"trait.fragile",
			"trait.fat",
			"trait.ailing"
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
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color]最大疲劳"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Stamina += 10;
	}

});

