this.possessed_undead_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Possessor = null,
		IsAlive = true
	},
	function setPossessor( _p )
	{
		if (typeof _p == "instance")
		{
			this.m.Possessor = _p;
		}
		else
		{
			this.m.Possessor = this.WeakTableRef(_p);
		}
	}

	function create()
	{
		this.m.ID = "effects.possessed_undead";
		this.m.Name = "被支配";
		this.m.Icon = "skills/status_effect_69.png";
		this.m.IconMini = "status_effect_69_mini";
		this.m.Overlay = "status_effect_69";
		this.m.SoundOnUse = [];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
	}

	function onUpdate( _properties )
	{
		if (this.m.Possessor == null)
		{
			this.removeSelf();
			return;
		}

		_properties.ActionPoints = 12;
		_properties.Initiative += 50;
		_properties.MeleeSkill += 15;
		_properties.MeleeDefense += 10;
		_properties.RangedDefense += 10;
		_properties.DamageReceivedTotalMult *= 0.75;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, actor.getPos());
		}

		if (actor.hasSprite("status_rage"))
		{
			local sprite = actor.getSprite("status_rage");
			sprite.Visible = true;

			if (actor.isHiddenToPlayer())
			{
				sprite.Alpha = 255;
			}
			else
			{
				sprite.Alpha = 0;
				sprite.fadeIn(1500);
			}
		}

		actor.setDirty(true);
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

	function onRemoved()
	{
		if (this.getContainer() != null)
		{
			local actor = this.getContainer().getActor();

			if (actor.hasSprite("status_rage"))
			{
				if (actor.isHiddenToPlayer())
				{
					actor.getSprite("status_rage").Visible = false;
				}
				else
				{
					local sprite = actor.getSprite("status_rage");
					sprite.fadeOutAndHide(1500);

					if (actor.isAlive())
					{
						this.Time.scheduleEvent(this.TimeUnit.Real, 1800, function ( _d )
						{
							if (_d.isAlive())
							{
								_d.setDirty(true);
							}
						}, actor);
					}
				}
			}
		}

		if (this.m.Possessor != null && !this.m.Possessor.isNull() && this.m.Possessor.isAlive())
		{
			local skill = this.m.Possessor.getSkills().getSkillByID("effects.possessing_undead");

			if (skill != null)
			{
				skill.setPossessed(null);
				this.m.Possessor.getSkills().remove(skill);
			}
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_damageHitpoints >= this.getContainer().getActor().getHitpoints())
		{
			this.m.IsAlive = false;
			this.onRemoved();
		}
	}

});

