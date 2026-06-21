this.cultist_fanatic_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.cultist_fanatic";
		this.m.Name = "达库尔狂热者";
		this.m.Icon = "ui/traits/trait_icon_64.png";
		this.m.Description = "这个角色是达库尔的狂热追随者，相信人在死亡时会被达库尔接纳。";
		this.m.Order = this.Const.SkillOrder.Trait - 1;
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color]决心"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "友军死亡时不会触发士气检定"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += 5;
		_properties.IsAffectedByDyingAllies = false;
	}

});

