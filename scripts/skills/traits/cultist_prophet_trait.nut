this.cultist_prophet_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.cultist_prophet";
		this.m.Name = "达库尔先知";
		this.m.Icon = "ui/traits/trait_icon_69.png";
		this.m.Description = "这个人物是达库尔的先知，是他意志的血肉导体，是他真理的凡间代言。其他的信徒聆听此人的每一句话语，并在他的训谕下感受到超越了自身身体的极限。";
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color]近战防御"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color]远程防御"
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
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "不会受到当前战斗中新产生的伤势的影响"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += 5;
		_properties.RangedDefense += 5;
		_properties.Hitpoints += 20;
		_properties.FatigueRecoveryRate += 2;
		_properties.Bravery += 10;
		_properties.IsAffectedByDyingAllies = false;
		_properties.IsAffectedByLosingHitpoints = false;
		_properties.IsAffectedByFreshInjuries = false;
	}

});

