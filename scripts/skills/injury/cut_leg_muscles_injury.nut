this.cut_leg_muscles_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.cut_leg_muscles";
		this.m.Name = "腿部肌肉割伤";
		this.m.Description = "腿部肌肉上的一处割伤使得任何快速且突然的行动都是不可能的。";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_06";
		this.m.Icon = "ui/injury/injury_icon_06.png";
		this.m.IconMini = "injury_icon_06_mini";
		this.m.HealingTimeMin = 3;
		this.m.HealingTimeMax = 5;
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-40%[/color]近战防御"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-40%[/color]主动性"
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

		_properties.MeleeDefenseMult *= 0.6;
		_properties.InitiativeMult *= 0.6;
	}

});

