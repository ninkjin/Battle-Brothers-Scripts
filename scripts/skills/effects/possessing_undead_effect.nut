this.possessing_undead_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Possessed = null,
		IsAlive = true
	},
	function setPossessed( _p )
	{
		if (typeof _p == "instance")
		{
			this.m.Possessed = _p;
		}
		else
		{
			this.m.Possessed = this.WeakTableRef(_p);
		}
	}

	function create()
	{
		this.m.ID = "effects.possessing_undead";
		this.m.Name = "支配亡灵中";
		this.m.Icon = "skills/status_effect_69.png";
		this.m.IconMini = "status_effect_69_mini";
		this.m.Overlay = "status_effect_69";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
	}

	function onUpdate( _properties )
	{
		if (this.m.Possessed == null)
		{
			this.removeSelf();
			return;
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_damageHitpoints >= this.Const.Combat.InjuryMinDamage)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "失去了专注");
			}

			this.removeSelf();
		}

		if (_damageHitpoints >= this.getContainer().getActor().getHitpoints())
		{
			this.m.IsAlive = false;
			this.onRemoved();
		}
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("permanent_injury_4"))
		{
			local sprite = actor.getSprite("permanent_injury_4");
			sprite.Visible = true;
			sprite.setBrush("zombie_rage_eyes");
			sprite.Alpha = 0;
			sprite.fadeIn(1500);
		}

		actor.setDirty(true);
	}

	function onRemoved()
	{
		if (this.getContainer() != null)
		{
			local actor = this.getContainer().getActor();

			if (actor.hasSprite("permanent_injury_4"))
			{
				local sprite = actor.getSprite("permanent_injury_4");
				sprite.fadeOutAndHide(1500);

				if (this.m.IsAlive)
				{
					this.Time.scheduleEvent(this.TimeUnit.Real, 1800, function ( _d )
					{
						_d.setDirty(true);
					}, this.getContainer().getActor());
				}
			}
		}

		if (this.m.Possessed != null && !this.m.Possessed.isNull() && this.m.Possessed.isAlive())
		{
			local skill = this.m.Possessed.getSkills().getSkillByID("effects.possessed_undead");

			if (skill != null)
			{
				skill.setPossessor(null);
				this.m.Possessed.getSkills().remove(skill);
			}
		}
	}

});

