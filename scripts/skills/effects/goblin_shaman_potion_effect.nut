this.goblin_shaman_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.goblin_shaman_potion";
		this.m.Name = "奔涌汗腺";
		this.m.Icon = "skills/status_effect_125.png";
		this.m.IconMini = "status_effect_125_mini";
		this.m.Overlay = "status_effect_125";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "当承受高压时，这个角色已经变异了的身体会过量产生浓稠黏液，并以出汗的方式排出。在这种状态下他想要逃出任何网和陷阱都要容易的多。只是记得别忘了带毛巾。";
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
				text = "总是能成功挣脱束缚效果，例如被网住或被缠绕"
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

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isGoblinShamanPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isGoblinShamanPotionAcquired", false);
	}

});

