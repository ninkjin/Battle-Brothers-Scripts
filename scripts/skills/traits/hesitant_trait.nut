this.hesitant_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.hesitant";
		this.m.Name = "迟疑";
		this.m.Icon = "ui/traits/trait_icon_25.png";
		this.m.Description = "嗯…好…也许吧。这个角色行动迟疑。";
		this.m.Titles = [
			"迟钝者"
		];
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave",
			"trait.deathwish",
			"trait.cocky",
			"trait.quick",
			"trait.brute",
			"trait.bloodthirsty",
			"trait.impatient"
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
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color]主动性"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Initiative += -10;
	}

});

