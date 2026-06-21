this.pound <- this.inherit("scripts/skills/skill", {
	m = {
		StunChance = 30
	},
	function create()
	{
		this.m.ID = "actives.pound";
		this.m.Name = "砸击";
		this.m.Description = "用链子和锤头把目标砸到地里。有点难以预测，但运气好的话能够绕过盾牌的掩护。被命中的目标可能会被打击的力量击晕一回合。";
		this.m.KilledString = "砸击致死";
		this.m.Icon = "skills/active_50.png";
		this.m.IconDisabled = "skills/active_50_sw.png";
		this.m.Overlay = "active_50";
		this.m.SoundOnUse = [
			"sounds/combat/pound_01.wav",
			"sounds/combat/pound_02.wav",
			"sounds/combat/pound_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/pound_hit_01.wav",
			"sounds/combat/pound_hit_02.wav",
			"sounds/combat/pound_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsShieldRelevant = false;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 66;
	}

	function getTooltip()
	{
		local p = this.getContainer().buildPropertiesForUse(this, null);
		local damage_regular_min = this.Math.floor(p.DamageRegularMin * p.DamageRegularMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_regular_max = this.Math.floor(p.DamageRegularMax * p.DamageRegularMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_Armor_min = this.Math.floor(p.DamageRegularMin * p.DamageArmorMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_Armor_max = this.Math.floor(p.DamageRegularMax * p.DamageArmorMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_direct_max = this.Math.floor(damage_regular_max * (this.m.DirectDamageMult + p.DamageDirectAdd + p.DamageDirectMeleeAdd));
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
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "造成[color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_max + "[/color]生命值伤害，其中[color=" + this.Const.UI.Color.DamageValue + "]0[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_direct_max + "[/color]可无视盔甲"
		});

		if (damage_Armor_max > 0)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "造成[color=" + this.Const.UI.Color.DamageValue + "]" + damage_Armor_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_Armor_max + "[/color]盔甲伤害"
			});
		}

		if (p.IsSpecializedInFlails)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "头部受到的攻击忽视额外[color=" + this.Const.UI.Color.PositiveValue + "]20%[/color]盔甲"
			});
		}
		else
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "头部受到的攻击忽视额外[color=" + this.Const.UI.Color.PositiveValue + "]10%[/color]盔甲"
			});
		}

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "有[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StunChance + "%[/color]几率命中时击昏"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "忽视盾牌提供的近战防御加成"
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInFlails ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor && this.Math.rand(1, 100) <= this.m.StunChance && !_targetTile.getEntity().getCurrentProperties().IsImmuneToStun && !_targetTile.getEntity().getSkills().hasSkill("effects.stunned"))
		{
			_targetTile.getEntity().getSkills().add(this.new("scripts/skills/effects/stunned_effect"));

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + "击晕了" + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + "1回合");
			}
		}

		return success;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_skill == this && _hitInfo.BodyPart == this.Const.BodyPart.Head)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
			{
				_hitInfo.DamageDirect += 0.2;
			}
			else
			{
				_hitInfo.DamageDirect += 0.1;
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
		}
	}

});

