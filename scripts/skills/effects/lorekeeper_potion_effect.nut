this.lorekeeper_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false,
		LastFrameUsed = 0
	},
	function isSpent()
	{
		return this.m.IsSpent;
	}

	function getLastFrameUsed()
	{
		return this.m.LastFrameUsed;
	}

	function create()
	{
		this.m.ID = "effects.lorekeeper_potion";
		this.m.Name = "博学者的肋骨";
		this.m.Icon = "skills/status_effect_151.png";
		this.m.IconMini = "status_effect_151_mini";
		this.m.Overlay = "status_effect_151";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "这个角色的身体里整合进了博学者的部分骨骼，结果是具备了在遭受似乎致命的伤口时快速恢复的能力。但如果他晚上睡着以后不会尖叫就好了……";
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
				text = "每场战斗有一次机会在本来将被杀死时会幸存并完全恢复生命值"
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

	function setSpent( _f )
	{
		this.m.IsSpent = _f;
		this.m.LastFrameUsed = this.Time.getFrame();
	}

	function onCombatStarted()
	{
		this.m.IsSpent = false;
		this.m.LastFrameUsed = 0;
	}

	function onCombatFinished()
	{
		this.m.IsSpent = false;
		this.m.LastFrameUsed = 0;
		this.skill.onCombatFinished();
	}

	function onUpdate( _properties )
	{
		if (this.m.IsSpent && this.m.LastFrameUsed == this.Time.getFrame())
		{
			this.getContainer().removeByType(this.Const.SkillType.DamageOverTime);
		}
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isLorekeeperPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isLorekeeperPotionAcquired", false);
	}

});

