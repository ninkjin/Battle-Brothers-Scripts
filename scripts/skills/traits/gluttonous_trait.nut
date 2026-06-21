this.gluttonous_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.gluttonous";
		this.m.Name = "贪吃";
		this.m.Icon = "ui/traits/trait_icon_07.png";
		this.m.Description = "好吃，再来一份！跟这个角色一起旅行的时候最好带上额外的食物，可以预料到一旦你的食物用完，他们就会很快离开。";
		this.m.Titles = [
			"肥猪"
		];
		this.m.Excluded = [
			"trait.athletic",
			"trait.iron_lungs",
			"trait.spartan",
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
			}
		];
	}

	function addTitle()
	{
		this.character_trait.addTitle();
	}

	function onUpdate( _properties )
	{
		_properties.DailyFood += 1.0;
	}

});

