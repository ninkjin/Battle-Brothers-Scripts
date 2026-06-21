this.deep_chest_cut_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.deep_chest_cut";
		this.m.Name = "胸部深割伤";
		this.m.Description = "一处深深嵌入胸部和胸大肌的流血切口使得光是保持站立都难，更别提使用武器了。";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_09";
		this.m.Icon = "ui/injury/injury_icon_09.png";
		this.m.IconMini = "injury_icon_09_mini";
		this.m.HealingTimeMin = 5;
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
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-35%[/color]生命值"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-35%[/color]最大疲劳"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-35%[/color]近战技能"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-35%[/color]远程技能"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onAdded()
	{
		this.injury.onAdded();

		if (!("State" in this.Tactical) || this.Tactical.State == null)
		{
			return;
		}

		local p = this.getContainer().getActor().getCurrentProperties();

		if (!p.IsAffectedByInjuries || this.m.IsFresh && !p.IsAffectedByFreshInjuries)
		{
			return;
		}

		if (this.getContainer().getActor().getHitpointsPct() > 0.65)
		{
			this.getContainer().getActor().setHitpoints(this.getContainer().getActor().getHitpointsMax() * 0.65);
		}
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);

		if (!_properties.IsAffectedByInjuries || this.m.IsFresh && !_properties.IsAffectedByFreshInjuries)
		{
			return;
		}

		if (this.m.IsShownOutOfCombat)
		{
			_properties.HitpointsMult *= 0.65;
		}

		_properties.StaminaMult *= 0.65;
		_properties.MeleeSkillMult *= 0.65;
		_properties.RangedSkillMult *= 0.65;
	}

});

