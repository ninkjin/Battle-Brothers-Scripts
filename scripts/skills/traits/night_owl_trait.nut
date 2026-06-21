this.night_owl_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.night_owl";
		this.m.Name = "夜枭";
		this.m.Icon = "ui/traits/trait_icon_57.png";
		this.m.Description = "有些角色比其他人更适应弱光环境，而这个人更是其中的佼佼者。";
		this.m.Titles = [
			"夜枭",
			"鹰眼"
		];
		this.m.Excluded = [
			"trait.short_sighted",
			"trait.night_blind"
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+1[/color]夜间视野"
			}
		];
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().hasSkill("special.night"))
		{
			_properties.Vision += 1;
		}
	}

});

