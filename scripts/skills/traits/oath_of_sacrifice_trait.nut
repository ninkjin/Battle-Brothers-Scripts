this.oath_of_sacrifice_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.oath_of_sacrifice";
		this.m.Name = "牺牲誓言";
		this.m.Icon = "ui/traits/trait_icon_87.png";
		this.m.Description = "这个角色已经立下牺牲誓言，发誓为战团的胜利放弃自我保护。然而很明显这样不怎么有利于身体健康。";
		this.m.Order = this.Const.SkillOrder.Trait - 1;
		this.m.Excluded = [];
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
				text = "无需支付任何工资"
			},
			{
				id = 10,
				type = "hint",
				icon = "ui/icons/warning.png",
				text = "伤势不会愈合"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.DailyWageMult *= 0.0;
	}

});

