this.deep_abdominal_cut_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.deep_abdominal_cut";
		this.m.Name = "腹部深割伤";
		this.m.Description = "腹部的一处深切口伤到了许多肌肉，使得光是走路或站直都疼，并减弱了这个角色的体质。";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_32";
		this.m.Icon = "ui/injury/injury_icon_32.png";
		this.m.IconMini = "injury_icon_32_mini";
		this.m.HealingTimeMin = 3;
		this.m.HealingTimeMax = 4;
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color]生命值"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color]最大疲劳"
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

		if (this.getContainer().getActor().getHitpointsPct() > 0.75)
		{
			this.getContainer().getActor().setHitpoints(this.getContainer().getActor().getHitpointsMax() * 0.75);
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
			_properties.HitpointsMult *= 0.75;
		}

		_properties.StaminaMult *= 0.75;
	}

});

