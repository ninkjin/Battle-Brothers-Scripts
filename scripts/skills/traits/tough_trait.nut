this.tough_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.tough";
		this.m.Name = "坚韧";
		this.m.Icon = "ui/traits/trait_icon_14.png";
		this.m.Description = "这个角色像钉子一样坚硬，被击中就像挠痒痒。";
		this.m.Titles = [
			"岩石",
			"公牛",
			"壮牛",
			"熊"
		];
		this.m.Excluded = [
			"trait.tiny",
			"trait.fragile",
			"trait.bleeder",
			"trait.ailing"
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
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color]生命值"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints += 10;
	}

});

