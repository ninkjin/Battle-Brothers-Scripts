this.aimed_shot <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = 0
	},
	function onItemSet()
	{
	}

	function create()
	{
		this.m.ID = "actives.aimed_shot";
		this.m.Name = "瞄准射击";
		this.m.Description = "一种集中注意力仔细瞄准的射击，即使在远距离也相对容易命中预期目标。无法在卷入近战时使用。";
		this.m.KilledString = "射杀";
		this.m.Icon = "skills/active_18.png";
		this.m.IconDisabled = "skills/active_18_sw.png";
		this.m.Overlay = "active_18";
		this.m.SoundOnUse = [
			"sounds/combat/aimed_shot_01.wav",
			"sounds/combat/aimed_shot_02.wav",
			"sounds/combat/aimed_shot_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/arrow_hit_01.wav",
			"sounds/combat/arrow_hit_02.wav",
			"sounds/combat/arrow_hit_03.wav"
		];
		this.m.SoundOnHitShield = [
			"sounds/combat/shield_hit_arrow_01.wav",
			"sounds/combat/shield_hit_arrow_02.wav",
			"sounds/combat/shield_hit_arrow_03.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/arrow_miss_01.wav",
			"sounds/combat/arrow_miss_02.wav",
			"sounds/combat/arrow_miss_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 1000;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsWeaponSkill = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsDoingForwardMove = false;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 7;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = this.Const.ProjectileType.Arrow;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "攻击范围为[color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color]格，如果向低处射击会更远。"
			}
		]);

		if (10 + this.m.AdditionalAccuracy >= 0)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "有[color=" + this.Const.UI.Color.PositiveValue + "]+" + (10 + this.m.AdditionalAccuracy) + "%[/color]额外命中，同时每格距离有[color=" + this.Const.UI.Color.NegativeValue + "]" + (-2 + this.m.AdditionalHitChance) + "%[/color]命中惩罚"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "有[color=" + this.Const.UI.Color.NegativeValue + "]" + (10 + this.m.AdditionalAccuracy) + "%[/color]额外命中，同时每格距离有[color=" + this.Const.UI.Color.NegativeValue + "]" + (-2 + this.m.AdditionalHitChance) + "%[/color]命中惩罚"
			});
		}

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "有[color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color]箭矢剩余"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]需要装备非空箭袋[/color]"
			});
		}

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
		return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0 && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (item == null)
		{
			return 0;
		}

		if (item.getAmmoType() == this.Const.Items.AmmoType.Arrows)
		{
			return item.getAmmo();
		}
	}

	function consumeAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (item != null)
		{
			item.consumeAmmo();
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.MaxRange = this.m.Item.getRangeMax() + (_properties.IsSpecializedInBows ? 1 : 0);
		this.m.AdditionalAccuracy = this.m.Item.getAdditionalAccuracy();
		this.m.FatigueCostMult = _properties.IsSpecializedInBows ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.consumeAmmo();

		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.getContainer().setBusy(true);
			local tag = {
				Skill = this,
				User = _user,
				TargetTile = _targetTile
			};
			this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.Delay, this.onPerformAttack, tag);

			if (!_user.isPlayerControlled() && _targetTile.getEntity().isPlayerControlled())
			{
				_user.getTile().addVisibilityForFaction(this.Const.Faction.Player);
			}

			return true;
		}
		else
		{
			return this.attackEntity(_user, _targetTile.getEntity());
		}
	}

	function onPerformAttack( _tag )
	{
		_tag.Skill.getContainer().setBusy(false);
		return _tag.Skill.attackEntity(_tag.User, _tag.TargetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += 10 + this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += -2 + this.m.AdditionalHitChance;
			_properties.DamageRegularMult *= 1.1;

			if (_properties.IsSharpshooter)
			{
				_properties.DamageDirectMult += 0.05;
			}
		}
	}

});

