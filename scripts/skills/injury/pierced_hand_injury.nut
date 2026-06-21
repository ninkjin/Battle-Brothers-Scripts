this.pierced_hand_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.pierced_hand";
		this.m.Name = "手部刺伤";
		this.m.Description = "手上多一个洞或许无法阻止一个坚定的战士，但确实会使掌握武器变得更困难。";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_41";
		this.m.Icon = "ui/injury/injury_icon_41.png";
		this.m.IconMini = "injury_icon_41_mini";
		this.m.HealingTimeMin = 3;
		this.m.HealingTimeMax = 4;
		this.m.InfectionChance = 1.0;
	}

	function getTooltip()
	{
		local ret = [
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
				id = 7,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color]近战技能"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color]远程技能"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);

		if (!_properties.IsAffectedByInjuries || this.m.IsFresh && !_properties.IsAffectedByFreshInjuries)
		{
			return;
		}

		_properties.MeleeSkillMult *= 0.8;
		_properties.RangedSkillMult *= 0.8;
	}

});

