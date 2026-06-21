this.pessimist_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.pessimist";
		this.m.Name = "悲观";
		this.m.Icon = "ui/traits/trait_icon_20.png";
		this.m.Description = "这杯子一定是半空的。";
		this.m.Excluded = [
			"trait.optimist",
			"trait.irrational",
			"trait.cocky",
			"trait.determined",
			"trait.survivor"
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]在负面士气检定时的决心"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "好心情消失得更快"
			}
		];
	}

});

