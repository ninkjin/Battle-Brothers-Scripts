this.exhausted_effect <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "effects.exhausted";
		this.m.Name = "精疲力竭";
		this.m.Description = "最近的事件使得这个角色身体精疲力竭，几乎无法跟上队伍的其他人，更不用说战斗了。休息几天应该就能奇迹痊愈。";
		this.m.Icon = "skills/status_effect_53.png";
		this.m.IconMini = "status_effect_53_mini";
		this.m.Type = this.m.Type | this.Const.SkillType.StatusEffect | this.Const.SkillType.SemiInjury;
		this.m.IsHealingMentioned = false;
		this.m.IsTreatable = false;
		this.m.HealingTimeMin = 1;
		this.m.HealingTimeMax = 3;
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
				id = 13,
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
		_properties.StaminaMult *= 0.6;
	}

});

