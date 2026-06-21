this.crumble_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.crumble";
		this.m.Name = "崩裂";
		this.m.Description = "使敌人阵形崩裂的猛烈打击。它可以覆盖2格的距离，可以从前线后方使用，超出大多数其他近战武器的范围。";
		this.m.KilledString = "砸碎";
		this.m.Icon = "skills/active_205.png";
		this.m.IconDisabled = "skills/active_205_sw.png";
		this.m.Overlay = "active_205";
		this.m.SoundOnUse = [
			"sounds/combat/dlc6/crumble_01.wav",
			"sounds/combat/dlc6/crumble_02.wav",
			"sounds/combat/dlc6/crumble_03.wav",
			"sounds/combat/dlc6/crumble_04.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/dlc6/crumble_hit_01.wav",
			"sounds/combat/dlc6/crumble_hit_02.wav",
			"sounds/combat/dlc6/crumble_hit_03.wav",
			"sounds/combat/dlc6/crumble_hit_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsTooCloseShown = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.4;
		this.m.HitChanceBonus = 0;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 50;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "攻击范围为[color=" + this.Const.UI.Color.PositiveValue + "]2" + "[/color]格"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "造成[color=" + this.Const.UI.Color.DamageValue + "]" + this.Const.Combat.FatigueReceivedPerHit * 2 + "[/color]额外疲劳"
		});

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInMaces)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "有[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color]攻击近身敌人的命中惩罚，因为武器过于笨重"
			});
		}

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInMaces ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.FatigueDealtPerHitMult += 2.0;

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInMaces && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
			else
			{
				this.m.HitChanceBonus = 0;
			}
		}
	}

});

