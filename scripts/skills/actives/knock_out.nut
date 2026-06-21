this.knock_out <- this.inherit("scripts/skills/skill", {
	m = {
		StunChance = 75,
		IsFromLute = false
	},
	function setStunChance( _c )
	{
		this.m.StunChance = _c;
	}

	function create()
	{
		this.m.ID = "actives.knock_out";
		this.m.Name = "打晕";
		this.m.Description = "一记重击，意在击晕或失能任何不幸被命中的家伙1回合，但不会造成很大伤害。被击晕的目标无法保持盾墙、矛墙或类似的防御技能。";
		this.m.Icon = "skills/active_32.png";
		this.m.IconDisabled = "skills/active_32_sw.png";
		this.m.Overlay = "active_32";
		this.m.SoundOnUse = [
			"sounds/combat/bash_01.wav",
			"sounds/combat/bash_02.wav",
			"sounds/combat/bash_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/bash_hit_01.wav",
			"sounds/combat/bash_hit_02.wav",
			"sounds/combat/bash_hit_03.wav"
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
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 50;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "造成[color=" + this.Const.UI.Color.DamageValue + "]" + this.Const.Combat.FatigueReceivedPerHit * 2 + "[/color]额外疲劳"
		});

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInMaces)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "有[color=" + this.Const.UI.Color.PositiveValue + "]100%[/color]几率命中时击晕"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "有[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StunChance + "%[/color]几率命中时击昏"
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
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor)
		{
			local target = _targetTile.getEntity();

			if ((_user.getCurrentProperties().IsSpecializedInMaces || this.Math.rand(1, 100) <= this.m.StunChance) && !target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasSkill("effects.stunned"))
			{
				target.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + "击晕了" + this.Const.UI.getColorizedEntityName(target) + "1回合");
				}

				if (this.m.IsFromLute && _user.isPlayerControlled())
				{
					this.updateAchievement("LuteStun", 1, 1);
				}
			}
		}

		return success;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageTotalMult *= 0.5;
			_properties.FatigueDealtPerHitMult += 2.0;
		}
	}

});

