this.ijirok_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ijirok_potion";
		this.m.Name = "疯神恩赐";
		this.m.Icon = "skills/status_effect_150.png";
		this.m.IconMini = "status_effect_150_mini";
		this.m.Overlay = "status_effect_150";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "这个角色出了些毛病。除了一阵阵疯狂的笑声和咕哝的责骂声之外，他的身体似乎常常会随缘抗拒被施加的变化。在战斗中，这倒是有幸让他有时可以避免遭受削弱效果。";
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]几率抵抗任何不良状态，例如茫然或击晕"
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
		_properties.IsResistantToAnyStatuses = true;
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isIjirokPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isIjirokPotionAcquired", false);
	}

});

