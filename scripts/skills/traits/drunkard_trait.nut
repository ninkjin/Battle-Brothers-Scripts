this.drunkard_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.drunkard";
		this.m.Name = "酒鬼";
		this.m.Icon = "ui/traits/trait_icon_29.png";
		this.m.Description = "根本不需要猜这个角色都把他的克朗花在什么上了。可以预料到他每场战斗前都会使劲喝酒，必要情况下会悄悄喝。 ";
		this.m.Titles = [
			"醉汉",
			"酒鬼"
		];
		this.m.Excluded = [
			"trait.teamplayer"
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
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color]伤害"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color]决心"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]近战技能"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color]远程技能"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 1.1;
		_properties.Bravery += 5;
		_properties.MeleeSkill += -5;
		_properties.RangedSkill += -10;
	}

});

