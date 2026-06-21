this.fainthearted_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.fainthearted";
		this.m.Name = "胆小";
		this.m.Icon = "ui/traits/trait_icon_41.png";
		this.m.Description = "这个角色时不时需要一些温暖的言语或拍拍后背。";
		this.m.Titles = [
			"小鸡",
			"弱鸡"
		];
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.deathwish",
			"trait.craven",
			"trait.cocky",
			"trait.bloodthirsty",
			"trait.iron_jaw",
			"trait.hate_greenskins",
			"trait.hate_undead",
			"trait.hate_beasts"
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
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]决心"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += -5;
	}

});

