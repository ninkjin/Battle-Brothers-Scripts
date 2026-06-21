this.cudgel_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.cudgel";
		this.m.Name = "重棒击";
		this.m.Description = "一种缓慢的过顶击，用全部力量把目标打成肉泥。任何人被这样的一击击中，都会感到茫然和神志不清，之后的2回合无法使出全力。";
		this.m.KilledString = "重棒打死";
		this.m.Icon = "skills/active_133.png";
		this.m.IconDisabled = "skills/active_133_sw.png";
		this.m.Overlay = "active_133";
		this.m.SoundOnUse = [
			"sounds/combat/cudgel_01.wav",
			"sounds/combat/cudgel_02.wav",
			"sounds/combat/cudgel_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/cudgel_hit_01.wav",
			"sounds/combat/cudgel_hit_02.wav",
			"sounds/combat/cudgel_hit_03.wav",
			"sounds/combat/cudgel_hit_04.wav"
		];
		this.m.SoundVolume = 1.25;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.5;
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
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "造成[color=" + this.Const.UI.Color.DamageValue + "]" + this.Const.Combat.FatigueReceivedPerHit * 4 + "[/color]额外疲劳"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "有[color=" + this.Const.UI.Color.PositiveValue + "]100%[/color]几率在命中时造成茫然"
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInMaces ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, target);

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && target.isAlive() && !target.getCurrentProperties().IsImmuneToDaze)
		{
			target.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + "一记重击使" + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + "茫然");
			}
		}

		return success;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
			_properties.FatigueDealtPerHitMult += 4.0;
		}
	}

});

