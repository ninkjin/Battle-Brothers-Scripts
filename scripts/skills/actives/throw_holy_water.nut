this.throw_holy_water <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.throw_holy_water";
		this.m.Name = "投掷圣水";
		this.m.Description = "向目标扔一瓶圣水，它会粉碎并且液体四溅。圣水会燃烧亡灵，但不会影响其他目标。";
		this.m.Icon = "skills/active_97.png";
		this.m.IconDisabled = "skills/active_97_sw.png";
		this.m.Overlay = "active_97";
		this.m.SoundOnUse = [
			"sounds/combat/throw_ball_01.wav",
			"sounds/combat/throw_ball_02.wav",
			"sounds/combat/throw_ball_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/acid_flask_impact_01.wav",
			"sounds/combat/acid_flask_impact_02.wav",
			"sounds/combat/acid_flask_impact_03.wav",
			"sounds/combat/acid_flask_impact_04.wav"
		];
		this.m.SoundOnHitDelay = 0;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsOffensiveToolSkill = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = true;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 3;
		this.m.ProjectileType = this.Const.ProjectileType.Flask2;
		this.m.ProjectileTimeScale = 1.5;
		this.m.IsProjectileRotated = false;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "造成[color=" + this.Const.UI.Color.DamageValue + "]20[/color]生命值伤害，持续[color=" + this.Const.UI.Color.DamageValue + "]3[/color]回合，此伤害无视护甲"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "有[color=" + this.Const.UI.Color.DamageValue + "]33%[/color]几率波及相同或更低高度的周围单位。"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "只影响亡灵目标"
		});
		return ret;
	}

	function applyEffect( _target )
	{
		if (!_target.getFlags().has("undead"))
		{
			return;
		}

		local poison = _target.getSkills().getSkillByID("effects.holy_water");

		if (poison == null)
		{
			_target.getSkills().add(this.new("scripts/skills/effects/holy_water_effect"));
		}
		else
		{
			poison.resetTime();
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_originTile.Level + 1 < _targetTile.Level)
		{
			return false;
		}

		return true;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();

		if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
		{
			local flip = !this.m.IsProjectileRotated && targetEntity.getPos().X > _user.getPos().X;

			if (_user.getTile().getDistanceTo(targetEntity.getTile()) >= this.Const.Combat.SpawnProjectileMinDist)
			{
				this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), targetEntity.getTile(), 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
		}

		_user.getItems().unequip(_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
		this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onApplyEffect.bindenv(this), {
			Skill = this,
			TargetTile = _targetTile
		});
	}

	function onApplyEffect( _data )
	{
		local targetEntity = _data.TargetTile.getEntity();

		if (_data.Skill.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(_data.Skill.m.SoundOnHit[this.Math.rand(0, _data.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
		}

		_data.Skill.applyEffect(targetEntity);

		for( local i = 0; i < 6; i = ++i )
		{
			if (!_data.TargetTile.hasNextTile(i))
			{
			}
			else
			{
				local nextTile = _data.TargetTile.getNextTile(i);

				if (this.Math.rand(1, 100) > 33)
				{
				}
				else if (nextTile.Level > _data.TargetTile.Level)
				{
				}
				else if (!nextTile.IsOccupiedByActor)
				{
				}
				else
				{
					local entity = nextTile.getEntity();
					_data.Skill.applyEffect(entity);
				}
			}
		}
	}

});

