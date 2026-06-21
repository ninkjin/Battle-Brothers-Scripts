this.cut_arm_sinew_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.cut_arm_sinew";
		this.m.Name = "臂腱割伤";
		this.m.Description = "一条被部分切断的手臂肌腱使得在攻击中投入任何力量都变得困难。";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_33";
		this.m.Icon = "ui/injury/injury_icon_33.png";
		this.m.IconMini = "injury_icon_33_mini";
		this.m.HealingTimeMin = 4;
		this.m.HealingTimeMax = 6;
		this.m.IsShownOnArm = true;
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-40%[/color]造成的伤害"
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

		_properties.DamageTotalMult *= 0.6;
	}

});

