this.thresh <- this.inherit("scripts/skills/skill", {
	m = {
		StunChance = 20
	},
	function create()
	{
		this.m.ID = "actives.thresh";
		this.m.Name = "回旋";
		this.m.Description = "一种鲁莽的旋转攻击，可以抽击你周围的所有目标，不论敌我。不难躲开，因为它不是针对性的，但如果被命中结果将是毁灭性的，有几率击晕被命中的目标1回合。除非你想减少薪酬支出，否则注意周围的自己人！";
		this.m.KilledString = "砸碎";
		this.m.Icon = "skills/active_46.png";
		this.m.IconDisabled = "skills/active_46_sw.png";
		this.m.Overlay = "active_46";
		this.m.SoundOnUse = [
			"sounds/combat/thresh_01.wav",
			"sounds/combat/thresh_02.wav",
			"sounds/combat/thresh_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/thresh_hit_01.wav",
			"sounds/combat/thresh_hit_02.wav",
			"sounds/combat/thresh_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAOE = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.HitChanceBonus = -15;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 35;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 20;
		this.m.ChanceSmash = 99;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local hitchanceBonus = this.m.HitChanceBonus;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
		{
			hitchanceBonus = hitchanceBonus + 5;
		}

		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "有[color=" + this.Const.UI.Color.NegativeValue + "]" + hitchanceBonus + "%[/color]命中惩罚"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "有[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StunChance + "%[/color]几率命中时击昏"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "最多可以击中6个目标"
			}
		]);
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInFlails ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local ret = false;
		local ownTile = this.m.Container.getActor().getTile();
		local soundBackup = [];
		this.spawnAttackEffect(ownTile, this.Const.Tactical.AttackEffectThresh);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!ownTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = ownTile.getNextTile(i);

				if (!tile.IsEmpty && tile.getEntity().isAttackable() && this.Math.abs(tile.Level - ownTile.Level) <= 1)
				{
					if (ret && soundBackup.len() == 0)
					{
						soundBackup = this.m.SoundOnHit;
						this.m.SoundOnHit = [];
					}

					local success = this.attackEntity(_user, tile.getEntity());
					ret = success || ret;

					if (_user.isAlive() && !_user.isDying())
					{
						if (success && tile.IsOccupiedByActor && this.Math.rand(1, 100) <= this.m.StunChance && !tile.getEntity().getCurrentProperties().IsImmuneToStun && !tile.getEntity().getSkills().hasSkill("effects.stunned"))
						{
							tile.getEntity().getSkills().add(this.new("scripts/skills/effects/stunned_effect"));

							if (!_user.isHiddenToPlayer() && tile.IsVisibleForPlayer)
							{
								this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + "击晕了" + this.Const.UI.getColorizedEntityName(tile.getEntity()) + "1回合");
							}
						}
					}
				}
			}
		}

		if (ret && this.m.SoundOnHit.len() == 0)
		{
			this.m.SoundOnHit = soundBackup;
		}

		return ret;
	}

	function onTargetSelected( _targetTile )
	{
		local ownTile = this.m.Container.getActor().getTile();

		for( local i = 0; i != 6; i = ++i )
		{
			if (!ownTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = ownTile.getNextTile(i);

				if (!tile.IsEmpty && tile.getEntity().isAttackable() && this.Math.abs(tile.Level - ownTile.Level) <= 1)
				{
					this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, tile, tile.Pos.X, tile.Pos.Y);
				}
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
			{
				_properties.MeleeSkill -= 10;
			}
			else
			{
				_properties.MeleeSkill -= 15;
			}
		}
	}

});

