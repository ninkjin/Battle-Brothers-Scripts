this.iron_lungs_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.iron_lungs";
		this.m.Name = "铁肺";
		this.m.Icon = "ui/traits/trait_icon_33.png";
		this.m.Description = "这个角色很少会气喘吁吁，无论是挥舞着重型武器还是在整个战场上奔跑。";
		this.m.Titles = [];
		this.m.Excluded = [
			"trait.asthmatic",
			"trait.fat",
			"trait.gluttonous",
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
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+3[/color]每回合疲劳恢复"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.FatigueRecoveryRate += 3;
	}

});

