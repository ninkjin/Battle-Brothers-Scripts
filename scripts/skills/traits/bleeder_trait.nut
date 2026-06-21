this.bleeder_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.bleeder";
		this.m.Name = "出血";
		this.m.Icon = "ui/traits/trait_icon_16.png";
		this.m.Description = "这个角色容易流血，而且会比其他大多数人流更长时间。";
		this.m.Excluded = [
			"trait.tough",
			"trait.iron_jaw",
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
				icon = "ui/icons/special.png",
				text = "流血伤害持续时间增加[color=" + this.Const.UI.Color.NegativeValue + "]1[/color]回合"
			}
		];
	}

});

