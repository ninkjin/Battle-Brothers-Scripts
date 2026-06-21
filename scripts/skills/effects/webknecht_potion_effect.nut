this.webknecht_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.webknecht_potion";
		this.m.Name = "变异血液循环";
		this.m.Icon = "skills/status_effect_144.png";
		this.m.IconMini = "status_effect_144_mini";
		this.m.Overlay = "status_effect_144";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "这个角色的身体已经突变，毒素和其它有害物质通过血液传播的速度要慢得多，这使得它们可以在不产生严重健康影响的情况下被排除。有意思的是，这似乎并不影响他把自己灌醉的能力。";
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
				text = "免疫中毒效果，包括织网蛛与哥布林的毒"
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
		_properties.IsImmuneToPoison = true;
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isWebknechtPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isWebknechtPotionAcquired", false);
	}

});

