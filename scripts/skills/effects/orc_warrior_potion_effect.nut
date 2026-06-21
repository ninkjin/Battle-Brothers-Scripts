this.orc_warrior_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.orc_warrior_potion";
		this.m.Name = "感官冗余";
		this.m.Icon = "skills/status_effect_128.png";
		this.m.IconMini = "status_effect_128_mini";
		this.m.Overlay = "status_effect_128";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "这个角色的身体突变并产生出了许多冗余的突触，使其在遭受最致命的致残打击时也能够维持一定程度对视觉、听觉和肌肉控制。";
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]33%[/color]几率抵抗茫然、踉跄、击晕、分神和凋零效果"
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
		_properties.IsResistantToPhysicalStatuses = true;
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isOrcWarriorPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isOrcWarriorPotionAcquired", false);
	}

});

