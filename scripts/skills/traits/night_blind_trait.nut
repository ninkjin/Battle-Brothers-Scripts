this.night_blind_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.night_blind";
		this.m.Name = "夜盲";
		this.m.Icon = "ui/traits/trait_icon_56.png";
		this.m.Description = "在夜间，这个角色必须和一群人绑在一起，因为他连自己的鼻子都看不见。";
		this.m.Excluded = [
			"trait.eagle_eyes",
			"trait.night_owl"
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
				icon = "ui/icons/vision.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-1[/color]夜间视野"
			}
		];
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().hasSkill("special.night"))
		{
			_properties.Vision -= 1;
		}
	}

});

