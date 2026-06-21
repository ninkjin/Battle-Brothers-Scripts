this.irrational_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.irrational";
		this.m.Name = "无常";
		this.m.Icon = "ui/traits/trait_icon_28.png";
		this.m.Description = "这刚才还是半满的杯子现在是半空的。";
		this.m.Excluded = [
			"trait.pessimist",
			"trait.optimist",
			"trait.insecure"
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
				text = "每次士气检定随机[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color]或[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color]决心"
			}
		];
	}

});

