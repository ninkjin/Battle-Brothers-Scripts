this.fat_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.fat";
		this.m.Name = "肥胖";
		this.m.Icon = "ui/traits/trait_icon_10.png";
		this.m.Description = "这个角色比起运动更喜欢猪排，很容易就会喘不上气。";
		this.m.Titles = [
			"胖子",
			"壮牛",
			"大山",
			"猪",
			"肥猪"
		];
		this.m.Excluded = [
			"trait.athletic",
			"trait.swift",
			"trait.quick",
			"trait.strong",
			"trait.spartan",
			"trait.swift",
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
				id = 10,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color]生命值"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color]最大疲劳"
			}
		];
	}

	function onAdded()
	{
		if (!this.m.IsNew)
		{
			return;
		}

		local actor = this.getContainer().getActor();

		if (actor.getEthnicity() == 1)
		{
			actor.getSprite("body").setBrush("bust_naked_body_southern_02");
		}
		else
		{
			actor.getSprite("body").setBrush("bust_naked_body_02");
		}
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints += 10;
		_properties.Stamina -= 10;
	}

});

