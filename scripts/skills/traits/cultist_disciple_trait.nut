this.cultist_disciple_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.cultist_disciple";
		this.m.Name = "达库尔门徒";
		this.m.Icon = "ui/traits/trait_icon_67.png";
		this.m.Description = "这个角色是达库尔的门徒，是一个对古老神明绝对忠诚的人。他欣然接纳肉体上的苦难，以让他更接近救赎。";
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
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20[/color]生命值"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+2[/color]每回合疲劳恢复"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color]决心"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "友军死亡时不会触发士气检定"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "失去生命值时不会触发士气检定"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints += 20;
		_properties.FatigueRecoveryRate += 2;
		_properties.Bravery += 10;
		_properties.IsAffectedByDyingAllies = false;
		_properties.IsAffectedByLosingHitpoints = false;
	}

});

