this.dislocated_shoulder_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.dislocated_shoulder";
		this.m.Name = "肩膀脱臼";
		this.m.Description = "一记重击把肩膀撞脱了关节，使得移动手臂非常困难。";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_03";
		this.m.Icon = "ui/injury/injury_icon_03.png";
		this.m.IconMini = "injury_icon_03_mini";
		this.m.HealingTimeMin = 5;
		this.m.HealingTimeMax = 7;
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-3[/color]行动点"
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

		_properties.ActionPoints -= 3;
		this.getContainer().getActor().setActionPoints(this.Math.min(_properties.ActionPoints, this.getContainer().getActor().getActionPoints()));
	}

});

