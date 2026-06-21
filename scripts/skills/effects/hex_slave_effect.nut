this.hex_slave_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Master = null,
		Color = this.createColor("#ffffff"),
		IsActivated = false
	},
	function activate()
	{
		this.m.IsActivated = true;
	}

	function setMaster( _p )
	{
		if (_p == null)
		{
			this.m.Master = null;
		}
		else if (typeof _p == "instance")
		{
			this.m.Master = _p;
		}
		else
		{
			this.m.Master = this.WeakTableRef(_p);
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
		this.m.ID = "effects.hex_slave";
		this.m.Name = "诅咒";
		this.m.KilledString = "死于诅咒";
		this.m.Icon = "skills/status_effect_84.png";
		this.m.IconMini = "status_effect_84_mini";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/hexe_hex_damage_01.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_02.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_03.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_04.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "这个角色遭到了诅咒，会与另一个角色感受相同的痛苦并遭受相同的伤害。小心点，这效果能杀了他。此效果还将持续[color=" + this.Const.UI.Color.NegativeValue + "]1[/color]回合。";
	}

	function applyDamage( _damage )
	{
		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, this.getContainer().getActor().getPos());
		}

		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = _damage;
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), this, hitInfo);
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("status_hex"))
		{
			actor.getSprite("status_hex").Visible = false;
			actor.getSprite("status_hex").Color = this.createColor("#ffffff");
		}

		actor.setDirty(true);

		if (this.m.Master != null && !this.m.Master.isNull() && !this.m.Master.getContainer().isNull())
		{
			local master = this.m.Master;
			this.m.Master = null;
			master.setSlave(null);
			master.removeSelf();
			master.getContainer().update();
		}
	}

	function onDeath( _fatalityType )
	{
		this.onRemoved();
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (this.m.IsActivated && (this.m.Master == null || this.m.Master.isNull() || !this.m.Master.isAlive()))
		{
			this.removeSelf();
		}
		else if (actor.hasSprite("status_hex"))
		{
			local hex = actor.getSprite("status_hex");
			local fadeIn = !hex.Visible;

			if (fadeIn)
			{
				hex.setBrush("bust_hex_sw");
				hex.Color = this.m.Color;
				hex.Alpha = 0;
				hex.Visible = true;
				hex.fadeIn(700);
				actor.setDirty(true);
			}
		}
	}

});

