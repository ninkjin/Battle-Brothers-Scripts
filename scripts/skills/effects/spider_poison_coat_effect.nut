this.spider_poison_coat_effect <- this.inherit("scripts/skills/skill", {
	m = {
		AttacksLeft = 4
	},
	function create()
	{
		this.m.ID = "effects.spider_poison_coat";
		this.m.Name = "带毒武器";
		this.m.Icon = "skills/status_effect_88.png";
		this.m.IconMini = "status_effect_88_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "这个角色正在使用一把涂有浓缩织网蛛毒液的武器。接下来的几次攻击如果至少造成[color=" + this.Const.UI.Color.NegativeValue + "]" + this.Const.Combat.PoisonEffectMinDamage + "[/color]生命值伤害则使目标中毒。受影响的目标在效果消失之前每回合失去[color=" + this.Const.UI.Color.NegativeValue + "]10[/color]生命值。";
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function resetTime()
	{
		if (this.getContainer().getActor().isPlacedOnMap())
		{
			this.spawnIcon("status_effect_88", this._targetEntity.getTile());
		}

		this.m.AttacksLeft = 4;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		--this.m.AttacksLeft;

		if (this.m.AttacksLeft <= 0)
		{
			this.removeSelf();
		}

		if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _damageInflictedHitpoints < this.Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0)
		{
			return;
		}

		if (!_targetEntity.isAlive())
		{
			return;
		}

		if (_targetEntity.getFlags().has("undead"))
		{
			return;
		}

		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + "中毒了");
		}

		local effect = this.new("scripts/skills/effects/spider_poison_effect");
		effect.setDamage(10);
		_targetEntity.getSkills().add(effect);
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		--this.m.AttacksLeft;

		if (this.m.AttacksLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

