this.fractured_elbow_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.fractured_elbow";
		this.m.Name = "肘部骨折";
		this.m.Description = "肘部的一处骨折使得有效的格挡与招架攻击变得困难。";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_23";
		this.m.Icon = "ui/injury/injury_icon_23.png";
		this.m.IconMini = "injury_icon_23_mini";
		this.m.HealingTimeMin = 3;
		this.m.HealingTimeMax = 5;
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color]近战防御"
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

		_properties.MeleeDefenseMult *= 0.75;
	}

});

