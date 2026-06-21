this.survivor_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.survivor";
		this.m.Name = "幸存者";
		this.m.Icon = "ui/traits/trait_icon_43.png";
		this.m.Description = "你为什么就是不死？这个角色是一个幸存者，大概率比他的同僚存活更久。";
		this.m.Titles = [
			"幸存者",
			"幸运儿",
			"蒙福者"
		];
		this.m.Excluded = [
			"trait.bleeder",
			"trait.pessimist",
			"trait.deathwish",
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
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "有[color=" + this.Const.UI.Color.PositiveValue + "]90%[/color]几率被击倒而不是直接死亡，前提未遭到必死击杀"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.SurviveWithInjuryChanceMult *= 2.72;
	}

});

