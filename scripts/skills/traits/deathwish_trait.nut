this.deathwish_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.deathwish";
		this.m.Name = "死愿";
		this.m.Icon = "ui/traits/trait_icon_13.png";
		this.m.Description = "我还没死呢！这个角色不在乎受伤，无论如何都会继续战斗。";
		this.m.Titles = [
			"疯子",
			"奇葩",
			"无畏者"
		];
		this.m.Excluded = [
			"trait.weasel",
			"trait.hesitant",
			"trait.dastard",
			"trait.fainthearted",
			"trait.craven",
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
				icon = "ui/icons/morale.png",
				text = "失去生命值时不会触发士气检定"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByLosingHitpoints = false;
	}

});

