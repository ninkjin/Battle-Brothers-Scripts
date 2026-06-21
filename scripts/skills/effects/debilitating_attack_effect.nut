this.debilitating_attack_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.debilitating_attack";
		this.m.Name = "削弱攻击";
		this.m.Description = "这个角色准备好了一个削弱攻击。击中目标会将他们造成伤害的能力降低一回合。未能击中目标则会浪费此效果。";
		this.m.Icon = "ui/perks/perk_34.png";
		this.m.IconMini = "perk_34_mini";
		this.m.SoundOnHit = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
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
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color]目标的伤害，持续1回合"
			}
		];
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!this.isGarbage() && _skill.isAttack() && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			local user = this.getContainer().getActor();

			if (this.m.SoundOnHit.len() > 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _targetEntity.getPos());
			}

			local effect = this.new("scripts/skills/effects/debilitated_effect");
			_targetEntity.getSkills().add(effect);
			this.removeSelf();
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.removeSelf();
	}

});

