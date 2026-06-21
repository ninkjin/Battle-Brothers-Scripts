this.split_shield <- this.inherit("scripts/skills/skill", {
	m = {
		ApplyAxeMastery = false
	},
	function isAxeMasteryApplied()
	{
		return this.m.ApplyAxeMastery;
	}

	function setApplyAxeMastery( _f )
	{
		this.m.ApplyAxeMastery = _f;
	}

	function create()
	{
		this.m.ID = "actives.split_shield";
		this.m.Name = "劈盾";
		this.m.Description = "一种专门摧毁对手盾牌的攻击。只能用于携带盾牌的目标，一定会命中。取决于武器和盾牌类型，可能需要多次劈盾才能摧毁。";
		this.m.Icon = "skills/active_09.png";
		this.m.IconDisabled = "skills/active_09_sw.png";
		this.m.Overlay = "active_09";
		this.m.SoundOnHit = [
			"sounds/combat/split_shield_01.wav",
			"sounds/combat/split_shield_02.wav",
			"sounds/combat/split_shield_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsUsingHitchance = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local damage = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage();

		if (this.m.ApplyAxeMastery && this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes)
		{
			damage = damage + this.Math.max(1, damage / 2);
		}

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
			id = 7,
			type = "text",
			icon = "ui/icons/shield_damage.png",
			text = "造成[color=" + this.Const.UI.Color.DamageValue + "]" + damage + "[/color]盾牌伤害"
		});

		if (this.m.MaxRange > 1)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "攻击范围为[color=" + this.Const.UI.Color.PositiveValue + "] " + this.m.MaxRange + "[/color]格"
			});
		}

		if (this.m.MaxRange > 1 && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes)
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
		this.m.FatigueCostMult = this.m.ApplyAxeMastery && _properties.IsSpecializedInAxes ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;

		if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() != null)
		{
			this.m.ActionPointCost = 6;
		}
		else
		{
			this.m.ActionPointCost = 4;
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		return _targetTile.getEntity().isArmedWithShield();
	}

	function onUse( _user, _targetTile )
	{
		local shield = _targetTile.getEntity().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (shield != null)
		{
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplitShield);
			local damage = _user.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage();

			if (this.m.ApplyAxeMastery && _user.getCurrentProperties().IsSpecializedInAxes)
			{
				damage = damage + this.Math.max(1, damage / 2);
			}

			local conditionBefore = shield.getCondition();
			shield.applyShieldDamage(damage);

			if (shield.getCondition() == 0)
			{
				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + "使用劈盾摧毁了" + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + "的盾牌");
				}
			}
			else
			{
				if (this.m.SoundOnHit.len() != 0)
				{
					this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _targetTile.getEntity().getPos());
				}

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + "使用劈盾击中了" + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + "的盾牌，造成[b]" + (conditionBefore - shield.getCondition()) + "[/b]伤害");
				}
			}

			if (!this.Tactical.getNavigator().isTravelling(_targetTile.getEntity()))
			{
				this.Tactical.getShaker().shake(_targetTile.getEntity(), _user.getTile(), 2, this.Const.Combat.ShakeEffectSplitShieldColor, this.Const.Combat.ShakeEffectSplitShieldHighlight, this.Const.Combat.ShakeEffectSplitShieldFactor, 1.0, [
					"shield_icon"
				], 1.0);
			}

			local overwhelm = this.getContainer().getSkillByID("perk.overwhelm");

			if (overwhelm != null)
			{
				overwhelm.onTargetHit(this, _targetTile.getEntity(), this.Const.BodyPart.Body, 0, 0);
			}
		}

		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this && this.m.MaxRange > 1)
		{
			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
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

