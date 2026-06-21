this.crush_armor <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.crush_armor";
		this.m.Name = "毁甲";
		this.m.Description = "使用武器以极高的效率捶打、弯折、撕裂进而使目标的盔甲失去作用。尽管穿着最厚的盔甲也能感受到冲击力，但这并不会对穿戴者造成太大伤害。";
		this.m.Icon = "skills/active_36.png";
		this.m.IconDisabled = "skills/active_36_sw.png";
		this.m.Overlay = "active_36";
		this.m.SoundOnUse = [
			"sounds/combat/crush_armor_01.wav",
			"sounds/combat/crush_armor_02.wav",
			"sounds/combat/crush_armor_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/crush_armor_hit_01.wav",
			"sounds/combat/crush_armor_hit_02.wav",
			"sounds/combat/crush_armor_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.DirectDamageMult = 0.0;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		local f = p.IsSpecializedInHammers ? 2.0 : 1.5;
		local damage_armor_min = this.Math.floor(p.DamageRegularMin * p.DamageArmorMult * f * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_armor_max = this.Math.floor(p.DamageRegularMax * p.DamageArmorMult * f * p.DamageTotalMult * p.MeleeDamageMult);
		local ret = this.getDefaultUtilityTooltip();

		if (damage_armor_max > 0)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "造成[color=" + this.Const.UI.Color.DamageValue + "]" + damage_armor_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_armor_max + "[/color]盔甲伤害"
			});
		}

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "造成[color=" + this.Const.UI.Color.DamageValue + "]" + 10 + "[/color]无视护甲的生命值伤害"
		});
		return ret;
	}

	function getExpectedDamage( _target )
	{
		local ret = this.skill.getExpectedDamage(_target);
		ret.HitpointDamage = this.Math.max(10, ret.HitpointDamage);
		ret.TotalDamage = this.Math.max(10, ret.TotalDamage);
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInHammers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local target = _targetTile.getEntity();
		return this.attackEntity(_user, target);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageArmorMult *= this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers ? 2.0 : 1.5;
			_properties.DamageRegularMult *= 0.0;
			_properties.DamageMinimum = this.Math.max(_properties.DamageMinimum, 10);
		}
	}

});

