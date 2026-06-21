this.throw_spear_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.throw_spear";
		this.m.Name = "投掷投矛";
		this.m.Description = "向目标投掷投矛以使目标的盾牌无法使用。装备盾牌的目标总是会被命中，相反没有装备盾牌的目标不一定会被命中，但如果命中可以造成大量伤害。无法在卷入近战时使用。";
		this.m.KilledString = "刺穿";
		this.m.Icon = "skills/active_138.png";
		this.m.IconDisabled = "skills/active_138_sw.png";
		this.m.Overlay = "active_138";
		this.m.SoundOnUse = [
			"sounds/combat/dlc2/throwing_spear_throw_01.wav",
			"sounds/combat/dlc2/throwing_spear_throw_02.wav",
			"sounds/combat/dlc2/throwing_spear_throw_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/dlc2/throwing_spear_hit_01.wav",
			"sounds/combat/dlc2/throwing_spear_hit_02.wav",
			"sounds/combat/dlc2/throwing_spear_hit_03.wav",
			"sounds/combat/dlc2/throwing_spear_hit_04.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/dlc2/throwing_spear_miss_01.wav",
			"sounds/combat/dlc2/throwing_spear_miss_02.wav",
			"sounds/combat/dlc2/throwing_spear_miss_03.wav",
			"sounds/combat/dlc2/throwing_spear_miss_04.wav"
		];
		this.m.SoundOnHitShield = [
			"sounds/combat/dlc2/throwing_spear_hit_shield_01.wav",
			"sounds/combat/dlc2/throwing_spear_hit_shield_02.wav",
			"sounds/combat/dlc2/throwing_spear_hit_shield_03.wav",
			"sounds/combat/dlc2/throwing_spear_hit_shield_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsOffensiveToolSkill = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsWeaponSkill = true;
		this.m.IsDoingForwardMove = false;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.45;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 2;
		this.m.MaxRange = 4;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = this.Const.ProjectileType.Javelin;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local damage = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/shield_damage.png",
			text = "造成[color=" + this.Const.UI.Color.DamageValue + "]" + damage + "[/color]盾牌伤害"
		});
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "攻击范围为[color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color]格，如果向低处投掷会更远。"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "有[color=" + this.Const.UI.Color.PositiveValue + "]+30%[/color]额外命中，同时每格距离有[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]命中惩罚"
			}
		]);

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]无法使用，因为此角色已卷入近战[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item == null)
		{
			return 0;
		}

		return item.getAmmo();
	}

	function consumeAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item != null)
		{
			item.consumeAmmo();
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();
		local shield = targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (shield != null && shield.isItemType(this.Const.Items.ItemType.Shield))
		{
			local flip = !this.m.IsProjectileRotated && targetEntity.getPos().X > _user.getPos().X;
			local time = this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, time, this.onApplyShieldDamage.bindenv(this), {
				User = _user,
				Skill = this,
				TargetTile = _targetTile,
				Shield = shield,
				Damage = _user.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage()
			});
		}
		else
		{
			local ret = this.attackEntity(_user, _targetTile.getEntity());
		}

		_user.getItems().unequip(_user.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += 20;
			_properties.HitChanceAdditionalWithEachTile -= 10;

			if (_targetEntity != null)
			{
				local shield = _targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

				if (shield != null && shield.isItemType(this.Const.Items.ItemType.Shield))
				{
					this.m.IsUsingHitchance = false;
				}
				else
				{
					this.m.IsUsingHitchance = true;
				}
			}
			else
			{
				this.m.IsUsingHitchance = true;
			}
		}
	}

	function onApplyShieldDamage( _tag )
	{
		local conditionBefore = _tag.Shield.getCondition();
		_tag.Shield.applyShieldDamage(_tag.Damage);

		if (_tag.Shield.getCondition() == 0)
		{
			if (!_tag.User.isHiddenToPlayer() && _tag.TargetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_tag.User) + "摧毁了" + this.Const.UI.getColorizedEntityName(_tag.TargetTile.getEntity()) + "的盾牌");
			}
		}
		else
		{
			if (!_tag.User.isHiddenToPlayer() && _tag.TargetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_tag.TargetTile.getEntity()) + "的盾牌被击中，受到[b]" + (conditionBefore - _tag.Shield.getCondition()) + "[/b]伤害");
			}

			if (_tag.Skill.m.SoundOnHitShield.len() != 0)
			{
				this.Sound.play(_tag.Skill.m.SoundOnHitShield[this.Math.rand(0, _tag.Skill.m.SoundOnHitShield.len() - 1)], this.Const.Sound.Volume.Skill, _tag.TargetTile.getEntity().getPos());
			}
		}

		if (!this.Tactical.getNavigator().isTravelling(_tag.TargetTile.getEntity()))
		{
			this.Tactical.getShaker().shake(_tag.TargetTile.getEntity(), _tag.User.getTile(), 2, this.Const.Combat.ShakeEffectSplitShieldColor, this.Const.Combat.ShakeEffectSplitShieldHighlight, this.Const.Combat.ShakeEffectSplitShieldFactor, 1.0, [
				"shield_icon"
			], 1.0);
		}
	}

});

