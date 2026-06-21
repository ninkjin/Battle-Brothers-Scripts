this.alp_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.alp_potion";
		this.m.Name = "强化视杆";
		this.m.Icon = "skills/status_effect_147.png";
		this.m.IconMini = "status_effect_147_mini";
		this.m.Overlay = "status_effect_147";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "这个角色的眼睛已经突变，可以更快、更剧烈的适应低光环境。从结果而言，他在夜间的视力现在几乎和白天差不多。";
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
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "不受夜间惩罚影响"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "再次突变会导致更长时间的疾病"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByNight = false;
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isAlpPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isAlpPotionAcquired", false);
	}

});

