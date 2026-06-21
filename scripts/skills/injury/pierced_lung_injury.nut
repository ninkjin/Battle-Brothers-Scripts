this.pierced_lung_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.pierced_lung";
		this.m.Name = "肺部刺伤";
		this.m.Description = "很明显第二个通气孔没有什么用，只会让你听起来像个风笛。";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_36";
		this.m.Icon = "ui/injury/injury_icon_36.png";
		this.m.IconMini = "injury_icon_36_mini";
		this.m.HealingTimeMin = 5;
		this.m.HealingTimeMax = 7;
		this.m.IsShownOnBody = true;
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
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-60%[/color]最大疲劳"
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

		_properties.StaminaMult *= 0.4;
	}

});

