this.optimist_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.optimist";
		this.m.Name = "乐观";
		this.m.Icon = "ui/traits/trait_icon_19.png";
		this.m.Description = "这杯子是半满的！";
		this.m.Excluded = [
			"trait.weasel",
			"trait.pessimist",
			"trait.irrational",
			"trait.insecure",
			"trait.dastard",
			"trait.paranoid"
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color]在正面士气检定时的决心"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "坏心情消失得更快"
			}
		];
	}

});

