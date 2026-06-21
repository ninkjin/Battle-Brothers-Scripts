this.direwolf_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {
		SkillsUsed = {}
	},
	function create()
	{
		this.m.ID = "effects.direwolf_potion";
		this.m.Name = "强化肌腱";
		this.m.Icon = "skills/status_effect_139.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_139";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "这个角色的肌肉已经发生了变异并对动作的突变产生了不同的反应。中途停止或中断动作都不会积累太多疲劳，因此可以从打偏或被格挡的攻击中快速恢复过来。";
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
				text = "攻击未命中时会有[color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]疲劳增长被退还"
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

	function getSkillsUsed()
	{
		return this.m.SkillsUsed;
	}

	function onTurnStarted()
	{
		this.m.SkillsUsed = {};
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (!(this.Const.SkillCounter in this.m.SkillsUsed))
		{
			this.m.SkillsUsed[this.Const.SkillCounter] <- _skill.getFatigueCost() / 2;
			local tag = {
				Actor = this.getContainer().getActor(),
				SkillCounter = this.Const.SkillCounter,
				Skill = this
			};
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 400, this.onTargedMissedCallback, tag);
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.Const.SkillCounter in this.m.SkillsUsed)
		{
			this.m.SkillsUsed[this.Const.SkillCounter] = 0;
		}
		else
		{
			this.m.SkillsUsed[this.Const.SkillCounter] <- 0;
		}
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		if (this.Const.SkillCounter in this.m.SkillsUsed)
		{
			this.m.SkillsUsed[this.Const.SkillCounter] = 0;
		}
		else
		{
			this.m.SkillsUsed[this.Const.SkillCounter] <- 0;
		}
	}

	function onTargedMissedCallback( _tag )
	{
		local SkillsUsed = _tag.Skill.getSkillsUsed();

		if ((_tag.SkillCounter in SkillsUsed) && _tag.Actor.isAlive() && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _tag.Actor.getID())
		{
			_tag.Actor.setFatigue(_tag.Actor.getFatigue() - SkillsUsed[_tag.SkillCounter]);
			_tag.Actor.setDirty(true);
		}
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isDirewolfPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isDirewolfPotionAcquired", false);
	}

});

