this.broken_ribs_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.broken_ribs";
		this.m.Name = "肋骨断裂";
		this.m.Description = "数根肋骨被钝力所折断，导致每一次呼吸都成为一段痛苦的过程。";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_20";
		this.m.Icon = "ui/injury/injury_icon_20.png";
		this.m.IconMini = "injury_icon_20_mini";
		this.m.HealingTimeMin = 5;
		this.m.HealingTimeMax = 7;
		this.m.IsShownOnArm = true;
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
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-40%[/color]最大疲劳"
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

		_properties.StaminaMult *= 0.6;
	}

});

