this.loyal_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.loyal";
		this.m.Name = "忠诚";
		this.m.Icon = "ui/traits/trait_icon_39.png";
		this.m.Description = "我支持你！这个角色永远忠诚，即使你的克朗和食物用完了，也不太可能离开你。";
		this.m.Titles = [
			"丹心",
			"追随者",
			"狗"
		];
		this.m.Excluded = [
			"trait.disloyal",
			"trait.craven",
			"trait.fainthearted",
			"trait.dastard"
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

});

