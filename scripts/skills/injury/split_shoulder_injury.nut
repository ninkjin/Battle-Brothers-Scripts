this.split_shoulder_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.split_shoulder";
		this.m.Name = "肩膀劈裂";
		this.m.Description = "一处深割伤劈开了这个角色的肩膀，损伤了肌肉组织并极大的限制了手臂的活动性。";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_29";
		this.m.Icon = "ui/injury/injury_icon_29.png";
		this.m.IconMini = "injury_icon_29_mini";
		this.m.HealingTimeMin = 4;
		this.m.HealingTimeMax = 6;
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
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color]造成的伤害"
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

		_properties.DamageTotalMult *= 0.5;
	}

});

