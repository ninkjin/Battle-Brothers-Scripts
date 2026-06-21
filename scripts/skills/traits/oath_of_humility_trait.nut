this.oath_of_humility_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.oath_of_humility";
		this.m.Name = "谦逊誓言";
		this.m.Icon = "ui/traits/trait_icon_81.png";
		this.m.Description = "这个角色已经立下谦逊誓言，发誓要自我反思和自我提高。";
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
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color]经验获取"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.XPGainMult *= 1.1;
	}

});

