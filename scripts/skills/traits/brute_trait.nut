this.brute_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.brute";
		this.m.Name = "粗暴";
		this.m.Icon = "ui/traits/trait_icon_01.png";
		this.m.Description = "不是进行灵巧攻击的苗子，这个角色在近战中会用全力击打对手头部以造成额外伤害，但会牺牲一定的准确性。";
		this.m.Titles = [
			"公牛",
			"壮牛",
			"锤子"
		];
		this.m.Excluded = [
			"trait.tiny",
			"trait.fragile",
			"trait.insecure",
			"trait.hesitant"
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
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color]击中头部时的伤害"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]近战技能"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += -5;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && !_skill.isRanged())
		{
			_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.15;
		}
	}

});

