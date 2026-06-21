this.whip_skill <- this.inherit("scripts/skills/skill", {
	m = {
		SoundsA = [
			"sounds/combat/whip_bleed_01.wav",
			"sounds/combat/whip_bleed_02.wav",
			"sounds/combat/whip_bleed_03.wav"
		],
		SoundsB = [
			"sounds/combat/whip_hit_01.wav",
			"sounds/combat/whip_hit_02.wav",
			"sounds/combat/whip_hit_03.wav",
			"sounds/combat/whip_hit_04.wav"
		]
	},
	function create()
	{
		this.m.ID = "actives.whip";
		this.m.Name = "鞭打";
		this.m.Description = "越过相当远的距离进行鞭打以造成2层流血伤害。对盔甲效果很差。";
		this.m.KilledString = "鞭打致死";
		this.m.Icon = "skills/active_161.png";
		this.m.IconDisabled = "skills/active_161.png";
		this.m.Overlay = "active_161";
		this.m.SoundOnUse = [
			"sounds/combat/whip_01.wav",
			"sounds/combat/whip_02.wav",
			"sounds/combat/whip_03.wav"
		];
		this.m.SoundOnHit = [];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.1;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
	}

	function addResources()
	{
		foreach( r in this.m.SoundsA )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.SoundsB )
		{
			this.Tactical.addResource(r);
		}
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local dmg = 2 * (this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "攻击范围为[color=" + this.Const.UI.Color.PositiveValue + "]3" + "[/color]格"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "造成额外[color=" + this.Const.UI.Color.DamageValue + "]" + dmg + "[/color]可堆叠的每回合流血伤害，持续2回合"
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInCleavers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return;
		}

		if (success && !_targetTile.IsEmpty)
		{
			if (!target.isAlive() || target.isDying())
			{
				if (this.isKindOf(target, "lindwurm_tail") || !target.getCurrentProperties().IsImmuneToBleeding)
				{
					this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
				else
				{
					this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
			}
			else if (!target.getCurrentProperties().IsImmuneToBleeding && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
			{
				local effect = this.new("scripts/skills/effects/bleeding_effect");
				effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
				target.getSkills().add(effect);
				effect = this.new("scripts/skills/effects/bleeding_effect");
				effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
				target.getSkills().add(effect);
				this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
			else
			{
				this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
		}

		return success;
	}

});

