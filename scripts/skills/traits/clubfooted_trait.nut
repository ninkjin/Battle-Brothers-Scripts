this.clubfooted_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.clubfooted";
		this.m.Name = "畸足";
		this.m.Icon = "ui/traits/trait_icon_23.png";
		this.m.Description = "从孩提时代就开始遭受脚部畸形之苦，这角色至今走路仍比大多数人都要困难。";
		this.m.Titles = [];
		this.m.Excluded = [
			"trait.weasel",
			"trait.athletic",
			"trait.quick",
			"trait.sure_footing",
			"trait.impatient",
			"trait.swift",
			"trait.lucky"
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
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]+2[/color]每格移动的疲劳积累"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MovementFatigueCostAdditional += 2;
	}

});

