this.injured_knee_cap_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.injured_knee_cap";
		this.m.Name = "膝盖骨受伤";
		this.m.Description = "敏感的膝盖骨受伤了，使得每次行动都十分疼，极大的限制了这个角色的活动性。";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_40";
		this.m.Icon = "ui/injury/injury_icon_40.png";
		this.m.IconMini = "injury_icon_40_mini";
		this.m.HealingTimeMin = 5;
		this.m.HealingTimeMax = 8;
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
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]2[/color]每移动一格额外需要的行动点"
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

		_properties.MovementAPCostAdditional += 2;
		_properties.InitiativeMult *= 0.6;
	}

});

