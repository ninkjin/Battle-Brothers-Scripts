this.asthmatic_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.asthmatic";
		this.m.Name = "哮喘";
		this.m.Icon = "ui/traits/trait_icon_22.png";
		this.m.Description = "由于呼吸急促且频繁咳嗽，这个角色需要更长时间从疲劳中恢复。";
		this.m.Titles = [];
		this.m.Excluded = [
			"trait.athletic",
			"trait.iron_lungs"
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
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-3[/color]每回合疲劳恢复"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.FatigueRecoveryRate += -3;
	}

});

