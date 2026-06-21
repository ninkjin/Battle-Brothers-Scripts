this.spartan_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.spartan";
		this.m.Name = "斯巴达";
		this.m.Icon = "ui/traits/trait_icon_08.png";
		this.m.Description = "谁需要燕麦片和水以外的食物？这个角色并不享受进食并且吃的很少，即便你的食物用完了，他也不会很快离开你。";
		this.m.Excluded = [
			"trait.fat",
			"trait.gluttonous"
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

	function onUpdate( _properties )
	{
		_properties.DailyFood -= 1.0;
	}

});

