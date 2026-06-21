this.hex_master_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1,
		Slave = null,
		Color = this.createColor("#ffffff"),
		IsActivated = false
	},
	function activate()
	{
		this.m.IsActivated = true;
	}

	function setSlave( _p )
	{
		if (_p == null)
		{
			this.m.Slave = null;
		}
		else if (typeof _p == "instance")
		{
			this.m.Slave = _p;
		}
		else
		{
			this.m.Slave = this.WeakTableRef(_p);
		}
	}

	function setColor( _c )
	{
		this.m.Color = _c;
	}

	function isAlive()
	{
		return this.getContainer() != null && !this.getContainer().isNull() && this.getContainer().getActor() != null && this.getContainer().getActor().isAlive() && this.getContainer().getActor().getHitpoints() > 0;
	}

	function create()
	{
		this.m.ID = "effects.hex_master";
		this.m.Name = "被诅咒保护";
		this.m.Icon = "skills/status_effect_84.png";
		this.m.IconMini = "status_effect_84_mini";
		this.m.SoundOnUse = [
			"sounds/combat/poison_applied_01.wav",
			"sounds/combat/poison_applied_02.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = false;
	}

	function resetTime()
	{
		this.m.TurnsLeft = 1;
	}

	function onTurnStart()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.m.Slave == null || this.m.Slave.isNull() || !this.m.Slave.isAlive())
		{
			this.removeSelf();
			return;
		}

		if (_damageHitpoints > 0)
		{
			this.m.Slave.applyDamage(_damageHitpoints);
		}

		if (this.m.Slave == null || this.m.Slave.isNull() || !this.m.Slave.isAlive())
		{
			this.removeSelf();
		}
	}

	function onUpdate( _properties )
	{
		if (this.m.IsActivated && (this.m.Slave == null || this.m.Slave.isNull() || !this.m.Slave.isAlive()))
		{
			this.removeSelf();
		}
		else
		{
			_properties.TargetAttractionMult *= 0.5;
			local actor = this.getContainer().getActor();
			actor.getSprite("status_hex").setBrush("bust_hex_sw");
			actor.getSprite("status_hex").Color = this.m.Color;
			actor.getSprite("status_hex").Visible = true;
			actor.setDirty(true);
		}
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.getSprite("status_hex").Visible = false;
		actor.getSprite("status_hex").Color = this.createColor("#ffffff");
		actor.setDirty(true);

		if (this.m.Slave != null && !this.m.Slave.isNull() && !this.m.Slave.getContainer().isNull())
		{
			local slave = this.m.Slave;
			this.m.Slave = null;
			slave.setMaster(null);
			slave.removeSelf();
			slave.getContainer().update();
		}
	}

	function onDeath( _fatalityType )
	{
		this.onRemoved();
	}

});

