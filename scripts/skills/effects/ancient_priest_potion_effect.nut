this.ancient_priest_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ancient_priest_potion";
		this.m.Name = "突触阻塞";
		this.m.Icon = "skills/status_effect_134.png";
		this.m.IconMini = "status_effect_134_mini";
		this.m.Overlay = "status_effect_134";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "这个角色的身体发生了变异，使他对是战是逃的直觉反应被改变。在承受高压时，他的边缘神经系统就是收不到用来逃跑的资源，使得他在战线中基本不可动摇。";
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
				icon = "ui/icons/morale.png",
				text = "士气最低只会降至溃散级别，无法降至逃跑级别"
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
			this.World.Statistics.getFlags().set("isAncientPriestPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isAncientPriestPotionAcquired", false);
	}

});

